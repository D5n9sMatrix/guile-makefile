; 4.4.2 Readline

; To make it easier for you to repeat and vary previously entered expressions, or to edit the expression that you’re typing in, Guile can use the GNU Readline library. This is not enabled by default because of licensing reasons, but all you need to activate Readline is the following pair of lines.

; scheme@(guile-user)> (use-modules (ice-9 readline))
; scheme@(guile-user)> (activate-readline)

; It’s a good idea to put these two lines (without the scheme@(guile-user)> prompts) in your .guile file. See The Init File, ~/.guile, for more on .guile.

