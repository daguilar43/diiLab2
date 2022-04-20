module ALU (
    input [2:0] portA,portB,
    input [1:0] opcode,
    input clk, rst,
    output [5:0] out
);

reg [1:0] init;
wire done;
wire init_mult;

assign init_mult = init[0];
//Decodificador
always @(*) begin
    case(opcode)
        2'b01: init<=1;
    default:
        init <=0;
    endcase
end
//Mux


//Módulos
multiplicador mult(.pp(out),.done(done),.MD(portA),.MR(portB),.init(init_mult),.clk(clk));

endmodule