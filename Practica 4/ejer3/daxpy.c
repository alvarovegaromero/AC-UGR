#include <stdlib.h> // biblioteca con funciones atoi(), rand(), srand(), malloc() y free()
#include <stdio.h> // biblioteca donde se encuentra la función printf()
#include <time.h>     // biblioteca donde se encuentra la función clock_gettime()
 
int main(int argc, char** argv)
{ 
  //Leer argumento de entrada (nº de componentes del vector)
  if (argc<2)
  {     
    printf("Falta N\n");
    exit(-1);
  }
 
  unsigned int N = atoi(argv[1]);
  const int a = 23 ; // cte
  int i;
  struct timespec cgt1,cgt2; double ncgt; //para tiempo de ejecución
  double *x = (double *) malloc(N*sizeof(double));
  double *y = (double *) malloc(N*sizeof(double));
 
  //Inicializar vectores

    srand(time(0));
    for (i = 0; i < N; i++)
    {
      x[i] = rand()/ ((double) rand()); 
      y[i] = rand()/ ((double) rand()); 
    }
 
  clock_gettime(CLOCK_REALTIME,&cgt1);

   for (i = 0 ; i < N ; i++)
   {
    y[i] += a*x[i];
   }
 
  clock_gettime(CLOCK_REALTIME,&cgt2);
  ncgt=(double) (cgt2.tv_sec-cgt1.tv_sec) + (double) ((cgt2.tv_nsec-cgt1.tv_nsec)/(1.e+9));
 
  printf("Tiempo(seg.):%11.9f\t / Tamaño Vectores:N: %d, / y[0] = %f / y[N-1] = %f \n",ncgt,N, y[0], y[N-1]);
 
 
  return 0;
}

