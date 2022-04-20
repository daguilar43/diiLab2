module divisor (
    input [2:0] portA,portB,
    input clk,
    input init,
    output reg [2:0] D,M,
    output reg done 
);

reg[2:0] status;
reg [2:0] DV,DR,A;
reg rst;
reg SH_DC;
reg subs;
reg [1:0] ct;
wire LT;
wire z;


//Registro desplazamiento
always @(posedge clk) begin
    if(rst) begin
      DV = portA;
      DR = portB;  
      {A,DV} = {3'b000,DV};  
    end
    else begin
        if (SH_DC) begin
            {A,DV} = {A,DV}<<1;
        end
    end
end
//Contador decreciente
always @(posedge clk) begin
    if(rst) begin
      ct = 3;  
    end
    else begin
        if (SH_DC) begin
            ct = ct-1;
        end
    end
end
//comparador 1
assign LT = (A<DR)? 1 : 0;
//restador
always @(posedge clk) begin
    begin
        if (subs) begin
            A = A - DR;
        end
    end
end
//Comparador 2
assign z=(ct==0)? 1 : 0;


//FSM
parameter START=0, SHIFT_DEC=1, NOTSUBS=2, SUBS=3, END=4;

always @(posedge clk) begin
    case(status)
    START: begin
        rst=0;
        SH_DC=0;
        subs=0;
        done=0;
        if(init) begin
            rst = 1;
            status=SHIFT_DEC;
        end
    end
    SHIFT_DEC: begin
        rst=0;
        SH_DC=1;
        subs=0;
        done=0;
        if(LT) status=NOTSUBS;
        else   status=SUBS;
    end
    NOTSUBS: begin
        rst=0;
        SH_DC=0;
        subs=0;
        done=0;
        DV[0]=0;
        if(z) status=END;
        else  status=SHIFT_DEC;
    end
    SUBS: begin
        rst=0;
        SH_DC=0;
        subs=1;
        done=0;
        DV[0]=1;
        if(z) status=END;
        else  status=SHIFT_DEC;
    end
    END: begin
        rst=0;
        SH_DC=0;
        subs=0;
        D = DV;
        M = A;
        done=1; 
    end
    default:
        status=START;
    endcase
end



endmodule