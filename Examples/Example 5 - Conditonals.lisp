;Conditionals
;progn is used to define multiple statements in one statements
;defparameter is similar to defvar
;Realtional Operators ==> ( = , > , < , >= , <= )
;Logical Operators ==> ( and , or , not )

(defparameter *num* 2)

(if (= *num* 2)
	;IF TRUE
	(progn (format t "YAY! ")					
			(format t "The Statement is True! ~%"))
	;ELSE
	(progn (format t "This statement") 				
			(format t "is not true. ~%")))

;Equalp ignores case senstivity and type check
;'chirag = 'CHIRAG
;1.0 = 1
;write-line function appends new line at the end

(if (and (= *num* 2) (equalp 'CHIRAG 'chirag))
	(write-line "TRUE!")
	(write-line "FALSE!"))

(setf *num* 1)

;case Statement

(defun foo(num)
	(case num
		(1 (write-line "ONE!"))
		(2 (write-line "TWO!"))
		(3 (write-line "THREE!"))
		(4 (write-line "FOUR!"))
		(5 (write-line "FIVE!"))
		(otherwise (write-line "UNDEFINED!"))))

(foo *num*)
;PRINTS ONE!

(foo 5)
;PRINTS FIVE!

(foo 100)
;PRINTS UNDEFINED!

;WHEN function
;Executes all statements when certain condition is met

(setf *num* 2)

(terpri)

(when (= 2 *num*)
	(print "I'm In WHEN STATEMENT")
	(print "Terpri is used to print new line after print"))

;UNLESS function
;Executes all statements when certain condition is NOT met

(unless (= *num* 10)
	(print "I'm in the UNLESS STATEMENT")
	(print "Bye Bye!"))

;COND STATEMENT 
;It is similar to if-else ladder

(defun checkVal (num)
	(cond 
		((> num 0) (print "Number is positive."))
		((< num 0) (print "Number is negative."))
		(t (print "Number is zero.")))) 
		;If All Conditions Fail 

(checkVal 10)
(checkVal -2)
(checkVal 0)



