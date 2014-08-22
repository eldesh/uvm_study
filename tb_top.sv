
//`timescale 1ps/1ps

module tb_top;
	`include "uvm_macros.svh"
	import uvm_pkg::*;

	`include "sample_model.svh"
	`include "sample_test.sv"

	initial begin
		run_test();
	end
endmodule

