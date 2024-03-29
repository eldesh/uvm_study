
class sample_master_base_seq extends uvm_sequence #(sample_seq_item);

	function new (string name="sample_master_base_seq");
		super.new(name);
	endfunction

	virtual task pre_body ();
		if (starting_phase != null) begin
			`uvm_info(get_type_name()
					, $sformatf("%s pre_body() raising %s objection"
							, get_sequence_path()
							, starting_phase.get_name()), UVM_MEDIUM);
			starting_phase.raise_objection(this);
		end
	endtask

	virtual task post_body ();
		if (starting_phase != null) begin
			`uvm_info(get_type_name()
					, $sformatf("%s post_body() raising %s objection"
							, get_sequence_path()
							, starting_phase.get_name()), UVM_MEDIUM);
			starting_phase.drop_objection(this);
		end
	endtask
endclass

`include "write_seq.sv"
`include "write_read_all_seq.sv"
`include "write_read_rand_all_seq.sv"

