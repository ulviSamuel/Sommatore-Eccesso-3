# Excess-3 Adder

![Verilog](https://img.shields.io/badge/HDL-Verilog-2f2f2f)
![Category](https://img.shields.io/badge/Category-Digital%20Logic-2f2f2f)
![Project](https://img.shields.io/badge/Project-Academic-2f2f2f)
![Year](https://img.shields.io/badge/Year-2026-2f2f2f)

An educational Verilog implementation of single-digit Excess-3 arithmetic, including addition, subtraction, correction, and supporting binary adder modules.

> [!NOTE]
> This repository contains an academic project originally developed during earlier programming and digital-logic studies. It is preserved as a record of the technical knowledge, design decisions, and development experience acquired at the time.

## Overview

The project builds an Excess-3 arithmetic datapath from reusable combinational modules. Binary half adders and full adders are composed into a 4-bit ripple-carry adder; higher-level modules then apply Excess-3 correction for single-digit addition and subtraction.

The source is contained in [`ProvaPropedeutica.v`](ProvaPropedeutica.v).

## Implemented modules

- `half_adder` computes the sum and carry of two bits.
- `full_adder` computes the sum and carry of three bits using two `half_adder` instances.
- `four_bit_adder` adds two 4-bit values with carry-in, carry-out, and an overflow `error` signal.
- `bits_complementer` produces the bitwise complement of a 4-bit input.
- `ecc3_digit_corrector` selects the Excess-3 correction based on the adder carry.
- `ecc3_single_digit_adder` adds two 4-bit Excess-3 digits and returns the corrected result and carry-out.
- `ecc3_ls_digit_complementer` complements the least-significant Excess-3 digit using the project's correction path.
- `ecc3_single_digit_subtractor` subtracts two Excess-3 digits and reports whether the selected result is positive.
- `ecc3_single_digit_subadder` selects addition or subtraction through `sel` and exposes the result sign and an addition error signal.

The `cin` and `cout` ports present on selected modules are intended to support possible multi-digit expansion, while the implemented subtraction and subadder interfaces operate on one digit.

## Technology

- **Hardware description language:** Verilog
- **Design style:** Hierarchical combinational logic
- **Encoding:** Excess-3 decimal digit representation

## Repository structure

```text
.
├── ProvaPropedeutica.v
├── .gitattributes
└── .gitignore
```

## Verification status

The repository does not contain a testbench, simulator configuration, dependency manifest, build script, or continuous-integration workflow. Consequently, no repository-defined installation, compilation, execution, or test command can be verified from the available files.

To evaluate the design, a Verilog simulator and an external testbench would be required; those prerequisites and procedures are not specified by this repository.

## License

This project is shared for educational and portfolio purposes. All rights reserved unless otherwise stated.
