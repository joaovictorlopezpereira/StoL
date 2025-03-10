#lang scheme

(require "definitions.scm")

(define (driver-loop)
  (display ">> ")
  (let ((input (read)))
    (if (end-program? input)
        (end-program)
        (begin
          (display (stol input))
          (newline)
          (newline)
          (driver-loop)))))

(define (dispatcher args)
  (if (= (vector-length args) 0)
      (begin
        (greetings)
        (driver-loop))
      (error-message)))

(define (error-message)
  (display
   "\nA argument was passed to stol.scm\nCorrect usage:\n>> racket stol.scm | to invoke the stol repl\n"))

(define (greetings)
  (display"\nWelcome to stol!\n\n"))

(define (end-program? exp)
  (or (eq? exp 'END)
      (eq? exp 'end)
      (eq? exp 'EXIT)
      (eq? exp 'exit)))

(define (end-program)
  (display "\nthanks for using STOL!\n")
  (exit))

(dispatcher (current-command-line-arguments))