module fontrenderer
#(
    COL_WIDTH = 8,
    ROW_HEIGHT = 16
)
(
    input clk,
    input enable = 1,
    input logic [7:0] char,
    input logic [$clog2(COL_WIDTH) - 1:0] x,
    input logic [$clog2(ROW_HEIGHT) - 1:0] y,
    output pixel,

    input logic [7:0] next_char,
    input logic [$left(y):0] next_y
);

    reg [11:0] font_addr;
    reg [11:0] next_font_addr;
    reg [7:0] font_data;
    reg pixel_data;
    reg next;

    fontrom fontrom
    (
        .clk(clk),
        .enable(enable),
        .addr(font_addr),
        .next_addr(next_font_addr),
        .next(next),
        .data(font_data)
    );

    assign pixel_data = font_data[7 - x];
    assign font_addr = {char, y};
    assign next_font_addr = {next_char, next_y};
    assign pixel = enable ? ~pixel_data : 0;
    assign next = x == 3'b111;
    
endmodule
