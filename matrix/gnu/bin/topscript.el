; 4.3.1 The Top of a Script File

; The first line of a Guile script must tell the operating system to use Guile to evaluate the script, and then tell Guile how to go about doing that. Here is the simplest case:

;    The first two characters of the file must be ‘#!’.

;    The operating system interprets this to mean that the rest of the line is the name of an executable that can interpret the script. Guile, however, interprets these characters as the beginning of a multi-line comment, terminated by the characters ‘!#’ on a line by themselves. (This is an extension to the syntax described in R5RS, added to support shell scripts.)
;    Immediately after those two characters must come the full pathname to the Guile interpreter. On most systems, this would be ‘/usr/local/bin/guile’.
;    Then must come a space, followed by a command-line argument to pass to Guile; this should be ‘-s’. This switch tells Guile to run a script, instead of soliciting the user for input from the terminal. There are more elaborate things one can do here; see The Meta Switch.
;    Follow this with a newline.
;    The second line of the script should contain only the characters ‘!#’ — just like the top of the file, but reversed. The operating system never reads this far, but Guile treats this as the end of the comment begun on the first line by the ‘#!’ characters.
;    If this source code file is not ASCII or ISO-8859-1 encoded, a coding declaration such as coding: utf-8 should appear in a comment somewhere in the first five lines of the file: see Character Encoding of Source Files.
;    The rest of the file should be a Scheme program. 

; Guile reads the program, evaluating expressions in the order that they appear. Upon reaching the end of the file, Guile exits. 
