; 4.4 Using Guile Interactively

; When you start up Guile by typing just guile, without a -c argument or the name of a script to execute, you get an interactive interpreter where you can enter Scheme expressions, and Guile will evaluate them and print the results for you. Here are some simple examples.

; scheme@(guile-user)> (+ 3 4 5)
; $1 = 12
; scheme@(guile-user)> (display "Hello world!\n")
; Hello world!
; scheme@(guile-user)> (values 'a 'b)
; $2 = a
; $3 = b

; This mode of use is called a REPL, which is short for “Read-Eval-Print Loop”, because the Guile interpreter first reads the expression that you have typed, then evaluates it, and then prints the result.

; The prompt shows you what language and module you are in. In this case, the current language is scheme, and the current module is (guile-user). See Support for Other Languages, for more information on Guile’s support for languages other than Scheme.

;     The Init File, ~/.guile
;     Readline
;     Value History
;     REPL Commands
;    Error Handling
;    Interactive Debugging

; Next: Readline, Up: Using Guile Interactively   [Contents][Index]
; 4.4.1 The Init File, ~/.guile

; When run interactively, Guile will load a local initialization file from ~/.guile. This file should contain Scheme expressions for evaluation.

; This facility lets the user customize their interactive Guile environment, pulling in extra modules or parameterizing the REPL implementation.

; To run Guile without loading the init file, use the -q command-line option.

