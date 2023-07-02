; 3.4.7 Example 2: A Shared Persistent Variable

; This example uses closure to create two procedures, get-balance and deposit, that both refer to the same captured local environment so that they can both access the balance variable binding inside that environment. The value of this variable binding persists between calls to either procedure.

; Note that the captured balance variable binding is private to these two procedures: it is not directly accessible to any other code. It can only be accessed indirectly via get-balance or deposit, as illustrated by the withdraw procedure.

(define get-balance #f)
(define deposit #f)

; (let ((balance 0))
;   (set! get-balance
;         (lambda ()
;           balance))
;   (set! deposit
;         (lambda (amount)
;           (set! balance (+ balance amount))
;           balance)))

(define (withdraw amount)
  (deposit (- amount)))

; (get-balance)
; ⇒
; 0

; (deposit 50)
; ⇒
; 50

; (withdraw 75)
; ⇒
; -25

; An important detail here is that the get-balance and deposit variables must be set up by defineing them at top level and then set!ing their values inside the let body. Using define within the let body would not work: this would create variable bindings within the local let environment that would not be accessible at top level.
