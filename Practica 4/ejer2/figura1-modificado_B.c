
#include <stdlib.h> // biblioteca con funciones atoi(), rand(), srand(), malloc() y free()
#include <stdio.h> // biblioteca donde se encuentra la función printf()
#include <time.h>     // biblioteca donde se encuentra la función clock_gettime()
 
struct aux{
        int a;
        int b;
};

 
int main(int argc, char** argv)
{ 
  //Leer argumento de entrada (nº de componentes del vector)
  if (argc<3)
  {     
    printf("Faltan M y/o N\n");
    exit(-1);
  }
 
  unsigned int N = atoi(argv[2]); // Máximo N =2^32-1=4294967295 (sizeof(unsigned int) = 4 B)
  unsigned int M = atoi(argv[1]);
  int i, ii, X1, X2;
  struct timespec cgt1,cgt2; double ncgt; //para tiempo de ejecución
  int R[M];
  struct aux s[N];
 
  //Inicializar vectores
  if (N < 9)
    for (i = 0; i < N; i++)
    {
      s[i].a = N * 0.1 + i * 0.1;
      s[i].b = N * 0.1 - i * 0.1;
    }
  else
  {
    srand(time(0));
    for (i = 0; i < N; i++)
    {
      s[i].a = rand()/ ((double) rand()); 
      s[i].b = rand()/ ((double) rand()); //printf("%d:%f,%f/",i,v1[i],v2[i]);
    }
  }
 
  clock_gettime(CLOCK_REALTIME,&cgt1);

   for (ii=0; ii<M;ii++) 
   {
      X1=0; X2=0;
      for(i=0; i<N;i+=2)
      {  
        X1+=2*s[i].a+ii;
        X2+=3*s[i].b-ii;

        X1+=2*s[i+1].a+ii;
        X2+=3*s[i+1].b-ii; 
      }
 
      if (X1<X2)  
        R[ii]=X1;  
      else  
        R[ii]=X2;
   }
 
  clock_gettime(CLOCK_REALTIME,&cgt2);
  ncgt=(double) (cgt2.tv_sec-cgt1.tv_sec) + (double) ((cgt2.tv_nsec-cgt1.tv_nsec)/(1.e+9));
 
  printf("Tiempo(seg.):%11.9f\t / Tamaño Vectores:N: %u, M: %u\n / R[0] = %u / R[N-1] = %u \n",ncgt,N,M, R[0], R[N-1]);
 
 
  return 0;
}

