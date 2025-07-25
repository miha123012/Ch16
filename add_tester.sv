`ifndef RANDOM_TESTER
`define RANDOM_TESTER
class add_tester extends random_tester;
	`uvm_component_utils(add_tester);
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function operation_t get_op();
		return add_op;
	endfunction
	
endclass

`endif