# Syncronous-FIFO
Verilog code for Synchronous Fifo Circuit to carry out RTL to GDS development

# syncfifo-verilog

A parameterizable Synchronous FIFO (First-In-First-Out) buffer implemented in Verilog, along with a testbench to verify functionality. This FIFO module supports simultaneous read and write operations, and includes flags for full and empty conditions.

---

## 📦 Project Structure

| File             | Description                                                 |
|------------------|-------------------------------------------------------------|
| `syncfifo.v`     | Main FIFO RTL design with configurable depth and data width |
| `syncfifo_tb.v`  | Testbench to simulate the FIFO using various operations     |

---

## 🧠 Features

- ✅ Parameterized FIFO depth and data width
- ✅ Synchronous design (single clock domain)
- ✅ Control signals:
  - `cs` (chip select)
  - `wen` (write enable)
  - `ren` (read enable)
- ✅ Status flags: `empty`, `full`
- ✅ Handles write and read pointer wrapping using one-bit overflow logic
- ✅ Includes a testbench for functional simulation

---

## ⚙️ Module Parameters

```verilog
parameter fifodepth = 8;       // Number of entries in FIFO
parameter datawidth = 32;      // Width of each data entry
