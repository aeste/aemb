#
# Makefile for AEMB Software
# 

CC = mb-g++
LFLAGS = -Wl,-defsym -Wl,_STACK_SIZE=0x2000 -Wl,-defsym -Wl,_HEAP_SIZE=0x2000
CFLAGS = -mtune=v5.00 -mxl-soft-div -msoft-float -mxl-barrel-shift -mno-xl-soft-mul
IFLAGS = -I cc/
OFLAGS = -Os

OBJDUMP = mb-objdump
OBJCOPY = mb-objcopy

testbench: testbench.cc sim
	echo "DONE"

uxe: uxe.cc sim
	echo "DONE"

testbench.cc: cc/testbench.cc
	$(CC) $(CFLAGS) $(IFLAGS) $(LFLAGS) $(OFLAGS) -specs=aemb.specs -o rom.elf cc/testbench.cc

uxe.cc: cc/uxe.cc 
	$(CC) $(CFLAGS) $(IFLAGS) $(LFLAGS) $(OFLAGS) -specs=aemb.specs -o rom.elf cc/uxe.cc

sim: 
	$(OBJDUMP) -DSCz rom.elf > rom.dump
	$(OBJCOPY) -O srec rom.elf rom.srec
	srec_cat rom.srec -fill 0xAE -within rom.srec -range-pad 4 -o ../sim/dump.vmem -vmem 32

clean:
	rm *.dump *.srec *.elf
