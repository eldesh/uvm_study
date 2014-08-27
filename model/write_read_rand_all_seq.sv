
class write_read_rand_all_seq extends sample_master_base_seq;
	write_seq _write;
	 read_seq _read;

	`uvm_object_utils(write_read_rand_all_seq)

	function new (string name="write_read_rand_all_seq");
		super.new(name);
	endfunction

	virtual task body ();
		int i, len;
		bit [7:0] addr_q[$], read_addr_q[$];
		
		for (i=0; i<256; ++i)
			addr_q.push_back(i);

		while (addr_q.size() != 0) begin
			len = $urandom_range(16,1);
			if (addr_q.size() < len)
				len = addr_q.size();

			$display("=========================");
			uvm_report_info("SEQ", $sformatf("Transaction start. length=%0d", len));
			for (i=0; i<len; ++i) begin
				bit [7:0] addr;
				`uvm_create(_write)
				addr = gen_rand_addr(addr_q);
				read_addr_q.push_back(addr);
				_write.addr = addr;
				_write.data = $urandom_range(255, 0);
				`uvm_send(_write)
			end

			$display("-------------------------");
			//for (i=0; i<len; ++i) begin
			while (read_addr_q.size() != 0) begin
				`uvm_create(_read)
				_read.addr = gen_rand_addr(read_addr_q);
				`uvm_send(_read)
			end
		end
	endtask

	function bit [7:0] gen_rand_addr (ref bit [7:0] addr_src_q[$]);
		int index = $urandom_range(addr_src_q.size()-1, 0);
		bit [7:0] rval = addr_src_q[index];
		addr_src_q.delete(index);
		return rval;
	endfunction

endclass

