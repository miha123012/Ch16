`ifndef SCOREBOARD
`define SCOREBOARD
class scoreboard extends uvm_subscriber #(shortint);
	`uvm_component_utils(scoreboard);
	uvm_tlm_analysis_fifo #(command_s) cmd_f;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		cmd_f = new("cmd_f", this);
	endfunction
	
	
	function void write(shortint t);
		shortint exp_result;
		command_s cmd;
		cmd.op = rst_op;
		do 
			if(!cmd_f.try_get(cmd)) $fatal(1, "No command in self checker");
		while ((cmd.op == no_op) || (cmd.op == rst_op));
		
		
			
		case(cmd.op)
			add_op: exp_result = cmd.A + cmd.B;
			and_op: exp_result = cmd.A & cmd.B;
			xor_op: exp_result = cmd.A ^ cmd.B;
			mul_op: exp_result = cmd.A * cmd.B;	
		endcase
		
	
		if(exp_result != t) begin
			$error("Time: %t; Error: A = %d, op = %s, B = %d, result = %d; exp_result = %d",
				$time, cmd.A, cmd.op.name(), cmd.B, t, exp_result);
		end
	
	endfunction
	
endclass

`endif
