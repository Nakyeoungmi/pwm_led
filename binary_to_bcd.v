`timescale 1ns / 1ps
module binary_to_bcd(
    input [7:0] binary_in,
    output reg [11:0] bcd_out
    );
    integer i;
    reg [19:0] shift_reg;

    always @(*) begin
        shift_reg = 20'd0;
        shift_reg[7:0] = binary_in;
        for (i = 0; i < 8; i = i + 1) begin
            if (shift_reg[11:8] >= 5)
                shift_reg[11:8] = shift_reg[11:8] + 3;
            if (shift_reg[15:12] >= 5)
                shift_reg[15:12] = shift_reg[15:12] + 3;
            shift_reg = shift_reg << 1;
        end
        bcd_out = shift_reg[19:8];
    end
endmodule
