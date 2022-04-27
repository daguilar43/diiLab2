`timescale 1ns / 1ps
module LSHIFT (
    input init,
    input [2:0] portA, portB,
    input clk,
    output reg [2:0] out,
    output reg DONE
);

always @(*) begin
    
    if (init) begin
        out = portA << portB;
        DONE = 1;
    end
    
end

endmodule

/* module testLSHIFT;
    
    reg clk, init;
    reg [2:0] portA,portB;
    wire [2:0] out;
    wire DONE;

    LSHIFT uut (.portA(portA),.portB(portB),.clk(clk),.init(init),.out(out),.DONE(DONE));

    initial begin
        $dumpfile("LSHIFT_tb.vcd");
        $dumpvars(0,testLSHIFT);
        portA = 5;
        portB = 1;
        clk=0;
        init=0;

        #18 init=1;
        #2000 $finish;
    end
    
always #1 clk = ~clk;

endmodule */