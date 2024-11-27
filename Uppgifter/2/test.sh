#!/bin/bash

# Color codes for output
GREEN='\033[32m'
RED='\033[31m'
BLUE='\033[34m'
NC='\033[0m' # No Color

setup_files() {
    cleanup_files

    # Create files with different sizes
    echo "This is a small file" > file1.txt
    dd if=/dev/zero of=file2.txt bs=1M count=1 2>/dev/null
    base64 /dev/urandom | head -c 500000 > file3.txt
    touch -t $(date -d "yesterday" +"%Y%m%d%H%M.%S") file5.txt
    touch -t $(date -d "1 year ago" +"%Y%m%d%H%M.%S") file4.txt
    
    # Create some hidden files
    echo "Hidden file 1" > .hidden1
    echo "Hidden file 2" > .hidden2
    echo "Hidden file 3" > .hidden3
}

cleanup_files() {
    rm -f file* testfile* .hidden*
}

main() {
    clear
    setup_files
    echo

    # Question 1
    echo -e "${BLUE}Fråga 1: Vilken fil är störst?${NC}"
    
    while true; do
        read -e -p "> " command
        
        if [ "$command" = "svara" ]; then
            read -p "Ditt svar: " answer
            if [ "$answer" = "file2.txt" ]; then
                echo -e "${GREEN}Precis så!${NC}\n"
                break
            else
                echo -e "${RED}Inte riktigt. Det finns en flagga som visar storleken på alla filer.${NC}"
            fi
        else
            eval "$command"
        fi
    done

    # Question 2
    echo -e "${BLUE}Fråga 2: Hur många dolda filer finns det i katalogen?${NC}"
    
    while true; do
        read -e -p "> " command
        
        if [ "$command" = "svara" ]; then
            read -p "Ditt svar: " answer
            if [ "$answer" = "3" ]; then
                echo -e "${GREEN}Korrekt!${NC}\n"
                break
            else
                echo -e "${RED}Nja. Tips: Tänk på att sk. dotfiler börjar med en punkt.${NC}"
            fi
        else
            eval "$command"
        fi
    done

    # Question 3
    echo -e "${BLUE}Fråga 3: Namnge en av de dolda filerna:${NC}"
    
    while true; do
        read -e -p "> " command
        
        if [ "$command" = "svara" ]; then
            read -p "Ditt svar: " answer
            if [[ "$answer" == .hidden* ]]; then
                echo -e "${GREEN}Perfekt, en fråga kvar.${NC}"
                break
            else
                echo -e "${RED}Nja. Tips: Tänk på att sk. dotfiler börjar med en punkt.${NC}"
            fi
        else
            eval "$command"
        fi
    done

    # Question 4
    echo -e "${BLUE}Fråga 4: Vilken fil har inte ändrats på längst tid?:${NC}"
    
    while true; do
        read -e -p "> " command
        
        if [ "$command" = "svara" ]; then
            read -p "Ditt svar: " answer
            if [[ "$answer" == "file4.txt" ]]; then
                echo -e "${GREEN}Snyggt! Alla frågor avklarade${NC}"
                break
            else
                echo -e "${RED}Inte riktigt. Tänk på att om datumet är längre än 6 månader tillbaka så visas även året.${NC}"
            fi
        else
            eval "$command"
        fi
    done

    echo -e "\nBra jobbat! Du kan nu:"
    echo "1. Hitta filer med ls -l"
    echo "2. Hitta dolda filer med ls -a"
    echo "3. Identifiera dolda filer"
    echo "4. Se när en fil senast ändrades"

    cleanup_files
}

# Run the script
main
