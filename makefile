wrapper: wrap.w
	python wrap/wrap.py -o src/wrap.c wrap.w
wrapper2: wrap2.w
	python wrap/wrap.py -o src/splitwrap.C wrap2.w
	mpicc -c src/splitwrap.C -o lib/splitwrap.o -w
	ar cr lib/libsplitwrap.a lib/splitwrap.o
	ranlib lib/libsplitwrap.a

hello:  src/mpi_hello.c
	mpicc -o bin/hello src/mpi_hello.c lib/libsplitwrap.a -lstdc++
	cp bin/hello bin/hello2
submit:
	msub moab/moab.sh
all:
	make wrapper2
	make hello
	make submit
