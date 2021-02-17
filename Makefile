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
	@echo -------------------- make clean --------------------
	make clean
	@echo ----------------------- make -----------------------
	make
	@echo --------------------- make run ---------------------
	qemu-system-x86_64 -L . -boot c -m 256 -fda $(TARGET)

clean:
	make -C 01-real_mode clean
	make -C 02-protected_mode clean
	rm disk.img
