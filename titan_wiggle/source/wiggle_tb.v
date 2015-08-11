`timescale 1 ns / 100ps

module wiggle_tb ();

reg osc;
reg perstn;

wire [31:0] gpio_a;
wire [31:0] gpio_b;

// --------------------------------------------------------------------
// Power on Reset
// --------------------------------------------------------------------
PUR     PUR_INST(.PUR(1'b1));
GSR     GSR_INST(.GSR(1'b1));

wiggle U1 ( .osc(osc),
				.gpio_a(gpio_a),
				.gpio_b(gpio_b),
				.perstn(perstn)
			);

always
	#10 osc = ~osc;

initial
begin
	$display($time, " << Starting the Simulation >>");
	osc = 1'b0;
	perstn = 1'b0;

	// Change to ~100ms
	#100
	$display($time, " << Releasing PERSTn >>");
	perstn = 1'b1;

	#10000000
	$display($time, " << Stopping the Simulation >>");
	$stop;
end

endmodule
