CC = gcc
LD = ld
ASM = nasm

CFLAGS = -m32 -ffreestanding -fno-pie -fno-stack-protector -nostdlib
LDFLAGS = -m elf_i386 -T linker.ld

all: os-image

os-image: bootloader.bin kernel.bin
	cat $^ > os-image

bootloader.bin: boot.asm
	$(ASM) -f bin -o $@ $<

kernel.bin: main.c
	$(CC) $(CFLAGS) -c -o main.o $<
	$(LD) $(LDFLAGS) -o kernel.bin main.o

clean:
	rm -f *.o *.bin os-image

run: os-image
	qemu-system-i386 -drive format=raw,file=os-image

.PHONY: all clean run
