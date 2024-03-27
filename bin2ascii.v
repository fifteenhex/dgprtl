module bin2ascii
(
    input [3:0] nibble,
    output [7:0] ascii
);

    reg [7:0] values [15:0];
    assign values[0] = "0";
    assign values[1] = "1";
    assign values[2] = "2";
    assign values[3] = "3";
    assign values[4] = "4";
    assign values[5] = "5";
    assign values[6] = "6";
    assign values[7] = "7";
    assign values[8] = "8";
    assign values[9] = "9";
    assign values[10] = "a";
    assign values[11] = "b";
    assign values[12] = "c";
    assign values[13] = "d";
    assign values[14] = "e";
    assign values[15] = "f";

    assign ascii = values[nibble];
    
endmodule
