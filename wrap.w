#include <mpi.h>
#include <stdio.h>

static MPI_Comm splitcomm;

inline void swap_world(MPI_Comm& world) {
  if (world == MPI_COMM_WORLD) {
    world = splitcomm;
  }
}

{{fn func MPI_Init}}{
  FILE * fp;					//open multi.conf
  fp = fopen("/g/g19/lavin2/multicram/moab/synthmulti.conf", "r");

  int a, b;
  char junk;
  char line[1024];
  int max[100];
  int len;
  int i = 0;

  while(fgets(line, sizeof line, fp) ) {	//find the max values
    if( sscanf(line, "%d %c %d", &a, &junk, &b) == 3 ){
      max[i] = b+1;
      i++;
    }
    else{
      printf("Possible in error in scan?\n");
      break;
    }
  }
  len = i;

  {{callfn}}					//first call PMPI_Init()

  int rank;					//get process rank
  PMPI_Comm_rank(MPI_COMM_WORLD, &rank);

  i = 0;
  int color;
  while(i < len){
    if (rank < max[i]){
      color = i;
      break;
    }else{
      i++;
    }
  }

  PMPI_Comm_split(MPI_COMM_WORLD, color, rank, &splitcomm);
  
}{{endfn}}

{{fnall func MPI_Init}}{
  {{apply_to_type MPI_Comm swap_world}}
  {{callfn}}
}{{endfnall}}
