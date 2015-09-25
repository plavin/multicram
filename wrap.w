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

   int group = rank/4;
   // now keep only the first 48 ranks of each 64.
   //int keep = (rank % 64 < 48) ? 1: 0;
   if(group==0){
      PMPI_Comm_split(MPI_COMM_WORLD,  group, rank, &comm1);
   }else{
      PMPI_Comm_split(MPI_COMM_WORLD,  group, rank, &comm2);
   }
}{{endfn}}

{{fnall func MPI_Init}}{
   {{apply_to_type MPI_Comm swap_world}}
   {{callfn}}
}{{endfnall}}