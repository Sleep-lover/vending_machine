module vending_machine(
input clk,
input rst,
input [1:0] in, // 01 = Rs 5, 10 = Rs 10
output reg out,
output reg [1:0] change
);
parameter s0 = 2'b00;
parameter s1 = 2'b01;
parameter s2 = 2'b10;   
reg [1:0] c_state, n_state;
always @ (posedge clk)
begin
    if (rst==1)
        begin
            c_state = 0;
            n_state = 0;
            change = 2'b00;
        end
    else 
        c_state = n_state;
    case(c_state)
        s0: // state 0: Rs0
        begin
            if(in==0)
                begin
                    n_state = s0;
                    out = 0;
                    change = 2'b00;
                end
            else if(in==2'b01)
                begin
                    n_state = s1;
                    out = 0;
                    change = 2'b00;
                end
            else if(in==2'b10)
                begin
                    n_state = s2;
                    out = 0;
                    change = 2'b00;
                end
        end
        s1: // state 1: Rs 5
        begin
            if(in==0)
                begin
                    n_state = s0;
                    out = 0;
                    change = 2'b01; // change returned Rs 5
                end
            else if(in==2'b01)
                begin
                    n_state = s2;
                    out = 0;
                    change = 2'b00;
                end
            else if(in==2'b10)
                begin
                    n_state = s0;
                    out = 1; // product will be given
                    change = 2'b00;
                end
        end
        s2: // state 2: Rs 10
        begin
            if(in==0)
                begin
                    n_state = s0;
                    out = 0;
                    change = 2'b10;  // change returned Rs 10
                end
            else if(in==2'b01)
                begin
                    n_state = s0;
                    out = 1; // product will be given
                    change = 2'b00;
                end
            else if(in==2'b10) // customer has given more money than product cost
                begin
                    n_state = s0;
                    out = 1; // product will be given
                    change = 2'b01; // change returned Rs 5
                end
        end
    endcase
end
endmodule