module SW2 (input [3:0] a, b, input cin,
     output [3:0] s, output cout);

 wire w1, w2, w3;
 SW1 u1(a[0], b[0], cin, s[0], w1);
 SW1 u2(a[1], b[1], w1, s[1], w2);
 SW1 u3(a[2], b[2], w2, s[2], w3);
 SW1 u4(a[3], b[3], w3, s[3], cout);
 
endmodule