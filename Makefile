include common.mk

.PHONY: resetgenerator_test
resetgenerator_test: resetgenerator.vvp
	./$<

fontrenderer_extra_srcs=fontrom.v
fontrenderer.vcd: fontrenderer.vvp

textbox_extra_srcs=fontrom.v fontrenderer.v
textbox.vcd: textbox.vvp

bin2ascii.vcd: bin2ascii.vvp

hexbox_extra_srcs=bin2ascii.v textbox.v fontrom.v fontrenderer.v
hexbox.vcd: hexbox.vvp

#xxd -c 1 -p seabios8x16.bin > seabios8x16.hex

clean:
	rm *.vcd *.vvp
