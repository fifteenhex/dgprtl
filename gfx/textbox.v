module textbox
#(
    SCREEN_WIDTH,
    SCREEN_HEIGHT,
    COL_WIDTH = 8,
    ROW_HEIGHT = 16,
    START_COL = 0,
    START_ROW = 0,
    COLS = 8,
    ROWS = 1
)
(
    input logic clk,
    input logic [$clog2(SCREEN_WIDTH) - 1:0] x,
    input logic [$clog2(SCREEN_HEIGHT) - 1:0] y,
    input logic [7:0] chars[0:COLS - 1],
    output logic pixel
);

    /* A window to handle where this renders */
    reg win_active;
    reg win_line;
    reg win_frame;
    reg [$clog2(COLS * COL_WIDTH) - 1:0] win_x;
    reg [$clog2(ROWS * ROW_HEIGHT) - 1:0] win_y;
    reg [$left(win_x):0] win_x_next;
    reg [$left(win_y):0] win_y_next;
    reg [$clog2((COLS * ROWS) * (COL_WIDTH * ROW_HEIGHT)) - 1:0] win_pixel;
    reg [$left(win_pixel):0] win_pixel_next;
    
    window #(
        .SCREEN_HEIGHT(SCREEN_HEIGHT),
        .SCREEN_WIDTH(SCREEN_WIDTH),
        .X_START(START_COL * COL_WIDTH),
        .X_END((START_COL + COLS) * COL_WIDTH),
        .Y_START(START_ROW * ROW_HEIGHT),
        .Y_END((START_ROW + ROWS) * ROW_HEIGHT)
    ) window_inst(
        .clk(clk),
        .x(x),
        .y(y),
        /* region control */
        .active(win_active),
        .line(win_line),
        .frame(win_frame),
        /* rendering control */
        .window_x(win_x),
        .window_y(win_y),
        .window_x_next(win_x_next),
        .window_y_next(win_y_next),
        .pixel(win_pixel),
        .pixel_next(win_pixel_next)
    );

    // The currently displayed char
    reg [$clog2(COL_WIDTH) - 1:0] char_x;
    reg [$clog2(ROW_HEIGHT) - 1:0] char_y;
    reg [$clog2(COLS) - 1:0] char_index;
    reg [7:0] char;

    assign char_x = win_x[$left(char_x):0];
    assign char_y = win_y;
    assign char_index = win_x[$left(win_x):$left(char_x) + 1];
    assign char = chars[char_index];

    /*
     * The next to be displayed char, to handle
     * situations where the font rom takes an
     * extra clock to present data
     */
    reg [$left(char_y):0] next_char_y;
    reg [$left(char_index):0] next_char_index;
    reg [7:0] next_char;
   
    assign next_char_y = win_y_next;
    assign next_char_index = char_index + 1;
    assign next_char = chars[next_char_index];

    fontrenderer fontrenderer_inst (
        .clk(clk),
        .enable(win_active),
        .x(char_x),
        .y(char_y),
        .char(char),
        .pixel(pixel),

        .next_char(next_char),
        .next_y(next_char_y)
    );

endmodule
