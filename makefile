wrapper: wrap.w
	python wrap/wrap.py -o splitwrap.C wrap.w
	mpicc -c splitwrap.C -o lib/splitwrap.o -w
	ar cr lib/libsplitwrap.a lib/splitwrap.o
	ranlib lib/libsplitwrap.a

hello:  src/mpi_hello.c
	mpicc -o hello.out mpi_hello.c lib/libsplitwrap.a -lstdc++
	cp hello.out hello2.out
	cp hello.out hello3.out

submit:
	msub moab.sh
all:
	make wrapper
	make hello
	make submit

clean:
	rm -rf hello.out hello2.out hello3.out 