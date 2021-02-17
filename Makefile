TARGET = bootloader.bin

$(TARGET) : bootloader.asm
	nasm $^ -o $@ 

run :
	qemu-system-x86_64 -L . -boot c -m 256 -hda $(TARGET)

clean :
	rm *.bin
