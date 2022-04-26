    module divisor (
        input [2:0] portA,portB,
        input clk,
        input START,
        output reg [2:0] DV,
        output reg DONE
    );

    reg[3:0] status, next_status;
    reg [2:0] DR,A;
    reg INIT;
    reg LDA;
    reg DV0;
    reg SH_DC;
    reg DV0_WRITE;
    reg [2:0] ct;
    wire LT;
    wire z;


    //Registros
    always @(LDA, INIT, SH_DC , DV0_WRITE) begin
        if(INIT) begin
        DV = portA;
        DR = portB;  
        A = 3'b000;
        end

        if (SH_DC) begin
                A=A<<1;
                A[0]=DV[2];
                DV=DV<<1;
            // {A,DV} = {A,DV}<<1;
            end        
        if(DV0_WRITE) 
            DV[0]=DV0;

        if(LDA) 
                A=A-DR;


      
    end 

    //Contador decreciente
    always @(INIT, SH_DC) begin
        if(INIT) begin
        ct = 3;  
        end
        else  if(ct!=0 && SH_DC) begin
                ct=ct-1; 
        end
    end


    //comparador 1
    assign LT = (A<DR)? 1 : 0;




    //Comparador 2
    assign z=(ct==0)? 1 : 0;


    //FSM
    parameter START_S=0, SHIFT_DEC=1, NOTADD=2, ADD=3, END1=4;


    always@(posedge clk) begin
    case(status)
		START_S: begin
            if(START) begin
                next_status=SHIFT_DEC;
            end
        end
        SHIFT_DEC: begin
            if(LT)
            next_status=NOTADD;
            else
            next_status=ADD;
        end
        NOTADD: begin

        if(z)  
            next_status=END1;
           
        else 
            next_status=SHIFT_DEC;
        end
        ADD: begin

            if(z) 
                next_status=END1;
        
            else 
                next_status=SHIFT_DEC;
                
        
        end
        END1: begin
            next_status=END1;
        end
        
        default: next_status=START_S;
        endcase
  end

    always @(status ) begin
        case(status)
        START_S: begin
            SH_DC=0;
            LDA=0;
            DONE=0;
            INIT=1;
            DV0=0;
            DV0_WRITE=0;
        end
        SHIFT_DEC: begin
            SH_DC=1;
            LDA=0;
            DONE=0;
            INIT=0;
            DV0=DV0;
            DV0_WRITE=0;
        end
        NOTADD: begin
            SH_DC=0;
            LDA=0;
            DONE=0;
            INIT=0;
            DV0=0;
            DV0_WRITE=1;

        end
        ADD: begin
            SH_DC=0;
            LDA=1;
            DONE=0;
            INIT=0;
            DV0=1;      
            DV0_WRITE=1;  	  
        end
        END1: begin
            SH_DC=0;
            LDA=0;
            DONE=1;
            INIT=0;
            DV0=0;
            DV0_WRITE=0;
        end
        
        default: DONE=0;
        endcase
    end

    always@(posedge clk) begin
        status=next_status;
    end
    endmodule