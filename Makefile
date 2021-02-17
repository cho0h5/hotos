TARGET = disk.img

all: bootloader disk.img

bootloader:
	make -C 01-bootloader 

$(TARGET): 01-bootloader/bootloader.bin
	cp 01-bootloader/bootloader.bin disk.img 

run:
	qemu-system-x86_64 -L . -boot c -m 256 -hda $(TARGET)

clean:
	make -C 01-bootloader clean
	rm disk.img
