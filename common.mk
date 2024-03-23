%.vvp: %.v %_test.v
	iverilog -g2005-sv -o $@ $^

%.vcd: %.vvp
	vvp $<
