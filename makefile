
LOG_DIR       = log
MODEL_DIR     = model
LIB_DIR       = lib
TESTBENCH_DIR = tb

INCLUDE_DIR  = $(MODEL_DIR) $(LIB_DIR) $(TESTBENCH_DIR)
INCLUDE_FLAG = $(addprefix +incdir+, $(INCLUDE_DIR))

TOPSRC   = tb_top.sv
SVSRCS   = $(TOPSRC) \
		   sample_test.sv \
		   $(MODEL_DIR)/sample_model.svh           \
		   $(MODEL_DIR)/sample_env.sv              \
		   $(MODEL_DIR)/sample_master_monitor.sv   \
		   $(MODEL_DIR)/sample_master_sequencer.sv \
		   $(MODEL_DIR)/sample_master_driver.sv    \
		   $(MODEL_DIR)/sample_master_agent.sv     \
		   $(MODEL_DIR)/sample_master_seq_lib.sv   \
		   $(MODEL_DIR)/sample_slave_monitor.sv    \
		   $(MODEL_DIR)/sample_slave_sequencer.sv  \
		   $(MODEL_DIR)/sample_slave_driver.sv     \
		   $(MODEL_DIR)/sample_slave_agent.sv      \
		   $(MODEL_DIR)/sample_slave_seq_lib.sv    \
		   $(MODEL_DIR)/sample_if.sv               \
		   $(MODEL_DIR)/sample_seq_item.sv         \
		   $(MODEL_DIR)/sample_if.sv               \
		   $(MODEL_DIR)/write_seq.sv               \
		   $(MODEL_DIR)/sample_scrbd_item.sv       \
		   $(TESTBENCH_DIR)/tb_env.sv              \
		   $(LIB_DIR)/uvm_component/gp_scoreboard.sv

TARGET   = uvm_hw
SVFLAGS  = -full64 -nc -sverilog $(INCLUDE_FLAG)
UVMFLAGS = -ntb_opts uvm \
		   +incdir+/home2/tools/synopsys/vcs-mx_vI-2014.03/etc/uvm-1.1 \
		   +define+UVM_NO_DEPRECATED \
		   +define+UVM_NO_RELNOTES

all: logdir_mk $(TARGET)

logdir_mk:
	@echo "make $(LOG_DIR)..."
	@mkdir -p $(LOG_DIR)

$(TARGET): $(SVSRCS)
	vcs $(SVFLAGS) $(UVMFLAGS) -l $(LOG_DIR)/$@.log -o $@ $(TOPSRC) model/sample_if.sv

.PHONY: run
run: $(TARGET)
	@echo "run sample_test ..."
	./$(TARGET) +UVM_TESTNAME="sample_test"
	@echo "run sample_test2 ..."
	./$(TARGET) +UVM_TESTNAME="sample_test2"

.PHONY: failrun
failrun: $(TARGET)
	# will occur the error '...is not registered with the factory'
	./$(TARGET) +UVM_TESTNAME="foobar"

.PHONY: clean
clean:
	-rm -rf csrc
	-rm -rf $(TARGET).daidir
	-rm     $(TARGET)
	-rm     vc_hdrs.h
	-rm     ucli.key


