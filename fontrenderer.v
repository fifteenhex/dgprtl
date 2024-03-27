module fontrenderer
(
    input clk,
    input logic [7:0] char,
    input logic [2:0] x,
    input logic [3:0] y,
    output pixel
);

    reg [11:0] font_addr;
    reg [7:0] font_data;
    reg pixel_data = '0;

    fontrom fontrom
    (
        .clk(clk),
        .addr(font_addr),
        .data(font_data)
    );

    always @(posedge clk) begin
        pixel_data = font_data[7 - x];
    end

    assign font_addr = {char, y};
    assign pixel = pixel_data;
    
endmodule
