// world_split.w
// Patrick Lavin
// Sept 2015
//
// This wrapper file will split a communicator in 2,
// using wrap.py

#include <mpi.h>

static MPI_Comm comm1, comm2;

inline void swap_world(MPI_Comm& world) {
   int rank;
   PMPI_Comm_rank(MPI_COMM_WORLD, &rank);
   if (world == MPI_COMM_WORLD) {
      if(rank/4==0){
         world = comm1;
      }else{
         world = comm2;
      }
   }
}

{{fn func MPI_Init}}{
   // First call PMPI_Init()
   {{callfn}}

   int rank;
   PMPI_Comm_rank(MPI_COMM_WORLD, &rank);

   int err = 0;
   int group = rank/4;
   if(group==0){
      if(PMPI_Comm_split(MPI_COMM_WORLD,  group, rank, &comm1)){
           printf("ERROR: 1\n");
      }
   }else{
      PMPI_Comm_split(MPI_COMM_WORLD,  group, rank, &comm2);
   }
}{{endfn}}

{{fnall func MPI_Init}}{
   {{apply_to_type MPI_Comm swap_world}}
   {{callfn}}
}{{endfnall}}
