
(defvar *test-name* nil)

(defmacro combine-results (&body forms)
	(with-gensyms (result)
		`(let ((result t))
			,@(loop for f in forms collect `(unless ,f (setf result nil))) 
			 result)))

(defun report-result (result form)
	(format t "~:[FAIL~;PASS~] ... ~a : ~a~%" result *test-name* form) result)

(defmacro check (&body body) 
	`(combine-results ,@(loop for f in body collect `(report-result ,f ',f))))


(defmacro deftest (test-name parameters &body body)
	`(defun ,test-name ,parameters
		(let ((*test-name* (append *test-name* (list ',test-name))))
			,@body)))

(deftest test-+ ()
		(check 
			(= (+ 1 2) 3) 
			(= (+ 1 2 3) 6)
			(= (+ -1 -3) -5)))

(deftest test-* ()
	(check
		(= (* 2 3) 6)
		(= (* 1 4 3) 12)
		(= (* 9 9) 81)))

(deftest test-arithmetic () 
	(combine-results 
	(test-+)
	(test-*)))
