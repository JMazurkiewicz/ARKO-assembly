CFLAGS = -std=c11 -Wall -Wextra -pedantic -Werror -O3
SOURCES = main.c

build: dcompl.asm $(SOURCES)
	nasm -f elf32 dcompl.asm
	$(CC) -m32 $(CFLAGS) $(SOURCES) dcompl.o -o dcompl.out

clean:
	rm *.o *.out
