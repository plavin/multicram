# Multicram

Inspired by Todd Gamblin's Cram, (and possibly a reimplementation of a CRAM feature), this program allows multiple MPI jobs to be run next to each other on a cluster, each with their own communicator. The jobs can be different executables and can each use a different number of ranks. 

##Usage 

1. First, compile the library, libsplitwrap.a with `make wrapper`. This code depends on wrap.py, also by Todd Gamblin. It is simply a collection of mpi wrappers that will split each job into its own communicator. (MPI_COMM_WORLD is replaced with a sub communicator.)

2. Then compile your MPI program(s) with the library to replace the normal MPI bindings. (An example is given in `make hello`.)

3. Create `multi.conf` to specifiy the executables and the ranks on which to place them. This step will most likely be machine dependent. (An example `multi.conf` is provided, and will work for Catalyst and similar machines. It has not been tested on BG/Q.)

4. When submitting your job, specify `--multi-prog $(PWD)/multi.conf` in the moab script. (An example is provided.)

