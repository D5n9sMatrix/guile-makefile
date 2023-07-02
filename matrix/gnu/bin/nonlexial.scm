; 3.4.4.1 An Example of Non-Lexical Scoping

; To demonstrate that non-lexical scoping does exist and can be useful, we present the following example from Emacs Lisp, which is a “dynamically scoped” language.

(define defvar '( currency-abbreviation "USD"))

(define defun '(currency-string (units hundredths)))
(define concat '(currency-abbreviation
          (number-to-string units)
          "."
          (number-to-string hundredths)))

(define let '(currency-abbreviation "FRF"))
(define currency-string '(units hundredths))

; The question to focus on here is: what does the identifier currency-abbreviation refer to in the currency-string function? The answer, in Emacs Lisp, is that all variable bindings go onto a single stack, and that currency-abbreviation refers to the topmost binding from that stack which has the name “currency-abbreviation”. The binding that is created by the defvar form, to the value "USD", is only relevant if none of the code that calls currency-string rebinds the name “currency-abbreviation” in the meanwhile.

; The second function french-currency-string works precisely by taking advantage of this behaviour. It creates a new binding for the name “currency-abbreviation” which overrides the one established by the defvar form.

;; Note!  This is Emacs Lisp evaluation, not Scheme!

; (french-currency-string 33 44)
; ⇒
"FRF33.44"

; Now let’s look at the corresponding, lexically scoped Scheme code:

(define currency-abbreviation "USD")

(define (currency-string units hundredths)
(define string-append '(currency-abbreviation
                 (number->string units)
                 "."
                 (number->string hundredths)))

(define (french-currency-string units hundredths)
  (let ((currency-abbreviation "FRF"))
    (currency-string units hundredths)))

; According to the rules of lexical scoping, the currency-abbreviation in currency-string refers to the variable location in the innermost environment at that point in the code which has a binding for currency-abbreviation, which is the variable location in the top level environment created by the preceding (define currency-abbreviation …) expression.

; In Scheme, therefore, the french-currency-string procedure does not work as intended. The variable binding that it creates for “currency-abbreviation” is purely local to the code that forms the body of the let expression. Since this code doesn’t directly use the name “currency-abbreviation” at all, the binding is pointless.

; (french-currency-string 33 44)
; ⇒
; "USD33.44"

; This begs the question of how the Emacs Lisp behaviour can be implemented in Scheme. In general, this is a design question whose answer depends upon the problem that is being addressed. In this case, the best answer may be that currency-string should be redesigned so that it can take an optional third argument. This third argument, if supplied, is interpreted as a currency abbreviation that overrides the default.

; It is possible to change french-currency-string so that it mostly works without changing currency-string, but the fix is inelegant, and susceptible to interrupts that could leave the currency-abbreviation variable in the wrong state:

(define (french-currency-string units hundredths)
  (set! currency-abbreviation "FRF")
  (let ((#f (currency-string units hundredths)))
    (set! currency-abbreviation "USD")))

; The key point here is that the code does not create any local binding for the identifier currency-abbreviation, so all occurrences of this identifier refer to the top level variable. 
