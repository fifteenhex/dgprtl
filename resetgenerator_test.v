module resetgenerator_test
#(
    CLOCK_PERIOD = 10
);

reg clk;
reg rst_in;
reg rst_out;

resetgenerator uut(
    .clk(clk),
    .rst_in(rst_in),
    .rst_out(rst_out)
);

always #(CLOCK_PERIOD/2) clk = ~clk;

initial begin
    $dumpfile("resetgenerator.vcd");
    $dumpvars(0,uut);

    clk <= 0;
    rst_in <= 0;

    #10 rst_in <= 1;
    #20 rst_in <= 0;

    wait(rst_out == 1);

    $finish;
end

endmodule
