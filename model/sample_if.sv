
interface sample_if (input logic clk, rstz);
	logic write;
	logic valid;
	logic ready;
	logic [7:0] addr;
	logic [7:0] wdata, rdata;
endinterface

