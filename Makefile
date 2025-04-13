all:
	nasm -f bin boot.asm -o ./boot.bin
	dd if=./message.txt >> ./boot.bin
	dd if=/dev/zero bs=512 count=1 >> ./boot.bin

test: boot.bin
	qemu-system-x86_64 -hda ./boot.bin

iso: boot.bin
	cp ./boot.bin ./os.bin
	truncate os.bin -s 1200k
	mkisofs -o os.iso -b os.bin ./