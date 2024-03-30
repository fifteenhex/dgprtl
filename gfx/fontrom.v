module fontrom
(
    input clk,
    input enable,
    input logic [11:0] addr,
    input logic [11:0] next_addr,
    input logic next,
    output logic [7:0] data
);
    reg [7:0] rom [0:4095];

    initial begin
        $readmemh("seabios8x16.hex", rom);
    end

    always @(posedge clk) begin
        if (enable && next)
            data <= rom[next_addr];
    end
endmodule
