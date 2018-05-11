;Data-Type

;Declaration

;setq function is used to Lexical Scoping (Block Scope)

;defvar fuction is used for Global or Dynamic Scoping


(setq a 10)
(setq b 1.23)
(setq c "Hello, World!")
(setq d NIL)
(setq e 11.4e+3)

;type-of function return the type of object
;print function is preceeded by a new line
;(format NIL "~%") can also be used to print new lines

(print (type-of a))
;(INTEGER 0 281474976710655) 

(print (type-of b))
;SINGLE-FLOAT 

(print (type-of c))
;SIMPLE-BASE-STRING 13

(print (type-of d))
;NULL

(print (type-of e))
;SINGLE-FLOAT 
