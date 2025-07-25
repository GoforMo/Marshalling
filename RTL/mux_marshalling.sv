`timescale 1ns/1ps
module mux_marshalling (
    input  logic clk, //same port mapping of sreg_marshalling
    input  logic rst,
    input  logic serial_in,
    output logic [7:0] byte_out
);

    logic [7:0] temp;
    logic [2:0] cnt;

    always_ff @(posedge clk) begin
        if (rst) begin
            byte_out <= '0;
            temp <= '0;
            cnt <= '0;
        end 
        else begin
            temp[cnt] <= serial_in;
            cnt <= cnt + 1;

            if (cnt == 0) begin
                byte_out <= temp;
            end
        end
    end

endmodule

