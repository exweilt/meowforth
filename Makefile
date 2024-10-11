mfi: mfi.asm
	nasm mfi.asm -f elf64 -o build/mfi.o
	ld build/mfi.o -o build/mfi

clean:
	rm build/*