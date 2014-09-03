module wiggle (clk, rstn, led, gpio);

input clk, rstn;
output [7:0] led;
output [23:0] gpio;

reg [23:0] count;
reg [7:0] sreg;
reg shift;
wire rstn;
wire [7:0] led;
wire [23:0] gpio;

assign rst = ~rstn;

always @(posedge clk or posedge rst)
begin
	if (rst)
		count <= 0;
	else
		count <= count + 1;
end

always @(posedge clk or posedge rst)
begin
	if (rst)
		shift <= 0;
	else if (count == 3)
		shift <= 1;
	else
		shift <= 0;
end

always @(posedge clk or posedge rst)
begin
	if (rst) begin
		sreg <= 8'b1111_1110;
	end else if (shift == 1) begin
		sreg <= sreg << 1;
		sreg[0] <= sreg[7];
//	end else begin
//		sreg <= sreg;
	end
end

assign led = sreg;
assign gpio = count;

endmodule
