; 4.3.4 Scripting Examples

; To start with, here are some examples of invoking Guile directly:

; guile -- a b c

;    Run Guile interactively; (command-line) will return
;    ("/usr/local/bin/guile" "a" "b" "c").
; guile -s /u/jimb/ex2 a b c

;     Load the file /u/jimb/ex2; (command-line) will return
;     ("/u/jimb/ex2" "a" "b" "c").
; guile -c '(write %load-path) (newline)'

;    Write the value of the variable %load-path, print a newline, and exit.
; guile -e main -s /u/jimb/ex4 foo

;    Load the file /u/jimb/ex4, and then call the function main, passing it the list ("/u/jimb/ex4" "foo").
; guile -e '(ex4)' -s /u/jimb/ex4.scm foo

;    Load the file /u/jimb/ex4.scm, and then call the function main from the module ’(ex4)’, passing it the list ("/u/jimb/ex4" "foo").
; guile -l first -ds -l last -s script

;    Load the files first, script, and last, in that order. The -ds switch says when to process the -s switch. For a more motivated example, see the scripts below.

; Here is a very simple Guile script:

; #!/usr/local/bin/guile -s
; !#
(display "Hello, world!")
(newline)

; The first line marks the file as a Guile script. When the user invokes it, the system runs /usr/local/bin/guile to interpret the script, passing -s, the script’s filename, and any arguments given to the script as command-line arguments. When Guile sees -s script, it loads script. Thus, running this program produces the output:

; Hello, world!

; Here is a script which prints the factorial of its argument:

; #!/usr/local/bin/guile -s
; !#
(define (fact n)
  (if (zero? n) 1
    (* n (fact (- n 1)))))

; (display (fact (string->number (cadr (command-line)))))
; (newline)

; In action:

; $ ./fact 5
; 120
; $

; However, suppose we want to use the definition of fact in this file from another script. We can’t simply load the script file, and then use fact’s definition, because the script will try to compute and display a factorial when we load it. To avoid this problem, we might write the script this way:

; #!/usr/local/bin/guile \
; -e main -s
; !#

(define (fact n)
  (if (zero? n) 1
    (* n (fact (- n 1)))))

(define (main args)
  (display (fact (string->number (cadr args))))
  (newline))

; This version packages the actions the script should perform in a function, main. This allows us to load the file purely for its definitions, without any extraneous computation taking place. Then we used the meta switch \ and the entry point switch -e to tell Guile to call main after loading the script.

; $ ./fact 50
; 30414093201713378043612608166064768844377641568960512000000000000

; Suppose that we now want to write a script which computes the choose function: given a set of m distinct objects, (choose n m) is the number of distinct subsets containing n objects each. It’s easy to write choose given fact, so we might write the script this way:

; #!/usr/local/bin/guile \
; -l fact -e main -s
; !#
(define (choose n m)
  (/ (fact m) (* (fact (- m n)) (fact n))))

; (define (main args)
;   (let ((n (string->number (cadr args)))
;         (m (string->number (caddr args))))
;     (display (choose n m))
;     (newline)))

; The command-line arguments here tell Guile to first load the file fact, and then run the script, with main as the entry point. In other words, the choose script can use definitions made in the fact script. Here are some sample runs:

; $ ./choose 0 4
; 1
; $ ./choose 1 4
; 4
; $ ./choose 2 4
; 6
; $ ./choose 3 4
; 4
; $ ./choose 4 4
; 1
; $ ./choose 50 100
; 100891344545564193334812497256

;To call a specific procedure from a given module, we can use the special form (@ (module) procedure):

; #!/usr/local/bin/guile \
; -l fact -e (@ (fac) main) -s
; !#

; (define-module (fac)
;  #:export (main))

; (define (choose n m)
;  (/ (fact m) (* (fact (- m n)) (fact n))))

; (define (main args)
;  (let ((n (string->number (cadr args)))
;        (m (string->number (caddr args))))
;    (display (choose n m))
;    (newline)))

; We can use @@ to invoke non-exported procedures. For exported procedures, we can simplify this call with the shorthand (module):

; #!/usr/local/bin/guile \
; -l fact -e (fac) -s
; !#
; (define-module (fac)
;  #:export (main))

; (define (choose n m)
;  (/ (fact m) (* (fact (- m n)) (fact n))))

; (define (main args)
;  (let ((n (string->number (cadr args)))
;        (m (string->number (caddr args))))
;    (display (choose n m))
;    (newline)))

; For maximum portability, we can instead use the shell to execute guile with specified command line arguments. Here we need to take care to quote the command arguments correctly:

;#!/usr/bin/env sh
; exec guile -l fact -e '(@ (fac) main)' -s "$0" "$@"
; !#
; (define-module (fac)
;  #:export (main))

; (define (choose n m)
;  (/ (fact m) (* (fact (- m n)) (fact n))))

;(define (main args)
;  (let ((n (string->number (cadr args)))
;        (m (string->number (caddr args))))
;    (display (choose n m))
;    (newline)))

; Finally, seasoned scripters are probably missing a mention of subprocesses. In Bash, for example, most shell scripts run other programs like sed or the like to do the actual work.

; In Guile it’s often possible get everything done within Guile itself, so do give that a try first. But if you just need to run a program and wait for it to finish, use system*. If you need to run a sub-program and capture its output, or give it input, use open-pipe. See Processes, and See Pipes, for more information.
