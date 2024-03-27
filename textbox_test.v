module textbox_test
#(
    CLOCK_PERIOD = 10
);

reg clk;
reg [5:0] x;
reg [3:0] y;
reg [7:0] chars[0:7];
reg pixel;

textbox uut
(
    .clk(clk),
    .x(x),
    .y(y),
    .chars(chars),
    .pixel(pixel)
);

always #(CLOCK_PERIOD/2) clk = ~clk;

initial begin
    $dumpfile("textbox.vcd");
    $dumpvars(0, clk);
    $dumpvars(1, uut);

    clk <= 0;
    x <= 0;
    y <= 0;
    chars[0] <= "A";
    chars[1] <= "B";
    chars[2] <= "C";
    chars[3] <= "D";
    chars[4] <= "1";
    chars[5] <= "2";
    chars[6] <= "3";
    chars[7] <= "4";
    
    for (int vert = 0; vert < 16; vert = vert + 1) begin 
        for (int hor = 0; hor < (8 * 8); hor = hor + 1) begin 
            @(posedge clk);
                x <= hor;
                y <= vert;
        end
    end

    @(posedge clk);

    $finish;
end

endmodule
