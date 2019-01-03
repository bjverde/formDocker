#!/bin/bash

#STYLE_COLOR
RED='\033[0;31m';
LIGHT_GREEN='\e[1;32m';
NC='\033[0m' # No Color

echo -e "${LIGHT_GREEN} Download FormDin by Git Clone ${NC}"
echo -e "${LIGHT_GREEN} essa etapa pode ser demorada !! :-( Vai depender da velocidade da sua internet ${NC}"
cd /var/www/html
git clone https://github.com/bjverde/formDin.git

echo -e "${LIGHT_GREEN} Baixando SysGen (gerador de sistemas) do github e colocando em www/formdin/sysgen ${NC}"
cd formDin;
git clone https://github.com/bjverde/sysgen.git

echo -e "${RED} Criando TMP formDin ${NC}"
mkdir -p base/tmp/
chmod 777 base/tmp/
