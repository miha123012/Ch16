`ifndef COVERAGE
`define COVERAGE
class coverage extends uvm_subscriber #(command_s);
	`uvm_component_utils(coverage);
	bit[7:0] A;
	bit[7:0] B;
	operation_t op_set;
	
	covergroup zeros_or_ones_on_ops;
		all_ops : coverpoint op_set {
			ignore_bins null_ops = {rst_op, no_op};
		}

		a_leg: coverpoint A {
			bins zeros = {'h00};
			bins others= {['h01:'hFE]};
			bins ones  = {'hFF};
		}

		b_leg: coverpoint B {
			bins zeros = {'h00};
			bins others= {['h01:'hFE]};
			bins ones  = {'hFF};
		}

		op_00_FF:  cross a_leg, b_leg, all_ops {
			bins add_00 = binsof (all_ops) intersect {add_op} &&
								(binsof (a_leg.zeros) || binsof (b_leg.zeros));

			bins add_FF = binsof (all_ops) intersect {add_op} &&
								(binsof (a_leg.ones) || binsof (b_leg.ones));

			bins and_00 = binsof (all_ops) intersect {and_op} &&
								(binsof (a_leg.zeros) || binsof (b_leg.zeros));

			bins and_FF = binsof (all_ops) intersect {and_op} &&
								(binsof (a_leg.ones) || binsof (b_leg.ones));

			bins xor_00 = binsof (all_ops) intersect {xor_op} &&
								(binsof (a_leg.zeros) || binsof (b_leg.zeros));

			bins xor_FF = binsof (all_ops) intersect {xor_op} &&
								(binsof (a_leg.ones) || binsof (b_leg.ones));

			bins mul_00 = binsof (all_ops) intersect {mul_op} &&
								(binsof (a_leg.zeros) || binsof (b_leg.zeros));

			bins mul_FF = binsof (all_ops) intersect {mul_op} &&
								(binsof (a_leg.ones) || binsof (b_leg.ones));

			bins mul_max = binsof (all_ops) intersect {mul_op} &&
								(binsof (a_leg.ones) && binsof (b_leg.ones));

			ignore_bins others_only = binsof(a_leg.others) && binsof(b_leg.others);

		}
	endgroup
   
	covergroup op_cov;
		coverpoint op_set {
			bins single_cycle[] = {[add_op : xor_op], rst_op,no_op};
			bins multi_cycle = {mul_op};

			bins opn_rst[] = ([add_op:mul_op] => rst_op);
			bins rst_opn[] = (rst_op => [add_op:mul_op]);

			bins sngl_mul[] = ([add_op:xor_op],no_op => mul_op);
			bins mul_sngl[] = (mul_op => [add_op:xor_op], no_op);

			bins twoops[] = ([add_op:mul_op] [* 2]);
			bins manymult = (mul_op [* 3:5]);

      }

   endgroup
   
   
	function new(string name, uvm_component parent);
		super.new(name, parent);
		op_cov = new();
		zeros_or_ones_on_ops = new();
	endfunction
	
	function void write(command_s t);
		A = t.A;
		B = t.B;
		op_set = t.op;
		op_cov.sample();
		zeros_or_ones_on_ops.sample();
	endfunction
	
endclass

`endif