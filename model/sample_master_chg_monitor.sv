
typedef class sample_master_monitor;
typedef class sample_scrbd_item;

class sample_master_chg_monitor extends sample_master_monitor;
	`uvm_component_utils(sample_master_chg_monitor)

	function new (string name, uvm_component parent);
		super.new (name, parent);
	endfunction

	task scrbd_write;
		sample_scrbd_item item;
		$display("[check]");
		forever begin
			@scrbd_e;
			item = new ();
			item.addr = vif.addr;
			if (vif.addr === 1'b1) begin
				item.data = vif.wdata;
				item.addr = vif.addr;
				ap_write.write(item);
			end else if (vif.addr === 1'b0) begin
				item.data = vif.rdata;
				item.addr = vif.addr;
				ap_read.write(item);
			end
		end
	endtask
endclass


