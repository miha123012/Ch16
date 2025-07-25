`ifndef BASE_TESTER
`define RANDOM_TEST

virtual class base_tester extends uvm_component;
	`uvm_component_utils(base_tester);
	virtual tinyalu_bfm bfm;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		if(!uvm_config_db #(virtual interface tinyalu_bfm)::get(null, "*", "bfm", bfm))
			$fatal("Faild to get bfm");
	endfunction
	
	pure virtual function byte get_data();
	pure virtual function operation_t get_op();
	
	task run_phase(uvm_phase phase);
		bit[7:0] iA;
		bit[7:0] iB;
		operation_t iop;
		
		phase.raise_objection(this);
		
		bfm.reset_alu();
		
		repeat(1000) begin
			//bfm.count_tests++;
			iA = get_data();
			iB = get_data();
			iop = get_op();
			//if (iop == rst_op) bfm.count_other++;
			
			/*case(iop) 
				add_op: bfm.count_total_add++;
				and_op: bfm.count_total_and++;
				xor_op: bfm.count_total_xor++;
				mul_op: bfm.count_total_mul++;
			endcase*/
			
			bfm.send_op(iA, iB, iop);
		end
		
		#500;
		/*$display("Time: %t; %0d tests completed with %0d errors; number of checks = %0d + %0d", 
			$time, bfm.count_tests, bfm.count_errors, bfm.count_check, bfm.count_other);
		$display("All operations: add = %0d, and = %0d, xor = %0d, mul = %0d", 
			bfm.count_total_add, bfm.count_total_and, bfm.count_total_xor, bfm.count_total_mul);
		$display("Check operations: add = %0d, and = %0d, xor = %0d, mul = %0d", 
			bfm.count_check_add, bfm.count_check_and, bfm.count_check_xor, bfm.count_check_mul);*/
			
		phase.drop_objection(this);
		
	endtask
endclass 
`endif