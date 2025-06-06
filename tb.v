module syncfifo_tb;

  // Testbench signals
  reg clk;
  reg rst;
  reg cs;
  reg wen;
  reg ren;
  reg [31:0] din;
  wire [31:0] dout;
  wire empty;
  wire full;

  // Instantiate the FIFO
  syncfifo #(
    .fifodepth(8),
    .datawidth(32)
  ) dut (
    .clk(clk),
    .rst(rst),
    .cs(cs),
    .wen(wen),
    .ren(ren),
    .din(din),
    .dout(dout),
    .empty(empty),
    .full(full)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;  // 100 MHz clock
  end

  // Testbench stimulus
  initial begin
    // Initialize signals
    clk = 0;
    rst = 0;
    cs = 0;
    wen = 0;
    ren = 0;
    din = 32'b0;

    // Reset the FIFO
    #10 rst = 1;
    #10 rst = 0;

    // Write data to FIFO
    #10 cs = 1; wen = 1; din = 32'd1;
    #10 cs = 1; wen = 1; din = 32'd2;
    #10 cs = 1; wen = 1; din = 32'd3;
    #10 cs = 1; wen = 1; din = 32'd4;
    #10 cs = 1; wen = 1; din = 32'd5;

    // Read data from FIFO
    #10 cs = 1; ren = 1;
    #10 cs = 1; ren = 1;
    #10 cs = 1; ren = 1;
    #10 cs = 1; ren = 1;
    #10 cs = 1; ren = 1;

    // End simulation
    #20 $finish;
  end

  // Monitor the signals
  initial begin
    $monitor("Time=%0t | cs=%b | wen=%b | ren=%b | dout=%d | empty=%b | full=%b", 
             $time, cs, wen, ren, dout, empty, full);
  end

endmodule
