#include <mpi.h>
#include <stdio.h>

static MPI_Comm splitcomm;

inline void swap_world(MPI_Comm& world) {
  if (world == MPI_COMM_WORLD) {
    world = splitcomm;
  }
}

{{fn func MPI_Init}}{
  {{callfn}}					//first call PMPI_Init()

  int rank;					//get process rank
  PMPI_Comm_rank(MPI_COMM_WORLD, &rank);

  int color = ((rank < 4) ? 1 : 2);		//separate processes into groups !!Generalize this!!
  PMPI_Comm_split(MPI_COMM_WORLD, color, rank, &splitcomm);
  
}{{endfn}}

{{fnall func MPI_Init}}{
  {{apply_to_type MPI_Comm swap_world}}
  {{callfn}}
}{{endfnall}}
