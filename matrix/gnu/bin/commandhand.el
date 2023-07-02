; 4.3.3 Command Line Handling

; The ability to accept and handle command line arguments is very important when writing Guile scripts to solve particular problems, such as extracting information from text files or interfacing with existing command line applications. This chapter describes how Guile makes command line arguments available to a Guile script, and the utilities that Guile provides to help with the processing of command line arguments.

; When a Guile script is invoked, Guile makes the command line arguments accessible via the procedure command-line, which returns the arguments as a list of strings.

; For example, if the script

; #! /usr/local/bin/guile -s
; !#
(write (command-line))
(newline)

; is saved in a file cmdline-test.scm and invoked using the command line ./cmdline-test.scm bar.txt -o foo -frumple grob, the output is

; ("./cmdline-test.scm" "bar.txt" "-o" "foo" "-frumple" "grob")

; If the script invocation includes a -e option, specifying a procedure to call after loading the script, Guile will call that procedure with (command-line) as its argument. So a script that uses -e doesn’t need to refer explicitly to command-line in its code. For example, the script above would have identical behaviour if it was written instead like this:

; #! /usr/local/bin/guile \
; -e main -s
; !#
(define (main args)
  (write args)
  (newline))

; (Note the use of the meta switch \ so that the script invocation can include more than one Guile option: See The Meta Switch.)

; These scripts use the #! POSIX convention so that they can be executed using their own file names directly, as in the example command line ./cmdline-test.scm bar.txt -o foo -frumple grob. But they can also be executed by typing out the implied Guile command line in full, as in:

; $ guile -s ./cmdline-test.scm bar.txt -o foo -frumple grob

; or

; $ guile -e main -s ./cmdline-test2.scm bar.txt -o foo -frumple grob

; Even when a script is invoked using this longer form, the arguments that the script receives are the same as if it had been invoked using the short form. Guile ensures that the (command-line) or -e arguments are independent of how the script is invoked, by stripping off the arguments that Guile itself processes.

; A script is free to parse and handle its command line arguments in any way that it chooses. Where the set of possible options and arguments is complex, however, it can get tricky to extract all the options, check the validity of given arguments, and so on. This task can be greatly simplified by taking advantage of the module (ice-9 getopt-long), which is distributed with Guile, See The (ice-9 getopt-long) Module.
