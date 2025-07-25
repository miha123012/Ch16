`ifndef RANDOM_TEST
`define RANDOM_TEST

class random_test extends uvm_test;
	`uvm_component_utils(random_test);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	env env_h;
	
	function void build_phase(uvm_phase phase);
		env_h = env::type_id::create("env_h", this);
	endfunction
endclass
`endif