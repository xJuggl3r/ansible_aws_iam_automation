#!/bin/bash
# Proposito: Automatiza o attach de Policies em grupos na AWS
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

        if [ "$grupo" == "DBA" ]; then
            aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonRDSFullAccess --group-name $grupo
            aws iam attach-group-policy --policy-arn arn:aws:iam::248420709401:policy/forceMFA --group-name $grupo        
        fi

        if [ "$grupo" == "CloudAdmin" ]; then
            aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AdministratorAccess --group-name $grupo
            aws iam attach-group-policy --policy-arn arn:aws:iam::248420709401:policy/forceMFA --group-name $grupo        
        fi

        if [ "$grupo" == "LinuxAdmin" ]; then
            aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonEC2FullAccess --group-name $grupo 
           aws iam attach-group-policy --policy-arn arn:aws:iam::248420709401:policy/forceMFA --group-name $grupo       
        fi

        if [ "$grupo" == "RedesAdmin" ]; then
            aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/AmazonVPCFullAccess --group-name $grupo
            aws iam attach-group-policy --policy-arn arn:aws:iam::248420709401:policy/forceMFA --group-name $grupo        
        fi

        if [ "$grupo" == "Estagiarios" ]; then
            aws iam attach-group-policy --policy-arn arn:aws:iam::aws:policy/ReadOnlyAccess --group-name $grupo
            aws iam attach-group-policy --policy-arn arn:aws:iam::248420709401:policy/forceMFA --group-name $grupo        
        fi
        
    fi
    

done < $INPUT

IFS=$OLDIFS