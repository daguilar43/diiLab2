`timescale 1ns / 1ps
module RSHIFT (
    input init,
    input [2:0] portA, portB,
    input clk,
    output reg [2:0] out,
    output reg DONE
);

always @(*) begin
    
    if (init) begin
        out = portA >> portB;
        DONE = 1;
    end
    
end

endmodule

/* module testRSHIFT;
    
    reg clk, init;
    reg [2:0] portA,portB;
    wire [2:0] out;
    wire DONE;

    RSHIFT uut (.portA(portA),.portB(portB),.clk(clk),.init(init),.out(out),.DONE(DONE));

    initial begin
        $dumpfile("RSHIFT_tb.vcd");
        $dumpvars(0,testRSHIFT);
        portA = 6;
        portB = 2;
        clk=0;
        init=0;

        #18 init=1;
        #2000 $finish;
    end
    
always #1 clk = ~clk;

endmodule */