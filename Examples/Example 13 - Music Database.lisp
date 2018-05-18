
(defparameter *db* nil)

(defun make-cd (title artist rating ripped)
	(list :title title :artist artist :rating rating :ripped ripped))

(defun add-record (new)
	(push new *db*))

;SOME RECORDS EXAMPLE ==>

;(add-record (make-cd "Roses" "Kathy Mattea" 7 t))
;(add-record (make-cd "Fly" "Dixie Chicks" 8 t))
;(add-record (make-cd "Home" "Dixie Chicks" 9 t))

(defun dump-db()
	(dolist (cd *db*)
		(format t "~{~a : ~10t ~a~%~} ~%" cd)))


(defun prompt-read (prompt)
	(format *query-io* "~a : " prompt)
	(force-output *query-io*)
	(read-line *query-io*))

;*query-io* is a global variable that contains the input stream connected to the terminal.

(defun prompt-for-cd()
	(add-record (make-cd 
		(prompt-read "Title")
		(prompt-read "Artist")
		(or (parse-integer (prompt-read "Rating") :junk-allowed t) 0)
		(y-or-n-p  "Ripped"))))


(defun add-cds()
	(loop 
	(prompt-for-cd)
	(if (not (y-or-n-p "Another"))(return))))

(defun save-db (filename)
	(with-open-file (myStream filename
					:direction :output
					:if-exists :supersede)
	(with-standard-io-syntax
		(print *db* myStream))))

;Unlike FORMAT, PRINT prints Lisp objects in a form that can be read back in by the Lisp reader. 
;The macro WITH-STANDARD-IO-SYNTAX ensures that certain variables that affect the behavior of PRINT are set to their standard values.

(defun load-db (filename)
	(with-open-file (myStream filename)
		;Default Direction is Input So No Need To Specify
		(with-standard-io-syntax 
			(setf *db* (read myStream)))))


; QUERING THE DATABASE

(defun select-by-artist (name)
	(remove-if-not #'(lambda (record)
		(equal (getf record :artist) name)) *db*))


;CREATION OF WHERE (FROM SQL)

;THE PROBLEM WITH RIPPED ARGUMENT ==>

; Normally if a function is called with no argument for a particular keyword parameter, the parameter will have the value NIL.
; However, sometimes you'll want to be able to distinguish between a NIL that was explicitly passed as the argument to a keyword parameter and the default value NIL.
; To allow this, when you specify a keyword parameter you can replace the simple name with a list consisting of the name of the parameter, a default value, and another parameter name, called a supplied-p parameter.
; The supplied-p parameter will be set to true or false depending on whether an argument was actually passed for that keyword parameter in a particular call to the function.
; Here's a version of foo that uses this feature:

; (defun foo (&key a (b 20) (c 30 c-p)) (list a b c c-p))
; c-p will be set true or false based on whether c is passed or not as an argument
; b will be set to 20 and c will be set to 30 if no argument passed

; GENERALIZED SELECTOR 

(defun select (selector-fn)
	(remove-if-not selector-fn *db*))

; THE WHERE CLAUSE 

#||

;THIS IS KINDA UNEFFICIENT DUE TO UNNECESSARY COMPARISONS

(defun where (&key title artist rating (ripped nil ripped-p))
	#'(lambda (cd)
		(and 
			(if title (equal (getf cd :title) title)   t)
			(if artist (equal (getf cd :artist) artist) t)
			(if rating (equal (getf cd :rating) rating) t)
			(if ripped-p (equal (getf cd :ripped) ripped) t))))


||#

; WHERE USING MACRO
; GENERATES ONLY THE COMPARISIONS BASED OF ARGUMENTS PASSED


(defun make-comparision-exp (field value)
	`(equal (getf cd ,field) ,value))

;>>>(make-comparison-expr :rating 10)
;	(EQUAL (GETF CD :RATING) 10)

(defun make-comparision-list (fields)
	(loop while fields
		collect (make-comparision-exp (pop fields) (pop fields))))



(defmacro where (&rest clauses)
	`#'(lambda (cd)
		 (and ,@(make-comparision-list clauses))))





;UPDATE FUNTION 



(defun update (selector-fn &key title artist rating (ripped nil ripped-p))
	(setf *db*
		(mapcar
			#'(lambda (row)
				(when (funcall selector-fn row)
					(if title    (setf (getf row :title) title))
					(if artist   (setf (getf row :artist) artist))
					(if rating   (setf (getf row :rating) rating))
					(if ripped-p (setf (getf row :ripped) ripped))) row) *db*)
		))

;DELETE ENTRY

(defun delete-rows (selector-fn)
	(setf *db* (remove-if selector-fn *db*)))
	
