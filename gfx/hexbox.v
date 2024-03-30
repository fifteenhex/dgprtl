module hexbox
#(
    COLS = 8
)
(
    input logic clk,
    input logic [31:0] value,
    output logic [7:0] chars [0:COLS - 1]
);

genvar i;
generate
    for (i = 0; i < 8; i++) begin : bin2ascii_insts
        bin2ascii bin2ascii_inst(
            .nibble(value[31 - (4 * i): 28 - (4 * i)]),
            .ascii(chars[i])
        );
    end
endgenerate

endmodule
