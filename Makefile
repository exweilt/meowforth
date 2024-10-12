mfi: mfi.asm
	nasm mfi.asm -f elf64 -g -F dwarf -o build/mfi.o
	ld build/mfi.o -g -o build/mfi

clean:
	rm build/*