#include <opt-A2.h>
#include <types.h>
#include <kern/errno.h>
#include <kern/unistd.h>
#include <kern/wait.h>
#include <lib.h>
#include <syscall.h>
#include <current.h>
#include <proc.h>
#include <thread.h>
#include <synch.h>
#include <addrspace.h>
#include <copyinout.h>
#include <mips/trapframe.h>
#include <vfs.h>
#include <vm.h>
#include <test.h>
#include <kern/fcntl.h>

  /* this implementation of sys__exit does not do anything with the exit code */
  /* this needs to be fixed to get exit() and waitpid() working properly */

/*void cleanup(struct proc p*, struct addrspace *as){
    kfree(proc);KASSERT(curproc->p_addrspace != NULL);
    as_deactivate();
    *
    * clear p_addrspace before calling as_destroy. Otherwise if
    * as_destroy sleeps (which is quite possible) when we
    * come back we'll be calling as_activate on a
    * half-destroyed address space. This tends to be
    * messily fatal.
    *
    as = curproc_setas(NULL);
    as_destroy(as);

    * detach this thread from its process *
    * note: curproc cannot be used after this call *
    proc_remthread(curthread);

    if this is the last user process in the system, proc_destroy()
     will wake up the kernel menu thread 
    proc_destroy(p);
  
    thread_exit();
     thread_exit() does not return, so we should never get here 
    panic("return from thread_exit in sys_exit\n");

}*/

void sys__exit(int exitcode) {

  P(master_exit_mutex);
  struct addrspace *as;
  struct proc *p = curproc;

  DEBUG(DB_SYSCALL,"Syscall: _exit(%d)\n",exitcode);
  
  //set as a zombie since any exit called on its children will destroy them
  //p->zombie_status = 1;

  //set exit code to parameter

  struct proc* parent = p->parent;

  //set the parent of all children to be null
  P(children_mutex);
  int m = array_num(p->children);
  for(int i = 0; i < m; i++){
    struct proc* c = (struct proc*) array_get(p->children,i);
    c->parent = NULL;
  }
  V(children_mutex);
  
  if(parent != NULL && parent->p_addrspace != NULL){
    
    //kprintf("process has parent and we are in exit");
    int child_index = -1;

    P(children_mutex);
    int n = array_num(parent->children_pids);
    //kprintf("here2");
    for(int i = 0; i < n; i++){
      int *a = (int*) array_get(parent->children_pids,i);
      //kprintf("here3");
      if(*a == (int)p->PID){
        child_index = i;
        //kprintf("here4");
        break;
      }
    }
    if(child_index >= 0){
      int* temp = kmalloc(sizeof(int));
      *temp = _MKWAIT_EXIT(exitcode);
      //kprintf("setting exit code to 0");
      array_set(parent->children_exit_codes,child_index,temp);
      V(children_mutex);
    }
  
    if(p->parent_waiting_on == 1){
      p->parent_waiting_on = 0;
      V(p->parent->wait_pid_chan);
    }
    
  }
  
  V(master_exit_mutex);

    //kprintf("set exit code for %d to %d\n" (int)p->PID,exitcode);
    
  //p->exit_code = exitcode;
  //P(parent_waiting_on_mutex);
  /*if(p->parent_waiting_on == 1){
      //p->parent_waiting_on = 0;
      //V(parent_waiting_on_mutex);
      V(p->parent->wait_pid_chan);
    }
  }*/

  //kprintf("deleting process: %d\n", (int)p->PID);

  //if parent is NULL or a zombie we need to cleanup and destroy process and its children recursively
  //if(p->parent == NULL || p->parent->zombie_status == 1){
    KASSERT(curproc->p_addrspace != NULL);
    as_deactivate();
    /*
    * clear p_addrspace before calling as_destroy. Otherwise if
    * as_destroy sleeps (which is quite possible) when we
    * come back we'll be calling as_activate on a
    * half-destroyed address space. This tends to be
    * messily fatal.
    */
    as = curproc_setas(NULL);
    as_destroy(as);

    /* detach this thread from its process */
    /* note: curproc cannot be used after this call */
    proc_remthread(curthread);

    /* if this is the last user process in the system, proc_destroy()
     will wake up the kernel menu thread */
    proc_destroy(p);
  
    thread_exit();
    /* thread_exit() does not return, so we should never get here */
    panic("return from thread_exit in sys_exit\n");
 // }

  //otherwise keep alive as wait_pid can be called on it
  /*else{
    //signal to parent to wake up if it is waiting on it
    if(p->parent_waiting_on == 1){
      P(parent_waiting_on_mutex);
      p->parent_waiting_on = 0;
      V(parent_waiting_on_mutex);
      V(p->parent->wait_pid_chan);
    }
  }*/

}


/* stub handler for getpid() system call                */
int
sys_getpid(pid_t *retval)
{
  #if OPT_A2
  struct proc *p = curproc;
  if(p == NULL){
    return -1;
  }
  /* for now, this is just a stub that always returns a PID of 1 */
  /* you need to fix this to make it work properly */
  *retval = p->PID;
  #endif
  return 0;
}


/* stub handler for waitpid() system call                */

int
sys_waitpid(pid_t pid,
	    userptr_t status,
	    int options,
	    pid_t *retval)
{
  int exitstatus;
  int result;

  //get current process
  struct proc* p = curproc;
  KASSERT(p!=NULL);

  //make sure it is calling wait_pid on a child
  int n = array_num(p->children);
  int child_index = -1;
 
  for(int i = 0; i < n; i++){
  
    int* a = (int*) array_get(p->children_pids,i);
    if(*a == (int)pid){
      child_index = i;
      //kprintf("found child index");
      break;
    }
  }

  //pid did not belong to a child, error and return
  if(child_index == -1){
    return -1;
  }

  if (options != 0) {
    return(EINVAL);
  }

  //get exit status of child

  //exitstatus = 0;
  P(exit_status_mutex);
  
  int* b = (int*) array_get(p->children_exit_codes,child_index);
  exitstatus = *b;
  //kprintf("Status is %d\n",exitstatus);

  //if child hasn't exited, wait on it and set child as lock holder
  if(exitstatus == -1){
    //kprintf("Status not 0 %d\n",pid);

    struct proc* child = (struct proc *) array_get(p->children,child_index);
    child->parent_waiting_on = 1;
    
    V(exit_status_mutex);
     //kprintf("waiting on child %d\n",pid);
    P(p->wait_pid_chan);
  }
  else{
    V(exit_status_mutex);
  }


  //now should be 0
  P(exit_status_mutex);
  b = (int*) array_get(p->children_exit_codes,child_index);
  exitstatus = *b;
  result = copyout((void *)&exitstatus,status,sizeof(int));
  V(exit_status_mutex);
  
  //if error copying output error
  if (result) {
    return(result);
  }

  //kprintf("exit status for %d is %d and status is %d\n",pid,exitstatus,(int)status);
  
  *retval = pid;
  return 0;  

  /* this is just a stub implementation that always reports an
     exit status of 0, regardless of the actual exit status of
     the specified process.   
     In fact, this will return 0 even if the specified process
     is still running, and even if it never existed in the first place.

     Fix this!
  */

  /* for now, just pretend the exitstatus is 0 */
  //exitstatus = 0;
  //result = copyout((void *)&exitstatus,status,sizeof(int));
  /*if (result) {
    return(result);
  }
  *retval = pid;
  return(0);*/
}

#if OPT_A2
int sys_fork(struct trapframe *tf,pid_t *retval){
  struct proc *p = curproc; // get curent process which called fork (parent)
  
  //make sure curprocc is not null
  if(p == NULL || p->p_addrspace == NULL){
    return -1;
  }
 
 //check if too many processes in system
 /*if(num_processes > 64000){
   return ENPROC;
 }


  //check if too many processes under parent
  if(array_num(p->children) > 64000){
    return EMPROC;
  }*/

  //create child name
  const char* child_name = "proc_" + (char)nextPID;
  const char* child_name_thread = "proc_" + (char)nextPID;

  //create child process
  struct proc *child = proc_create_runprogram(child_name);
  if(child == NULL){ 
    return -1;
  }

  //set return value to child PID
  *retval = child->PID;

  //assign parent to child->parent
  child->parent = p;

  //assign child to parent children array
  unsigned index;
  unsigned index1;
  unsigned index2;
  int n = array_num(p->children);
  int m = array_num(p->children_exit_codes);
  int o = array_num(p->children_pids);
  
  P(children_mutex);
  int *exit_status = kmalloc(sizeof(int));
  int *child_pid = kmalloc(sizeof(int));
  *exit_status = -1;
  *child_pid = child->PID;
  int r = array_add(p->children, child, &index);
  int s = array_add(p->children_exit_codes,exit_status , &index1);
  int t = array_add(p->children_pids, child_pid, &index2);

  /*int* a = (int*)array_get(p->children_exit_codes, 0);
  int* b = (int*)array_get(p->children_pids, 0);
  kprintf("newest status added to chldren_codes: %d\n", *a);
  kprintf("child pid: %d\n",(int) child->PID);
  kprintf("newest PID added to chldren_pids: %d\n", *b);*/
  (void)r;
  (void)s;
  (void)t;
  V(children_mutex);
  
  //verify array_add did not fail
  if(array_num(p->children) != (unsigned) n + 1 ||array_num(p->children_exit_codes) != (unsigned) m + 1 || array_num(p->children_pids) != (unsigned) o + 1){
    return -1;
  }

  //copy address space
  P(trapframe_mutex);
  int ret = as_copy(p->p_addrspace, &(child->p_addrspace));
  struct trapframe* tf_copy = kmalloc(sizeof(struct trapframe));
  *tf_copy = *tf;
  V(trapframe_mutex);

  //verify copy was successfull otherwise produce memory error
  if(ret == ENOMEM){
    return ENOMEM;
  }
  
  //kprintf("Parent PID: %d\n", p->PID);
  //kprintf("Child PID: %d\n", child->PID);


  //create enter_forked_process function pointer
  void (*e_f_p)(void*, unsigned long) = &enter_forked_process; 
  unsigned long data2 = 0;

  //create thread for child and enter it
  thread_fork(child_name_thread, child, e_f_p, tf_copy ,data2);

  return 0;
  
}

int sys_execv(const_userptr_t program, userptr_t args){

  
  (void)args;
  //copy result
  int result;

  //length of program string
  size_t program_len = strlen((char*)program) + 1;
  
  //store program string is kernal space
  char *program_path = kmalloc(program_len);
  
  //make user->kernal space copy of program
  result = copyinstr(program, program_path, (int) program_len, &program_len);
  
  //if problem copying return error code
  if(result){return result;}
  
  //test we have correct program path: WORKS
  //kprintf("Program is: %s\n", program_path);
  
  //loop through args to count how many there are
  char** args_array_temp = (char**) args;
  char temp[] = "temp";
  char* arg_temp = temp;
  int counter = -1;
  int index = 0;
  while(arg_temp != NULL){
    arg_temp = args_array_temp[index];
    index++;
    counter++;
  }
  
  //test argument count result: WORKS
  //kprintf("Program has: %d arguments\n", counter);
  
  //go through args and copy each argument to kernal space
  char** args_array = kmalloc((counter + 2)*sizeof(char *));

  //set program name as argv[0] in argument array
  args_array[0] = program_path;

  for(int i = 0; i < counter; i++){
    
    //get arg length
    size_t arg_len = strlen((char*)args_array_temp[i]) + 1;
    
    //store copy result
    int result;
    
    //store arg in kernal space
    char* arg = kmalloc(arg_len);

    //make copy
    result = copyinstr((const_userptr_t) args_array_temp[i], arg, (int) arg_len, &arg_len);
    
    //if copy fails return error code
    if(result){return result;}

    //otherwise add string to array
    args_array[i+1] = arg;
  }

  //NULL terminate the arguments so we know when we're done
  char* null_term = kmalloc(2);
  null_term = NULL;
  args_array[counter + 1] = null_term;

  //test arguments in kernal space: WORKS
  for(int i = 0; i <= counter+1; i++){
    //kprintf("Argument %d for program %s is %s\n", i,program_path,args_array[i]);
  }


  struct addrspace *as;
	struct vnode *v;
	vaddr_t entrypoint, stackptr;

	// Open the file. 
	result = vfs_open(program_path, O_RDONLY, 0, &v);
	if (result) {
		return result;
	}

	// We should be a new process.
	//KASSERT(curproc_getas() == NULL);

	// Create a new address space.
	as = as_create();
	if (as ==NULL) {
		vfs_close(v);
		return ENOMEM;
	}

	// Switch to it and activate it.
	struct addrspace* old = curproc_setas(as);
	as_activate();

	// Load the executable.
	result = load_elf(v, &entrypoint);
	
  if (result) {
		// p_addrspace will go away when curproc is destroyed
		vfs_close(v);
		return result;
	}

	// Done with the file now.
	vfs_close(v);

	// Define the user stack in the address space
	result = as_define_stack(as, &stackptr, args_array);
	if (result) {
		// p_addrspace will go away when curproc is destroyed
		return result;
	}
  /*vaddr_t *test;
  //size_t ptr_size = 4;
  result = copyin((const_userptr_t) &stackptr, test, 4);
  kprintf("Result from copyin: %d\n", result);
  kprintf("Address at that location is: %x\n",*test);
  kprintf("Here\n");*/
  
  as_destroy(old);
  
  //kprintf("Stack ptr is %x\n",stackptr);
	// Warp to user mode.*/
	enter_new_process(counter, (userptr_t) stackptr /*userspace addr of argv*/,
		  stackptr, entrypoint);
	
  return 0;
}
#endif
