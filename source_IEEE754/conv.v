`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2024 03:27:10
// Design Name: 
// Module Name: conv
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module conv(    output [31:0]out,
                output reg  done,
                input [31:0]feature,filter,
                input clk,rst,
                input [2:0]stride,pad
                 );

parameter  m = 2,n_dum = 3;
wire [2:0]n;
assign n = n_dum+2*pad;

reg [7:0]counta,countb,countc,countd;
reg [3:0]state,nextstate; 
parameter s0=0,s1=1,s2=2,s3=3,s4=4,s5=5,s6=6,s7=7,s8=8;

reg [31:0] feature_dum [(n_dum)*(n_dum)-1:0];
reg [31:0]filter_dum[m*m-1:0];
reg [31:0]operanda,operandb;
reg [31:0]sum ,product;
reg sign;


reg [31:0]temp1;
wire [31:0]product_dum;
wire [31:0]temp;
reg [47:0]result;

reg [2:0]r,c;
wire [7:0]index; //index of feature matrix
wire [7:0]indexa;//index of filter matrix along with padding
wire [3:0]index_feature;

wire [7:0]check00;
wire [7:0]check01;
wire [7:0]pa0;
wire [7:0]pa1;

assign pa1 = (n*(pad));
assign pa0 = (n)*(n_dum+pad);


assign check00 = n*(r+stride*countd)+pad;
assign check01 = n*(r+stride*countd)+pad+n_dum;

assign indexa = (m)*r+c;

assign index = (n)*(r+stride*countd)+c+stride*countc;
assign index_feature= index - (n_dum)*(pad)-2*pad*(r+stride*countd)-pad;

adder  add( .out(temp),.A(temp1),.B(product),.op(1'b0));
multi mul(.op(product_dum),.a(operanda),.b(operandb));


always @(posedge clk)
begin
    if(rst)
    begin
       state <= s0;
    end
    
    else 
    begin
        state <= nextstate;
        if(state == s0)
        begin
            counta <= 0; 
            countb <= 0; 
            countc <= 0; 
            countd <= 0; 
            sum <= 0;
            r<=0;
            c<=0;
        end
        if(state == s1)
        begin
            if(counta<(n_dum*n_dum-1))//2
            begin
                counta <= counta + 1;
            end
            else 
            begin
                counta <= 0;
            end
        end
        
        if(state == s2)
        begin
            feature_dum[counta] <= feature;
        end
        
        if(state == s3)
        begin
            if(countb<(m*m-1))
            begin
                countb <= countb + 1;
            end
            else 
            begin
                countb <= 0;
            end
        end
        
        if(state == s4)
        begin
            filter_dum[countb] <= filter;
        end
        
        if(state == s5)
        begin
            if(c<m-1)
            begin
                c <= c+1;
            end
            else 
            begin
                c <= 0;
                if(r<m-1) r <= r+1;
                else 
                    begin
                        r <= 0;
                        sum <= 0;
                        if((m-1)+stride*(countc+1)>=n) 
                        begin
                            countc <= 0;
                            countd <= countd + 1;
                        end
                        else countc <= countc+1;
                    end
            end
            
        end
        
        if(state == s6)
        begin
                operanda <= feature_dum[index_feature];
                operandb <= filter_dum[indexa];
                temp1 <= sum;
        end
        
        if(state == s7)
        begin
            if((index < pa1) || (index >= pa0)) //pa1,pa0
            begin
                product <= 0;
            end
            else if((index >= pa1) && (index < pa0))//check0,1
            begin
                if((index < check00) || (index >= check01))//check00,01
                begin
                    product <= 0;
                end
                else 
                begin
                    product <= product_dum;
                end
            end
        end
        

        
        if(state == s8)
        begin
            sum <= temp;
        end
    end
end

always @(*)
begin
    done = 0;
    case(state)
        
        s0: begin
                nextstate = s2;
                done = 0;
            end
            
        s1:begin
                nextstate = s2;
                done = 0;
            end 
        
        s2: if(counta==(n_dum*n_dum-1))
            begin
                done = 0;
                nextstate = s4;
            end
            else
            begin
                done = 0;
                nextstate = s1;
            end
            
        s3: begin
                nextstate = s4;
                done = 0;
            end
        
        s4: if(countb<(m*m-1))
            begin
                nextstate = s3;
                done = 0;
            end
            else
            begin
                nextstate = s6;
                done = 0;
            end
            
        s5: begin
                done = 0;
                nextstate = s6;
//                if(m*r+c==m*m-1)
//                    begin
//                       done = 1;
////                       out = sum;
//                       if(((m-1)+stride*(countc+1)>(n-1)) && (m-1)+stride*(countd+1)>(n-1))
//                            begin
//                                nextstate = s0;
//                                complete = 1;
//                                done = 1;
//                            end
//                       else nextstate = s6;  
//                    end
//                else nextstate = s6;
                  if(m*r+c==m*m-1)
                    begin
                       done = 1;
//                       out = sum;
                   end
            end
            
        s6: begin//s5
                done = 0;
                nextstate = s7;
            end
            
        s7: begin
                nextstate = s8;
                done = 0;
            end
        
        s8: begin//s7
                done = 0;
                nextstate = s5;
             end
        default : begin
                    nextstate = s0;
                    done = 0;
                  end
                
    endcase    
end

assign out = sum;
endmodule
