#!/bin/bash
# Proposito: Força a utilização de MFA nos grupos criados na AWS
# Utilizacao: ./aws-cria-policy.sh <formato arquivo entrada .csv>
# Ex: ./aws-cria-grupo.sh usuarios2.csv
# Formato do arquivo de entrada: usuarios,grupo,senha
# Autor: Andre Torres / xJuggl3r
# ------------------------------------------

INPUT=$1
OLDIFS=$IFS
IFS=','

[ ! -f $INPUT ] && { echo "$INPUT arquivo nao encontrado"; exit 99; }

command -v dos2unix >/dev/null || { echo "utilitario dos2unix nao encontrado. Por favor, instale dos2unix antes de rodar o script."; exit 1; }

dos2unix $INPUT

while read -r usuario grupo senha || [ -n "$grupo" ]
do
    if [ "$grupo" != "grupo" ]; then
        aws iam attach-group-policy --policy-arn arn:aws:iam::248420709401:policy/forceMFA --group-name $grupo
    fi
    

done < $INPUT

IFS=$OLDIFS