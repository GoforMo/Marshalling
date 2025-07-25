`timescale 1ns/1ps
module tb;
    localparam int CLK_HZ     = 100_000_000;
    localparam time CLK_PERIOD = 1s / CLK_HZ;
    // Signals
    logic        clk;
    logic        rst = 1;
    logic        serial_in;
    logic [7:0]  byte_out;
    logic [31:0] test_pattern = 32'hABCD1234;
    // DUT instantiation
    mux_marshalling DUT (
        .clk       (clk),
        .rst       (rst),
        .serial_in (serial_in),
        .byte_out  (byte_out)    );
    // Clock generation
    initial
    begin
        clk = 1'b0;
    end
    always #(CLK_PERIOD/2) clk = !clk; //logical NOT because clock is single bit
    // Test sequence + waveform dump
    initial begin : simulation   
        // VCD dump
        $dumpfile("mux_marshalling.fst");
        $dumpvars(0, tb);
        #(CLK_PERIOD);
        rst       = 0;
        // Shift in 32 bits, one per clock
        for (int i = 0; i < 32; i++) begin
            serial_in = test_pattern[i];
            #(CLK_PERIOD);
        end
        # (CLK_PERIOD*12);
        $finish;
    end
endmodule
