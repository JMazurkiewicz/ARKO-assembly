CC_ARGS = -std=c11 -Wall -Wextra -pedantic -O3
C_FILES = main.c sepia.c bmp.c

x86: sepia_x86.asm $(C_FILES)
	nasm -f elf32 sepia_x86.asm
	cc -m32 $(CC_ARGS) $(C_FILES) sepia_x86.o -o sepia.out

x64: sepia_x64.asm $(C_FILES)
	nasm -f elf64 sepia_x64.asm
	cc -m64 $(CC_ARGS) $(C_FILES) sepia_x64.o -o sepia.out 

clean:
	rm *.o *.out
