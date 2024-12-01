#!/bin/bash

# Colour codes for output
GREEN='\033[32m'
RED='\033[31m'
BLUE='\033[34m'
YELLOW='\033[33m'
NC='\033[0m' # To reset colour

setup1() {
    echo "Varför är det ingen snö på Glasgows gator på vintern?" > setup.txt
}

setup2() {
    echo "De har miljontals invånare, och alla skottar." > punchline.txt
}

setup3() {
    yes "lite text som vi kör ett par gånger." | head -n 583 > ordfil.txt
}


cleanup_files() {
    rm -f *.txt
}

validate_concat() {
    if [ ! -f "perfection.txt" ]; then
        echo -e "${RED}Hittar inte en fil med namnet perfection.txt. Kontrollera stavning.${NC}"
        return 1
    fi

    expected="$(cat setup.txt punchline.txt)"
    actual="$(cat perfection.txt)"

    if [ "$actual" = "$expected" ]; then
        return 0
    else
        echo -e "${RED}Det matchar inte riktigt.. Försök igen${NC}"
        return 1
    fi
}

main() {
    clear
    setup1
    echo
    # Question 1
    echo -e "${BLUE}Fråga 1: Vilken stad omnämns i setup.txt?${NC}"
    echo -e "${YELLOW}Du kan använda kommandon som vanligt. När du vill ge ditt svar skriv 'svara'.${NC}"
    echo -e "${YELLOW}'Svara' måste anges vid varje nytt försök.${NC}"

    while true; do
        read -e -p "> " command
        if [ "$command" = "svara" ]; then
            read -p "Ditt svar: " answer
            if [ "${answer,,}" = "glasgow" ]; then
                echo -e "${GREEN}Helt rätt!${NC}\n"
                break
            else
                echo -e "${RED}Kunde man tro men det är inte korrekt.${NC}\n"
            fi
        else
            eval "$command"
        fi
    done

    setup2

    #Question 2
    echo -e "${BLUE}Fråga 2: En punchline.txt har nu skapats i katalogen. Skapa en tredje fil där du sammanfogar setup följt av punchline \
med hjälp av cat kommandot.\nGe den nya filen namnet "perfection.txt" och skriv 'svara' när filen är skapad.${NC}"

    while true; do
        read -e -p "> " command
        if [ "$command" = "svara" ]; then
            if validate_concat; then
                echo -e "${GREEN}Den var la go! Bra jobbat!${NC}\n"
                break
            fi
        else
            eval "$command"
        fi
    done
    
    cleanup_files

    setup3

    #Question 3
    echo -e "${BLUE}Fråga 3: Vi har nu en ny fil i katalogen. Använd dina kunskaper för att ta reda på namnet på filen och ta hjälp av ett kommando \
för att få fram hur många ORD (inte rader som i exemplet) som finns i filen och ange det när du svarar.${NC}"

    while true; do
        read -e -p "> " command
        if [ "$command" = "svara" ]; then
            read -p "Ditt svar: " answer
            if [ "${answer}" = "4664" ]; then
                echo -e "${GREEN}Möcke bra!"
                break
            else
                echo -e "${RED}Matchar inte det jag har här i facit.. Har du använt wc-kommandot med rätt flagga? Använd 'wc --help' för att se vilken flagga som räknar ord.${NC}"
            fi
        else
            eval "$command"
        fi
    done

    echo -e "${GREEN}Nu kan du förhoppningsvis lite mer kring cat och redirects${NC}"

    cleanup_files

}

main
