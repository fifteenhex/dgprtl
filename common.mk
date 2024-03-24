.SECONDEXPANSION:
%.vvp: $$($$*_extra_srcs) %.v %_test.v
	iverilog -g2005-sv -o $@ $^

%.vcd: %.vvp
	vvp $<
