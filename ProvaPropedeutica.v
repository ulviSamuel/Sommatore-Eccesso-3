module half_adder(a, b, carry, sum);

input a, b;
output carry, sum;

assign sum = a ^ b;
assign carry = a & b;

endmodule

module full_adder(a, b, c, sum, cout);

input a, b, c;
output sum, cout;
wire tsum, carry1, carry2;

half_adder ha0 (.a(a), .b(b), .carry(carry1), .sum(tsum));
half_adder ha1 (.a(c), .b(tsum), .carry(carry2), .sum(sum));

assign cout = carry1 | carry2;

endmodule

module four_bit_adder(
    input wire [3:0] a, b,
    input wire cin,
    output wire [3:0] sum,
    output wire cout,
    output wire error
);

wire carry0, carry1, carry2, carry3;

full_adder fa0 (.a(a[0]), .b(b[0]), .c(cin), .sum(sum[0]), .cout(carry0));
full_adder fa1 (.a(a[1]), .b(b[1]), .c(carry0), .sum(sum[1]), .cout(carry1));
full_adder fa2 (.a(a[2]), .b(b[2]), .c(carry1), .sum(sum[2]), .cout(carry2));
full_adder fa3 (.a(a[3]), .b(b[3]), .c(carry2), .sum(sum[3]), .cout(carry3));

assign error = carry3 ^ carry2;
assign cout = carry3;

endmodule

module digit_corrector (
    input [3:0] sum_res,
    input carry,
    output [3:0] correction
);

    wire [3:0] sum3, sum13;

    four_bit_adder plus3_adder (.a(sum_res), .b(4'b0011), .cin(1'b0), .sum(sum3), .cout(), .error());
    four_bit_adder plus13_adder (.a(sum_res), .b(4'b1101), .cin(1'b0), .sum(sum13), .cout(), .error());

    assign correction = carry ? sum3 : sum13;

endmodule

module adder_ecc3_single_digit(
    input [3:0] a, b,
    input cin,
    output [3:0] sum,
    output cout
);

    wire [3:0] temp_sum;

    four_bit_adder fba0 (.a(a), .b(b), .cin(cin), .sum(temp_sum), .cout(cout), .error());
    digit_corrector dc0 (.sum_res(temp_sum), .carry(cout), .correction(sum));
    
endmodule