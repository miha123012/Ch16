`ifndef COMMAND_MONITOR
`define COMMAND_MONITOR
class command_monitor extends uvm_component;
	`uvm_component_utils(command_monitor);
	uvm_analysis_port #(command_s) ap;
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		virtual interface tinyalu_bfm bfm;
		if(!uvm_config_db #(virtual interface tinyalu_bfm)::get(null, "*", "bfm", bfm))
			$fatal("Faild to get bfm");
		bfm.command_monitor_h = this;
		ap = new("ap", this);
	endfunction
	
	function operation_t op2enum(bit[2:0] op);
      case(op)
        3'b000 : return no_op;
        3'b001 : return add_op;
        3'b010 : return and_op;
        3'b011 : return xor_op;
        3'b100 : return mul_op;
        3'b111 : return rst_op;
        default : $fatal($sformatf("Illegal operation on op bus: %3b",op));
      endcase // case (op)
   endfunction
   
   function void write_to_monitor(bit[7:0] A, bit[7:0] B, bit[2:0] op);
		command_s cmd;
		cmd.A = A;
		cmd.B = B;
		cmd.op = op2enum(op);
		$display("COMMAND MONITOR: A:%0d B:%0d op: %s", A, B, cmd.op.name());
		ap.write(cmd);
	endfunction
		
endclass
`endif
