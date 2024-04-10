module bramwrapper_dualport
#(
    parameter BLOCK = 0,
    parameter IN_WIDTH = 4,
    parameter OUT_WIDTH = 1
)
(
    input logic in_clk,
    input logic in_bank,
    input logic [2:0] in_block,
    input logic [$clog2((16 * 1024) / IN_WIDTH) - 1:0] in_addr,
    input logic [IN_WIDTH - 1:0] in_data,

    input logic out_clk,
    input logic out_bank,
    input logic [2:0] out_block,
    input logic [13:0] out_addr,
    output logic out_data
);

    wire [30:0] do_discard;
    wire [$clog2(IN_WIDTH) -1 : 0] in_addr_pad;
    wire [31: IN_WIDTH] in_data_pad;

    assign in_addr_pad = '0;
    assign in_data_pad = '0;

    SDPB
    #(
        .READ_MODE(1'b1),
        .BIT_WIDTH_0(IN_WIDTH),
        .BIT_WIDTH_1(OUT_WIDTH),
        .BLK_SEL_0(BLOCK),
        .BLK_SEL_1(BLOCK),
        .RESET_MODE("ASYNC")
    ) bram (
        // port a
        .CLKA(in_clk),
        .CEA(in_bank),
        .ADA({in_addr, in_addr_pad}),
        .BLKSELA(in_block),
        .DI({in_data_pad,in_data}),
        // port b
        .CLKB(out_clk),
        .CEB(out_bank),
        .RESET(1'b0),
        .OCE(1'b1),
        .BLKSELB(out_block),
        .ADB(out_addr),
        .DO({do_discard,out_data})
    );

endmodule
