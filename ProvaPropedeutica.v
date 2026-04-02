//Half adder: svolge la somma di due bit e restituisce il risultato e l'eventuale carry relativo
module half_adder(a, b, carry, sum);

input a, b;
output carry, sum;

assign sum = a ^ b;
assign carry = a & b;

endmodule

//Full adder: svolge la somma di tre bit e restituisce il risultato e l'eventuale carry finale.
module full_adder(a, b, c, sum, cout);

input a, b, c;
output sum, cout;
wire tsum, carry1, carry2;

half_adder ha0 (.a(a), .b(b), .carry(carry1), .sum(tsum));
half_adder ha1 (.a(c), .b(tsum), .carry(carry2), .sum(sum));

assign cout = carry1 | carry2;

endmodule

/*Adder a 4 bit: svolge la somma di due numeri a 4 bit (+ eventuale carry relativo dell'operazione precedente) e restituisce
il risultato e l'eventuale carry relativo + un potenziale errore di overflow che nel caso del sommatore ecc3 non viene considerato in quanto
l'errore non è rilevante.*/
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

/*Digit corrector: ritorna in uscita il risultato "corretto" di una somma a 4 bit in eccesso 3, ottenuto sommando o sottraendo 3 al numero
ricevuto in ingresso se nella somma relativa è presente o meno un carry in uscita.*/
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


//Complementer: dati 4 bit in ingresso, si occupa di ritornare in uscita il complementare binario per ognuno di essi.
module bits_complementer (
    input [3:0] a,
    output [3:0] a_comp
);

    assign a_comp[0] = !a[0];
    assign a_comp[1] = !a[1];
    assign a_comp[2] = !a[2];
    assign a_comp[3] = !a[3];

endmodule


//
module ecc3_number_complementer(
    input [3:0] a,
    output [3:0] a_comp
);

    wire [3:0] a_bits_comp, temp_sum;
    wire sum_cout;

    bits_complementer bc (.a(a), .a_comp(a_bits_comp));
    four_bit_adder fba (.a(a_bits_comp), .b(4'b0100), .cin(1'b0), .sum(temp_sum), .cout(sum_cout), .error());
    digit_corrector dc (.sum_res(temp_sum), .carry(sum_cout), .correction(a_comp));

endmodule

//Scrivere che c'è il cout e il cin per poter espandere il circuito a più cifre
module adder_ecc3_single_digit(
    input [3:0] a, b,
    input cin,
    //input sel,
    output [3:0] sum,
    output cout
    //output sign
);

    wire [3:0] temp_sum;

    four_bit_adder fba (.a(a), .b(b), .cin(cin), .sum(temp_sum), .cout(cout), .error());
    digit_corrector dc (.sum_res(temp_sum), .carry(cout), .correction(sum));
    
endmodule