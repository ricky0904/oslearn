echo making image
make
qemu-system-x86_64 -drive file=./build/entry64.bin,format=raw,if=ide -smp 2 -s -S
#		-smp 2, sockets=1, cores=2, threads=1 \
#		-cpu host \
#		-accel kvm \
#		-s -S

