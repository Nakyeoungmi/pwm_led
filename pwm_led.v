`timescale 1ns / 1ps

module pwm_led(
    input clk,
    input rst_btn,
    input [7:0] dip_sw,
    output reg led_out,
    output [7:0] seg,
    output [7:0] seg_sel
    );

    wire [7:0] cnt;
    wire rst = rst_btn;
    wire [11:0] bcd;

    counter8 u_cnt (
        .clk(clk),
        .rst(rst),
        .count(cnt)
    );

    always @(*) begin
    if (rst)
        led_out = 1'b0;
    else if (cnt < dip_sw)
        led_out = 1'b1;
    else
        led_out = 1'b0;
end


    binary_to_bcd u_b2b (
        .binary_in(dip_sw),
        .bcd_out(bcd)
    );

    seg7_controller u_seg (
        .clk(clk),
        .rst(rst),
        .bcd(bcd),
        .seg(seg),
        .seg_sel(seg_sel)
    );

endmodule
