# x86 and amd64 projects

## Building

### Linux

To build programs you will need `NASM` assembler. It can be installed with `apt-get` on Debian-based distributions:

```bash
sudo apt-get install nasm
```

You will also need `gcc` compiler with 32-bit libraries:

```bash
sudo apt-get install gcc gcc-multilib
```

### Windows

To build programs on Windows you will need Linux environment like Cygwin or WSL.

## Small x86 project

The goal of the small project is to create program taking two arguments:

* Some string with digits
* Single digit

The program will print modified string with digits that are the difference between corresponding digit from string and digit from second program's argument, for example:

```bash
./dcompl.out "unsigned char x = 254" 9
```

Will print `unsigned char x = 745`, because:

* |2 - 9| = 7
* |5 - 9| = 4
* |4 - 9| = 5

Building:

```bash
cd small-project
make
```

## Main "sepia" project (x86 and amd64)

The goal of the main project is to create program transforming `.bmp` file into sepia toned file.

Building:

```bash
cd sepia
make x86 # or x64
```

## Scores

* Small x86 project: 3/3
* Main x86 project: 6/6
* Main amd64 project: 2/2
