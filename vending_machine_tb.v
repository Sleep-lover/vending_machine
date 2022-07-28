`include "vending_machine.v"
`timescale 1ps/1ps
module vending_machine_tb;
    
    // inputs
    reg clk;
    reg [1:0] in;
    reg rst;
    
    // output
    wire out;
    wire [1:0] change;

    vending_machine uut(
        .clk(clk),
        .rst(rst),
        .in(in),
        .out(out),
        .change(change)
);

initial 
begin  
    // initialize inputs
        $dumpfile("vending_machine.vcd");
        $dumpvars(0,vending_machine_tb);
        rst = 1;
        clk = 0;
        #5 rst = 0;in = 1;
        #5 in = 2'b01;
        #5 in = 2'b01;
        #5 in = 2'b01;
        #5 in = 2'b01;
        #5 $finish;
end
    always #5 clk = ~clk;
endmodule