module CLKDIV2
(
    input logic HCLKIN,
    input logic RESETN,
    output logic CLKOUT
);

reg counter = '0;

assign CLKOUT = counter;

always @(posedge HCLKIN) begin
    counter <= counter + '1;
end

endmodule
