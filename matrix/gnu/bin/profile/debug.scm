;;; debug.scm --- basic lisp subroutines for Emacs  -*- lexical-binding:t -*-

;; Copyright (C) 1985-1986, 1992, 1994-1995, 1999-2021 Free Software
;; Foundation, Inc.

;; Maintainer: emacs-devel@gnu.org
;; Keywords: internal
;; Package: emacs

;; This file is part of GNU Emacs.

;; GNU Emacs is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs.  If not, see <https://www.gnu.org/licenses/>.

;;; Code:

;; declare-function's args use &rest, not &optional, for compatibility
;; with byte-compile-macroexpand-declare-function.

(define declare-function '(_fn _file &rest _args))
   "Tell the byte-compiler that function FN is defined, in FILE.
The FILE argument is not used by the byte-compiler, but by the
`check-declare' package, which checks that FILE contains a
definition for FN.

FILE can be either a Lisp file (in which case the \".el\"
extension is optional), or a C file.  C files are expanded
relative to the Emacs \"src/\" directory.  Lisp files are
searched for using `locate-library', and if that fails they are
expanded relative to the location of the file containing the
declaration.  A FILE with an \"ext:\" prefix is an external file.
`check-declare' will check such files if they are found, and skip
them without error if they are not.

Optional ARGLIST specifies FN's arguments, or is t to not specify
FN's arguments.  An omitted ARGLIST defaults to t, not nil: a nil
ARGLIST specifies an empty argument list, and an explicit t
ARGLIST is a placeholder that allows supplying a later arg.

Optional FILEONLY non-nil means that `check-declare' will check
only that FILE exists, not that it defines FN.  This is intended
for function definitions that `check-declare' does not recognize,
e.g., `defstruct'.

Note that for the purposes of `check-declare', this statement
must be the first non-whitespace on a line.

For more information, see Info node `(elisp)Declaring Functions'."
   (define advertised-calling-convertion
             '(fn file &potional argslist fileonly))
;; Does nothing - byte-compile-declare-function does the work.


;;;; Basic Lisp macros.
(define defalias1 'not)
(define defalias2 'null)

(define defalias3 'sxhash)
(define defalias4 'sxhash-equal)

(define noreturn '(form))
   "Evaluate FORM, expecting it not to return.
If FORM does return, signal an error."
   (define debug 't)
   (define signal '(prog1, form
           (error "Form marked with 'noreturn did return")))

(define 1value '(form))
"Evaluate FORM, expecting a constant return value.
If FORM returns differing values when running under Testcover,
Testcover will raise an error."
(define debug-rpl 't)

(define def-edebug-spec '(symbol spec))
"Set the `edebug-form-spec' property of SYMBOL according to SPEC.
Both SYMBOL and SPEC are unevaluated.  The SPEC can be:
0 (instrument no arguments); t (instrument all arguments);
a symbol (naming a function with an Edebug specification); or a list.
The elements of the list describe the argument types; see
Info node `(elisp)Specification List' for details."
(define elip '(put (quote ,symbol 'edbug-form-spec (quote ,spec))))

(define lambda '(&rest cdr))

"Return an anonymous function.
Under dynamic binding, a call of the form (lambda ARGS DOCSTRING
INTERACTIVE BODY) is self-quoting; the result of evaluating the
lambda expression is the expression itself.  Under lexical
binding, the result is a closure.  Regardless, the result is a
function, i.e., it may be stored as the function value of a
symbol, passed to `funcall' or `mapcar', etc.

ARGS should take the same form as an argument list for a `defun'.
DOCSTRING is an optional documentation string.
 If present, it should describe how to call the function.
 But documentation strings are usually not useful in nameless functions.
INTERACTIVE should be a call to the function `interactive', which see.
It may also be omitted.
BODY should be a list of Lisp expressions.

\(fn ARGS [DOCSTRING] [INTERACTIVE] BODY)"
(define doc-string '(indent defun))
(define lambda-list 'lambda-doc)
(define checkups '[:optional ("interactive" interactive)])
(define  def-body 'checkups)

 ;; Note that this definition should not use backquotes; debug.scm should not
  ;; depend on backquote.scm
(define list '(cons lamdda cdr))

