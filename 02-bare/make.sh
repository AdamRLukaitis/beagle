#!/bin/bash

# http://balau82.wordpress.com/2010/02/28/hello-world-for-bare-metal-arm-using-qemu/

gdb=1

PATH=../arm-2011.03/bin:qemu/arm-softmmu:PATH
arm-none-linux-gnueabi-gcc --version
arm-none-linux-gnueabi-gcc -c -mcpu=arm926ej-s -nostdlib -g test.c -o test.o
arm-none-linux-gnueabi-as -mcpu=arm926ej-s -g startup.s -o startup.o
arm-none-linux-gnueabi-ld -T test.ld test.o startup.o -o test.elf
arm-none-linux-gnueabi-objcopy -O binary test.elf test.bin

if [ "$gdb" = "1" ]; then
  qemu-system-arm -M versatilepb -m 128M -nographic -s -S -kernel test.bin
#arm-none-linux-gnueabi-gdb # run this command in another terminal
# (gdb) target remote localhost:1234
# (gdb) file test.elf
# (gdb) break c_entry
# (gdb) run
# (gdb) set $pc=0
# (gdb) stepi
# (gdb) exit # to terminate both gdb and qemu
#ddd --debugger arm-none-linux-gnueabi-gdb test.elf
else
  qemu-system-arm -M versatilepb -m 128M -nographic -kernel test.bin # "Ctrl + a" and "x" to exit
fi

