//////////////////////////////////////////////////////////////////////////////////
// Engineer:       Jennifer George
// Design Name:    Synchronous FIFO
// Description: 
//   This module implements a parameterizable Synchronous FIFO (First In, First Out)
//   memory buffer with configurable depth and data width.
//
//   It supports concurrent read and write operations using read and write pointers,
//   with status signals for EMPTY and FULL conditions. The FIFO operates synchronously
//   with a single clock and includes control signals for read/write enable and chip select.
//
// Parameters:
//   - fifodepth : Depth of the FIFO (default = 8)
//   - datawidth : Width of each data word (default = 32)
//
// Ports:
//   - clk     : Clock input
//   - rst     : Active-low asynchronous reset
//   - cs      : Chip select
//   - wen     : Write enable
//   - ren     : Read enable
//   - din     : Data input
//   - dout    : Data output
//   - empty   : FIFO empty flag
//   - full    : FIFO full flag
//
// Internal Notes:
//   - Write and read pointers are one bit wider to handle full condition detection.
//   - 'full' is detected by checking if read pointer equals inverted MSB of write pointer concatenated with rest.
//   - Data is written to and read from a memory array using the lower bits of the pointers.
//
// Dependencies: None
//
// Revision History:
//   Rev 1.0 - Initial design
//
//////////////////////////////////////////////////////////////////////////////////

module syncfifo 
  // Parameters section
  #( parameter fifodepth = 8,
    parameter datawidth = 32)
  (input clk,
   input rst,
    input cs, 
    input wen, 
    input ren,
  input [datawidth-1:0] din, 
  output reg [datawidth-1:0] dout, 
   output empty, 
   output full);
  
  localparam fifodepthlog = $clog2(fifodepth);// FIFO_DEPTH_LOG = 4 (no. of bits required to represent 8) 
  reg [fifodepthlog:0] rpntr;
  reg [fifodepthlog:0] wpntr;//3:0 reg // Wr/Rd pointer have 1 extra bits at MSB 
  reg [datawidth-1:0] fifo [0:fifodepth-1];
  
  //write 
  always @(posedge clk or negedge rst)
    begin 
      if(rst)
      wpntr <= 0; 
      else if (cs && wen && !full) 
        begin 
          fifo[wpntr [fifodepthlog-1:0]] <= din;
          wpntr <= wpntr + 1'b1;
        end
    end
  
  //read
 always @(posedge clk or negedge rst)
    begin 
      if(rst)
      rpntr <= 0; 
      else if (cs && ren && !full) 
        begin 
          dout<=fifo[rpntr [fifodepthlog-1:0]];
          rpntr <= rpntr + 1'b1;
        end
    end
  
  // Declare the empty/full 
  assign empty= (rpntr == wpntr);
  assign full = (rpntr== {~wpntr[fifodepthlog],wpntr[fifodepthlog-1:0]}); 
  
endmodule
