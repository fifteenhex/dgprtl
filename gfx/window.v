module window
#(
    SCREEN_WIDTH,
    SCREEN_HEIGHT,
    X_START,
    X_END,
    Y_START,
    Y_END
)
(
    input clk,
    input [$clog2(SCREEN_WIDTH) - 1:0] x,
    input [$clog2(SCREEN_HEIGHT) - 1:0] y,
    
    /* region control */
    output active,
    output line,
    output frame,

    /* drawing control */
    output [$clog2((X_END - X_START) * (Y_END - Y_START)) - 1:0] pixel,
    output [$left(pixel):0] pixel_next,
    output [$clog2(X_END - X_START) - 1:0] window_x,
    output [$clog2(Y_END - Y_START) - 1:0] window_y,

    output [$left(window_x):0] window_x_next,
    output [$left(window_y):0] window_y_next
);

    assign window_x = line ? x - X_START : '0;
    assign window_y = frame ? y - Y_START : '0;
    assign window_y_next = pixel_next[$left(pixel_next):$left(window_x) + 1];

    assign active = line && frame;
    assign line = (x >= X_START) && (x < X_END) ? '1 : '0;
    assign frame = (y >= Y_START) && (y < Y_END) ? '1 : '0;

    assign pixel = {window_y, window_x};
    assign pixel_next = pixel + 1;

endmodule
