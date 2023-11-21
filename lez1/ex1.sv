module inv1 (
    input  x,
    output y
);
  logic x, y;

  assign y = ~x;

endmodule


module example_testbench ();
  logic a, b;

  inv1 ex (
      a,
      b
  );

  initial begin

    $dumpfile("test.vcd");
    $dumpvars;

    a = 0;
    #10 a = 1;

    $finish;
  end

endmodule
