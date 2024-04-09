module framebuffer_test
#(
    CLOCK_PERIOD = 10
);

reg clk;

framebuffer framebuffer (
    .clk(clk)
);

always #(CLOCK_PERIOD/2) clk = ~clk;

initial begin
    $dumpfile("framebuffer.vcd");
    $dumpvars(0, clk);
    $dumpvars(0, uut);

    clk <= 0;

    $finish;
end

endmodule
