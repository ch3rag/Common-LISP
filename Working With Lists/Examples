;Find the last box of a list.

(defun last-item (sequence)
	(if (null (cdr sequence)) (car sequence)
		(last-item (cdr sequence))))

; >>> (join (1 2 3) (a b c))
; ((1 a ) (2 b) (3 c))

(defun join (seq1 seq2)
	(if (or (null seq1) (null seq2)) '()
		(cons (list (car seq1) (car seq2)) (join (cdr seq1) (cdr seq2)))))

#||

(defun last-second (sequence)
	(cond ((null sequence) sequence)
		((null (cdr sequence)) sequence)
		((null (cdr (cdr sequence))) sequence)
		(t (last-second (cdr sequence)))))

||#

; >>>(last-second '(a b c d e))
; (d e)

(defun last-second (sequence)
	(if (or (null sequence) (null (cdr sequence)) (null (cdr (cdr sequence)))) sequence
	(last-second (cdr sequence))))

; >>> (kth '(a b c d e) 3)
; (d)

(defun kth (sequence index)
	(if (or (= index 0) (null sequence)) (car sequence)
		(kth (cdr sequence) (- index 1))))


; >>> (number-of-element '(a b c d e))
; 5

(defun number-of-element (sequence)
	(let ((y 0))
		(loop for x in sequence do 
			(setf y (+ 1 y))) y))

(defun transverse (sequence)
	(loop for x in sequence do
		(print x)))

; >>> (list-reverse '(1 2 3 4 5))
; (5 4 3 2 1)

(defun list-reverse (sequence)
	(if (null sequence) '()
	(append (list-reverse (cdr sequence)) (list (car sequence)))))

; >>> (is-palindrome '(X A M A X))
; T

(defun is-palindrome (sequence)
	(if (equal sequence (list-reverse sequence)) t
		nil))

; >>> (flatten '(a (b c (d e))))
; (a b c d e)	

(defun flatten (sequence)
	(cond ((null sequence) '())
		((listp (car sequence)) (append (flatten (car sequence)) (flatten (cdr sequence))))
		(t (append (list (car sequence)) (flatten (cdr sequence))))))


		

