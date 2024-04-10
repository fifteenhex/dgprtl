module framebuffer_xy2addr
#(
    HEIGHT = 512,
    WIDTH = 1024,
    WIDTH_IN = 4,
    BPP = 1,
    IN_ADDR_LINE_WIDTH = $clog2(1024 / WIDTH_IN)
)
(
    input logic [9:0] x,
    input logic [8:0] y,
    output logic [3:0] bank = 4'b0001,
    output logic [2:0] block,
    output logic [IN_ADDR_WIDTH - 1:0] addr
);

    localparam IN_ADDR_UNITS = ((16 * 1024) / WIDTH_IN);
    localparam IN_ADDR_WIDTH = $clog2(IN_ADDR_UNITS);

    wire logic [IN_ADDR_WIDTH - 1:0] in_addr;
    
    always @(*) begin
        // 4 banks of BRAM banks
        case (y[8:7])
            2'b00: bank <= 4'b0001;
            2'b01: bank <= 4'b0010;
            2'b10: bank <= 4'b0100;
            2'b11: bank <= 4'b1000;
        endcase        
    end
    
    // 8 BRAMs per bank
    assign block = y[6:4];
    /* 
     * There are 16Kbit per bram, so 16 1024 pixel lines
     * this means that the bottom four bits of the current in y
     * select the line in a single bram */
    assign addr[IN_ADDR_WIDTH - 1:IN_ADDR_LINE_WIDTH] = y[3:0];
    //assign in_addr[IN_ADDR_LINE_WIDTH - 1:0] = in_x[9:2];
    assign addr[IN_ADDR_LINE_WIDTH - 1:0] = x[9:4];

endmodule
