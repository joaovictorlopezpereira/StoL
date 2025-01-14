# StoL

## Description

  A simple Scheme to Latex arithmetic expressions converter.

-----

## Requirements

  It is necessary to have ``racket`` installed in order to run the program.

-----

## How to Use it

  Execute

  ```bash
  racket stol.scm
  ```

  in the terminal in order to start the stol REPL.

-----

## Usage Examples

  ```bash
  racket stol.scm
  >> (expt (* x 2) (+ 5 (log 2 10)))
  (x \times 2)^{(5 + \log_{10}(2))}
  ```

  In this example, the Scheme expression ``(expt (* x 2) (+ 5 (log 2 10)))`` is being translated into the LaTeX expression ``(x \times 2)^{(5 + \log_{10}(2))}``, which, in the LaTeX formatting, would be rendered as:

  \[(x \times 2)^{(5 + \log_{10}(2))}.\]