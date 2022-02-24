#!/bin/bash

#Instrucciones del script para ejecutar código:
echo -e Ejecucion de SumaVectores_global, con for paralelizado y sections

for ((P=16384;P<=67108864;P=P*2))
do
	echo -e "\n Ejecutando con for con $P componentes"
	./sp-OpenMP-for $P
	echo -e "\n Ejecutando con sections con $P componentes"
	./sp-OpenMP-sections $P
	echo -e "\n Ejecutando secuencial con $P componentes"
	./SumaVectoresC_global $P
done

