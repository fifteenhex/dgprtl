module framebuffer
#(
    HEIGHT = 512,
    WIDTH = 1024,
    WIDTH_IN = 4,
    BPP = 1
)
(
    input logic in_clk,
    input logic in_enable,
    /* Max vertical resolution is HEIGHT lines, has to be 512 for now */
    input logic [$clog2(HEIGHT - 1) - 1:0] in_y,
    /* Max horizontal resolution is 1024 pixels */
    input logic [$clog2(WIDTH - 1) - 1:0] in_x,
    /* 4 pixels at a time */
    input logic [WIDTH_IN - 1:0] in_data,

    // output side
    input logic out_clk,
    input logic [$clog2(HEIGHT - 1) - 1:0] out_y,
    input logic [$clog2(WIDTH - 1) - 1:0] out_x,
    output logic out_data
);

    localparam IN_ADDR_UNITS = ((16 * 1024) / WIDTH_IN);
    localparam IN_ADDR_WIDTH = $clog2(IN_ADDR_UNITS);
    localparam IN_ADDR_LINE_WIDTH = $clog2(1024 / WIDTH_IN);


    reg [3:0] out_bank;
    wire logic [2:0] out_block;
    wire logic [13:0] out_addr;
    wire logic [3:0] out_bank_data [7:0];

    
    wire [3:0] in_bank;
    wire logic [2:0] in_block;
    wire logic [IN_ADDR_WIDTH - 1:0] in_addr;

    framebuffer_xy2addr 
    #(
        .WIDTH_IN(WIDTH_IN)
    )
    xy2addr_in
    (
        .x(in_x),
        .y(in_y),
        .bank(in_bank),
        .block(in_block),
        .addr(in_addr)
    );
    
    genvar i;
    genvar j;
    generate
        for (i = 0; i < 4; i++) begin : bram_banks
            for (j = 0; j < 8; j++) begin : bram_blocks
                bramwrapper_dualport #(
                    .BLOCK(j),
                    .IN_WIDTH(WIDTH_IN)
                ) inst (
                    .in_clk(in_clk),
                    .in_bank(in_bank[i] && in_enable),
                    .in_block(in_block),
                    .in_addr(in_addr),
                    .in_data(in_data),
                    .out_clk(out_clk),
                    .out_bank(out_bank[i]),
                    .out_block(out_block),
                    .out_addr(out_addr),
                    .out_data(out_bank_data[j][i])
                );
            end
        end
    endgenerate

    always @(posedge out_clk) begin
        // 4 banks of BRAM banks
        case (out_y[8:7])
            2'b00: out_bank <= 4'b0001;
            2'b01: out_bank <= 4'b0010;
            2'b10: out_bank <= 4'b0100;
            2'b11: out_bank <= 4'b1000;
        endcase        
    end

    assign out_block = out_y[6:4];
    assign out_addr[13:10] = out_y[3:0];
    assign out_addr[9:0] = out_x;

    assign out_data = out_bank_data[out_block][out_y[8:7]];

endmodule
