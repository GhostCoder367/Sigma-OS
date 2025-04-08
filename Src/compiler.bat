nasm boot.asm -f bin -o boot.bin

nasm boot2.asm -f bin -o boot2.bin

copy /b boot.bin+boot2.bin boot.img

