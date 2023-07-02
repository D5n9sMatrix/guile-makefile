; 3.4.9 Example 4: Object Orientation

; Closure is the capture of an environment, containing persistent variable bindings, within the definition of a procedure or a set of related procedures. This is rather similar to the idea in some object oriented languages of encapsulating a set of related data variables inside an “object”, together with a set of “methods” that operate on the encapsulated data. The following example shows how closure can be used to emulate the ideas of objects, methods and encapsulation in Scheme.

; (define (make-account)
;   (let ((balance 0))
;     (define (get-balance)
;       balance)
;    (define (deposit amount)
;       (set! balance (+ balance amount))
;       balance)
;     (define (withdraw amount)
;       (deposit (- amount)))

;     (lambda args
;       (apply
;         (case (car args)
;           ((get-balance) get-balance)
;           ((deposit) deposit)
;           ((withdraw) withdraw)
;           (else (error "Invalid method!")))
;         (cdr args)))))

; Each call to make-account creates and returns a new procedure, created by the expression in the example code that begins “(lambda args”.

(define my-account '(make-account))

; my-account
; ⇒
; #<procedure args>

; This procedure acts as an account object with methods get-balance, deposit and withdraw. To apply one of the methods to the account, you call the procedure with a symbol indicating the required method as the first parameter, followed by any other parameters that are required by that method.

; (my-account 'get-balance)
; ⇒
; 0

; (my-account 'withdraw 5)
; ⇒
; -5

; (my-account 'deposit 396)
; ⇒
; 391

; (my-account 'get-balance)
; ⇒
; 391

; Note how, in this example, both the current balance and the helper procedures get-balance, deposit and withdraw, used to implement the guts of the account object’s methods, are all stored in variable bindings within the private local environment captured by the lambda expression that creates the account object procedure.

