; 3.4.3 Environment Chaining

; In the example of the previous subsection, we glossed over an important point. The body of the let expression in that example refers not only to the local variable s, but also to the top level variables a, b, c and sqrt. (sqrt is the standard Scheme procedure for calculating a square root.) If the body of the let expression is evaluated in the context of the local let environment, how does the evaluation get at the values of these top level variables?

; The answer is that the local environment created by a let expression automatically has a reference to its containing environment — in this case the top level environment — and that the Scheme interpreter automatically looks for a variable binding in the containing environment if it doesn’t find one in the local environment. More generally, every environment except for the top level one has a reference to its containing environment, and the interpreter keeps searching back up the chain of environments — from most local to top level — until it either finds a variable binding for the required identifier or exhausts the chain.

; This description also determines what happens when there is more than one variable binding with the same name. Suppose, continuing the example of the previous subsection, that there was also a pre-existing top level variable s created by the expression:

(define s "Some beans, my lord!")

; Then both the top level environment and the local let environment would contain bindings for the name s. When evaluating code within the let body, the interpreter looks first in the local let environment, and so finds the binding for s created by the let syntax. Even though this environment has a reference to the top level environment, which also has a binding for s, the interpreter doesn’t get as far as looking there. When evaluating code outside the let body, the interpreter looks up variable names in the top level environment, so the name s refers to the top level variable.

; Within the let body, the binding for s in the local environment is said to shadow the binding for s in the top level environment.
