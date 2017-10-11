// This is an example of a simple 32 bit up-counter called simple_counter.v
// It has a single clock input and a 32-bit output port

module simple_counter (clock, triggerIn, reset, counter_out); 

input triggerIn;
input clock;
input reset; 
output reg [31:0] counter_out;
reg lastVal = 0;

always @ (posedge clock)// on positive clock edge
begin 
	
  if((triggerIn==1)&&(triggerIn!=lastVal)) begin
		counter_out <= counter_out + 1;
  end
  lastVal=triggerIn;
 
 if(reset==1)
	counter_out <= 0;
end 
endmodule// end of module counter

