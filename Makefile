%.vvp: %.v %_test.v
	iverilog -g2005-sv -o $@ $^

%.vcd: %.vvp
	vvp $<

.PHONY: resetgenerator_test
resetgenerator_test: resetgenerator.vvp
	./$<
