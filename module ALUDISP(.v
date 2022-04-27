module ALUDISP(
    input [2:0] portA,portB,
    input [1:0] opcode,
    input clk, rst, 
    output reg [6:0] SSeg
);

wire[15:0] salALU;


//modulos
ALU uu1(.portA(portA),portB(portB),.opcode(opcode),.clk(clk),.clk(clk),.out(salALU));
BCDtoSSeg uu2(.BCD(salALU[3:0]),.SSeg(SSeg));
    
endmodule