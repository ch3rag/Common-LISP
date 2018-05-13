;MACROS

;Solving progn and if-else problem using macros and quasi-quoting

(defvar *age* 18)


(if (>= *age* 18)
	(progn 
		(print "CONGRATS!")
		(print "YOU ARE AUTHORISED TO DRIVE!"))
	(progn 
		(print "SORRY!")
		(print "YOU ARE NOT AUTHORISED TO DRIVE!")))


;USING MACROS

(defmacro ifit (condition &rest body)
	`(if ,condition (progn ,@body)))

(ifit (>= *age* 18)
	(print "CONGRATS!")
	(print "YOU ARE AUTHORISED TO DRIVE!"))


;DEFINING LET USING MACROS

(defun add (num_1 num_2) 
	(let ((sum (+ num_1 num_2)))
	(format t "~%~a + ~a = ~a ~%" num_1 num_2 sum)))

(add 1 2)

;USING MACRO

(defmacro letx (val1 val2 &rest body)
	`(let ((,val1 ,val2)) ,@body))

(defun difference (num_1 num_2)
	(letx dif 
		(- num_1 num_2) 
		(format t "~a - ~a = ~a ~%" num_1 num_2 dif)))

(difference 3 2)

