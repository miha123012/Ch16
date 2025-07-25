vlog -sv +incdir+C:/questasim64_10.4c/verilog_src/uvm-1.2/src my_alu.sv tinyalu_pkg.sv tinyalu_bfm.sv top.sv
vsim -c -do "run -all" top +UVM_TESTNAME=random_test