#lang scheme

(provide stol)

(define (stol exp)
  (cond
    ((number?   exp) (number->string   exp))
    ((constant? exp) (constant->string exp))
    ((symbol?   exp) (symbol->string   exp))
    ((list?     exp)
     (cond
       ((sum-or-sub? exp) (stol-sum-or-sub exp))
       ((product?    exp) (stol-prod       exp))
       ((division?   exp) (stol-div        exp))
       ((expt?       exp) (stol-expt       exp))
       ((log?        exp) (stol-log        exp))
       ((trig?       exp) (stol-trig       exp))
       ))))


;-----begin-----constant-----
(define (constant? exp)
  (or (eq? exp 'pi)
      (eq? exp 'alpha)
      (eq? exp 'beta)
      (eq? exp 'gamma)))

(define (constant->string exp)
  (cond ((eq? exp 'pi) "\\pi")
        ((eq? exp 'alpha) "\\alpha")
        ((eq? exp 'beta) "\\beta")
        ((eq? exp 'gamma) "\\gamma")))
;------end------constant-----


;-----begin-----sum-or-sub-----
(define (sum-or-sub? x)
  (or (eq? (car x) '+)
      (eq? (car x) '-)))

(define (stol-sum-or-sub exp)
  (let ((op (stol (car exp)))
        (args (map stol (cdr exp))))
    (string-append "("
                   (s-to-common op args)
                   ")")))
;------end------sum-or-sub-----


;-----begin-----prod-----
(define (product? x)
  (eq? (car x) '*))

(define (stol-prod exp)
  (let ((op "\\times")
        (args (map stol (cdr exp))))
    (string-append "("
                   (s-to-common op args)
                   ")")))
;------end------prod-----


;-----begin-----div-----
(define (division? x)
  (eq? (car x) '/))

(define (stol-div exp)
  (let ((num (cadr exp))
        (den (caddr exp)))
    (string-append "\\dfrac{"
                   (stol num)
                   "}{"
                   (stol den)
                   "}")))


;------end------div-----


;-----begin-----expt-----
(define (expt? x)
  (eq? (car x) 'expt))

(define (stol-expt exp)
  (let ((base (cadr exp))
        (exponent (caddr exp)))
    (string-append (stol base)
                   "^{"
                   (stol exponent)
                   "}")))
;------end------expt-----


;-----begin-----log-----
(define (log? x)
  (eq? (car x) 'log))

(define (stol-log exp)
  (let ((base (caddr exp))
        (arg (cadr exp)))
    (string-append "\\log_{"
                   (stol base)
                   "}("
                   (stol arg)
                   ")")))
;------end------log-----


;-----begin-----trigonometry-----
(define (trig? x)
  (or (eq? (car x) 'sin)
      (eq? (car x) 'cos)
      (eq? (car x) 'tan)))

(define (stol-trig exp)
  (let ((op (car exp))
        (arg (cadr exp)))
    (string-append "\\"
                   (stol op)
                   "("
                   (stol arg)
                   ")")))

;------end------trigonometry-----


;-----begin-----helper-----
(define (s-to-common op args)
  (if (null? (cdr args))
      (car args)
      (string-append (car args) " "
                     op " "
                     (s-to-common op (cdr args)))))
;------end------helper-----
