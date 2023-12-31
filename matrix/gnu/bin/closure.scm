; 3.4.5 Closure

; Consider a let expression that doesn’t contain any lambdas:

; (let ((s (/ (+ a b c) 2)))
;  (sqrt (* s (- s a) (- s b) (- s c))))

; When the Scheme interpreter evaluates this, it

;    creates a new environment with a reference to the environment that was current when it encountered the let
;    creates a variable binding for s in the new environment, with value given by (/ (+ a b c) 2)
;    evaluates the expression in the body of the let in the context of the new local environment, and remembers the value V
;    forgets the local environment
;    continues evaluating the expression that contained the let, using the value V as the value of the let expression, in the context of the containing environment. 

; After the let expression has been evaluated, the local environment that was created is simply forgotten, and there is no longer any way to access the binding that was created in this environment. If the same code is evaluated again, it will follow the same steps again, creating a second new local environment that has no connection with the first, and then forgetting this one as well.

; If the let body contains a lambda expression, however, the local environment is not forgotten. Instead, it becomes associated with the procedure that is created by the lambda expression, and is reinstated every time that that procedure is called. In detail, this works as follows.

;    When the Scheme interpreter evaluates a lambda expression, to create a procedure object, it stores the current environment as part of the procedure definition.
;    Then, whenever that procedure is called, the interpreter reinstates the environment that is stored in the procedure definition and evaluates the procedure body within the context of that environment. 

; The result is that the procedure body is always evaluated in the context of the environment that was current when the procedure was created.

; This is what is meant by closure. The next few subsections present examples that explore the usefulness of this concept.

