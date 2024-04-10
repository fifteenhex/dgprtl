include ../common.mk

fontrenderer_extra_srcs=fontrom.v
textbox_extra_srcs=fontrom.v fontrenderer.v window.v
hexbox_extra_srcs=bin2ascii.v textbox.v $(textbox_extra_srcs)
framebuffer_extra_srcs=framebuffer_xy2addr.v ../mem/bramwrapper_dualport_gowin.v ../gowin_SDPB.v

textbox.vcd:

all: window.vcd textbox.vcd hexbox.vcd fontrenderer.vcd bin2ascii.vcd framebuffer.vcd
