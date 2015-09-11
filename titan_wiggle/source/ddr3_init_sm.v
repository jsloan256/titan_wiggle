module ddr3_init_sm (rst, clk, init_done, init_start);

input wire rst;
input wire clk;
input wire init_done;
output reg init_start;

reg [7:0] init_dly_cnt;

parameter IDLE = 3'b000,
			START_CNT = 3'b001,
			WAITFOR_CNT = 3'b010,
			INIT_DDR = 3'b011,
			INIT_DONE = 3'b100;

reg [2:0] state, next;

	always @(posedge clk or posedge rst)
		if (rst) state <= IDLE;
		else state <= next;

	always @(state or init_done or init_dly_cnt) begin
		next = 'bx;
		case (state)
			IDLE : next = START_CNT;
			START_CNT : next = WAITFOR_CNT;
			WAITFOR_CNT : if (init_dly_cnt == 8'h3c) next = INIT_DDR;
						else next = WAITFOR_CNT;
			INIT_DDR : if (init_done) next = INIT_DONE;
						else next = INIT_DDR;
			INIT_DONE : next = INIT_DONE;
		endcase
	end

	always @(posedge clk or posedge rst)
		if (rst) begin
			init_start <= 1'b0;
		end
		else begin
			init_start <= 1'b0;
		case (next)
			INIT_DDR: init_start <= 1'b1;
		endcase
	end

	always @(posedge clk or posedge rst)
	begin
		if (rst) begin
			init_dly_cnt <= 8'h00;
		end else begin
			init_dly_cnt <= init_dly_cnt + 1;
		end
	end

endmodule
