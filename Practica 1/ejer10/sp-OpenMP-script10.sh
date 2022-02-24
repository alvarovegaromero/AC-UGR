#!/bin/bash

echo "Id. usuario del trabajo: $SLURM_JOB_USER"
echo "Id. del trabajo: $SLURM_JOBID"
echo "Nombre del trabajo especificado por usuario: $SLURM_JOB_NAME"
echo "Directorio de trabajo (en el que se ejecuta el script): $SLURM_SUBMIT_DIR"
echo "Cola: $SLURM_JOB_PARTITION"
echo "Nodo que ejecuta este trabajo:$SLURM_SUBMIT_HOST"
echo "Nº de nodos asignados al trabajo: $SLURM_JOB_NUM_NODES"
echo "Nodos asignados al trabajo: $SLURM_JOB_NODELIST"
echo "CPUs por nodo: $SLURM_JOB_CPUS_PER_NODE"

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

