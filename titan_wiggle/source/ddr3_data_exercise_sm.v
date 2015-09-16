module ddr3_data_exercise_sm (rst, clk, cmd_rdy, datain_rdy, read_data, read_data_valid, wl_err, cmd_valid, cmd, cmd_burst_cnt, addr, write_data, data_mask);

input wire rst;
input wire clk;
input wire cmd_rdy;
input wire datain_rdy;
input wire [63:0] read_data;
input wire read_data_valid;
input wire wl_err;
output reg cmd_valid;
output reg [3:0] cmd;
output wire [4:0] cmd_burst_cnt;
output reg [25:0] addr;
output reg [63:0] write_data;
output wire [7:0] data_mask;

//assign cmd_burst_cnt = 5'b01000;
assign cmd_burst_cnt = 5'b00001;
//assign addr = 26'h1234567;
//assign addr = 26'h0001400;
//assign write_data = 64'hDEADBEEFDEADBEEF;
assign data_mask = 8'b00000000;

// DDR3 core commands
parameter NADA = 4'b0000,
			READ = 4'b0001,
			WRITE = 4'b0010,
			READA = 4'b0011,
			WRITEA = 4'b0100,
			PDOWN_ENT = 4'b0101,
			LOAD_MR = 4'b0110,
			SEL_REF_ENT = 4'b1000,
			SEL_REF_EXIT = 4'b1001,
			PDOWN_EXIT = 4'b1011,
			ZQ_LNG = 4'b1100,
			ZQ_SHRT = 4'b1101;

// DDR3 Addresses
parameter ADDRESS1 = 26'h0001400,
//			ADDRESS2 = 26'h1555555;
			ADDRESS2 = 26'h0001500;

// DDR3 Data
parameter DATA1_1 = 64'h1AAA2AAA3AAA4AAA,
			DATA1_2 = 64'hE555D555C555B555,
			DATA2_1 = 64'h0123456789ABCDEF,
			DATA2_2 = 64'hFEDCBA9876543210;

// FSM States
parameter S_IDLE = 4'b0000,
			S_PDOWN_ENT = 4'b0001,
			S_PDOWN_EXIT = 4'b0010,
			S_WRITE_ADDR1 = 4'b0011,
			S_WRITE_WAIT1 = 4'b0100,
			S_WRITE_DATA1_1 = 4'b0101,
			S_WRITE_DATA1_2 = 4'b0110,
			S_WRITE_ADDR2 = 4'b0111,
			S_WRITE_WAIT2 = 4'b1000,
			S_WRITE_DATA2_1 = 4'b1001,
			S_WRITE_DATA2_2 = 4'b1010,
			S_READ1 = 4'b1011,
			S_READ2 = 4'b1100,
			S_HALT = 4'b1101;

reg [3:0] state, next;

	always @(posedge clk or posedge rst)
		if (rst) state <= S_IDLE;
		else state <= next;

	always @(state or cmd_rdy or datain_rdy) begin
		next = 'bx;
		case (state)
			// Wait for the first cmd_rdy pulse; It signifies that the DDR3 has been initialized
			S_IDLE : if (cmd_rdy) next = S_PDOWN_ENT;
						else next = S_IDLE;
			S_PDOWN_ENT : if (cmd_rdy) next = S_PDOWN_EXIT;
						else next = S_PDOWN_ENT;
			S_PDOWN_EXIT : if (cmd_rdy) next = S_WRITE_ADDR1;
						else next = S_PDOWN_EXIT;
			S_WRITE_ADDR1 : if (cmd_rdy) next = S_WRITE_WAIT1;
						else next = S_WRITE_ADDR1;
			S_WRITE_WAIT1 : if (datain_rdy) next = S_WRITE_DATA1_1;
						else next = S_WRITE_WAIT1;
			S_WRITE_DATA1_1 : next = S_WRITE_DATA1_2;
			S_WRITE_DATA1_2 : next = S_WRITE_ADDR2;
			S_WRITE_ADDR2 : if (cmd_rdy) next = S_WRITE_WAIT2;
						else next = S_WRITE_ADDR2;
			S_WRITE_WAIT2 : if (datain_rdy) next = S_WRITE_DATA2_1;
						else next = S_WRITE_WAIT2;
			S_WRITE_DATA2_1 : next = S_WRITE_DATA2_2;
			S_WRITE_DATA2_2 : next = S_READ1;
			S_READ1 : if (cmd_rdy) next = S_READ2;
						else next = S_READ1;
			S_READ2 : if (cmd_rdy) next = S_HALT;
						else next = S_READ2;
			S_HALT : next = S_HALT;
		endcase
	end

	always @(posedge clk or posedge rst)
		if (rst) begin
			cmd_valid <= 1'b0;
			cmd <= NADA;
			addr <= 26'h0000000;
			write_data <= 64'h0000000000000000;
		end
		else begin
			cmd_valid <= 1'b0;
			cmd <= NADA;
		case (next)
			S_PDOWN_ENT:
				begin
					cmd_valid <= 1'b1;
					cmd <= PDOWN_ENT;
				end
			S_PDOWN_EXIT:
				begin
					cmd_valid <= 1'b1;
					cmd <= PDOWN_EXIT;
				end
			S_WRITE_ADDR1:
				begin
					cmd_valid <= 1'b1;
					cmd <= WRITE;
					addr <= ADDRESS1;
				end
			S_WRITE_DATA1_1:
				begin
					write_data <= DATA1_1;
				end
			S_WRITE_DATA1_2:
				begin
					write_data <= DATA1_2;
				end
			S_WRITE_ADDR2:
				begin
					cmd_valid <= 1'b1;
					cmd <= WRITE;
					addr <= ADDRESS2;
				end
			S_WRITE_DATA2_1:
				begin
					write_data <= DATA2_1;
				end
			S_WRITE_DATA2_2:
				begin
					write_data <= DATA2_2;
				end
			S_READ1:
				begin
					cmd_valid <= 1'b1;
					cmd <= READ;
					addr <= ADDRESS1;
				end
			S_READ2:
				begin
					cmd_valid <= 1'b1;
					cmd <= READ;
					addr <= ADDRESS2;
				end
		endcase
	end

endmodule
