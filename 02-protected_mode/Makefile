TARGET = protected_mode.bin

all: $(TARGET)

$(TARGET): main.bin protected_mode.asm
	nasm protected_mode.asm -o $@ 
	cat main.bin >> $@

main.bin: main.c
	nasm centry.asm -o $@ 

clean:
	rm *.bin
