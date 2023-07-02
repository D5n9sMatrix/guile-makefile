; 4.2.2 Environment Variables

; The environment is a feature of the operating system; it consists of a collection of variables with names and values. Each variable is called an environment variable (or, sometimes, a “shell variable”); environment variable names are case-sensitive, and it is conventional to use upper-case letters only. The values are all text strings, even those that are written as numerals. (Note that here we are referring to names and values that are defined in the operating system shell from which Guile is invoked. This is not the same as a Scheme environment that is defined within a running instance of Guile. For a description of Scheme environments, see Names, Locations, Values and Environments.)

; How to set environment variables before starting Guile depends on the operating system and, especially, the shell that you are using. For example, here is how to tell Guile to provide detailed warning messages about deprecated features by setting GUILE_WARN_DEPRECATED using Bash:

; $ export GUILE_WARN_DEPRECATED="detailed"
; $ guile

; Or, detailed warnings can be turned on for a single invocation using:

; $ env GUILE_WARN_DEPRECATED="detailed" guile

; If you wish to retrieve or change the value of the shell environment variables that affect the run-time behavior of Guile from within a running instance of Guile, see Runtime Environment.

; Here are the environment variables that affect the run-time behavior of Guile:

; GUILE_AUTO_COMPILE

;    This is a flag that can be used to tell Guile whether or not to compile Scheme source files automatically. Starting with Guile 2.0, Scheme source files will be compiled automatically, by default.

;    If a compiled (.go) file corresponding to a .scm file is not found or is not newer than the .scm file, the .scm file will be compiled on the fly, and the resulting .go file stored away. An advisory note will be printed on the console.

;    Compiled files will be stored in the directory $XDG_CACHE_HOME/guile/ccache, where XDG_CACHE_HOME defaults to the directory $HOME/.cache. This directory will be created if it does not already exist.

;    Note that this mechanism depends on the timestamp of the .go file being newer than that of the .scm file; if the .scm or .go files are moved after installation, care should be taken to preserve their original timestamps.

;    Set GUILE_AUTO_COMPILE to zero (0), to prevent Scheme files from being compiled automatically. Set this variable to “fresh” to tell Guile to compile Scheme files whether they are newer than the compiled files or not.

;    See Compiling Scheme Code.
; GUILE_HISTORY

;    This variable names the file that holds the Guile REPL command history. You can specify a different history file by setting this environment variable. By default, the history file is $HOME/.guile_history.
; GUILE_INSTALL_LOCALE

;    This is a flag that can be used to tell Guile whether or not to install the current locale at startup, via a call to (setlocale LC_ALL "")2. See Locales, for more information on locales.

;    You may explicitly indicate that you do not want to install the locale by setting GUILE_INSTALL_LOCALE to 0, or explicitly enable it by setting the variable to 1.

;    Usually, installing the current locale is the right thing to do. It allows Guile to correctly parse and print strings with non-ASCII characters. Therefore, this option is on by default.
; GUILE_LOAD_COMPILED_PATH

 ;   This variable may be used to augment the path that is searched for compiled Scheme files (.go files) when loading. Its value should be a colon-separated list of directories. If it contains the special path component ... (ellipsis), then the default path is put in place of the ellipsis, otherwise the default path is placed at the end. The result is stored in %load-compiled-path (see Load Paths).

;    Here is an example using the Bash shell that adds the current directory, ., and the relative directory ../my-library to %load-compiled-path:

;     $ export GUILE_LOAD_COMPILED_PATH=".:../my-library"
;     $ guile -c '(display %load-compiled-path) (newline)'
;     (. ../my-library /usr/local/lib/guile/3.0/ccache)

; GUILE_LOAD_PATH

;    This variable may be used to augment the path that is searched for Scheme files when loading. Its value should be a colon-separated list of directories. If it contains the special path component ... (ellipsis), then the default path is put in place of the ellipsis, otherwise the default path is placed at the end. The result is stored in %load-path (see Load Paths).

;    Here is an example using the Bash shell that prepends the current directory to %load-path, and adds the relative directory ../srfi to the end:

;    $ env GUILE_LOAD_PATH=".:...:../srfi" \
;     guile -c '(display %load-path) (newline)'
;    (. /usr/local/share/guile/3.0 \
;     /usr/local/share/guile/site/3.0 \
;     /usr/local/share/guile/site \
;     /usr/local/share/guile \
;    ../srfi)

;     (Note: The line breaks, above, are for documentation purposes only, and not required in the actual example.)
; GUILE_EXTENSIONS_PATH

;     This variable may be used to augment the path that is searched for foreign libraries via load-extension, dynamic-link, load-foreign-library, or the like. Its value should be a colon-separated (semicolon on Windows) list of directories. See Foreign Libraries.
; GUILE_WARN_DEPRECATED

;    As Guile evolves, some features will be eliminated or replaced by newer features. To help users migrate their code as this evolution occurs, Guile will issue warning messages about code that uses features that have been marked for eventual elimination. GUILE_WARN_DEPRECATED can be set to “no” to tell Guile not to display these warning messages, or set to “detailed” to tell Guile to display more lengthy messages describing the warning. See Deprecation.
; HOME

;    Guile uses the environment variable HOME, the name of your home directory, to locate various files, such as .guile or .guile_history.
; GUILE_JIT_THRESHOLD

;    Guile has a just-in-time (JIT) code generator that makes running Guile code fast. See Just-In-Time Native Code, for more. The unit of code generation is the function. Each function has its own counter that gets incremented when the function is called and at each loop iteration in the function. When the counter exceeds the GUILE_JIT_THRESHOLD, the function will get JIT-compiled. Set GUILE_JIT_THRESHOLD to -1 to disable JIT compilation, or 0 to eagerly JIT-compile each function as it’s first seen.
; GUILE_JIT_LOG

;     Set to 1, 2, or 3 to give increasing amounts of logging for JIT compilation events. Used for debugging.
; GUILE_JIT_STOP_AFTER

;    Though we have tested the JIT compiler as well as we can, it’s possible that it has bugs. If you suspect that Guile’s JIT compiler is causing your program to fail, set GUILE_JIT_STOP_AFTER to a positive integer indicating the maximum number of functions to JIT-compile. By bisecting over the value of GUILE_JIT_STOP_AFTER, you can pinpoint the precise function that is being miscompiled.


