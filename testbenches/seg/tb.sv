`timescale 1ns/1ps
module tb;
    // Clock parameters
    localparam int CLK_HZ     = 100_000_000;
    localparam time CLK_PERIOD = 1s / CLK_HZ;
    // Signals
    logic        clk;
    logic        rst    = 1;
    logic        serial_in;
    logic [7:0]  byte_out;
    // DUT instantiation
    sreg_marshalling DUT (
        .clk       (clk),
        .rst       (rst),
        .serial_in (serial_in),
        .byte_out  (byte_out)
    );
    // Clock generation
    initial begin
        clk = 1;
    end
    always #(CLK_PERIOD/2) clk = !clk;
    // Test sequence + waveform dump
    initial begin : simulation 
        logic [31:0] test_pattern = 32'hABCD1234;
        // VCD dump
        $dumpfile("sreg_marshalling.vcd");
        $dumpvars(0, tb);
        // Release reset after a few cycles
        #10ns;
        rst = 0;
        // Shift in 32 bits, one per clock
        for (int i = 0; i < 32; i++) begin
            serial_in = test_pattern[i];
            #(CLK_PERIOD);
        end
        # (CLK_PERIOD*12);
        $finish;
    end
endmodule
