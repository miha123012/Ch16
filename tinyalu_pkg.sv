`ifndef TINYALU_PKG
`define TINYALU_PKG
package tinyalu_pkg;
	typedef enum bit[2:0] {no_op = 3'b000,
                          add_op = 3'b001, 
                          and_op = 3'b010,
                          xor_op = 3'b011,
                          mul_op = 3'b100,
                          rst_op = 3'b111} operation_t;

	typedef struct {
		bit[7:0] A;
		bit[7:0] B;
		operation_t op;
	} command_s;

	import uvm_pkg::*;
	`include "uvm_macros.svh"

	`timescale 1ns/1ps	


	`include "coverage.sv"
	`include "scoreboard.sv"
	`include "base_tester.sv"
	`include "random_tester.sv"
	`include "add_tester.sv"
	`include "command_monitor.sv"
	`include "result_monitor.sv"
	
	`include "env.sv"

	
	//`include "add_test.sv"
	
endpackage

`endif

