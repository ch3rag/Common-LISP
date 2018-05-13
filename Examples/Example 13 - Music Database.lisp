
(defparameter *db* nil)

(defun make-cd (title artist rating ripped)
	(list :title title :artist artist :rating rating :ripped ripped))

(defun add-record (new)
	(push new *db*))

;(add-record (make-cd "Roses" "Kathy Mattea" 7 t))
;(add-record (make-cd "Fly" "Dixie Chicks" 8 t))
;(add-record (make-cd "Home" "Dixie Chicks" 9 t))

(defun dump-dp()
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

(defun menu()
	(loop
	(format t "~%::MUSIC CD DATABASE::~%1. ADD CDS~%2. VIEW DATABASE~%3. SAVE DATABASE~%4. LOAD DATABASE~%5. EXIT~%ENTER CHOICE :")
	(setf choice (read))
	(case choice
		(1 (funcall #'add-cds))
		(2 (funcall #'dump-dp))
		(3 (funcall #'save-db "myDB"))
		(4 (funcall #'load-db "myDB"))
		(5 (return 0))
		(otherwise (format t "WRONG CHOICE!")))))

(menu)


;To Be Continued...
