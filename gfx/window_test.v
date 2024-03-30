module window_test
#(
    CLOCK_PERIOD = 10
);

reg clk;
reg [31:0] x;
reg [31:0] y;

always #(CLOCK_PERIOD/2) clk = ~clk;

window #(
    .SCREEN_WIDTH(800),
    .SCREEN_HEIGHT(600),
    .X_START(64),
    .X_END(64 + 64),
    .Y_START(16),
    .Y_END(16 + 16)
)
uut(
    .clk(clk),
    .x(x),
    .y(y)
);

initial begin
    $dumpfile("window.vcd");
    $dumpvars(0, clk);
    $dumpvars(0, uut);

    clk <= 0;

    for (int vert = 0; vert < 600; vert++) begin
        for (int hor = 0; hor < 800; hor++) begin
            x <= hor;
            y <= vert;
            @(posedge clk);
        end
    end
    
    $finish;
end

endmodule
