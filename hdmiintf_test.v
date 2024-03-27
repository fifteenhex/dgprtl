module hdmiintf_test
#(
    CLOCK_PERIOD = 10
);

reg pixel_clk;


always #(CLOCK_PERIOD/2) pixel_clk = ~pixel_clk;

hdmiintf uut(
    .clk_in(pixel_clk)
);

initial begin
    $dumpfile("hdmiintf.vcd");
    $dumpvars(0,pixel_clk);
    $dumpvars(0,uut);

    pixel_clk <= 0;

    for (int i = 0; i < (uut.HORIZONTAL_PIXELS * uut.VERTICAL_LINES) * 2; i = i + 1) begin
        @(posedge pixel_clk);
    end

    $finish;
end

endmodule
れ
