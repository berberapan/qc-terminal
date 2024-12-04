#!/bin/bash
# test.sh - first exercise

# Colour codes for output
GREEN='\033[32m'
RED='\033[31m'
BLUE='\033[34m'
YELLOW='\033[33m'
NC='\033[0m' # To reset colour


if [ -z "$greeting" ]; then
    echo -e "${RED}greeting-variablen är inte satt.${NC}"
    exit 1
elif [ "$greeting" != "Hello world" ]; then
    echo -e "${RED}greeting har fel värde. Den returnerar $greeting${NC}"
    echo -e "${RED}Kolla så små och stora bokstäver är korrekt.${NC}"
    exit 1
else
    echo -e "${GREEN}Så ja! greeting har korrekt värde!${NC}"
    echo -e "${GREEN}Nu vet du hur man ger en variabel ett värde i terminalen.${NC}"
fi
