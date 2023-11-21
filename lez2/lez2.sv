module flop (
    input logic clk,
    input logic [3:0] d,
    output logic [3:0] q
);

  always_ff @(posedge clk) begin
    q <= d;
  end

endmodule

module test ();
  logic clk;
  logic [3:0] D, Q;

  flop d (
      clk,
      D,
      Q
  );

  always #1 clk = ~clk;

  initial begin
    #2 clk = 0;

    $dumpfile("flop.vcd");
    $dumpvars;
    $monitor("%4d clock=%b D=%b Q=%b", $time, clk, D, Q);

    #5 D = 0;

    #5 D = 1;

    $display("");
    #2 D = 0;
    #1 D = 1;
    #10 $finish;

  end
endmodule
