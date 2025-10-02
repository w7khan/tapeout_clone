/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

    reg [7:0] counter;

    always @(posedge clk or negedge rst_n) begin
        //reset
        if (!rst_n) begin
            counter <= 8'b0;
        end

        //set
        else if (uio_in[1]) begin
            counter <= ui_in;
        end
        
        //enable
        else if (uio_in[0]) begin
            counter <= counter + 1'b1;
        end
        
    end

    // Tri-state output
    assign uo_out = uio_in[2] ? counter : 8'bz;

endmodule
