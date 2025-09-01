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

> **Note**: This repository is gradually being updated and translated to English.  
[![status](https://img.shields.io/badge/files-to%20be%20uploaded-yellow)]()
---


# 🧩 Register Binding and Signal Mapping in VHDL


---

# ⚙ Implementation Details and MMIO Access in the RTOS



---
# How to Set Up the Environment

## Clone 

```bash
git clone --recurse https://github.com/bbzaffari/MMIO-tripleDes-VHDL-core
````

---

## 1st Docker Setup:
For the purposes of this class, the professor provided a pre-configured Docker environment that includes all the necessary dependencies for the system to run properly.
You can download and set it up using the following command:

### 1. Docker pull the pre-built image
```bash
docker pull ghcr.io/sjohann81/linux-es

````

###  2. Run the Docker container:

```bash
docker run -it --name SE -v "$PWD":/home ghcr.io/sjohann81/linux-es
```

* ***docker run*** **is more than just "starting a container." It’s a compound command** that:
   - 1. Creates a new container from the specified image (ghcr.io/sjohann81/linux-es) — this is like taking a blueprint (image) and building a working instance (container).
   - 2. Allocates resources like filesystem layers, network, and isolated namespaces.
   - 3. Configures the container with options like terminal interaction (-it), naming (--name), volume mounting (-v), and more.
   * 4. Runs the container by executing its default entrypoint (in this case, a shell environment).
   
* **`-it`**: Allocates an interactive terminal so you can use the command line inside the container.
* **`--name SE***`**: Names the container `SE`, which helps you reference it easily later.
* **`-v "$PWD":/home`**: Mounts your current working directory (from your host machine) into the container at the path `/home`.

> **Notes**:
> - ***1. After the first run, do not repeat the docker run command, or you'll create duplicate containers.***
>    * 1. This can lead to:
>    * 2. Confusion (multiple containers with similar configurations)
>    * 3. Conflicts over mounted volumes
>    * 4. Wasted disk space and dangling containers
> 
> * ***2. `$PWD` is an environment variable that returns your current working directory.***
>    * That directory **must contain the files you previously cloned** from the project repository.
>    * Inside the container, those files will be accessible at `/home`.

---
## 2nd — Starting and accessing the container (after the first run)

Once you've created the container using `docker run`, ***you don't need to recreate it again.***
Instead, follow these two simple commands to ***reuse*** the container:

#### 1. `docker start SE`
```bash
docker start SE
````
This command **starts an existing container** that has already been created earlier using `docker run`.

* `SE` is the name you assigned to the container when you first ran it.
* This command starts the container **in the background** — it doesn’t attach to its terminal.

#### 2. `docker exec -it SE bash`
```bash
docker exec -it SE bash
```
This command **attaches a terminal to the running container**, allowing you to interact with it just like you would with a regular Linux shell.

* `-it`: Opens an interactive terminal session.
* `SE`: Refers to the container you started.
* `bash`: Launches the Bash shell inside the container.

> - Use `start + exec` every time you want to return to the container after rebooting or closing Docker — **never `docker run` again** for this purpose.
> - Together, these two commands will bring you **back into your development environment** inside the container — ready to compile, run, and edit your project files that were mounted in `/home`.


---
---

# How to run:

1. It is assumed that the files are located in the `/home` directory.
2. Sometimes `debug.txt` is automatically deleted, but simply running the command again resolves it.
3. Validation was performed using `debug.txt`, with output inspected via `hexdump`.

## ECB

```bash 
cd /home/ucx-os-minimo
make veryclean
make clean
make ucx ARCH=riscv/hf-riscv-e
make ECB
cd /home/minimo-hf-risc/software/
make clean
cd /home/minimo-hf-risc/sim/rv32e_basic
make clean
cp /home/ucx-os-minimo/build/target/code.txt /home/minimo-hf-risc/software/code.txt
make ghdl-vcd TIME=10ms
````

## CTR
```bash
cd /home/ucx-os-minimo
make veryclean
make clean
make ucx ARCH=riscv/hf-riscv-e
make CTR
cd /home/minimo-hf-risc/software/
make clean
cd /home/minimo-hf-risc/sim/rv32e_basic
make clean
cp /home/ucx-os-minimo/build/target/code.txt /home/minimo-hf-risc/software/code.txt
make ghdl-vcd TIME=10ms
````

## CBC
```bash
cd /home/ucx-os-minimo
make veryclean
make clean
make ucx ARCH=riscv/hf-riscv-e
make CBC
cd /home/minimo-hf-risc/software/
make clean
cd /home/minimo-hf-risc/sim/rv32e_basic
make clean
cp /home/ucx-os-minimo/build/target/code.txt /home/minimo-hf-risc/software/code.txt
make ghdl-vcd TIME=10ms
````
---
---


