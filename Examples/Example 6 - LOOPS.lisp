;Loops

;FOR LOOP

(loop for x from 1 to 10
	do (format t "~a " x))

;Loop Until Certain Condition is TURE
(terpri)

(defvar x 1)

(loop
	   (format t "~a " x)
		(when (= x 10) (return x))
		(setf x (+ x 1)))


(terpri)

;dotimes function
;loops a fixed Number of times
;x initializes to zero by default

(dotimes (x 10)
	(format t "~a " x))

;LOOPING THROUGH A LIST

(defvar myList '(101 12 234 45 6 78))

(loop for item in myList do
	(print item))
