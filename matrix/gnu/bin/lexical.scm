; 3.4.4 Lexical Scope

; The rules that we have just been describing are the details of how Scheme implements “lexical scoping”. This subsection takes a brief diversion to explain what lexical scope means in general and to present an example of non-lexical scoping.

; “Lexical scope” in general is the idea that

 ;   an identifier at a particular place in a program always refers to the same variable location — where “always” means “every time that the containing expression is executed”, and that
;    the variable location to which it refers can be determined by static examination of the source code context in which that identifier appears, without having to consider the flow of execution through the program as a whole. 

 ; In practice, lexical scoping is the norm for most programming languages, and probably corresponds to what you would intuitively consider to be “normal”. You may even be wondering how the situation could possibly — and usefully — be otherwise. To demonstrate that another kind of scoping is possible, therefore, and to compare it against lexical scoping, the following subsection presents an example of non-lexical scoping and examines in detail how its behavior differs from the corresponding lexically scoped code.
