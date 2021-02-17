TARGET = disk.img

all: bootloader disk.img

bootloader:
	make -C 01-real_mode 

$(TARGET): 01-real_mode/bootloader.bin
	cp 01-real_mode/bootloader.bin disk.img 

run:
	qemu-system-x86_64 -L . -boot c -m 256 -hda $(TARGET)

clean:
	make -C 01-real_mode clean
	rm disk.img
