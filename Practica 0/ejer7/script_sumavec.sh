#!/bin/bash

#Instrucciones del script para ejecutar código:
echo -e "\n 1. Ejecución SumaVectorC varias veces desde 2^16 a 2^26:\n"

for ((P=65536;P<=67108864;P=P*2))
do
	echo -e "\n Ejecutando con $P componentes"
	srun ./SumaVectoresC_dinamico $P
done

