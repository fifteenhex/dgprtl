include common.mk

.PHONY: resetgenerator_test
resetgenerator_test: resetgenerator.vvp
	./$<

#xxd -c 1 -p seabios8x16.bin > seabios8x16.hex

clean:
	rm *.vcd *.vvp
