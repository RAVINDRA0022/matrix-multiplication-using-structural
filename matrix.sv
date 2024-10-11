`timescale 1ns / 1ps
module multiplier(input wire [15:0] a, input wire [15:0] b, output wire [31:0] product);
    assign product = a * b;
endmodule
module adder(input wire [31:0] a, input wire [31:0] b, output wire [31:0] sum);
    assign sum = a + b;
endmodule
module calculation( input wire [143:0] A,input wire [143:0] B,output wire [287:0] C );
    wire [15:0] A1 [0:2][0:2];wire [15:0] B1 [0:2][0:2];wire [31:0] C1 [0:2][0:2];
    wire [31:0] P[0:2][0:2][0:2]; wire [31:0] S1[0:2][0:2];wire [31:0] S2[0:2][0:2];     
    assign {A1[0][0], A1[0][1], A1[0][2], A1[1][0], A1[1][1], A1[1][2], A1[2][0], A1[2][1], A1[2][2]} = A;
    assign {B1[0][0], B1[0][1], B1[0][2], B1[1][0], B1[1][1], B1[1][2], B1[2][0], B1[2][1], B1[2][2]} = B;
    genvar i, j, k;
    generate
        for (i = 0; i < 3; i = i + 1) begin : loop_i
            for (j = 0; j < 3; j = j + 1) begin : loop_j
                for (k = 0; k < 3; k = k + 1) begin : loop_k
                    multiplier mult(.a(A1[i][k]), .b(B1[k][j]), .product(P[i][j][k]));
                end
            end
        end
    endgenerate
    generate
        for (i = 0; i < 3; i = i + 1) begin : sum_i
            for (j = 0; j < 3; j = j + 1) begin : sum_j
                adder add1(.a(P[i][j][0]), .b(P[i][j][1]), .sum(S1[i][j]));
                adder add2(.a(S1[i][j]), .b(P[i][j][2]), .sum(C1[i][j]));
            end
        end
    endgenerate
    assign C = {C1[0][0], C1[0][1], C1[0][2], C1[1][0], C1[1][1], C1[1][2], C1[2][0], C1[2][1], C1[2][2]};
endmodule

