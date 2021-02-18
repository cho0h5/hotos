TARGET = protected_mode.bin

all: $(TARGET)

$(TARGET): main.bin protected_mode.asm
	nasm protected_mode.asm -o $@ 
	cat main.bin >> $@

main.bin: main.c
	gcc -c -m32 -ffreestanding -o main.o main.c
	x86_64-linux-gnu-ld -melf_i386 -T test.x -nostdlib -o main.elf main.o
	x86_64-linux-gnu-objcopy -j .text -j .data -j .rodata -j .bss -S -O binary main.elf main.bin

clean:
	rm *.o
	rm *.elf
	rm *.bin
