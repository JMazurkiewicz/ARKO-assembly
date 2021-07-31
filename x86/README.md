# x86 and amd64 projects

## Building

### Linux

To build programs in this directory you will need `NASM` assembler. It can be installed with `apt-get` on Debian-based distros:

```bash
sudo apt-get install nasm
```

You will also need `gcc` compiler with 32-bit libraries:

```bash
sudo apt-get install gcc gcc-multilib
```

### Windows

To build programs in this directory you will need Linux environment like Cygwin or WSL.

## Small x86 project

@todo

Building:

```bash
cd small-project
nasm -f elf32 dcompl.asm
gcc -m32 dcompl.o main.c -o dcompl.out
```

## Main project (x86 and amd64)

The goal of the main project is to create program transforming `.bmp` file into sepia tonned file.

Building:

```bash
cd sepia
make x86 # or x64
./sepia.out
```

## Scores

* Small x86 project: 3/3
* Main x86 project: 6/6
* Main amd64 project: 2/2
