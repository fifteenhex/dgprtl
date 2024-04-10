module SP
#(
    READ_MODE = 1'b0,
    WRITE_MODE = 2'b11,
    BIT_WIDTH = 32,
    BLK_SEL = 4'b0000,
    RESET_MODE = "ASYNC",
    INIT_RAM_00 = 0
)
(
    input logic CLK,
    input logic [13:0] AD,
    input logic [31:0] DI,
    output logic [31:0] DO,
    input OCE,
    input CE,
    input RESET,
    input WRE,
    input logic [2:0] BLKSEL
);

endmodule
