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
	(cond ((null sequence) '())
		  ((equal (car sequence) (car (cdr sequence))) (length-encode-check (cdr sequence)))
		  (t (cdr sequence))))

; Modified run-length encoding
; >>> (encode-modified '(a a a a b c c a a d e e e e))
; ((4 A) B (2 C) (2 A) D (4 E))

(defun run-length-helper (sequence length)
	(cond ((null sequence) '())
		((equal (car sequence) (cadr sequence)) (setf length (1+ length)) (run-length-helper (cdr sequence) length))
		((= length 0) (car sequence))
		(t (list (1+ length) (car sequence)))))

(defun run-length (sequence)
	(if (null sequence) '()
	(cons (run-length-helper sequence 0) (run-length (run-length-check sequence)))))


(defun run-length-check (sequence)
	(cond ((null sequence) '())
		((equal (car sequence) (car (cdr sequence))) (run-length-check (cdr sequence)))
		(t (cdr sequence))))

; DECODING ABOVE LISTS

(defun decode-list-builder (length element)
	(if (= length 0) '()
		(cons element (decode-list-builder (- length 1) element))))


(defun decode-helper (sequence)
	(if (not (listp sequence)) (list sequence)
		(decode-list-builder (car sequence) (cadr sequence))))

(defun decode (sequence)
	(if (null sequence) '()
	 (append (decode-helper (car sequence)) (decode (cdr sequence)))))

; >>> (repli '(a b c) 3)
; (A A A B B B C C C)

(defun replicate-helper (element times)
	(if (= times 0) '()
		(cons element (replicate-helper element (- times 1)))))

(defun replicate (sequence times)
	(if (null sequence) '()
		(append (replicate-helper (car sequence) times) (replicate (cdr sequence) times))))


; Drop every N'th element from a list.
; >>> (drop '(a b c d e f g h i k) 3)
; (A B D E G H K)

(defun drop-helper (sequence position current)
	(cond ((= position 0) '()) 
		 ((null sequence) '())
		 ((= (mod current position) 0) (drop-helper (cdr sequence) position 1))
		 (t (cons (car sequence) (drop-helper (cdr sequence) position (+ 1 current))))))


(defun drop (sequence position)
	(if (null sequence) '()
		(drop-helper sequence position 1)))



; >>> (split '(a b c d e f g h i k) 3)
; ( (A B C) (D E F G H I K))

(defun split-before (sequence position)
	(if (= position 0) '()
	 (cons (car sequence) (split-before (cdr sequence) (- position 1)))))

(defun split-after (sequence position)
	(if (= position 0) sequence
		(split-after (cdr sequence) (- position 1))))


(defun split (sequence position)
	(if (< position 0) (setf position (+ (list-length sequence) position)))
	(cond ((null sequence) '())
		((<= position 0) '())
		((> position (list-length sequence)) sequence)
		(t (list (split-before sequence position) (split-after sequence position)))))


; >>> (slice '(a b c d e f g h i k) 3 7)
; (C D E F G)

(defun slice-helper (sequence start end &optional (initial 1))
	(cond ((or (> initial end) (null sequence))'())
		((>= initial start) (cons (car sequence) (slice-helper (cdr sequence) start end (1+ initial))))
		(t (slice-helper (cdr sequence) start end (1+ initial)))))

(defun slice (sequence start end)
	(cond ((null sequence) '())
		((> start end) '())
		(t (slice-helper sequence start end))))

; >>> (rotate '(a b c d e f g h) 3)
; (D E F G H A B C)

; >>> (rotate '(a b c d e f g h) -2)
; (G H A B C D E F)

(defun rotate (sequence position)
	(if (< position 0) (setf position (+ (list-length sequence) position)))
	(cond ((null sequence) '())
		((< position 0) '())
		((> position (list-length sequence)) sequence)
		(t (append (split-after sequence position) (split-before sequence position)))))


; >>> (remove-at '(a b c d) 2)
; (A C D)

(defun remove-at-helper (sequence position)
	(cond ((null sequence) '())
		((= position 1) (remove-at-helper (cdr sequence) (- position 1)))
		(t (cons (car sequence) (remove-at-helper (cdr sequence) (- position 1)))))) 

(defun remove-at (sequence position)
	(if (< position 0) (setf position (+ (list-length position) position)))
	(cond ((null sequence) '())
		((or (> position (list-length sequence)) (<= position 0)) sequence)
		(t (remove-at-helper sequence position))))

; >>> (insert-at 'alfa '(a b c d) 2)
; (A ALFA B C D)

(defun insert-at-helper (element sequence position)
	(cond ((null sequence) '())
		((= position 1) (cons element sequence))
		(t (cons (car sequence) (insert-at-helper element (cdr sequence) (- position 1))))))

(defun insert-at (element sequence position)
	(if (< position 0) (setf position (+ (list-length sequence) (+ position))))
	(cond ((null sequence) '())
		((or (> position (list-length sequence)) (< position 0)) sequence)
		(t (insert-at-helper element sequence position))))




		

