module latchingcounter
#(
    parameter INCREMENT = 1
)
(
    input logic clk,
    input logic rst,
    output logic [31:0] count = 0,
    output logic [31:0] counter = 0
);

    always @(posedge clk) begin
        if (rst)
            begin
            count <= counter;
            counter <= 0;
            end
        else
            counter <= counter + INCREMENT;
    end

endmodule