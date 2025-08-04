# 3DES MMIO Driver on HF-RISC + UCX/OS

This project implements a **Triple DES (3DES)** encryption system in a minimal embedded stack, using:

- A **VHDL IP core** for the 3DES algorithm (RTL-level)
- A **Memory-Mapped I/O (MMIO)** interface to connect the crypto block to a custom SoC based on **HF-RISC**
- A **UCX/OS microkernel driver**, running on top of this simulated hardware platform

The work was developed using minimal versions of both [HF-RISC](https://github.com/sjohann81/hf-risc) and [UCX/OS](https://github.com/sjohann81/ucx-os), provided by the course instructor, Prof. Sérgio Johann.

The driver enables encryption and decryption of arbitrary-length messages via system calls (`write()`, `read()`) and supports the following block cipher modes:

- **ECB (Electronic Codebook)**
- **CBC (Cipher Block Chaining)**
- **CTR (Counter Mode)**

The system includes padding (PKCS#7), task ID management, and validation using real text data, ensuring correct operation across the full encryption pipeline.

> **Note**: This repository is currently being updated and translated to English.  
