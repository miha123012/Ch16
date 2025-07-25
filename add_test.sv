`ifndef ADD_TEST
`define ADD_TEST
class add_test extends random_test;
	`uvm_component_utils(add_test);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	//env env_h;
	
	function void build_phase(uvm_phase phase);
		random_tester::type_id::set_type_override(add_tester::get_type());
		//env_h = env::type_id::create("env_h", this);
		super.build_phase(phase);
	endfunction
endclass

`endif