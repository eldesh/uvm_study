
SVSRCS   = tb_top.sv
SVFLAGS  = -full64 -nc -sverilog
UVMFLAGS = -ntb_opts uvm +incdir+/home2/tools/synopsys/vcs-mx_vI-2014.03/etc/uvm-1.1

all: sv_hw

sv_hw: $(SVSRCS)
	vcs $(SVFLAGS) $(UVMFLAGS) $(SVSRCS)

.PHONY: clean
clean:
	rm -rf csrc
	rm -rf simv.daidir
	rm     simv
	rm     vc_hdrs.h


