/*
 * Very basic module to generate a reset pulse
 * from a push button or similar.
 */

module resetgenerator (
    input logic clk,
    input logic rst_in,
    output logic rst_out
);

reg [16:0] counter = '0;

assign rst_out = ~counter[16];

always @(posedge clk) begin
    if (rst_in)
        counter <= 0;
    else if (!counter[16])
        counter <= counter + 1;
end

endmodule
