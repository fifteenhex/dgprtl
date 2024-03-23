include common.mk

.PHONY: resetgenerator_test
resetgenerator_test: resetgenerator.vvp
	./$<
