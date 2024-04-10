module framebuffer_test
#(
    CLOCK_PERIOD = 10
);

reg clk;
reg enable;
reg [9:0] fb_x;
reg [8:0] fb_y;

framebuffer 
#(
    .WIDTH_IN(4)
)
uut4 (
    .in_clk(clk),
    .in_enable(enable),
    .in_x(fb_x),
    .in_y(fb_y),
    .out_x(fb_x),
    .out_y(fb_y)
);

framebuffer 
#(
    .WIDTH_IN(16)
)
uut16 (
    .in_clk(clk),
    .in_enable(enable),
    .in_x(fb_x),
    .in_y(fb_y),
    .out_x(fb_x),
    .out_y(fb_y)
);

always #(CLOCK_PERIOD/2) clk = ~clk;

initial begin
    $dumpfile("framebuffer.vcd");
    $dumpvars(0, clk);
    $dumpvars(0, uut4);
    $dumpvars(0, uut16);

    clk <= 0;
    enable <= 1;
    fb_x <= 0;
    fb_y <= 0;

    for (int y = 0; y < 512; y++) begin
        for (int x = 0; x < 1024; x++) begin
            @(posedge clk)
            fb_x <= x;
            fb_y <= y;
        end
    end


    $finish;
end

endmodule
