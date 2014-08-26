
interface sample_if (input logic clk, rstz);
	logic write;
	logic valid;
	logic [7:0] addr, data;
endinterface

