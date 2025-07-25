module top;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	import tinyalu_pkg::*;

	/*`include "env.sv"
	
	`include "random_test.sv"
	`include "add_test.sv"*/
	`include "random_test.sv"
	
	tinyalu_bfm bfm();
	my_alu DUT (.A(bfm.A), .B(bfm.B), .op(bfm.op), 
               .clk(bfm.clk), .reset_n(bfm.reset_n), 
               .start(bfm.start), .done(bfm.done), .result(bfm.result));
			   
	initial begin
		
		$timeformat(-9, 0, " ns", 5);
		uvm_config_db #(virtual interface tinyalu_bfm)::set(null, "*", "bfm", bfm);
		run_test();
	end
endmodule

