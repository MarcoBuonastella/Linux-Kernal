[1mdiff --git a/build/install/lib/libc.a b/build/install/lib/libc.a[m
[1mindex c33cae5..6f93c5a 100644[m
Binary files a/build/install/lib/libc.a and b/build/install/lib/libc.a differ
[1mdiff --git a/build/user/lib/libc/libc.a b/build/user/lib/libc/libc.a[m
[1mindex c33cae5..6f93c5a 100644[m
Binary files a/build/user/lib/libc/libc.a and b/build/user/lib/libc/libc.a differ
[1mdiff --git a/kern/arch/mips/syscall/syscall.c b/kern/arch/mips/syscall/syscall.c[m
[1mindex 499580e..46f82f7 100644[m
[1m--- a/kern/arch/mips/syscall/syscall.c[m
[1m+++ b/kern/arch/mips/syscall/syscall.c[m
[36m@@ -35,6 +35,7 @@[m
 #include <thread.h>[m
 #include <current.h>[m
 #include <syscall.h>[m
[32m+[m[32m#include <opt-A2.h>[m
 [m
 [m
 /*[m
[36m@@ -131,7 +132,11 @@[m [msyscall(struct trapframe *tf)[m
 	  break;[m
 #endif // UW[m
 [m
[31m-	    /* Add stuff here */[m
[32m+[m[32m /* Add stuff here */[m
[32m+[m[32m#if OPT_A2[m
[32m+[m[32m  case SYS_fork:[m
[32m+[m[32m    break;[m
[32m+[m[32m#endif[m
  [m
 	default:[m
 	  kprintf("Unknown syscall %d\n", callno);[m
[1mdiff --git a/kern/compile/ASST1/catmouse.o b/kern/compile/ASST1/catmouse.o[m
[1mindex 3fe8e08..f54216f 100644[m
Binary files a/kern/compile/ASST1/catmouse.o and b/kern/compile/ASST1/catmouse.o differ
[1mdiff --git a/kern/compile/ASST1/catmouse_synch.o b/kern/compile/ASST1/catmouse_synch.o[m
[1mindex acbc0b8..2a28278 100644[m
Binary files a/kern/compile/ASST1/catmouse_synch.o and b/kern/compile/ASST1/catmouse_synch.o differ
[1mdiff --git a/kern/compile/ASST1/console.o b/kern/compile/ASST1/console.o[m
[1mindex d29ad9d..51c18ff 100644[m
Binary files a/kern/compile/ASST1/console.o and b/kern/compile/ASST1/console.o differ
[1mdiff --git a/kern/compile/ASST1/device.o b/kern/compile/ASST1/device.o[m
[1mindex ceee243..57c7ff3 100644[m
Binary files a/kern/compile/ASST1/device.o and b/kern/compile/ASST1/device.o differ
[1mdiff --git a/kern/compile/ASST1/emu.o b/kern/compile/ASST1/emu.o[m
[1mindex 2563a5d..34252af 100644[m
Binary files a/kern/compile/ASST1/emu.o and b/kern/compile/ASST1/emu.o differ
[1mdiff --git a/kern/compile/ASST1/fstest.o b/kern/compile/ASST1/fstest.o[m
[1mindex 3c90e20..4ccc7c8 100644[m
Binary files a/kern/compile/ASST1/fstest.o and b/kern/compile/ASST1/fstest.o differ
[1mdiff --git a/kern/compile/ASST1/kernel b/kern/compile/ASST1/kernel[m
[1mindex ddec4f9..2d36f54 100755[m
Binary files a/kern/compile/ASST1/kernel and b/kern/compile/ASST1/kernel differ
[1mdiff --git a/kern/compile/ASST1/kprintf.o b/kern/compile/ASST1/kprintf.o[m
[1mindex 8171259..475d158 100644[m
Binary files a/kern/compile/ASST1/kprintf.o and b/kern/compile/ASST1/kprintf.o differ
[1mdiff --git a/kern/compile/ASST1/lamebus_machdep.o b/kern/compile/ASST1/lamebus_machdep.o[m
[1mindex bfddc72..542ff55 100644[m
Binary files a/kern/compile/ASST1/lamebus_machdep.o and b/kern/compile/ASST1/lamebus_machdep.o differ
[1mdiff --git a/kern/compile/ASST1/lhd.o b/kern/compile/ASST1/lhd.o[m
[1mindex 54c9199..543d0a5 100644[m
Binary files a/kern/compile/ASST1/lhd.o and b/kern/compile/ASST1/lhd.o differ
[1mdiff --git a/kern/compile/ASST1/main.o b/kern/compile/ASST1/main.o[m
[1mindex 2dda702..7ddfaaf 100644[m
Binary files a/kern/compile/ASST1/main.o and b/kern/compile/ASST1/main.o differ
[1mdiff --git a/kern/compile/ASST1/menu.o b/kern/compile/ASST1/menu.o[m
[1mindex 0c1efa6..030615e 100644[m
Binary files a/kern/compile/ASST1/menu.o and b/kern/compile/ASST1/menu.o differ
[1mdiff --git a/kern/compile/ASST1/proc.o b/kern/compile/ASST1/proc.o[m
[1mindex 983a775..bf10e37 100644[m
Binary files a/kern/compile/ASST1/proc.o and b/kern/compile/ASST1/proc.o differ
[1mdiff --git a/kern/compile/ASST1/sfs_vnode.o b/kern/compile/ASST1/sfs_vnode.o[m
[1mindex ea39419..e6b85c0 100644[m
Binary files a/kern/compile/ASST1/sfs_vnode.o and b/kern/compile/ASST1/sfs_vnode.o differ
[1mdiff --git a/kern/compile/ASST1/synch.o b/kern/compile/ASST1/synch.o[m
[1mindex 5cdbef9..d1dd278 100644[m
Binary files a/kern/compile/ASST1/synch.o and b/kern/compile/ASST1/synch.o differ
[1mdiff --git a/kern/compile/ASST1/synchtest.o b/kern/compile/ASST1/synchtest.o[m
[1mindex 9da299d..9da5636 100644[m
Binary files a/kern/compile/ASST1/synchtest.o and b/kern/compile/ASST1/synchtest.o differ
[1mdiff --git a/kern/compile/ASST1/thread.o b/kern/compile/ASST1/thread.o[m
[1mindex 252711f..e768b42 100644[m
Binary files a/kern/compile/ASST1/thread.o and b/kern/compile/ASST1/thread.o differ
[1mdiff --git a/kern/compile/ASST1/traffic.o b/kern/compile/ASST1/traffic.o[m
[1mindex c14dfb9..b56f867 100644[m
Binary files a/kern/compile/ASST1/traffic.o and b/kern/compile/ASST1/traffic.o differ
[1mdiff --git a/kern/compile/ASST1/traffic_synch.o b/kern/compile/ASST1/traffic_synch.o[m
[1mindex 5b46635..ce35fc3 100644[m
Binary files a/kern/compile/ASST1/traffic_synch.o and b/kern/compile/ASST1/traffic_synch.o differ
[1mdiff --git a/kern/compile/ASST1/tt3.o b/kern/compile/ASST1/tt3.o[m
[1mindex 85a4ec9..8875654 100644[m
Binary files a/kern/compile/ASST1/tt3.o and b/kern/compile/ASST1/tt3.o differ
[1mdiff --git a/kern/compile/ASST1/uw-tests.o b/kern/compile/ASST1/uw-tests.o[m
[1mindex cd6eaaa..d7ef546 100644[m
Binary files a/kern/compile/ASST1/uw-tests.o and b/kern/compile/ASST1/uw-tests.o differ
[1mdiff --git a/kern/compile/ASST1/uw-vmstats.o b/kern/compile/ASST1/uw-vmstats.o[m
[1mindex 799b8d1..09f3d74 100644[m
Binary files a/kern/compile/ASST1/uw-vmstats.o and b/kern/compile/ASST1/uw-vmstats.o differ
[1mdiff --git a/kern/compile/ASST1/vers.c b/kern/compile/ASST1/vers.c[m
[1mindex 9f79826..7265bc9 100644[m
[1m--- a/kern/compile/ASST1/vers.c[m
[1m+++ b/kern/compile/ASST1/vers.c[m
[36m@@ -1,3 +1,3 @@[m
 /* This file is automatically generated. Edits will be lost.*/[m
[31m-const int buildversion = 1;[m
[32m+[m[32mconst int buildversion = 33;[m
 const char buildconfig[] = "ASST1";[m
[1mdiff --git a/kern/compile/ASST1/vers.o b/kern/compile/ASST1/vers.o[m
[1mindex 70d7095..9913fd1 100644[m
Binary files a/kern/compile/ASST1/vers.o and b/kern/compile/ASST1/vers.o differ
[1mdiff --git a/kern/compile/ASST1/version b/kern/compile/ASST1/version[m
[1mindex d00491f..bb95160 100644[m
[1m--- a/kern/compile/ASST1/version[m
[1m+++ b/kern/compile/ASST1/version[m
[36m@@ -1 +1 @@[m
[31m-1[m
[32m+[m[32m33[m
[1mdiff --git a/kern/compile/ASST1/vfslist.o b/kern/compile/ASST1/vfslist.o[m
[1mindex e5c2f9f..97e54c1 100644[m
Binary files a/kern/compile/ASST1/vfslist.o and b/kern/compile/ASST1/vfslist.o differ
[1mdiff --git a/kern/compile/ASST1/vfslookup.o b/kern/compile/ASST1/vfslookup.o[m
[1mindex 53e3b09..1f2a2a6 100644[m
Binary files a/kern/compile/ASST1/vfslookup.o and b/kern/compile/ASST1/vfslookup.o differ
[1mdiff --git a/kern/compile/ASST1/vnode.o b/kern/compile/ASST1/vnode.o[m
[1mindex 7ff8a71..bfb27be 100644[m
Binary files a/kern/compile/ASST1/vnode.o and b/kern/compile/ASST1/vnode.o differ
[1mdiff --git a/kern/include/synch.h b/kern/include/synch.h[m
[1mindex 2ccc642..5778a44 100644[m
[1m--- a/kern/include/synch.h[m
[1m+++ b/kern/include/synch.h[m
[36m@@ -74,6 +74,11 @@[m [mvoid V(struct semaphore *);[m
  */[m
 struct lock {[m
         char *lk_name;[m
[32m+[m[32m        struct spinlock lk_spinlock;[m
[32m+[m[32m        struct wchan *lk_wchan;[m
[32m+[m[32m        volatile int lk;[m
[32m+[m[32m        struct thread *lk_holder;[m
[32m+[m
         // add what you need here[m
         // (don't forget to mark things volatile as needed)[m
 };[m
[36m@@ -113,6 +118,8 @@[m [mvoid lock_destroy(struct lock *);[m
 [m
 struct cv {[m
         char *cv_name;[m
[32m+[m[32m        //struct spinlock cv_lock;[m
[32m+[m[32m        struct wchan* wchan;[m
         // add what you need here[m
         // (don't forget to mark things volatile as needed)[m
 };[m
[1mdiff --git a/kern/include/syscall.h b/kern/include/syscall.h[m
[1mindex 81caf1b..e915f3a 100644[m
[1m--- a/kern/include/syscall.h[m
[1m+++ b/kern/include/syscall.h[m
[36m@@ -29,7 +29,7 @@[m
 [m
 #ifndef _SYSCALL_H_[m
 #define _SYSCALL_H_[m
[31m-[m
[32m+[m[32m#include <opt-A2.h>[m
 [m
 struct trapframe; /* from <machine/trapframe.h> */[m
 [m
[36m@@ -63,7 +63,10 @@[m [mint sys_write(int fdesc,userptr_t ubuf,unsigned int nbytes,int *retval);[m
 void sys__exit(int exitcode);[m
 int sys_getpid(pid_t *retval);[m
 int sys_waitpid(pid_t pid, userptr_t status, int options, pid_t *retval);[m
[31m-[m
 #endif // UW[m
 [m
[32m+[m[32m#if OPT_A2[m
[32m+[m[32mint sys_fork(void);[m
[32m+[m[32m#endif[m
[32m+[m
 #endif /* _SYSCALL_H_ */[m
[1mdiff --git a/kern/synchprobs/traffic_synch.c b/kern/synchprobs/traffic_synch.c[m
[1mindex 492a32d..f6aae4a 100644[m
[1m--- a/kern/synchprobs/traffic_synch.c[m
[1m+++ b/kern/synchprobs/traffic_synch.c[m
[36m@@ -4,6 +4,7 @@[m
 #include <synch.h>[m
 #include <opt-A1.h>[m
 [m
[32m+[m
 /* [m
  * This simple default synchronization mechanism allows only vehicle at a time[m
  * into the intersection.   The intersectionSem is used as a a lock.[m
[36m@@ -22,6 +23,14 @@[m
  * replace this with declarations of any synchronization and other variables you need here[m
  */[m
 static struct semaphore *intersectionSem;[m
[32m+[m[32mstatic struct semaphore *North;[m
[32m+[m[32mstatic struct semaphore *East;[m
[32m+[m[32mstatic struct semaphore *South;[m
[32m+[m[32mstatic struct semaphore *West;[m
[32m+[m
[32m+[m[32m//set initial direction[m
[32m+[m[32mDirection currDir = 0;[m
[32m+[m[32mstatic int redLightCounter = 3;[m
 [m
 [m
 /* [m
[36m@@ -34,11 +43,13 @@[m [mstatic struct semaphore *intersectionSem;[m
 void[m
 intersection_sync_init(void)[m
 {[m
[31m-  /* replace this default implementation with your own implementation */[m
[31m-[m
   intersectionSem = sem_create("intersectionSem",1);[m
[31m-  if (intersectionSem == NULL) {[m
[31m-    panic("could not create intersection semaphore");[m
[32m+[m[32m  North = sem_create("North",2147483647);[m
[32m+[m[32m  East = sem_create("East",2147483647);[m
[32m+[m[32m  South = sem_create("South",2147483647);[m
[32m+[m[32m  West = sem_create("West",2147483647);[m
[32m+[m[32m  if (intersectionSem == NULL || North == NULL || East == NULL || West == NULL || South == NULL) {[m
[32m+[m[32m  panic("could not create a trafficsemaphore");[m
   }[m
   return;[m
 }[m
[36m@@ -53,8 +64,16 @@[m [mintersection_sync_init(void)[m
 void[m
 intersection_sync_cleanup(void)[m
 {[m
[31m-  /* replace this default implementation with your own implementation */[m
[32m+[m[41m  [m
   KASSERT(intersectionSem != NULL);[m
[32m+[m[32m  KASSERT(North != NULL);[m
[32m+[m[32m  KASSERT(East != NULL);[m
[32m+[m[32m  KASSERT(South != NULL);[m
[32m+[m[32m  KASSERT(West != NULL);[m
[32m+[m[32m  sem_destroy(North);[m
[32m+[m[32m  sem_destroy(East);[m
[32m+[m[32m  sem_destroy(South);[m
[32m+[m[32m  sem_destroy(West);[m
   sem_destroy(intersectionSem);[m
 }[m
 [m
[36m@@ -75,14 +94,35 @@[m [mintersection_sync_cleanup(void)[m
 void[m
 intersection_before_entry(Direction origin, Direction destination) [m
 {[m
[31m-  /* replace this default implementation with your own implementation */[m
[31m-  (void)origin;  /* avoid compiler complaint about unused parameter */[m
[31m-  (void)destination; /* avoid compiler complaint about unused parameter */[m
[32m+[m[41m  [m
[32m+[m[32m  (void)origin;[m[41m  [m
[32m+[m[32m  (void)destination;[m[41m [m
   KASSERT(intersectionSem != NULL);[m
[32m+[m[32m  KASSERT(North != NULL);[m
[32m+[m[32m  KASSERT(East != NULL);[m
[32m+[m[32m  KASSERT(South != NULL);[m
[32m+[m[32m  KASSERT(West != NULL);[m
[32m+[m[41m  [m
[32m+[m[32m  //lock interection[m
   P(intersectionSem);[m
[32m+[m[41m  [m
[32m+[m[32m  //add vehicle to respetive wait queue[m
[32m+[m[32m  if(origin == 0){[m
[32m+[m[32m    P(North);[m
[32m+[m[32m  }[m
[32m+[m[32m  else if(origin == 1){[m
[32m+[m[32m    P(East);[m
[32m+[m[32m  }[m
[32m+[m[32m  else if(origin == 2){[m
[32m+[m[32m    P(South);[m
[32m+[m[32m  }[m
[32m+[m[32m  else{[m
[32m+[m[32m    P(West);[m
[32m+[m[32m  }[m
 }[m
 [m
 [m
[32m+[m
 /*[m
  * The simulation driver will call this function each time a vehicle[m
  * leaves the intersection.[m
[36m@@ -97,9 +137,110 @@[m [mintersection_before_entry(Direction origin, Direction destination)[m
 void[m
 intersection_after_exit(Direction origin, Direction destination) [m
 {[m
[31m-  /* replace this default implementation with your own implementation */[m
[31m-  (void)origin;  /* avoid compiler complaint about unused parameter */[m
[31m-  (void)destination; /* avoid compiler complaint about unused parameter */[m
[32m+[m[32m  (void)origin;[m[41m  [m
[32m+[m[32m  (void)destination;[m[41m [m
   KASSERT(intersectionSem != NULL);[m
[32m+[m[32m  KASSERT(North != NULL);[m
[32m+[m[32m  KASSERT(East != NULL);[m
[32m+[m[32m  KASSERT(South != NULL);[m
[32m+[m[32m  KASSERT(West != NULL);[m
[32m+[m[41m  [m
[32m+[m
[32m+[m[32m  //1) signal car on current wait queue to wake[m
[32m+[m[32m  //2) if no one is waiting in that queue, try the next one[m
[32m+[m[32m  //3) if we have been on the same queue for 5 straight turns, give next a chance[m
[32m+[m[41m  [m
[32m+[m[32m  //check is queues have cars waiting[m
[32m+[m[32m  bool isN_Empty = (North->sem_count > -1);[m
[32m+[m[32m  bool isE_Empty = (East->sem_count > -1);[m
[32m+[m[32m  bool isS_Empty = (South->sem_count > -1);[m
[32m+[m[32m  bool isW_Empty = (West->sem_count > -1);[m
[32m+[m
[32m+[m[32m  //if we have been at the same queue 5 times give another a chance[m
[32m+[m[32m  if(redLightCounter == 0){[m
[32m+[m[32m    redLightCounter = 5;[m
[32m+[m[32m    if(currDir == 3){[m
[32m+[m[32m      currDir = 0;[m
[32m+[m[32m    }[m
[32m+[m[32m    else{[m
[32m+[m[32m      currDir += 1;[m
[32m+[m[32m    }[m
[32m+[m[32m  }[m
[32m+[m
[32m+[m[32m  //signal to current queue or another if its empty[m
[32m+[m[32m  if(currDir == 0){[m
[32m+[m[32m    if(!isN_Empty){[m
[32m+[m[32m      V(North);[m
[32m+[m[32m    }[m
[32m+[m[32m    else if(!isE_Empty){[m
[32m+[m[32m      currDir = 1;[m
[32m+[m[32m      V(East);[m
[32m+[m[32m    }[m
[32m+[m[32m    else if(!isS_Empty){[m
[32m+[m[32m      currDir = 2;[m
[32m+[m[32m      V(South);[m
[32m+[m[32m    }[m
[32m+[m[32m    else if(!isW_Empty){[m
[32m+[m[32m      currDir = 3;[m
[32m+[m[32m      V(West);[m
[32m+[m[32m    }[m
[32m+[m[32m    else{}[m
[32m+[m[32m  }[m
[32m+[m[32m  else if(currDir == 1){[m
[32m+[m[32m    if(!isE_Empty){[m
[32m+[m[32m      V(East);[m
[32m+[m[32m    }[m
[32m+[m[32m    else if(!isS_Empty){[m
[32m+[m[32m      currDir = 2;[m
[32m+[m[32m      V(South);[m
[32m+[m[32m    }[m
[32m+[m[32m    else if(!isW_Empty){[m
[32m+[m[32m      currDir = 3;[m
[32m+[m[32m      V(West);[m
[32m+[m[32m    }[m
[32m+[m[32m    else if(!isN_Empty){[m
[32m+[m[32m      currDir = 0;[m
[32m+[m[32m      V(North);[m
[32m+[m[32m    }[m
[32m+[m[32m    else{}[m
[32m+[m[32m  }[m
[32m+[m[32m  else if(currDir == 2){[m
[32m+[m[32m    if(!isS_Empty){[m
[32m+[m[32m      V(South);[m
[32m+[m[32m    }[m
[32m+[m[32m    else if(!isW_Empty){[m
[32m+[m[32m      currDir = 3;[m
[32m+[m[32m      V(West);[m
[32m+[m[32m    }[m
[32m+[m[32m    else if(!isN_Empty){[m
[32m+[m[32m      currDir = 0;[m
[32m+[m[32m      V(North);[m
[32m+[m[32m    }[m
[32m+[m[32m    else if(!isE_Empty){[m
[32m+[m[32m      currDir = 1;[m
[32m+[m[32m      V(East);[m
[32m+[m[32m    }[m
[32m+[m[32m    else{}[m
[32m+[m[32m  }[m
[32m+[m[32m  else if(currDir == 3){[m
[32m+[m[32m    if(!isW_Empty){[m
[32m+[m[32m      V(West);[m
[32m+[m[32m    }[m
[32m+[m[32m    else if(!isN_Empty){[m
[32m+[m[32m      currDir = 0;[m
[32m+[m[32m      V(North);[m
[32m+[m[32m    }[m
[32m+[m[32m    else if(!isE_Empty){[m
[32m+[m[32m      currDir = 1;[m
[32m+[m[32m      V(East);[m
[32m+[m[32m    }[m
[32m+[m[32m    else if(!isS_Empty){[m
[32m+[m[32m      currDir = 2;[m
[32m+[m[32m      V(South);[m
[32m+[m[32m    }[m
[32m+[m[32m    else{}[m
[32m+[m[32m  }[m
[32m+[m
[32m+[m[32m  redLightCounter--;[m[41m  [m
   V(intersectionSem);[m
 }[m
[1mdiff --git a/kern/syscall/proc_syscalls.c b/kern/syscall/proc_syscalls.c[m
[1mindex 36c2cf1..06a326c 100644[m
[1m--- a/kern/syscall/proc_syscalls.c[m
[1m+++ b/kern/syscall/proc_syscalls.c[m
[36m@@ -92,3 +92,6 @@[m [msys_waitpid(pid_t pid,[m
   return(0);[m
 }[m
 [m
[32m+[m[32mint sys_fork(void){[m
[32m+[m[32m  return 0;[m
[32m+[m[32m}[m
[1mdiff --git a/kern/thread/.synch.c.swp b/kern/thread/.synch.c.swp[m
[1mdeleted file mode 100644[m
[1mindex 8297064..0000000[m
Binary files a/kern/thread/.synch.c.swp and /dev/null differ
[1mdiff --git a/kern/thread/synch.c b/kern/thread/synch.c[m
[1mindex 9a7468c..758464b 100644[m
[1m--- a/kern/thread/synch.c[m
[1m+++ b/kern/thread/synch.c[m
[36m@@ -161,10 +161,26 @@[m [mlock_create(const char *name)[m
         if (lock->lk_name == NULL) {[m
                 kfree(lock);[m
                 return NULL;[m
[31m-        }[m
[32m+[m[32m        }[m[41m        [m
         [m
         // add stuff here as needed[m
[32m+[m
[32m+[m[32m        //initialize lock value[m
[32m+[m[32m        lock->lk = 0;[m
[32m+[m
[32m+[m[32m        //initialize lock's thread[m
[32m+[m[32m        lock->lk_holder = NULL;[m
[32m+[m
[32m+[m[32m        //initialize wchan[m
[32m+[m	[32m      lock->lk_wchan = wchan_create(lock->lk_name);[m
[32m+[m	[32m      if (lock->lk_wchan == NULL) {[m
[32m+[m		[32m        kfree(lock->lk_name);[m
[32m+[m		[32m        kfree(lock);[m
[32m+[m		[32m        return NULL;[m
[32m+[m	[32m      }[m
         [m
[32m+[m[32m        //initialize spinlock[m
[32m+[m	[32m      spinlock_init(&lock->lk_spinlock);[m[41m [m
         return lock;[m
 }[m
 [m
[36m@@ -174,35 +190,74 @@[m [mlock_destroy(struct lock *lock)[m
         KASSERT(lock != NULL);[m
 [m
         // add stuff here as needed[m
[31m-        [m
[32m+[m[32m        spinlock_cleanup(&lock->lk_spinlock);[m
[32m+[m	[32m      wchan_destroy(lock->lk_wchan);[m
[32m+[m[32m        kfree(lock->lk_holder);[m
         kfree(lock->lk_name);[m
         kfree(lock);[m
[32m+[m
 }[m
 [m
 void[m
 lock_acquire(struct lock *lock)[m
 {[m
[31m-        // Write this[m
[31m-[m
[31m-        (void)lock;  // suppress warning until code gets written[m
[32m+[m[32m      //(void)lock;[m
[32m+[m[32m      //kprintf("lock_acquire");[m
[32m+[m[41m      [m
[32m+[m[32m      KASSERT(lock != NULL);[m
[32m+[m[41m      [m
[32m+[m[41m      [m
[32m+[m[32m      // Write this[m
[32m+[m[41m       [m
[32m+[m[32m      if(lock_do_i_hold(lock)){[m
[32m+[m[32m         return;[m
[32m+[m[32m      }[m
[32m+[m
[32m+[m[41m      [m
[32m+[m[32m      spinlock_acquire(&lock->lk_spinlock);[m
[32m+[m[32m        while(lock->lk == 1){[m
[32m+[m[32m          wchan_lock(lock->lk_wchan);[m
[32m+[m[32m          spinlock_release(&lock->lk_spinlock);[m
[32m+[m[32m          wchan_sleep(lock->lk_wchan);[m
[32m+[m[32m          spinlock_acquire(&lock->lk_spinlock);[m
[32m+[m[32m        }[m
[32m+[m[41m        [m
[32m+[m[32m        lock->lk_holder = curthread;[m
[32m+[m[32m        lock->lk = 1;[m
[32m+[m[32m        spinlock_release(&lock->lk_spinlock);[m
 }[m
 [m
 void[m
[31m-lock_release(struct lock *lock)[m
[31m-{[m
[31m-        // Write this[m
[32m+[m[32mlock_release(struct lock *lock){[m
[32m+[m
[32m+[m[32m        //(void)lock;[m
[32m+[m[41m       [m
[32m+[m[32m        KASSERT(lock != NULL);[m
[32m+[m[41m  [m
[32m+[m[32m        if(!lock_do_i_hold(lock)){[m
[32m+[m[32m          return;[m
[32m+[m[32m        }[m
 [m
[31m-        (void)lock;  // suppress warning until code gets written[m
[32m+[m[32m        spinlock_acquire(&lock->lk_spinlock);[m
[32m+[m[32m        lock->lk = 0;[m
[32m+[m[32m        lock->lk_holder = NULL;[m
[32m+[m[32m        wchan_wakeone(lock->lk_wchan);[m
[32m+[m[32m        spinlock_release(&lock->lk_spinlock);[m
 }[m
 [m
 bool[m
 lock_do_i_hold(struct lock *lock)[m
 {[m
[31m-        // Write this[m
[32m+[m[41m        [m
[32m+[m[32m        //(void)lock;[m
[32m+[m[32m        KASSERT(lock != NULL);[m
 [m
[31m-        (void)lock;  // suppress warning until code gets written[m
[32m+[m[32m        // Write this[m
[32m+[m[32m        if(lock->lk_holder == curthread){[m
[32m+[m[32m          return true;[m
[32m+[m[32m        }[m
 [m
[31m-        return true; // dummy until code gets written[m
[32m+[m[32m        return false; // dummy until code gets written[m
 }[m
 [m
 ////////////////////////////////////////////////////////////[m
[36m@@ -211,8 +266,7 @@[m [mlock_do_i_hold(struct lock *lock)[m
 [m
 [m
 struct cv *[m
[31m-cv_create(const char *name)[m
[31m-{[m
[32m+[m[32mcv_create(const char *name){[m
         struct cv *cv;[m
 [m
         cv = kmalloc(sizeof(struct cv));[m
[36m@@ -226,18 +280,26 @@[m [mcv_create(const char *name)[m
                 return NULL;[m
         }[m
         [m
[31m-        // add stuff here as needed[m
[32m+[m[32m        //initialize cv wait channel[m
[32m+[m	[32m      cv->wchan = wchan_create(cv->cv_name);[m
[32m+[m	[32m      if (cv->wchan == NULL) {[m
[32m+[m		[32m        kfree(cv->cv_name);[m
[32m+[m		[32m        kfree(cv);[m
[32m+[m		[32m        return NULL;[m
[32m+[m[32m        }[m
[32m+[m
[32m+[m[32m        //spinlock_init(&cv->cv_lock);[m
         [m
         return cv;[m
 }[m
 [m
 void[m
[31m-cv_destroy(struct cv *cv)[m
[31m-{[m
[32m+[m[32mcv_destroy(struct cv *cv){[m
         KASSERT(cv != NULL);[m
 [m
         // add stuff here as needed[m
[31m-        [m
[32m+[m[32m        //spinlock_cleanup(&cv->cv_lock);[m
[32m+[m[32m        wchan_destroy(cv->wchan);[m[41m        [m
         kfree(cv->cv_name);[m
         kfree(cv);[m
 }[m
[36m@@ -245,23 +307,50 @@[m [mcv_destroy(struct cv *cv)[m
 void[m
 cv_wait(struct cv *cv, struct lock *lock)[m
 {[m
[31m-        // Write this[m
[31m-        (void)cv;    // suppress warning until code gets written[m
[31m-        (void)lock;  // suppress warning until code gets written[m
[32m+[m[32m        KASSERT(cv != NULL);[m
[32m+[m[32m        KASSERT(lock != NULL);[m
[32m+[m[41m        [m
[32m+[m[32m        //spinlock_acquire(&cv->cv_lock);[m
[32m+[m[41m        [m
[32m+[m[32m        wchan_lock(cv->wchan);[m
[32m+[m[32m        lock_release(lock);[m
[32m+[m[41m        [m
[32m+[m[32m        //spinlock_release(&cv->cv_lock);[m
[32m+[m[32m        wchan_sleep(cv->wchan);[m
[32m+[m[41m        [m
[32m+[m[32m        lock_acquire(lock);[m
[32m+[m[41m        [m
[32m+[m[32m        //(void)cv;    // suppress warning until code gets written[m
[32m+[m[32m        //(void)lock;  // suppress warning until code gets written[m
 }[m
 [m
 void[m
 cv_signal(struct cv *cv, struct lock *lock)[m
 {[m
[31m-        // Write this[m
[31m-	(void)cv;    // suppress warning until code gets written[m
[31m-	(void)lock;  // suppress warning until code gets written[m
[32m+[m[41m        [m
[32m+[m[32m  KASSERT(cv != NULL);[m
[32m+[m[32m  KASSERT(lock != NULL);[m
[32m+[m[32m  //KASSERT(lock->lk_holder == curthread);[m
[32m+[m[41m  [m
[32m+[m[32m   //spinlock_acquire(&cv->cv_lock);[m
[32m+[m[32m   wchan_wakeone(cv->wchan);[m
[32m+[m[32m   //spinlock_release(&cv->cv_lock);[m
[32m+[m[32m  //lock_release(lock);[m
[32m+[m
[32m+[m	[32m//(void)cv;    // suppress warning until code gets written[m
[32m+[m	[32m//(void)lock;  // suppress warning until code gets written[m
 }[m
 [m
 void[m
 cv_broadcast(struct cv *cv, struct lock *lock)[m
 {[m
[31m-	// Write this[m
[31m-	(void)cv;    // suppress warning until code gets written[m
[31m-	(void)lock;  // suppress warning until code gets written[m
[32m+[m	[32mKASSERT(cv != NULL);[m
[32m+[m[32m  KASSERT(lock != NULL);[m
[32m+[m
[32m+[m[32m  //wchan_lock(cv->wchan);[m
[32m+[m[32m  wchan_wakeall(cv->wchan);[m
[32m+[m[32m  //lock_release(lock);[m
[32m+[m
[32m+[m	[32m//(void)cv;    // suppress warning until code gets written[m
[32m+[m	[32m//(void)lock;  // suppress warning until code gets written[m
 }[m
