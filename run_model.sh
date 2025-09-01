#!/bin/bash

set -e
set -x  # Debug mode

UCX_DIR="/home/ucx-os-minimo"
HF_DIR="/home/minimal-HF-RISC-V"
SIM_DIR="$HF_DIR/sim/rv32e_basic"
SW_DIR="$HF_DIR/software"
CODE_TXT="$UCX_DIR/build/target/code.txt"
DST_CODE_TXT="$SW_DIR/code.txt"

# Normalize argument: remove carriage return, spaces, convert to uppercase
MODE=$(echo "$1" | tr -d '\r' | tr -d '[:space:]')
MODE=$(echo "$MODE" | tr '[:lower:]' '[:upper:]')

# Debug raw bytes of the argument
echo "$MODE" | od -c

if [[ "$MODE" != "ECB" && "$MODE" != "CTR" && "$MODE" != "CBC" ]]; then
    echo "Invalid mode: $MODE"
    echo "Valid options are: ECB, CTR, CBC"
    exit 1
fi

echo "========== MODE: $MODE =========="

cd "$UCX_DIR"
make veryclean
make clean
make ucx ARCH=riscv/hf-riscv-e
make build-app APP_MODE=$MODE

cd "$SW_DIR"
make clean

cd "$SIM_DIR"
make clean

cp "$CODE_TXT" "$DST_CODE_TXT"

make ghdl-vcd TIME=10ms

echo "Done: $MODE"
