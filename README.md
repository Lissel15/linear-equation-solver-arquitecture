# Simplified datapath: linear equation solver (VHDL)

A datapath in VHDL whose "program" is four linear equations of the form `a*x + b = 0`.
Each instruction selects a pair of registers `(a, b)`, and the ALU computes `x = -b / a`.

## Architecture

```
clk ─> pc ─> rom ─> instr ─┬─> control_unit ──> reg_w, alu_c
                           │
                           └─> register select ─> reg_file ─> rd1 (a), rd2 (b) ─> alu ─> alu_res
```

- `pc.vhd`: program counter, +4 per clock.
- `rom.vhd`: instruction ROM holding 4 instructions (`1` to `4`), one per equation.
- `reg_file.vhd`: 32 x 32-bit registers, preloaded with the coefficients.
- `alu.vhd`: implements one operation (`ctrl = "0010"`): `x = -b / a`, returns 0 if `a = 0`.
- `control_unit.vhd`: currently drives a constant `reg_w = 1` and `alu_c = "0010"`.
- `cpu.vhd`: top level; maps each instruction to its register pair.
- `tb.vhd`: 20 ns clock, writes the ALU output at each rising edge to `salida.txt`.

## Equations and expected results

| Instr | Equation | Registers (a, b) | Expected x |
|---|---|---|---|
| 1 | 2x + 4 = 0 | (2, 4) | -2 |
| 2 | 5x - 10 = 0 | (5, -10) | 2 |
| 3 | 3x + 9 = 0 | (3, 9) | -3 |
| 4 | 4x - 8 = 0 | (4, -8) | 2 |

## Known limitations

This is a simplified datapath, not a general-purpose processor.

- Instructions are fixed values `1` to `4`, not a real opcode/operand format.
- The ALU has a single operation, and the control unit ignores the opcode.
- No write-back (the register file is never written) and no data memory.
- The ROM has 16 entries but is indexed with `addr(7 downto 2)` (0 to 63), so a simulation longer than about 300 ns reads out of range. Use `addr(5 downto 2)` to fix.

## Simulation

Simulated in Active-HDL 12 (Student Edition) with `tb` as top-level entity, for 260 ns. The testbench writes one result per clock to `salida.txt`.

## FPGA

Programmed on an Altera/Intel DE10-Lite FPGA with Quartus.

Board demo: 

## My contribution
I worked on this project as part of a team of 3, contributing to both the design and the hardware side:
- Researched how to take a VHDL design from simulation to real hardware on an Altera/Intel DE10-Lite board using Quartus.
- Worked on the Quartus workflow: creating the project, assigning pins manually in the Pin Planner, compiling, and programming the board.
