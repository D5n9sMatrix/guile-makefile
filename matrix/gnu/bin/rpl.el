; 4.4.4 REPL Commands

; The REPL exists to read expressions, evaluate them, and then print their results. But sometimes one wants to tell the REPL to evaluate an expression in a different way, or to do something else altogether. A user can affect the way the REPL works with a REPL command.

; The previous section had an example of a command, in the form of ,option.

; scheme@(guile-user)> ,option value-history #t

; Commands are distinguished from expressions by their initial comma (‘,’). Since a comma cannot begin an expression in most languages, it is an effective indicator to the REPL that the following text forms a command, not an expression.

; REPL commands are convenient because they are always there. Even if the current module doesn’t have a binding for pretty-print, one can always ,pretty-print.

; The following sections document the various commands, grouped together by functionality. Many of the commands have abbreviations; see the online help (,help) for more information.

;    Help Commands
;    Module Commands
;    Language Commands
;    Compile Commands
;    Profile Commands
;    Debug Commands
;    Inspect Commands
;    System Commands
