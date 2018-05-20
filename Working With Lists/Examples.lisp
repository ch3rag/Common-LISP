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



; >>> (compress '(a a a a a b b b c c c c c d d a a a))
; (a b c d a)

(defun compress (sequence)
	(cond ((null sequence) '())
		((equal (car sequence) (car (cdr sequence))) (compress (cdr sequence)))
		(t (cons (car sequence) (compress (cdr sequence))))))
		
; >>> (pack '(a a a a b c c a a d e e e e))
; ((A A A A) (B) (C C) (A A) (D) (E E E E))

(defun pack-helper (sequence)
	(cond ((null sequence) '())
		((equal (car sequence) (car (cdr sequence))) (cons (car sequence) (pack-helper (cdr sequence))))
		(t (list (car sequence)))))

(defun pack-check (sequence)
	(if (equal (car sequence) (car (cdr sequence))) (pack-check (cdr sequence))
		(cdr sequence)))

(defun pack (sequence)
	(if (null sequence) '()
		(cons (pack-helper sequence) (pack (pack-check sequence)))))


; >>> (length-encode '(a a a a b b b c d d d d d))
; ((4 a)(3 b)(5 d))

(defun length-encode-helper (sequence length)
	(cond ((null sequence) '())
		((equal (car sequence) (car (cdr sequence))) (setf length (+ 1 length)) (length-encode-helper (cdr sequence) length))
		(t (list (1+ length) (car sequence)))))

(defun length-encode (sequence)
	(if (null sequence) '()
	(cons (length-encode-helper sequence 0) (length-encode (length-encode-check (cdr sequence))))))


(defun length-encode-check (sequence)
	(if (equal (car sequence) (car (cdr sequence))) (length-encode-check (cdr sequence))
		(cdr sequence)))

		

