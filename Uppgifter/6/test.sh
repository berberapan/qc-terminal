#!/bin/bash
# Colour codes for output
GREEN='\033[32m'
RED='\033[31m'
BLUE='\033[34m'
YELLOW='\033[33m'
NC='\033[0m' # To reset colour

setup() {
    # Skapa testmiljö
    mkdir -p ./testfiles
    cd ./testfiles
    echo "#!/bin/bash\necho 'Hello World!'" > script.sh
    echo "Publik data" > public.txt
    chmod 644 public.txt  # Alla kan läsa, ägaren kan skriva
    cd ..
}

clear_files() {
    rm -rf testfiles
}

main() {
    clear
    setup

    # Uppgift 1 - chmod
    echo -e "${BLUE}Uppgift 1: En ny katalog har skapats med namnet 'testfiles' i den finns en fil 'script.sh' som ska kunna köras. 
Ge filen rätt rättigheter så att ägaren kan göra allt, medan gruppen bara kan läsa den och övriga varken kan läsa eller köra den.${NC}"
    echo -e "${YELLOW}Skriv 'svara' när du är klar.${NC}"
    
    while true; do
        read -e -p "> " command
        if [ "$command" = "svara" ]; then
            if [ "$(stat -c %a ./testfiles/script.sh)" = "740" ]; then
                echo -e "${GREEN}Perfekt!${NC}\n"
                break
            else
                echo -e "${RED}Inte riktigt. Tänk på att ägaren ska kunna köra (7), gruppen läsa (4) och övriga ha inga rättigheter (0).${NC}\n"
            fi
        else
            eval "$command"
        fi
    done

    echo -e "${BLUE}Uppgift 2: I katalogen 'testfiles' finns en fil 'public.txt'. Ändra rättigheterna så att de stämmer överrens med den numeriska notationen (640)${NC}"
    echo -e "${YELLOW}Skriv 'svara' när du är klar.${NC}"
    
    while true; do
        read -e -p "> " command
        if [ "$command" = "svara" ]; then
            perms=$(stat -c "%a" ./testfiles/public.txt)
            if [ "$perms" = "640" ]; then
                echo -e "${GREEN}Utmärkt! 6 (rw-) för ägaren, 4 (r--) för gruppen, och 0 (---) för övriga är korrekt!${NC}\n"
                break
            else
                echo -e "${RED}Inte riktigt. Försök igen${NC}\n"
            fi
        else
            eval "$command"
        fi
    done
    clear_files
    echo -e "${BLUE}Bra jobbat!${NC}"
}

main

