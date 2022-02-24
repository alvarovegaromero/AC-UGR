#include <stdio.h>
#include <stdlib.h>
#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_get_thread_num() 0
#endif

//export OMP_SCHEDULE="monotonic:static,x" y sus variantes
//gcc -O2 -fopenmp -o schedule-clause schedule-clause.c
//OMP_NUM_THREADS=3

main(int argc, char **argv) {
	int i, n=200,chunk,a[n],suma=0;

	if(argc < 3) {
		fprintf(stderr,"\nFalta iteraciones o chunk \n");
		exit(-1);
	}

	int modifier;
	omp_sched_t kind;

	omp_get_schedule(&kind, &modifier);

	printf("Valores por defecto: %d y el chunk: %d \n", kind, modifier);

	n = atoi(argv[1]); 

	if (n>200) 
		n=200; 

	chunk = atoi(argv[2]);

	for (i=0; i<n; i++) 
		a[i] = i;

	#pragma omp parallel for firstprivate(suma) lastprivate(suma) schedule(runtime)
	for (i=0; i<n; i++)
	{ 
		suma = suma + a[i];
		printf(" thread %d suma a[%d]=%d suma=%d \n",
		omp_get_thread_num(),i,a[i],suma);
	}

	printf("Fuera de 'parallel for' suma=%d\n",suma);
}