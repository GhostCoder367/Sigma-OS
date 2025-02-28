nasm boot.asm -f bin -o boot.bin
nasm partition.asm -f bin -o partition.bin
cat boot.bin partition.bin > boot.flp
read -p "Press Enter to continue..."
