module SDPB
#(
    READ_MODE = 1'b0,
    WRITE_MODE = 2'b11,
    BIT_WIDTH_0 = 32,
    BIT_WIDTH_1 = 32,
    BLK_SEL_0 = 4'b0000,
    BLK_SEL_1 = 4'b0000,
    RESET_MODE = "ASYNC",
    INIT_RAM_00 = 0
)
(
    // port A
    input logic CLKA,
    input logic [13:0] ADA,
    input logic [31:0] DI,
    output logic [31:0] DO,
    input OCE,
    input CEA,
    input RESET,
    input WRE,
    input logic [2:0] BLKSELA,
    // port B
    input logic CLKB,
    input logic [13:0] ADB,
    input logic [2:0] BLKSELB,
    input CEB
);

endmodule
