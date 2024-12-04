#!/bin/bash

# Colour codes for output
GREEN='\033[32m'
RED='\033[31m'
BLUE='\033[34m'
YELLOW='\033[33m'
NC='\033[0m' # To reset colour

setup1() {
    mkdir -p projekt/{src,test}
    touch projekt/src/Main.java
    echo "public class Main { }" > projekt/src/Main.java
}

setup2() {
    mkdir -p backup
    touch viktigt.txt
    echo "Viktig information som inte får försvinna" > viktigt.txt
}

setup3() {
    mkdir -p temp_filer
    for i in {1..5}; do
        touch "fil$i.tmp"
    done
}

cleanup_files() {
    rm -rf projekt backup gamla_filer fil*.tmp viktigt.txt
}

validate_copy() {
    if [ ! -f "backup/viktigt.txt" ]; then
        echo -e "${RED}Kan inte hitta viktigt.txt i backup-katalogen${NC}"
        return 1
    fi
    if [ ! -f "viktigt.txt" ]; then
        echo -e "${RED}Originalfilen ligger inte kvar på sin orginalplats.${NC}"
        return 1
    fi
    return 0
}

validate_move() {
    count=$(ls temp_filer/*.tmp 2>/dev/null | wc -l)
    if [ "$count" -eq 5 ]; then
        return 0
    else
        echo -e "${RED}Alla .tmp filer har inte flyttats över till temp_filer${NC}"
        return 1
    fi
}

main() {
    clear
    cleanup_files
    setup1
    echo
    echo -e "${BLUE}Uppgift 1: I katalogen finns nu ett Java-projekt. Skapa en ny fil med namnet 'Test.java' i test-katalogen.${NC}"
    echo -e "${YELLOW}Skriv 'svara' när du är klar.${NC}"

    while true; do
        read -e -p "> " command
        if [ "$command" = "svara" ]; then
            if [ -f "projekt/test/Test.java" ]; then
                echo -e "${GREEN}Kanon! Filen ligger där den ska.${NC}\n"
                break
            else
                echo -e "${RED}Hittar ingen Test.java i projekt/test katalogen. Kontrollera sökvägen och filnamnet.${NC}\n"
            fi
        else
            eval "$command"
        fi
    done

    cleanup_files

    setup2
    # Question 2
    echo -e "${BLUE}Uppgift 2: En txt-fil och en katalog som heter backup har nu skapats. Kopiera txt-filen till backup-katalogen, \
men låt originalfilen vara kvar. Skriv 'svara' när du är klar.${NC}"
    
    while true; do
        read -e -p "> " command
        if [ "$command" = "svara" ]; then
            if validate_copy; then
                echo -e "${GREEN}Säkerhetskopia skapad och originalfilen ligger kvar. Allt jag drömt om!${NC}\n"
                break
            fi
        else
            eval "$command"
        fi
    done

    cleanup_files

    setup3
    # Question 3
    echo -e "${BLUE}Uppgift 3: Ett antal temporära filer har skapats i katalogen. Flytta alla till \
        katalogen 'temp_filer' (Kom ihåg att det kan göras med ett kommando). Skriv 'svara' när du är klar.${NC}"
    
    while true; do
        read -e -p "> " command
        if [ "$command" = "svara" ]; then
            if validate_move; then
                echo -e "${GREEN}Snyggt! Alla uppgifter slaktade igen.${NC}"
                break
            fi
        else
            eval "$command"
        fi
    done

    echo -e "${GREEN}Nu har vi lite grundläggande kunskaper kring filhantering. Piping näst på tur!${NC}"
    cleanup_files
}

main
