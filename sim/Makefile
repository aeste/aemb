# Copyright (C) 2011 Aeste Works (M) Sdn Bhd.

TMP := $(shell mktemp -d)/v
DMP := $(shell uuidgen -t)
RND := $(shell od -d -N2 -vAn /dev/urandom)

VER = $(wildcard verilog/*.v)

LIB = -y ../rtl/verilog
LOG = $(DMP).log
VCD = $(DMP).vcd

edk63:	verilog/edk63.v clean
	iverilog $(LIB) -tnull -M$(TMP).ls verilog/edk63.v
	uniq $(TMP).ls | sed 1d > $(TMP).fs
	iverilog -c$(TMP).fs -E -tnull -o $(TMP).v verilog/edk63.v
	iverilog -Wall -o $(TMP).vvp $(TMP).v
	vvp -l $(LOG) $(TMP).vvp +randseed=$(RND) +dumpfile=$(VCD)

clean:
	rm -rf $(TMP)*
