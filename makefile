.PHONY: all clean


all: 
	rgbasm -o start.o start.z80
	sdcc -c -msm83 main.c
	rgblink -o test.gb start.o main.rel

clean: 
	rm -f start.o
	rm -f main.rel
	rm -f main.lst
	rm -f main.asm
	rm -f main.sym
	rm -f test.gb
