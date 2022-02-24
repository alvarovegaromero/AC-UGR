#include <stdio.h>
#include <stdlib.h>

#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_get_thread_num() 0
#endif

//gcc -fopenmp -O2 -o scheduled-clauseModificado5 scheduled-clauseModificado5.c

main(int argc, char **argv) 
{
	int i, n=200,chunk,a[n],suma=0;
	if(argc < 3) 
	{
		fprintf(stderr,"\nFalta iteraciones o chunk \n");
		exit(-1);
	}

	n = atoi(argv[1]); 
	if (n>200) 
		n=200;
	chunk = atoi(argv[2]);

	for (i=0; i<n; i++) 
		a[i] = i;

	omp_sched_t tipo;
	int modif;

	#pragma omp parallel 
	{
		#pragma omp for firstprivate(suma) lastprivate(suma) schedule(dynamic,chunk)
		for (i=0; i<n; i++)
		{ 
			suma = suma + a[i];
			printf(" thread %d suma a[%d]=%d suma=%d \n", omp_get_thread_num(),i,a[i],suma);
		}

		#pragma omp single
		{

		omp_get_schedule(&tipo, &modif);
		printf("DENTRO DE LA REGIÓN PARALELIRAZADA, ANTES DE MODIFICAR: \n");

		printf("dyn_var: %d\n", omp_get_dynamic());
		printf("nthreads-var: %d\n", omp_get_max_threads());
		printf("run-sched-var: %d y modif: %d \n\n", tipo, modif);

		if(tipo == omp_sched_static) printf("Tipo es static\n");
		else if(tipo == omp_sched_dynamic) printf("Tipo es dinámico\n");
		else if(tipo == omp_sched_guided) printf("Tipo es guided\n");
		else printf("Tipo es auto\n");

		//Modificamos

		omp_set_dynamic(10);
		omp_set_num_threads(4); //asignarle 4 hebras
		omp_set_schedule(1, 2);

		omp_get_schedule(&tipo, &modif);
		printf("DENTRO DE LA REGIÓN PARALELIRAZADA, DESPUÉS DE MODIFICAR: \n");

		printf("dyn_var: %d\n", omp_get_dynamic());
		printf("nthreads-var: %d\n", omp_get_max_threads());
		printf("run-sched-var: %d y modif: %d \n\n", tipo, modif);

		}
	}

	omp_get_schedule(&tipo, &modif);
	printf("FUERA DE LA REGIÓN PARALELIRAZADA, ANTES DE MODIFICAR: \n");

	printf("dyn_var: %d\n", omp_get_dynamic());
	printf("nthreads-var: %d\n", omp_get_max_threads());
	printf("run-sched-var: %d y modif: %d \n\n", tipo, modif);

	omp_set_dynamic(5);
	omp_set_num_threads(2); //asignarle 4 hebras
	omp_set_schedule(2, 1);

	printf("Fuera de 'parallel for' suma=%d\n",suma);
	printf("FUERA DE LA REGIÓN PARALELIRAZADA, DESPUÉS DE MODIFICAR: \n");	
	printf("dyn_var: %d\n", omp_get_dynamic());
	printf("nthreads-var: %d\n", omp_get_max_threads());
	printf("run-sched-var: %d y modif: %d \n", tipo, modif);	
}