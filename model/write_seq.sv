
class write_seq extends sample_master_base_seq;
	`uvm_object_utils(write_seq)

	function new (string name="write_seq");
		super.new(name);
	endfunction

	virtual task body ();
		`uvm_create(req)
		req.write <= 1'b1;
		req.addr  <= 8'h10;
		req.wdata <= 8'h55;
		`uvm_send(req)

		`uvm_create(req);
		req.write <= 1'b0;
		req.addr  <= 8'h10;
		`uvm_send(req);
		uvm_report_info("SEQ", $sformatf("read data is %02xh", req.rdata));
		#1000;
	endtask
endclass

