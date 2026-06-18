echo making image
make
qemu-system-x86_64 -drive file=./build/entry64.bin,format=raw,if=ide -s -S

