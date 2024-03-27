module fontrom
(
    input clk,
    input logic [11:0] addr,
    output logic [7:0] data
);
    reg [7:0] rom [0:4095];
    assign data = rom[addr];

    initial begin
        $readmemh("seabios8x16.hex", rom);
    end
endmodule
