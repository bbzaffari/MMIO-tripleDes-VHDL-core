# 3DES MMIO Driver on HF-RISC + UCX/OS

This project implements a **Triple DES (3DES)** encryption system in a minimal embedded stack, using:

- A **VHDL IP core** for the 3DES algorithm (RTL-level)
- A **Memory-Mapped I/O (MMIO)** interface to connect the crypto block to a custom SoC based on **HF-RISC**
- A **UCX/OS microkernel driver**, running on top of this simulated hardware platform

The work was developed using minimal versions of both [HF-RISC](https://github.com/sjohann81/hf-risc) and [UCX/OS](https://github.com/bbzaffari/ucx-os-minimo), provided by the course instructor, Prof. Sérgio Johann.

The driver enables encryption and decryption of arbitrary-length messages via system calls (`write()`, `read()`) and supports the following block cipher modes:

- **ECB (Electronic Codebook)**
- **CBC (Cipher Block Chaining)**
- **CTR (Counter Mode)**

The system includes padding (PKCS#7), task ID management, and validation using real text data, ensuring correct operation across the full encryption pipeline.

---

## Clone the repos

---

## Docker Setup:
For the purposes of this class, the professor provided a pre-configured Docker environment that includes all the necessary dependencies for the system to run properly.
You can download and set it up using the following command:

### Docker pull the pre-built image
```bash
docker pull ghcr.io/sjohann81/linux-es

````

###  Run the Docker container:

```bash
docker run -it --name SE -v "$PWD":/root ghcr.io/sjohann81/linux-es
```

* ***docker run*** **is more than just "starting a container." It’s a compound command** that:
   - 1. Creates a new container from the specified image (ghcr.io/sjohann81/linux-es) — this is like taking a blueprint (image) and building a working instance (container).
   - 2. Allocates resources like filesystem layers, network, and isolated namespaces.
   - 3. Configures the container with options like terminal interaction (-it), naming (--name), volume mounting (-v), and more.
   * 4. Runs the container by executing its default entrypoint (in this case, a shell environment).
   
* **`-it`**: Allocates an interactive terminal so you can use the command line inside the container.
* **`--name SE***`**: Names the container `SE`, which helps you reference it easily later.
* **`-v "$PWD":/root`**: Mounts your current working directory (from your host machine) into the container at the path `/root ( or /home)`.

> **Notes**:
> - 1. After the first run, do not repeat the docker run command, or you'll create duplicate containers.
>    * 1. This can lead to:
>    * 2. Confusion (multiple containers with similar configurations)
>    * 3. Conflicts over mounted volumes
>    * 4. Wasted disk space and dangling containers
> 
> * 2. `$PWD` is an environment variable that returns your current working directory.
>    * That directory **must contain the files you previously cloned** from the project repository.
>    * Inside the container, those files will be accessible at `/root`.

###

---

> **Note**: This repository is currently being updated and translated to English.  
[![status](https://img.shields.io/badge/files-to%20be%20uploaded-yellow)]()
