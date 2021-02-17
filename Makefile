TARGET = disk.img

all: bootloader disk.img

$(TARGET): 16bit/bootloader.bin
	cp 16bit/bootloader.bin disk.img 

bootloader:
	make -C 16bit 

run:
	qemu-system-x86_64 -L . -boot c -m 256 -hda $(TARGET)

clean:
	make -C 16bit clean
	rm disk.img
