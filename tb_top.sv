
//`timescale 1ps/1ps
`define _GP_SCOREBOARD_MODE2_MARK mark

module tb_top;
	`include "uvm_macros.svh"
	import uvm_pkg::*;

	`include "uvm_component/gp_scoreboard.sv"

	`include "sample_model.svh"
	`include "sample_master_chg_monitor.sv"
	`include "tb_env.sv"
	`include "sample_test.sv"

	logic clk, rstz;
	sample_if vif(clk, rstz);

	initial begin
		clk <= 1'b1;
		#100
		forever #50 clk <= ~clk;
	end

	initial begin
		rstz     <= 1'b0;
		#80 rstz <= 1'b1;
	end

	initial begin
		uvm_config_db#(virtual sample_if)
				::set(uvm_root::get(), "", "vif", vif);
		run_test();
	end
endmodule

