module bin2ascii_test
#(
    CLOCK_PERIOD = 10
);

reg clk;
reg [3:0] nibble;

bin2ascii uut
(
    .nibble(nibble)
);

always #(CLOCK_PERIOD/2) clk = ~clk;

initial begin
    $dumpfile("bin2ascii.vcd");
    $dumpvars(0, clk);
    $dumpvars(1, uut);

    clk <= 0;
    nibble <= 0;

    for (int i = 0; i < 16; i = i + 1) begin
        @(posedge clk);
        nibble <= i;
    end

    @(posedge clk);

    $finish;
end

endmodule
