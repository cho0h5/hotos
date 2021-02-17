TARGET = bootloader.bin

$(TARGET) : bootloader.asm
	nasm $^ -o $@ 

clean :
	rm *.bin
