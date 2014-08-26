
class write_seq extends sample_master_base_seq;
	bit [7:0] addr, data;

	`uvm_object_utils(write_seq)

	function new (string name="write_seq");
		super.new(name);
	endfunction

	virtual task body ();
		`uvm_create(req)
		req.write = 1'b1;
		req.addr  = this.addr;
		req.wdata = this.data;
		`uvm_send(req)
	endtask
endclass

class read_seq extends sample_master_base_seq;
	bit [7:0] addr, rdata;

	`uvm_object_utils(read_seq)

	function new (string name="read_seq");
		super.new(name);
	endfunction

	virtual task body ();
		`uvm_create(req);
		req.write = 1'b0;
		req.addr  = this.addr;
		`uvm_send(req);
		this.rdata = req.rdata;
	endtask
endclass

class write_read_seq extends sample_master_base_seq;
	write_seq _write;
	read_seq  _read;

	`uvm_object_utils(write_read_seq)

	function new (string name="write_read_seq");
		super.new(name);
	endfunction

	virtual task body ();
		bit [7:0] addr, data;
		addr = 8'h10;
		data = 8'h5A;

		`uvm_create(_write);
		_write.addr = addr;
		_write.data = data;
		`uvm_send(_write);

		`uvm_create(_read);
		_read.addr = addr;
		`uvm_send(_read);
	endtask
endclass


