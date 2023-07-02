; 4.2.1 Command-line Options

; Here we describe Guile’s command-line processing in detail. Guile processes its arguments from left to right, recognizing the switches described below. For examples, see Scripting Examples.

; script arg...
; -s script arg...

;    By default, Guile will read a file named on the command line as a script. Any command-line arguments arg... following script become the script’s arguments; the command-line function returns a list of strings of the form (script arg...).

;    It is possible to name a file using a leading hyphen, for example, -myfile.scm. In this case, the file name must be preceded by -s to tell Guile that a (script) file is being named.

;    Scripts are read and evaluated as Scheme source code just as the load function would. After loading script, Guile exits.
; -c expr arg...

;    Evaluate expr as Scheme code, and then exit. Any command-line arguments arg... following expr become command-line arguments; the command-line function returns a list of strings of the form (guile arg...), where guile is the path of the Guile executable.
; -- arg...

;    Run interactively, prompting the user for expressions and evaluating them. Any command-line arguments arg... following the -- become command-line arguments for the interactive session; the command-line function returns a list of strings of the form (guile arg...), where guile is the path of the Guile executable.
; -L directory

;    Add directory to the front of Guile’s module load path. The given directories are searched in the order given on the command line and before any directories in the GUILE_LOAD_PATH environment variable. Paths added here are not in effect during execution of the user’s .guile file.
; -C directory

;    Like -L, but adjusts the load path for compiled files.
; -x extension

;    Add extension to the front of Guile’s load extension list (see %load-extensions). The specified extensions are tried in the order given on the command line, and before the default load extensions. Extensions added here are not in effect during execution of the user’s .guile file.
; -l file

;    Load Scheme source code from file, and continue processing the command line.
; -e function

 ;   Make function the entry point of the script. After loading the script file (with -s) or evaluating the expression (with -c), apply function to a list containing the program name and the command-line arguments—the list provided by the command-line function.

;    A -e switch can appear anywhere in the argument list, but Guile always invokes the function as the last action it performs. This is weird, but because of the way script invocation works under POSIX, the -s option must always come last in the list.

;    The function is most often a simple symbol that names a function that is defined in the script. It can also be of the form (@ module-name symbol), and in that case, the symbol is looked up in the module named module-name.

;    As a shorthand you can use the form (symbol ...), that is, a list of only symbols that doesn’t start with @. It is equivalent to (@ module-name main), where module-name is (symbol ...) form. See Using Guile Modules and Scripting Examples.
; -ds

;    Treat a final -s option as if it occurred at this point in the command line; load the script here.

;    This switch is necessary because, although the POSIX script invocation mechanism effectively requires the -s option to appear last, the programmer may well want to run the script before other actions requested on the command line. For examples, see Scripting Examples.
; \

;    Read more command-line arguments, starting from the second line of the script file. See The Meta Switch.
; --use-srfi=list

;    The option --use-srfi expects a comma-separated list of numbers, each representing a SRFI module to be loaded into the interpreter before evaluating a script file or starting the REPL. Additionally, the feature identifier for the loaded SRFIs is recognized by the procedure cond-expand when this option is used.

;    Here is an example that loads the modules SRFI-8 (’receive’) and SRFI-13 (’string library’) before the GUILE interpreter is started:

;    guile --use-srfi=8,13

; --r6rs

;    Adapt Guile’s initial environment to better support R6RS. See Incompatibilities with the R6RS, for some caveats.
; --r7rs

;    Adapt Guile’s initial environment to better support R7RS. See Incompatibilities with the R7RS, for some caveats.
; --debug

;    Start with the debugging virtual machine (VM) engine. Using the debugging VM will enable support for VM hooks, which are needed for tracing, breakpoints, and accurate call counts when profiling. The debugging VM is slower than the regular VM, though, by about ten percent. See VM Hooks, for more information.

;    By default, the debugging VM engine is only used when entering an interactive session. When executing a script with -s or -c, the normal, faster VM is used by default.
; --no-debug

;    Do not use the debugging VM engine, even when entering an interactive session.

;     Note that, despite the name, Guile running with --no-debug does support the usual debugging facilities, such as printing a detailed backtrace upon error. The only difference with --debug is lack of support for VM hooks and the facilities that build upon it (see above).
; -q

;    Do not load the initialization file, .guile. This option only has an effect when running interactively; running scripts does not load the .guile file. See The Init File, ~/.guile.
; --listen[=p]

;    While this program runs, listen on a local port or a path for REPL clients. If p starts with a number, it is assumed to be a local port on which to listen. If it starts with a forward slash, it is assumed to be the file name of a UNIX domain socket on which to listen.

;    If p is not given, the default is local port 37146. If you look at it upside down, it almost spells “Guile”. If you have netcat installed, you should be able to nc localhost 37146 and get a Guile prompt. Alternately you can fire up Emacs and connect to the process; see Using Guile in Emacs for more details.

;        Note: Opening a port allows anyone who can connect to that port to do anything Guile can do, as the user that the Guile process is running as. Do not use --listen on multi-user machines. Of course, if you do not pass --listen to Guile, no port will be opened.

;        Guile protects against the HTTP inter-protocol exploitation attack, a scenario whereby an attacker can, via an HTML page, cause a web browser to send data to TCP servers listening on a loopback interface or private network. Nevertheless, you are advised to use UNIX domain sockets, as in --listen=/some/local/file, whenever possible. 

;    That said, --listen is great for interactive debugging and development.
; --auto-compile

;    Compile source files automatically (default behavior).
; --fresh-auto-compile

;    Treat the auto-compilation cache as invalid, forcing recompilation.
; --no-auto-compile

;    Disable automatic source file compilation.
; --language=lang

;    For the remainder of the command line arguments, assume that files mentioned with -l and expressions passed with -c are written in lang. lang must be the name of one of the languages supported by the compiler (see Compiler Tower). When run interactively, set the REPL’s language to lang (see Using Guile Interactively).

;    The default language is scheme; other interesting values include elisp (for Emacs Lisp), and ecmascript.

;    The example below shows the evaluation of expressions in Scheme, Emacs Lisp, and ECMAScript:

;     guile -c "(apply + '(1 2))"
;     guile --language=elisp -c "(= (funcall (symbol-function '+) 1 2) 3)"
;     guile --language=ecmascript -c '(function (x) { return x * x; })(2);'

;    To load a file written in Scheme and one written in Emacs Lisp, and then start a Scheme REPL, type:

;    guile -l foo.scm --language=elisp -l foo.el --language=scheme

; -h, --help

;    Display help on invoking Guile, and then exit.
; -v, --version

;    Display the current version of Guile, and then exit.

    
