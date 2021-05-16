#!/bin/bash
# Proposito: Automatiza a criação de grupos na AWS
# Utilizacao: ./aws-cria-policy.sh <formato arquivo entrada .csv>
# Ex: ./aws-cria-grupo.sh usuarios2.csv
# Formato do arquivo de entrada: usuarios,grupo,senha
# Autor Original Jean Rodrigues
# Adaptação: Andre Torres / xJuggl3r
# ------------------------------------------

INPUT=$1
OLDIFS=$IFS
IFS=','

[ ! -f $INPUT ] && { echo "$INPUT arquivo nao encontrado"; exit 99; }

command -v dos2unix >/dev/null || { echo "utilitario dos2unix nao encontrado. Por favor, instale dos2unix antes de rodar o script."; exit 1; }

dos2unix $INPUT

while read -r usuario grupo senha || [ -n "$usuario" ]
do
    if [ "$usuario" != "usuarios" ]; then
        aws iam create-group --group-name $grupo        
    fi
    

done < $INPUT

IFS=$OLDIFS