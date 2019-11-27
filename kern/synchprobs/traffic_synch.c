#include <types.h>
#include <lib.h>
#include <synchprobs.h>
#include <synch.h>
#include <opt-A1.h>


/* 
 * This simple default synchronization mechanism allows only vehicle at a time
 * into the intersection.   The intersectionSem is used as a a lock.
 * We use a semaphore rather than a lock so that this code will work even
 * before locks are implemented.
 */

/* 
 * Replace this default synchronization mechanism with your own (better) mechanism
 * needed for your solution.   Your mechanism may use any of the available synchronzation
 * primitives, e.g., semaphores, locks, condition variables.   You are also free to 
 * declare other global variables if your solution requires them.
 */

/*
 * replace this with declarations of any synchronization and other variables you need here
 */
static struct semaphore *intersectionSem;
static struct semaphore *North;
static struct semaphore *East;
static struct semaphore *South;
static struct semaphore *West;

//set initial direction
Direction currDir = 0;
static int redLightCounter = 3;


/* 
 * The simulation driver will call this function once before starting
 * the simulation
 *
 * You can use it to initialize synchronization and other variables.
 * 
 */
void
intersection_sync_init(void)
{
  intersectionSem = sem_create("intersectionSem",1);
  North = sem_create("North",2147483647);
  East = sem_create("East",2147483647);
  South = sem_create("South",2147483647);
  West = sem_create("West",2147483647);
  if (intersectionSem == NULL || North == NULL || East == NULL || West == NULL || South == NULL) {
  panic("could not create a trafficsemaphore");
  }
  return;
}

/* 
 * The simulation driver will call this function once after
 * the simulation has finished
 *
 * You can use it to clean up any synchronization and other variables.
 *
 */
void
intersection_sync_cleanup(void)
{
  
  KASSERT(intersectionSem != NULL);
  KASSERT(North != NULL);
  KASSERT(East != NULL);
  KASSERT(South != NULL);
  KASSERT(West != NULL);
  sem_destroy(North);
  sem_destroy(East);
  sem_destroy(South);
  sem_destroy(West);
  sem_destroy(intersectionSem);
}


/*
 * The simulation driver will call this function each time a vehicle
 * tries to enter the intersection, before it enters.
 * This function should cause the calling simulation thread 
 * to block until it is OK for the vehicle to enter the intersection.
 *
 * parameters:
 *    * origin: the Direction from which the vehicle is arriving
 *    * destination: the Direction in which the vehicle is trying to go
 *
 * return value: none
 */

void
intersection_before_entry(Direction origin, Direction destination) 
{
  
  (void)origin;  
  (void)destination; 
  KASSERT(intersectionSem != NULL);
  KASSERT(North != NULL);
  KASSERT(East != NULL);
  KASSERT(South != NULL);
  KASSERT(West != NULL);
  
  //lock interection
  P(intersectionSem);
  
  //add vehicle to respetive wait queue
  if(origin == 0){
    P(North);
  }
  else if(origin == 1){
    P(East);
  }
  else if(origin == 2){
    P(South);
  }
  else{
    P(West);
  }
}



/*
 * The simulation driver will call this function each time a vehicle
 * leaves the intersection.
 *
 * parameters:
 *    * origin: the Direction from which the vehicle arrived
 *    * destination: the Direction in which the vehicle is going
 *
 * return value: none
 */

void
intersection_after_exit(Direction origin, Direction destination) 
{
  (void)origin;  
  (void)destination; 
  KASSERT(intersectionSem != NULL);
  KASSERT(North != NULL);
  KASSERT(East != NULL);
  KASSERT(South != NULL);
  KASSERT(West != NULL);
  

  //1) signal car on current wait queue to wake
  //2) if no one is waiting in that queue, try the next one
  //3) if we have been on the same queue for 5 straight turns, give next a chance
  
  //check is queues have cars waiting
  bool isN_Empty = (North->sem_count > -1);
  bool isE_Empty = (East->sem_count > -1);
  bool isS_Empty = (South->sem_count > -1);
  bool isW_Empty = (West->sem_count > -1);

  //if we have been at the same queue 5 times give another a chance
  if(redLightCounter == 0){
    redLightCounter = 5;
    if(currDir == 3){
      currDir = 0;
    }
    else{
      currDir += 1;
    }
  }

  //signal to current queue or another if its empty
  if(currDir == 0){
    if(!isN_Empty){
      V(North);
    }
    else if(!isE_Empty){
      currDir = 1;
      V(East);
    }
    else if(!isS_Empty){
      currDir = 2;
      V(South);
    }
    else if(!isW_Empty){
      currDir = 3;
      V(West);
    }
    else{}
  }
  else if(currDir == 1){
    if(!isE_Empty){
      V(East);
    }
    else if(!isS_Empty){
      currDir = 2;
      V(South);
    }
    else if(!isW_Empty){
      currDir = 3;
      V(West);
    }
    else if(!isN_Empty){
      currDir = 0;
      V(North);
    }
    else{}
  }
  else if(currDir == 2){
    if(!isS_Empty){
      V(South);
    }
    else if(!isW_Empty){
      currDir = 3;
      V(West);
    }
    else if(!isN_Empty){
      currDir = 0;
      V(North);
    }
    else if(!isE_Empty){
      currDir = 1;
      V(East);
    }
    else{}
  }
  else if(currDir == 3){
    if(!isW_Empty){
      V(West);
    }
    else if(!isN_Empty){
      currDir = 0;
      V(North);
    }
    else if(!isE_Empty){
      currDir = 1;
      V(East);
    }
    else if(!isS_Empty){
      currDir = 2;
      V(South);
    }
    else{}
  }

  redLightCounter--;  
  V(intersectionSem);
}
