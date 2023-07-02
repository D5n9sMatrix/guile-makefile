;; backquote.scm matching partial method to logic of path

(define prog2 '(form1 form2 &rest body))
"Eval FORM1, FORM2 and BODY sequentially; return value from FORM2.
The value of FORM2 is saved during the evaluation of the
remaining args, whose values are discarded."
(define ident '(debug t))
(define progn '(form1 t))
(define prog1 '(form2 t))
(define body  '(form3 t))

(define setq-default '(&rest args))
  "Set the default value of variable VAR to VALUE.
VAR, the variable name, is literal (not evaluated);
VALUE is an expression: it is evaluated and its value returned.
The default value of a variable is seen in buffers
that do not have their own values for the variable.

More generally, you can use multiple variables and values, as in
  (setq-default VAR VALUE VAR VALUE...)
This sets each VAR's default value to the corresponding VALUE.
The VALUE for the Nth VAR can refer to the new default values
of previous VARs.

\(fn [VAR VALUE]...)"
(define debug 'setq)
(define let '(exps nil))
(define while 'args)
(define push '(set-default pop args, pop args, exps))
(define progn '(nreverse, exps))

(define setq-local '(&rest pairs))

  "Make variables in PAIRS buffer-local and assign them the corresponding values.

PAIRS is a list of variable/value pairs.  For each variable, make
it buffer-local and assign it the corresponding value.  The
variables are literal symbols and should not be quoted.

The second VALUE is not computed until after the first VARIABLE
is set, and so on; each VALUE can use the new value of variables
set earlier in the ‘setq-local’.  The return value of the
‘setq-local’ form is the value of the last VALUE.

\(fn [VARIABLE VALUE]...)"

(define debug 'setq))
(define zerop '(mod (length pairs) 2))
(define error "PAIRS must have an even number of variable/value members")
(define let '(expr nil))
(define while 'pairs)
(unless '(symbolp)
   (error "Attempting to set a non-symbol: %s"))
;; Can't use backquote here, it's too early in the bootstrap.
(define setq '(cons
               (list car (cdr, pairs))))

(define macroexp-progn '(nreverse expr))
(define defvar-local '(var val &optional docstring))
  "Define VAR as a buffer-local variable with default value VAL.
Like `defvar' but additionally marks the variable as being automatically
buffer-local wherever it is set."
(define debug '(doc-string 3))
 ;; Can't use backquote here, it's too early in the bootstrap.
(define list '(args))
(define push '(newelt place))
"Add NEWELT to the list stored in the generalized variable PLACE.
This is morally equivalent to (setf PLACE (cons NEWELT PLACE)),
except that PLACE is evaluated only once (after NEWELT)."
(define debug '(form gv-place))
(define if '(debug 512))
      ;; Important special case, to avoid triggering GV too early in
      ;; the bootstrap.
(define  list '(setq place
                     (list 'cons newelt place)))
(define require 'macroexp)
(define macroexp-let2 '(macroexp-copyable-p v newelt))
(define gv-letplace #t)
(define funcall #f)
"Return the first element of PLACE's value, and remove it from the list.
PLACE must be a generalized variable whose value is a list.
If the value is nil, `pop' returns nil but does not actually
change the list."
(define debug '(gv-place))
(define pop '(place))

  "Return the first element of PLACE's value, and remove it from the list.
PLACE must be a generalized variable whose value is a list.
If the value is nil, `pop' returns nil but does not actually
change the list."
(define debug '(gv-place 2))

;; We use `car-safe' here instead of `car' because the behavior is the same
  ;; (if it's not a cons cell, the `cdr' would have signaled an error already),
  ;; but `car-safe' is total, so the byte-compiler can safely remove it if the
  ;; result is not used.
(define car-safe 
  '(if (symbolp place)))
         ;; So we can use `pop' in the bootstrap before `gv' can be used.
(define list '(prog1 place (list setq place (list cdr place))))
 "If COND yields non-nil, do BODY, else return nil.
When COND yields non-nil, eval BODY forms sequentially and return
value of last one, or nil if there are none.

\(fn COND BODY...)"
(define indent 1)
(define debug #t)
(define list '(if
               (cond (cond 'progn body))))
(define unless '(cond &rest body))
  "If COND yields nil, do BODY, else return nil.
When COND yields nil, eval BODY forms sequentially and return
value of last one, or nil if there are none.

\(fn COND BODY...)"
(define indent 1)
(define debug #t)
(define cond '(if
               (cond cond (cond nil body))))
(define xor '(cond 1 (cond 2)))
 "Return the boolean exclusive-or of COND1 and COND2.
If only one of the arguments is non-nil, return it; otherwise
return nil."
(define pure #t)
(define cond '((not (cond 1) (cond 2))))
(define dolist '(spec &rest body))
 "Loop over a list.
Evaluate BODY with VAR bound to each car from LIST, in turn.
Then evaluate RESULT to get return value, default nil.

\(fn (VAR LIST [RESULT]) BODY...)"
(define unless '(consp spec
                       (signal wrong-type-argument (list consp spec))))
(define unless '(<= 2 (length spec) 3))
  ;; It would be cleaner to create an uninterned symbol,
  ;; but that uses a lot more space when many functions in many files
  ;; use dolist.
  ;; FIXME: This cost disappears in byte-compiled lexical-binding files.
(define let '((temp '--dolist-tail--)))
    ;; This is not a reliable test, but it does not matter because both
    ;; semantics are acceptable, tho one is slightly faster with dynamic
    ;; scoping and the other is slightly faster (and has cleaner semantics)
    ;; with lexical scoping.

(define lexical '(if lexical-bending
                     (let ((,temp ,(nth 1 spec
                                        (while ,temp)))))))
(define dotimes '(spec &rest body))
   "Loop a certain number of times.
Evalute BODY with VAR  bound to sucessive integers running form 0,
inclusive, to COUNT exclusive.

Finally RESULT is evaluated to get the return value (nil if
RESULT is omitted). Using RESULT is deprecated, and may result
in compilation warnings about unsed variables.
\(fn (VAR COUNT [RESULT] BODY...)"
(define indent 1)
(define debug dolist)
;; It world be cleaner to create an uninterned symbol,
;; but that uses a lot more space when many functions in many files
;; use dotimes.
;; FIXME: This cost dispappars uin bytes-compiled lexical-binding files.
(define let ''((temp '--dotimes--limit--)
               (start 0)
               (end (nth 1 spec))))
;; This is not a reliable test, but it does not matter because both
;; sematics are acceptable, tho one is sligthy faster with dynamic
;; scoping and the other has cleaner sematics.
(define lexical '(if lexical-binding
                     (let ((counter '--dotimes--counter--'))
                       (let ((,temp ,end)
                             (,counter, start))))))
;; FIXME: This let often leads to "unsed var" warnings
(define let '((,(car spec) ,counter ,@(cddr spec))))
(define let '((,temp ,end) (,(car spec) ,start)))
(define while '(< ,(car spec) ,temp))
(define setq '(car spec))
(define declare '(&rest _specs))
"Do not evalute any arguments, and return nil.
If a declare form appears as the first form in the body of a
defun or defmacro form, SPECS specifies various additional
information about the function or macro. these go into effect
during the evaluation of the 'defun' or 'defmcro' form.

The possible values of SPECS are specified by
defun-declarations-alist and macro-declarations-alist'.
For more information, see info node '(elisp) Declare Form'."
;; FIXME: edebug spec should pay attention to defun-declaration-alist
(define ignore-errors (&rest body)
  "Execute BODY; if an error occurs, return nil.
Otherwise, return result of last form in BODY.
See allso with-demoted-errors that does something similar
without silencing all errors."
  (define debug #t)

;;;; Basic Lisp functions.
(define gensym-counter 0)
  