#include <stdlib.h> // biblioteca con funciones atoi(), rand(), srand(), malloc() y free()
#include <stdio.h> // biblioteca donde se encuentra la función printf()
#include <time.h>     // biblioteca donde se encuentra la función clock_gettime()
 
//gcc -O2 -lrt -o pmm-secuencial pmm-secuencial.c

//Sólo puede estar definida una de las tres constantes VECTOR_ (sólo uno de los ...
//tres defines siguientes puede estar descomentado):
//#define MATRIZ_LOcAL    // descomentar para que los vectores sean variables ...
                   // locales (si se supera el tamaño de la pila se ...
                   // generará el error "Violación de Segmento")
//#define MATRIZ_GLOBAL// descomentar para que los vectores sean variables ...
                   // globales (su longitud no estará limitada por el ...
                   // tamaño de la pila del programa)
#define MATRIZ_DYNAMIC    // descomentar para que los vectores sean variables ...
                   // dinámicas (memoria reutilizable durante la ejecución)
#ifdef MATRIZ_GLOBAL
#define MAX 33554432         //=2^25
double v1[MAX], v2[MAX], v3[MAX];
#endif
 
int main(int argc, char** argv)
{ 
  int i;
  struct timespec cgt1,cgt2; double ncgt; //para tiempo de ejecución
 
  //Leer argumento de entrada (nº de componentes del vector)
  if (argc<2)
  {     
    printf("Faltan nº cde filas y columnas de la matriz\n");
    exit(-1);
  }
 
  unsigned int N = atoi(argv[1]); // Máximo N =2^32-1=4294967295 (sizeof(unsigned int) = 4 B)
  #ifdef MATRIZ_LOCAL
  double m1[N][N], m2[N],[N] m3[N][N];   // Tamaño variable local en tiempo de ejecución ...
                        // disponible en C a partir de actualización C99
  #endif

  #ifdef MATRIZ_GLOBAL
  if (N>MAX) N=MAX;
  #endif

  #ifdef MATRIZ_DYNAMIC
  double **m1, **m2, **m3;
  m1 = (double**) malloc(N*sizeof(double*));// malloc necesita el tamaño en bytes
  m2 = (double**) malloc(N*sizeof(double*)); //si no hay espacio suficiente malloc devuelve NULL
  m3 = (double**) malloc(N*sizeof(double*));

  if ( (m1==NULL) || (m2==NULL) || (m3==NULL) )
  {     
    printf("Error en la reserva de espacio para las matrices\n");
    exit(-2);
  }

  for(i = 0 ; i < N ; i++)
  {
    m1[i] = (double*) malloc (N*sizeof(double));
    m2[i] = (double*) malloc (N*sizeof(double));
    m3[i] = (double*) malloc (N*sizeof(double));

    if((m1[i]==NULL) || (m2[i]==NULL) || (m3[i]==NULL))
      printf("Error en la reserva de espacio para las matrices\n"); 
  }

#endif
 
  //Inicializar matrices
  if (N < 9)
    for (i = 0; i < N; i++)
      for(int j = 0 ; j < N ; j++)
      {
        m1[i][j] = N * 0.1 + i * 0.1;
        m2[i][j] = N * 0.1 + j * 0.1;
        m3[i][j] = 0;
      }
  else
  {
    srand(time(0));
    for (i = 0; i < N; i++)
      for(int j = 0 ; j < N ; j++)
      {
        m1[i][j] = rand() / ((double) rand()); 
        m2[i][j] = rand() / ((double) rand());
        m3[i][j] = 0;        
      }
  }
 
  clock_gettime(CLOCK_REALTIME,&cgt1);

  for(i=0; i<N; i++)
    for(int k = 0 ; k < N ; k++)
      for(int j = 0 ; j < N ; j++)
        m3[i][j] += m1[i][k] * m2[k][j];
 
  clock_gettime(CLOCK_REALTIME,&cgt2);
  ncgt=(double) (cgt2.tv_sec-cgt1.tv_sec)+
       (double) ((cgt2.tv_nsec-cgt1.tv_nsec)/(1.e+9));

  printf("Tiempo(seg.):%11.9f\t / Tamaño Matrices:%u\t/ m3[0][0]=(%8.6f) / / m3[N-1][N-1]=(%8.6f\n)", ncgt,N,m3[0][0],m3[N-1][N-1]);
  if(N < 10)
  {
    printf("\nm1: \n");
    for (i = 0; i < N; i++)
    {
      printf("\n");
      for(int j = 0 ; j < N ; j++)
        printf("%8.6f ", m1[i][j]);
    }

    printf("\nm2: \n");
    for (i = 0; i < N; i++)
    {
      printf("\n");
      for(int j = 0 ; j < N ; j++)
        printf("%8.6f ", m2[i][j]);
    }

    printf("\nm3: \n");
    for (i = 0; i < N; i++)
    {
      printf("\n");
      for(int j = 0 ; j < N ; j++)
        printf("%8.6f ", m3[i][j]);
    }
    printf("\n");
  }      
 
  #ifdef MATRIZ_DYNAMIC

  for(int j = 0 ; j < N ; j++)
  {
    free(m1[i]);
    free(m2[i]);
    free(m3[i]);
  }


  free(m1); 
  free(m2); 
  free(m3);
  #endif
  return 0;
}
