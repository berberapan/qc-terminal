#!/bin/bash

# Colour codes for output
GREEN='\033[32m'
RED='\033[31m'
BLUE='\033[34m'
YELLOW='\033[33m'
NC='\033[0m' # To reset colour

setup1(){
    mkdir -p ./filer && cd ./filer
    for  i in {1..200}; do
        size=$((RANDOM % 200 + 500))
        head -c $size /dev/urandom | base64 > "fil$i.txt"
    done
    cd ..
}

setup2(){
    sleep 50000 &
    SLEEP_PID=$!
    sleep 1
}

clear_files(){
    rm -rf filer
}


main(){
    clear
    setup1

    # Question 1
    echo -e "${BLUE}Uppgift 1: En katalog har skapats med namnet filer. Använd det du har lärt dig för att svara på hur många filer det finns i den katalogen som är större än 900 bytes.${NC}"
    echo -e "${YELLOW}Skriv 'svara' när du vet.${NC}"

    correct_count=$(find ./filer -type f -size +900c | wc -l)

    while true; do
        read -e -p "> " command
        if [ "$command" = "svara" ]; then
            read -p "Ditt svar: " answer
            if [ "$answer" = "$correct_count" ]; then
                echo -e "${GREEN}Ding Ding Ding. Rätt som vanligt!${NC}\n"
                break
            else
                echo -e "${RED}Icke. Kolla så att du har rätt storlek och att du inte inkluderar test.sh.${NC}\n"
            fi
        else
            eval "$command"
        fi
    done

    clear_files
                

    # Question 2
    echo -e "${BLUE}Uppgift 2: Ta reda på vem som är författaren av kommandot 'curl'. Skriv 'svara' när du vill ge ditt svar.${NC}"
    while true; do
        read -e -p  "> " command
        if [ "$command" = "svara" ]; then
            read -p "Ditt svar: " answer
            if [ "${answer,,}" = "daniel stenberg" ]; then
                echo -e "${GREEN}Bra jobbat!${NC}\n"
                break
            else
                echo -e "${RED}Nja.. Försök igen!${NC}\n"
            fi
        else
            eval "$command"
        fi
    done

    setup2

    # Question 3
    echo -e "${BLUE}Uppgift 3: En process körs nu i bakgrunden. Processens namn är 'sleep 50000'. Ta reda på PID för processen och döda den.${NC}"
    echo -e "${YELLOW}Skriv 'svara' när processen är avslutad.${NC}"
    while true; do
        read -e -p "> " command
        if [ "$command" = svara ]; then
            if ps -p $SLEEP_PID > /dev/null 2>&1; then
                echo -e "${RED}Processen är fortfarande igång. Fortsätt försöka!${NC}\n"
            else
                echo -e "${GREEN}Vår egen Arnold!${NC}\n"
                break
            fi
        else
            eval "$command"
        fi
    done

    echo -e "${BLUE}Vidare till nästa sida!${NC}"
}

main
