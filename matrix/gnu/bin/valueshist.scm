; 4.4.3 Value History

; Just as Readline helps you to reuse a previous input line, value history allows you to use the result of a previous evaluation in a new expression. When value history is enabled, each evaluation result is automatically assigned to the next in the sequence of variables $1, $2, …. You can then use these variables in subsequent expressions.

; scheme@(guile-user)> (iota 10)
; $1 = (0 1 2 3 4 5 6 7 8 9)
; scheme@(guile-user)> (apply * (cdr $1))
; $2 = 362880
; scheme@(guile-user)> (sqrt $2)
; $3 = 602.3952191045344
; scheme@(guile-user)> (cons $2 $1)
; $4 = (362880 0 1 2 3 4 5 6 7 8 9)

; Value history is enabled by default, because Guile’s REPL imports the (ice-9 history) module. Value history may be turned off or on within the repl, using the options interface:

; scheme@(guile-user)> ,option value-history #f
; scheme@(guile-user)> 'foo
; foo
; scheme@(guile-user)> ,option value-history #t
; scheme@(guile-user)> 'bar
; $5 = bar

; Note that previously recorded values are still accessible, even if value history is off. In rare cases, these references to past computations can cause Guile to use too much memory. One may clear these values, possibly enabling garbage collection, via the clear-value-history! procedure, described below.

; The programmatic interface to value history is in a module:

(use-modules (ice-9 history))

; Scheme Procedure: value-history-enabled?

;    Return true if value history is enabled, or false otherwise. 

; Scheme Procedure: enable-value-history!

;    Turn on value history, if it was off. 

; Scheme Procedure: disable-value-history!

;    Turn off value history, if it was on. 

; Scheme Procedure: clear-value-history!

; Clear the value history. If the stored values are not captured by some other data structure or closure, they may then be reclaimed by the garbage collector.
