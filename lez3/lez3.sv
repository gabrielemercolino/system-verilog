module FSM (
    input  logic i,
    input  logic clk,
    input  logic reset,
    output logic q
);
  typedef enum logic [1:0] {
    S0,
    S1,
    S2
  } state_t;
  state_t [1:0] state, next_state;
  always_ff @(posedge clk, posedge reset) begin
    if (reset) begin
      state <= S0;
    end else begin
      state <= next_state;
    end
  end

  always_comb begin
    case (state)
      S0: next_state = S1;
      S1: next_state = S2;
      S2: next_state = S0;
      default: next_state = S0;
    endcase
  end

  assign q = state == S0;
endmodule

module latch_SR (
    input  logic S,
    input  logic R,
    output logic y,
    output logic not_y
);
  always_comb begin
    case ({
      S, R
    })
      2'b01:   {y, not_y} = 2'b01;
      2'b10:   {y, not_y} = 2'b10;
      2'b11:   {y, not_y} = 2'b00;
      default: {y, not_y} = {y, not_y};
    endcase
  end
endmodule

module ex1 (
    input  logic a,
    b,
    c,
    output logic y
);
  assign y = ~a & ~b & ~c | a & ~b & ~c | a & ~b & c;
endmodule

module ex2 (
    input  logic a,
    b,
    c,
    clock,
    output logic x,
    y
);
  logic ix, iy;
  always_comb begin
    ix = a & b;
    iy = c | x;
  end

  always_ff @(posedge clock) begin
    x <= ix;
    y <= iy;
  end
endmodule

module lez3 ();
  logic s, r, y, not_y;
  latch_SR sr1 (
      s,
      r,
      y,
      not_y
  );

  initial begin
    $dumpfile("test.vcd");
    $dumpvars;

    s = 0;
    r = 1;
    $monitor("s:%b, r:%b", s, r);
    $finish;
  end
endmodule
