module hexbox
#(
    COLS = 8,
    XBITS = $clog2(COLS * 8) - 1
)
(
    input clk,
    input [31:0] value,
    input logic [XBITS:0] x,
    input logic [3:0] y,
    output pixel
);

reg [7:0] chars [7:0];
genvar i;
generate
    for (i = 0; i < 8; i++) begin : bin2ascii_insts
        bin2ascii bin2ascii_inst(
            .nibble(value[31 - (4 * i): 28 - (4 * i)]),
            .ascii(chars[i])
        );
    end
endgenerate

textbox textbox_inst(
    .clk(clk),
    .x(x),
    .y(y),
    .chars(chars),
    .pixel(pixel)
);

endmodule
