module sdram_chip_intf
(
    inout logic [15:0] data,
    output logic [12:0] addr,
    output logic [1:0] ba,
    output logic cs,
    output logic cas,
    output logic ras,
    output logic udm,
    output logic ldm,
    output logic nwe,
    output logic clk
);

enum {IDLE} state;

endmodule
