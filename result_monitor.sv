`ifndef RESULT_MONITOR
`define RESULT_MONITOR
class result_monitor extends uvm_component;
	`uvm_component_utils(result_monitor);
	
	uvm_analysis_port #(shortint) ap;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void write_to_monitor(shortint res);
		$display ("RESULT MONITOR: resultA: %0d",res);
		ap.write(res);
	endfunction
	
	function void build_phase(uvm_phase phase);
		virtual interface tinyalu_bfm bfm;
		if(!uvm_config_db #(virtual interface tinyalu_bfm)::get(null, "*", "bfm", bfm))
			$fatal("Faild to get bfm");
		bfm.result_monitor_h = this;
		ap = new("ap", this);
	endfunction
	
endclass
`endif
