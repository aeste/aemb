# Copyright (C) 2011 Aeste Works (M) Sdn Bhd.

TMP := $(shell mktemp -d)/v
DMP := $(shell hostname)-$(shell date -I)
RND := $(shell date +%N)

VER = $(wildcard verilog/*.v)

LIB = -y ../rtl/verilog
LOG = $(DMP).log
VCD = $(DMP).vcd

edk63:	edk63.v vvp clean

edk63.v:
	@iverilog $(LIB) -tnull -M$(TMP).ls verilog/edk63.v
	@uniq $(TMP).ls | sed 1d > $(TMP).fs
	@iverilog -c$(TMP).fs -E -tnull -o $(TMP).v verilog/edk63.v

edk32:	edk32.v vvp clean

edk32.v:
	@iverilog $(LIB) -tnull -M$(TMP).ls verilog/edk32.v
	@uniq $(TMP).ls | sed 1d > $(TMP).fs
	@iverilog -c$(TMP).fs -E -tnull -o $(TMP).v verilog/edk32.v

vvp:
	@iverilog -Wall -o $(TMP).vvp $(TMP).v
	@time -p vvp -l $(LOG) $(TMP).vvp +randseed=$(RND) +dumpfile=$(VCD)

clean:
	@rm -rf $(TMP)*

clear:
	@rm -f *.log
