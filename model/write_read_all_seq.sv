
class write_read_all_seq extends sample_master_base_seq;
	write_seq _write;
	 read_seq _read;

	`uvm_object_utils(write_read_all_seq)

	function new (string name="write_read_all_seq");
		super.new(name);
	endfunction

	virtual task body ();
		int i;
		for (i=0; i<256; i++) begin
			`uvm_create(_write)
			_write.addr = i;
			_write.data = $urandom_range(255, 0);
			`uvm_send(_write)
		end
		for (i=0; i<256; i++) begin
			`uvm_create(_read)
			_read.addr = i;
			`uvm_send(_read)
		end
	endtask

endclass

