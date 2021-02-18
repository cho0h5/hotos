TARGET = disk.img

all: bootloader protected_mode disk.img

bootloader:
	make -C 01-real_mode 

protected_mode:
	make -C 02-protected_mode 

$(TARGET): 01-real_mode/bootloader.bin 02-protected_mode/protected_mode.bin
	cat 01-real_mode/bootloader.bin >> disk.img 
	cat 02-protected_mode/protected_mode.bin >> disk.img 

run:
	qemu-system-x86_64 -L . -boot c -m 256 -fda $(TARGET)

clean:
	make -C 01-real_mode clean
	make -C 02-protected_mode clean
	rm disk.img

createdocker:
	docker run -it -d --volume=$(PWD):/workspace --name=hotos_build ubuntu:20.04

rundocker:
	docker exec -it hotos_build /bin/bash

deldocker:
	docker rm hotos_build
