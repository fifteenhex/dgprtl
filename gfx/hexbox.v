module hexbox
#(
    COLS = 8
)
(
    input logic [((COLS * 4) - 1):0] value,
    output logic [7:0] chars [0:COLS - 1]
);

genvar i;
generate
    for (i = COLS - 1; i >= 0; i--) begin : bin2ascii_insts
        bin2ascii bin2ascii_inst(
            .nibble(value[(((i + 1) * 4) - 1) : (i * 4)]),
            .ascii(chars[(COLS - 1) - i])
        );
    end
endgenerate

endmodule
