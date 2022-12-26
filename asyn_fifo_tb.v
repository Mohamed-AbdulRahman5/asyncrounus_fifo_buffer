`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/26/2022 03:15:34 AM
// Design Name: 
// Module Name: asyn_fifo_tb
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


module asyn_fifo_tb();

parameter addr_size=3,word_width=8;
 reg r_clk;
   reg w_clk;
    // read and write command
      reg rd;
      reg wr;
   reg reset_n;
   reg [word_width-1:0] data_in;
  wire [word_width-1:0] data_out;
  wire full;
   wire empty ;
   
asyn_fifo_top #(.addr_size(addr_size), .word_width(word_width)) fifo_tb( .r_clk(r_clk),.w_clk(w_clk),.rd(rd),.wr(wr),
.reset_n(reset_n),.data_in(data_in),.data_out(data_out),.full(full),.empty(empty)   
    );
// initial condition
initial
begin
 r_clk= 1'b0 ;
 w_clk =1'b0;
 rd =1'b0;
 wr =1'b0;
 data_in= 'd104;
end

// generating the clocks 
always #8 r_clk = ~r_clk ;
always #3 w_clk = ~w_clk ; //writing clock is faster
 

//reset block
initial
begin
 reset_n =1'b1;
  #1 reset_n =1'b0; 
 #1 reset_n =1'b1;
end



// testing 
initial
begin // it's empty at the begin 

// write untill it's full 
  #2.5 if(full!=1 )
begin data_in= 'd104;
 wr=1'b1;  end //st word h
#3.5  if(full==0)
 begin data_in= 'd100;
  wr=1'b0;  end// shouldn't write d
  #6 if(full==0)
  begin
  wr=1'b1;  
 data_in= 'd105;
 end
   //2nd word i
  #6  if(full==0)
  data_in= 'd95;
 //third _
   #6  if(full==0)
  data_in= 'd116;
   //forth t
    #6 if(full==0)
   data_in= 'd104;
   //fifh h
     #6 if(full==0)
   data_in= 'd101;
   //sixth  e
      #6 if(full==0)
    data_in= 'd114;
      //sevinth r
      #6 if(full==0)
      data_in= 'd101;
       //last word it should indicate full here e
        wait(full);
        wr=1'b0;
        
        
        
        /// reading 
        // will begin two clock later cause of syncroizing
        # 2 rd=1'b1 ; //will read until it's empty  
        //after 2 cycle of 
    wait(empty);
    
      
        
        // reading and writing simultaneously
        //it's reading cause rd is one
        #6 if(full==0)
        begin data_in= 'd79;
         wr=1'b1;  end 
          #6 if(full==0)
        data_in= 'd114;
          #6 if(full==0)
           data_in= 'd105;
           #6 if(full==0)
            data_in= 'd103;
            #6 if(full==0)
            data_in= 'd105;
             #6 if(full==0)
              data_in= 'd110;
              #6 if(full==0)
             data_in= 'd97;
             #6 if(full==0)
            data_in= 'd108;
            #6 if(full==0)
          data_in= 'd95;
          #6 if(full==0)
           data_in= 'd70;
           #6 if(full==0)
           data_in= 'd73;
           #6 if(full==0)
           data_in= 'd70;
            #6 if(full==0)
              data_in= 'd73;
              #6 if(full==0)
              data_in= 'd73;
              #2 wr =1'b0;
           wait(empty); 
              #5 $finish ;
                      
             
        
end 










endmodule
