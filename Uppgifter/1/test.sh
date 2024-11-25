#!/bin/bash
# test.sh - first exercise

if [ -z "$greeting" ]; then
    echo "❌ ❌ ❌ - greeting-variablen är inte satt."
    exit 1
elif [ "$greeting" != "Hello world!" ]; then
    echo "❌ - greeting har fel värde. Den returnerar $greeting"
    echo "Kolla så små och stora bokstäver är korrekt."
    exit 1
else
    echo "✅ Så ja! greeting har korrekt värde!"
    echo "Nu vet du hur man ger en variabel ett värde i terminalen."
fi
