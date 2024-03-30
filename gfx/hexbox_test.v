module hexbox_test
#(
    CLOCK_PERIOD = 10
);

reg clk;
reg enable;
reg [31:0] value;
reg [5:0] x;
reg [3:0] y;
reg pixel;

hexbox uut (
    .clk(clk),
    .enable(enable),
    .value(value),
    .x(x),
    .y(y),
    .pixel(pixel)
);

always #(CLOCK_PERIOD/2) clk = ~clk;

initial begin
    $dumpfile("hexbox.vcd");
    $dumpvars(0, clk);
    $dumpvars(0, uut);

    clk <= 0;
    enable <= 1;
    value <= 32'habcd1234;
    x <= 0;
    y <= 0;

    for (int v = 0; v < 255; v++) begin
        for (int vert = 0; vert < 16; vert++) begin
            for (int hor = 0; hor < (8 * 8); hor++) begin
                @(negedge clk);
                y <= vert;
                x <= hor;
                @(posedge clk);
            end
        end
    end

    $finish;
end

endmodule
