`timescale 1ns/1ps
interface tinyalu_bfm;
	
	import tinyalu_pkg::*;
	
	bit clk;
	bit reset_n;
	bit start;
	bit[7:0] A;
	bit[7:0] B;
	bit[2:0] op;
	shortint result;
	bit done;
	operation_t  op_set;
	
	command_monitor command_monitor_h;
	result_monitor result_monitor_h;
	
	int count_errors = 0;
	int count_tests = 0;
	int count_check = 0;
	int count_other = 0;
	
	int count_check_add = 0;
	int count_check_and = 0;
	int count_check_xor = 0;
	int count_check_mul = 0;
	
	int count_total_add = 0;
	int count_total_and = 0;
	int count_total_xor = 0;
	int count_total_mul = 0;
	
	assign op = op_set;
	
	initial begin
		forever #10 clk = ~clk;
	end
	
	task reset_alu();
		reset_n = 0;
		start = 0;
		repeat(2) @(negedge clk);
		reset_n = 1;
	endtask
	
	task send_op (input bit[7:0] iA, input bit[7:0] iB, input operation_t iop);
		op_set = iop;
		if (iop == rst_op) begin
			reset_n = 0;
			start = 0;
			@(negedge clk);
			#1;
			reset_n = 1;
		end
		
		else begin
			@(negedge clk);
			A = iA;
			B = iB;
			start = 1;
			if (iop == no_op) begin
				@(posedge clk);
				#1;
				start = 1'b0;           
			end
			else begin
				do
					@(negedge clk);
				while (done == 0);
				start = 1'b0;
			end
		end
	endtask
	
	always @(posedge clk) begin //command_monitor
		bit new_command;
		if(!start) new_command = 1;
		else 
			if(new_command) begin
				command_monitor_h.write_to_monitor(A, B, op);
				new_command = (op != 3'b000);
			end
	end //command_monitor
	
	always @(negedge reset_n)
		if(command_monitor_h != null) 
			command_monitor_h.write_to_monitor(A, B, rst_op);
	
	always @(negedge clk)
		if (done)
			result_monitor_h.write_to_monitor(result);
			
endinterface



