#!/bin/bash

# ANSI escape codes for colors
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# List of images size to pass to the program
image_sizes=( "32"  "64"  "96"  "128" )
n_bits=(      "6"   "6"   "6"   "7"   )
p_errors=(    "0.1" "0.1" "0.1" "0.2" )

for ((i=0; i<${#image_sizes[@]}; i++)); do
    echo -e "${GREEN}Running program with image size ${image_sizes[i]}, n_bits ${n_bits[i]}, p_error ${p_errors[i]}, using FHE${NC}"
    poetry run python3 src/ConvolutionalNeuralNetwork.py "${image_sizes[i]}" "${n_bits[i]}" "${p_errors[i]}" "use_fhe" "1" "/image_size"
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
        echo -e "${GREEN}Program finished successfully.${NC}"
        continue
    fi

    echo -e "${RED}Program exited with code 1.${NC}"
    rm -rf .artifacts
done
