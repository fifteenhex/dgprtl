module textbox
#(
    COLS = 8,
    XBITS = $clog2(COLS * 8) - 1
)
(
    input logic clk,
    input logic [XBITS:0] x,
    input logic [3:0] y,
    input logic [7:0] chars[COLS - 1:0],
    output logic pixel
);

    reg [2:0] char_x;
    reg [XBITS - 2: 0] char_index;
    reg [7:0] char;

    fontrenderer fontrenderer_inst (
        .clk(clk),
        .x(char_x),
        .y(y),
        .char(char),
        .pixel(pixel)
    );

    assign char_x = x[2:0];
    assign char_index = x[XBITS:3];
    assign char = chars[char_index];

endmodule
