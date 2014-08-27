
`define set_seq(INST,SEQ) \
	uvm_config_db#(uvm_object_wrapper)::set(this, `"INST`", "default_sequence", SEQ::type_id::get())

`define uvm_test_head(NAME) \
	class NAME extends sample_test_base; \
		`uvm_component_utils(NAME) \
		function new (string name=`"NAME`", uvm_component parent=null); \
			super.new(name, parent); \
		endfunction


class sample_test_base extends uvm_test;
	`uvm_component_utils(sample_test_base)
	tb_env tb;

	function new (string name="sample_test_base", uvm_component parent=null);
		super.new(name, parent);
	endfunction

	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		tb = tb_env::type_id::create("tb", this);
	endfunction

	task run_phase (uvm_phase phase);
		uvm_report_info("TEST", "Hello, World!");
		uvm_top.print_topology();
	endtask
endclass


`uvm_test_head(sample_test)
	function void build_phase(uvm_phase phase);
		`set_seq(tb.sample_model.master.sequencer.run_phase, write_read_seq);
		`set_seq(tb.sample_model.slave.sequencer.run_phase, normal_response_seq);
		super.build_phase(phase);
	endfunction
endclass

`uvm_test_head(sample_test2)
	function void build_phase(uvm_phase phase);
		`set_seq(tb.sample_model.master.sequencer.run_phase, write_read_seq);
		`set_seq(tb.sample_model.slave.sequencer.run_phase, random_response_seq);
		super.build_phase(phase);
	endfunction
endclass

`uvm_test_head(sample_test3)
	function void build_phase(uvm_phase phase);
		`set_seq(tb.sample_model.master.sequencer.run_phase, write_read_all_seq);
		`set_seq(tb.sample_model.slave.sequencer.run_phase, random_response_seq);
		super.build_phase(phase);
	endfunction
endclass

`uvm_test_head(sample_test4)
	function void build_phase(uvm_phase phase);
		`set_seq(tb.sample_model.master.sequencer.run_phase, write_read_rand_all_seq);
		`set_seq(tb.sample_model.slave.sequencer.run_phase, random_response_seq);
		super.build_phase(phase);
	endfunction
endclass

