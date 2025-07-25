module my_alu(
	input bit clk,
	input bit reset_n,
	input bit start,
	input bit[7:0] A,
	input bit[7:0] B,
	input bit[2:0] op,
	output bit[15:0] result,
	output bit done
);
	typedef enum bit [2:0] {
		IDLE,  
		MULT1,
		MULT2, 
		MULT3,
		RES
	} state_t;

	state_t state, next_state;

	always_ff @(posedge clk or negedge reset_n)
		if(!reset_n) state <= IDLE;
		else state <= next_state;	
	
	
	always_comb begin
		
		case(state)
			IDLE: begin
				done = 0;
				if(start) begin
					result = 0;
					if (op == 3'b100) next_state = MULT1;
					else next_state = RES;
				end
				else next_state = IDLE;
			end
				
			MULT1: next_state = MULT2;
			MULT2: next_state = MULT3;
			MULT3: next_state = RES;
			RES: begin
				next_state = IDLE;
				done = (op != 3'b000);
				case(op)
					3'b001: result = A + B;         // ADD
					3'b010: result = {8'b0, A & B}; // AND       
					3'b011: result = {8'b0, A ^ B}; // XOR
					3'b100: result = A * B;         // MUL
					default: result = 0;
				endcase
			end
		endcase
	end
	
endmodule


