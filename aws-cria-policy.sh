#!/bin/bash
# Proposito: Automatiza a criação de políticas na AWS
# Utilizacao: ./aws-cria-policy.sh <nome-da-policy> <formato arquivo entrada .txt>
# Ex: ./aws-cria-policy.sh forceMFA force_mfapolicy.txt
# Formato do arquivo de entrada: usuarios,grupo,senha
# Autor: Andre Torres / xJuggl3r
# ------------------------------------------

aws iam create-policy --policy-name $1 --policy-document file://$2