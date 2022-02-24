#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <malloc.h>

//gcc -O2 -fopenmp -o pmv-secuencialGLOBAL pmv-secuencialGLOBAL.c

#ifdef _OPENMP
	#include <omp.h>
#else
	#define omp_get_thread_num() 0
#endif

#define MAX 33554432	//=2^25

int main(int argc, char const * argv[])
{
	if(argc != 2)
	{
		fprintf(stderr, "Introduce un único argumento: N \n");
		exit(EXIT_FAILURE);
	}

	int i, j;
	unsigned int n = atoi(argv[1]);
	double cgt1, cgt2, tiempo;
	double suma = 0;

	if(n>MAX)
		n=MAX;


	double **A, *B, *C, t;

	A=(double**) malloc (n*sizeof(double*));
	B=(double*) malloc (n*sizeof(double));
	C=(double*) malloc (n*sizeof(double));

	if((A==NULL) || (B==NULL) || (C==NULL))
	{
		printf("Error en la reserva de memoria\n");
		exit(-2);
	}

	for(i = 0 ; i < n ; i++)
	{
		A[i] = (double*) malloc (n*sizeof(double));

		if(A[i] == NULL)
		{
			printf("Error en la reserva de memoria\n");
			exit(-3);
		}
	}

	for(i = 0 ; i < n ; i++) //Rellenar matriz de datos "aleatorios" y Vectores - Se puede hacer con directiva master, o de forma secuencial
	{
		B[i]= 0.5*i;
		C[i]=0;
		for(j = 0 ; j < n ; j++)
			A[i][j] = 0.5*i - 0.5*j;
	}

	cgt1 = omp_get_wtime();

	#pragma omp parallel for shared(A,B,C,n) schedule(runtime) private(j) //i ya es privada
		for(i = 0 ; i < n ; i++) //Calculo del producto
		{

			printf(" thread %d, fila: %d \n", omp_get_thread_num(),i);
	
			for(j = i ; j >= 0 ; j--)
			{
				C[i] += A[i][j] * B[j];
					/*
					printf("A[%d][%d] = %f con i=%d y j=%d ", i, j, A[i][j], i, j);
					printf("B[%d] = %f con j=%d ", j, B[j], j);
					printf("\n\n");
					*/
			}
		}

	cgt2 = omp_get_wtime();
	tiempo = cgt2 - cgt1;

	//Salida

	printf("Tiempo de ejecución: %f \n", tiempo);
	printf("Valor de n: %d \n", n);

	if(n < 3) //Si es de tam pequeño
	{
		for(int i = 0 ; i < n ; i++)
			printf("C[%d] = %f \n", i, C[i]);
	}
	else
	{
			printf("C[0] = %f \n", C[0]);
			printf("C[ULTIMO] = %f \n", C[n-1]);
	}

	//Liberar memoria

	for(i=0 ; i < n ; i++)
		free(A[i]);

	free(A);
	free(B);
	free(C);
}