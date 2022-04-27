module ALU (
    input [2:0] portA,portB,
    input [1:0] opcode,
    input clk, rst,
    output [15:0] out
);


wire done;

reg [3:0] init;
wire init_LSHIFT;
wire init_RSHIFT;
wire init_ZERO;
wire init_DIV;

wire [2:0] out_lshift;
wire [2:0] out_rshift;
wire out_zero;
wire [2:0] out_div;


assign init_LSHIFT = init[0];
assign init_RSHIFT = init[1];
assign init_ZERO = init[2];
assign init_DIV = init[3];

reg [15:0]int_bcd;
wire DONE_div;
wire DONE_lshift;
wire DONE_rshift;
wire DONE_zero;

assign out = int_bcd;

//Decodificador
always @(*) begin
    case(opcode)
        2'b00: init<=1;
        2'b01: init<=2;
        2'b10: init<=4;
        2'b11: init<=8;
    default:
        init <=0;
    endcase
end
//Mux
always @(*) begin
	case(opcode) 
		2'b00: int_bcd <={8'b00,out_lshift};
		2'b01: int_bcd <={8'b00,out_rshift};
		2'b10: int_bcd <={8'b00,out_zero};
		2'b11: int_bcd <={8'b00,out_div};
	default:
		int_bcd <= 0;
	endcase
	
end
//Módulos
LSHIFT U1 (.portA(portA),.portB(portB),.clk(clk),.init(init_LSHIFT),.out(out_lshift),.DONE(DONE_lshift));
RSHIFT U2 (.portA(portA),.portB(portB),.clk(clk),.init(init_RSHIFT),.out(out_rshift),.DONE(DONE_rshift));
ZERO U3 (.portA(portA),.portB(portB),.clk(clk),.START(init_ZERO),.ZERO(out_zero),.DONE(DONE_zero));
divisor U4 (.portA(portA),.portB(portB),.clk(clk),.START(init_DIV),.DV(out_div),.DONE(DONE_div));


endmodule