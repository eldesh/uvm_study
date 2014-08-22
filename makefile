
LOG_DIR  = log
SVSRCS   = tb_top.sv
TARGET   = uvm_hw
SVFLAGS  = -full64 -nc -sverilog
UVMFLAGS = -ntb_opts uvm \
		   +incdir+/home2/tools/synopsys/vcs-mx_vI-2014.03/etc/uvm-1.1 \
		   +define+UVM_NO_DEPRECATED \
		   +define+UVM_NO_RELNOTES

all: logdir_mk $(TARGET)

logdir_mk:
	@echo "make $(LOG_DIR)..."
	@mkdir -p $(LOG_DIR)

$(TARGET): $(SVSRCS)
	vcs $(SVFLAGS) $(UVMFLAGS) -l $(LOG_DIR)/$@.log -o $@ $(SVSRCS)

.PHONY: clean
clean:
	-rm -rf csrc
	-rm -rf $(TARGET).daidir
	-rm     $(TARGET)
	-rm     vc_hdrs.h
	-rm     ucli.key


