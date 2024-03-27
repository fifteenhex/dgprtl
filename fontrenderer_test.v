module fontrenderer_test
#(
    CLOCK_PERIOD = 10
);

reg clk;
reg [7:0] char;
reg [2:0] x;
reg [3:0] y;
reg pixel;

fontrenderer uut(
    .clk(clk),
    .char(char),
    .x(x),
    .y(y),
    .pixel(pixel)
);

always #(CLOCK_PERIOD/2) clk = ~clk;



initial begin
    $dumpfile("fontrenderer.vcd");
    $dumpvars(0, clk);
    $dumpvars(1, uut);

    clk <= 0;
    char <= "A";
    x <= 0;
    y <= 0;

    @(posedge clk);

    for (int i = 0; i < 16; i = i + 1) begin
        for (int j = 0; j < 8; j = j + 1) begin
            x <= j;
            y <= i;
            @(posedge clk);
        end
    end

    @(posedge clk);

    $finish;
end

endmodule
