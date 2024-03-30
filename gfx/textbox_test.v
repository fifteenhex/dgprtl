module textbox_test
#(
    CLOCK_PERIOD = 10,
    SCREEN_WIDTH = 800
);

reg clk;
reg enable;

/* Screen x and y */
reg [$clog2(SCREEN_WIDTH) - 1:0] x;
reg [5:0] y;
reg [7:0] chars[0:31];
reg pixel;

textbox #(
 .SCREEN_WIDTH(SCREEN_WIDTH),
 .SCREEN_HEIGHT(600),
 .START_COL(4),
 .START_ROW(1),
 .COLS(32)
) uut
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
    $dumpvars(0, x);
    $dumpvars(0, y);
    $dumpvars(0, uut);

    clk <= 0;
    enable <= 0;
    x <= 0;
    y <= 0;
    chars[0] <= "a";
    chars[1] <= "b";
    chars[2] <= "d";
    chars[3] <= "d";
    chars[4] <= "e";
    chars[5] <= "f";
    chars[6] <= "g";
    chars[7] <= "h";

    chars[8] <= "1";
    chars[9] <= "2";
    chars[10] <= "3";
    chars[11] <= "4";
    chars[12] <= "5";
    chars[13] <= "6";
    chars[14] <= "7";
    chars[15] <= "8";
    
    for (int frame = 0; frame < 3; frame++) begin
        for (int vert = 0; vert < 64; vert = vert + 1) begin
            for (int hor = 0; hor < SCREEN_WIDTH; hor = hor + 1) begin
                x <= hor;
                y <= vert;
                @(posedge clk);
            end
        end
    end

    @(posedge clk);

    $finish;
end

endmodule
