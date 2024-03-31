module bramwrapper_singleport
#(
    parameter BLOCK = 0,
    parameter WIDTH = 8
)
(
    input logic clk,
    input logic enable,
    input logic [2:0] block,
    input logic [11:0] addr,
    input logic [WIDTH - 1:0] data_in,
    output logic [WIDTH - 1:0] data_out
);

    wire logic [31:WIDTH] do_discard;

    SP #(
        .READ_MODE(1'b0),
        .WRITE_MODE(2'b00),
        .BIT_WIDTH(WIDTH),
        .BLK_SEL(BLOCK),
        .RESET_MODE("ASYNC")
    ) bram (
        .CLK(clk),
        .CE(enable),
        .AD({addr, 2'b00}),
        .BLKSEL(block),
        .DI({{(31 - WIDTH){1'b0}}, data_in}),
        .DO({do_discard,data_out})
    );

endmodule
