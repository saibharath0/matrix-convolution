`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.03.2024 10:56:00
// Design Name: 
// Module Name: adder
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


//module adder(  output reg [31:0]O,
//                 input [31:0]A,B,
//                 input A_S
//              );
               
//reg [7:0]exp_dif;
//reg [7:0]explar;
//reg [23:0]montissa_1,montissa_2;
////reg [23:0]montissa1_1,montissa1_2;

//reg [24:0]result;
//reg [23:0]result1;
//reg [4:0]i;
//reg [4:0]shift=0;
//reg [4:0]count=0;
//always@(A,B) begin
//   if( A[31]==0 && B[31]==0)
//   begin
//       O = 32'b0;
//   end 
//   if( A[31]^B[31]^A_S== 0) begin
//       montissa_1 = {1'b1,A[22:0]};
//       montissa_2 = {1'b1,B[22:0]};
       
//       if(A[30:23]>B[30:23]) exp_dif=A[30:23]-B[30:23];
//       else exp_dif=B[30:23]-A[30:23];

//       if(A[30:23]>B[30:23]) montissa_1=montissa_1;
//       else montissa_1 = montissa_1>>exp_dif;

//       if(B[30:23]>A[30:23]) montissa_2=montissa_2;
//       else montissa_2 = montissa_2>>exp_dif;

//       result = montissa_1+montissa_2;
       
//       if(result[24]==1)  O[22:0]= result[23:1];
//       else O[22:0] = result[22:0];

//       if(A[30:23]>B[30:23]) explar = A[30:23];
//       else explar = B[30:23];

//       if(result[24]==1) O[30:23] = explar + 1;
//       else O[30:23] = explar;
       
//       if((~A[31])&(~B[31])&(~A_S)) O[31] = 0;
//       else if((~A[31])&(B[31])&(A_S)) O[31] = 0;
//       else if((A[31])&(B[31])&(~A_S)) O[31] = 1;
//       else if((A[31])&(~B[31])&(A_S)) O[31] = 1;
       
//   end
   
//   if(A[31]^B[31]^A_S== 1) begin
//       montissa_1 = {1'b1,A[22:0]};
//       montissa_2 = {1'b1,B[22:0]};
       
//       if(A[30:23]>B[30:23]) O[31] = A[31];
////       if(A[30:0]>B[30:0]) O[31] = A[31];
//       else O[31] = B[31];
       
//       if(A[30:23]>B[30:23]) exp_dif=A[30:23]-B[30:23];
//       else exp_dif=B[30:23]-A[30:23];

//       if(A[30:23]>B[30:23]) montissa_1=montissa_1;
//       else montissa_1 = montissa_1>>exp_dif;

//       if(B[30:23]>A[30:23]) montissa_2=montissa_2;
//       else montissa_2 = montissa_2>>exp_dif;
       
       
//       if((A[30:23]>=B[30:23])&(A[22:0]>=B[22:0]))  result1 = montissa_1 - montissa_2;
//       else begin result1 = montissa_2 - montissa_1;
//                  O[31] = ~O[31];
//            end
//       count = 0;
//       for(i=23;i>0;i=i-1) 
//       begin
//        if((result1[i]==1)&&(count==0)) begin
//          shift = 23-i;
//          count = count + 1;
//          end
//       end
       
//       O[22:0] = result1<<shift;
       
//       if(A[30:23]>B[30:23]) O[30:23] = A[30:23] - shift;
//       else O[30:23] = B[30:23] - shift;
       
            
//   end
//end 
//endmodule
module adder(output reg[31:0] out,
             input [31:0] A,B,
             input op);
//input op;
//input [31:0]A,B;
//output reg [31:0]out=0;

reg [31:0]res;
reg [31:0]temp1,temp2,tempA,tempB;
reg [7:0]e_final;
reg [23:0]m_shift;
reg [7:0]exp_diff=0;
reg [24:0]m_final=0;

reg count=0;
reg [4:0]index=23;
reg [4:0]i=23;

always@(A,B,op)
begin
if(A == 0 && B == 0) out = 32'd0;
else 
begin
        if(op==0)
        begin
        tempA=A;
        tempB=B;
        end
    else
        begin
        tempA=A;
        tempB={~B[31],B[30:0]};
        end
    temp1 = (A[30:0]>B[30:0])?tempA:tempB;
    temp2 = (A[30:0]<B[30:0])?tempA:tempB;
    exp_diff = temp1[30:23] - temp2[30:23];
    e_final = temp1[30:23];
    res[31] = temp1[31];
    m_shift = {1'b1,temp2[22:0]}>>exp_diff;
    
    if(temp1[31]==temp2[31])
        begin
        m_final = {1'b1,temp1[22:0]}+m_shift;
        res[22:0] = (m_final[24]==1)?m_final[23:1]:m_final[22:0];
        res[30:23] = (m_final[24]==1)?e_final+1:e_final;
        end
    else
        begin
        m_final = {1'b1,temp1[22:0]}-m_shift;
        count=0;
        index=23;
        for(i=23;i>0;i=i-1)
            begin
            if(m_final[i]==1 && count==0)
                begin
                index=i;
                count=count+1;
                end
            end
        m_final[23:0]=m_final[23:0]<<(23-index);
        res[22:0]=m_final[22:0];
        res[30:23]=e_final-(23-index);
        end
    out = ((A[31]!=B[31])&&(A[30:0]==B[30:0]))? 32'b0:res;
    end
end
endmodule

