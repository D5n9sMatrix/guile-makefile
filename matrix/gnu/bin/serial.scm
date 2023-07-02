;c3.4.6 Example 1: A Serial Number Generator

;cThis example uses closure to create a procedure with a variable binding that is private to the procedure, like a local variable, but whose value persists between procedure calls.

; (define (make-serial-number-generator)
;  (let ((current-serial-number 0))
;    (lambda ()
;      (set! current-serial-number (+ current-serial-number 1))
;      current-serial-number)))

; (define entry-sn-generator (make-serial-number-generator))

; (entry-sn-generator)
; ⇒
; 1

; (entry-sn-generator)
; ⇒
; 2

;cWhen make-serial-number-generator is called, it creates a local environment with a binding for current-serial-number whose initial value is 0, then, within this environment, creates a procedure. The local environment is stored within the created procedure object and so persists for the lifetime of the created procedure.

; Every time the created procedure is invoked, it increments the value of the current-serial-number binding in the captured environment and then returns the current value.

; Note that make-serial-number-generator can be called again to create a second serial number generator that is independent of the first. Every new invocation of make-serial-number-generator creates a new local let environment and returns a new procedure object with an association to this environment.
