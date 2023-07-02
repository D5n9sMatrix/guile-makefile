; 4.3.2 The Meta Switch

; Guile’s command-line switches allow the programmer to describe reasonably complicated actions in scripts. Unfortunately, the POSIX script invocation mechanism only allows one argument to appear on the ‘#!’ line after the path to the Guile executable, and imposes arbitrary limits on that argument’s length. Suppose you wrote a script starting like this:

; #!/usr/local/bin/guile -e main -s
; !#

(define (main args)
  (map (lambda (arg) (display arg) (display " "))
       (cdr args))
  (newline))

; The intended meaning is clear: load the file, and then call main on the command-line arguments. However, the system will treat everything after the Guile path as a single argument — the string "-e main -s" — which is not what we want.

; As a workaround, the meta switch \ allows the Guile programmer to specify an arbitrary number of options without patching the kernel. If the first argument to Guile is \, Guile will open the script file whose name follows the \, parse arguments starting from the file’s second line (according to rules described below), and substitute them for the \ switch.

; Working in concert with the meta switch, Guile treats the characters ‘#!’ as the beginning of a comment which extends through the next line containing only the characters ‘!#’. This sort of comment may appear anywhere in a Guile program, but it is most useful at the top of a file, meshing magically with the POSIX script invocation mechanism.

; Thus, consider a script named /u/jimb/ekko which starts like this:

; #!/usr/local/bin/guile \
; -e main -s
; !#
(define (main args)
        (map (lambda (arg) (display arg) (display " "))
             (cdr args))
        (newline))

; Suppose a user invokes this script as follows:

; $ /u/jimb/ekko a b c

; Here’s what happens:

;    the operating system recognizes the ‘#!’ token at the top of the file, and rewrites the command line to:

;    /usr/local/bin/guile \ /u/jimb/ekko a b c

;    This is the usual behavior, prescribed by POSIX.
;    When Guile sees the first two arguments, \ /u/jimb/ekko, it opens /u/jimb/ekko, parses the three arguments -e, main, and -s from it, and substitutes them for the \ switch. Thus, Guile’s command line now reads:

;    /usr/local/bin/guile -e main -s /u/jimb/ekko a b c

;    Guile then processes these switches: it loads /u/jimb/ekko as a file of Scheme code (treating the first three lines as a comment), and then performs the application (main "/u/jimb/ekko" "a" "b" "c"). 

; When Guile sees the meta switch \, it parses command-line argument from the script file according to the following rules:

;    Each space character terminates an argument. This means that two spaces in a row introduce an argument "".
;    The tab character is not permitted (unless you quote it with the backslash character, as described below), to avoid confusion.
;    The newline character terminates the sequence of arguments, and will also terminate a final non-empty argument. (However, a newline following a space will not introduce a final empty-string argument; it only terminates the argument list.)
;    The backslash character is the escape character. It escapes backslash, space, tab, and newline. The ANSI C escape sequences like \n and \t are also supported. These produce argument constituents; the two-character combination \n doesn’t act like a terminating newline. The escape sequence \NNN for exactly three octal digits reads as the character whose ASCII code is NNN. As above, characters produced this way are argument constituents. Backslash followed by other characters is not allowed. 
