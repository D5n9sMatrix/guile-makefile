; 4.4.4.2 Module Commands

; REPL Command: module [module]

;    Change modules / Show current module. 

; REPL Command: import module …

;    Import modules / List those imported. 

; REPL Command: load file

;    Load a file in the current module. 

; REPL Command: reload [module]

;    Reload the given module, or the current module if none was given. 

; REPL Command: binding

;    List current bindings. 

; REPL Command: in module expression
; REPL Command: in module command arg …

; Evaluate an expression, or alternatively, execute another meta-command in the context of a module. For example, ‘,in (foo bar) ,binding’ will show the bindings in the module (foo bar).

