;Last Item In List

(defun last-item(x)
    (if (equal (cdr x) NIL) x
    (last-item (cdr x))))

;(print (last-item '(1 2 3 4)))

;Find the last but one box of a list.

(defun last-two-items (x)
    (if (equal (cdr (cdr x)) NIL) x
    (last-two-items (cdr x))))

;(print (last-two-items '(1 2 3 4)))

;Find the K'th element of a list.

(defun kth(x k)
    (cond 
        ((null x) NIL)
        ((< k 0) NIL)
        ((>= k (length x)) NIL)
        ((= k 0) (car x))
        (t (kth (cdr x) (- k 1)))))

;(print (kth '(1 2 3 4) 4))


;Find the number of elements of a list.

(defun num-elements(x)
    (if (null x) 0
    (1+ (num-elements (cdr x)))))

;(print (num-elements '(1 2 3 4 5 6)))

;Reverse a list

(defun list-reverse (x)
    (if (null x) '()
        (append (list-reverse (cdr x)) (list (car x)))))

;(print (list-reverse '(1 2 3 4 5)))


(defun is-palindrome (x)
    (if (equal  x (list-reverse x)) t nil))
    
;(print (is-palindrome '(1 2 3 3 2 1)))

;Flatten a nested list structure.

(defun flatten (x)
    (cond 
        ((null x) '())
        ((listp (car x)) (append (flatten (car x)) (flatten (cdr x))))
        (t (cons (car x) (flatten (cdr x))))))

;(print (flatten '((1) 2 ((3) 3) ((2)) 1)))

;Eliminate consecutive duplicates of list elements.
(defun compress(x) 
    (cond 
        ((null x) '())
        ((equal (car x) (cadr x)) (compress (cdr x)))
        (t (cons (car x) (compress (cdr x))))))

;(print (compress '(1 1 1 2 2 3 3 3 3 4 4 5 5 6)))

;Pack consecutive duplicates of list elements into sublists.

(defun pack(x)
    (if (null x) '()
        (cons (pack-helper x) (pack (pack-check x)))))

(defun pack-helper (x)
        (if (equal (car x) (cadr x)) (cons (car x) (pack-helper (cdr x)))
        (list (car x))))

(defun pack-check (x)
        (if (equal (car x) (cadr x)) (pack-check (cdr x))
        (cdr x)))

;Run Length Encoding of a list

(defun encoding-helper (x)
    (if (equal (car x) (cadr x)) (list (1+ (car (encoding-helper (cdr x)))) (car x))
    (list 1 (car x))))

(defun length-encoding (x)
    (if (null x) '()
    (cons (encoding-helper x) (length-encoding (pack-check x)))))  




;Modified Length Encoding (Considering Atoms as "ATOMS ONLY")      

(defun modified-length-encoding-helper (x)
    (cond
    ((equal (car x) (cadr x)) (list (1+ (car (modified-length-encoding-helper (cdr x)))) (car x)))
    (t (list 1 (car x)))))

(defun modified-length-encoding-check (x)
    (cond
    ((null x) '())
    ((equal (car x) (cadr x)) (modified-length-encoding-check (cdr x)))
    (t (cdr x))))


(defun modified-length-encoding (x)
    (cond 
    ((null  x) '())
    ((equal (car x) (cadr x)) (cons (modified-length-encoding-helper x) (modified-length-encoding (modified-length-encoding-check x))))
    (t (cons (car x) (modified-length-encoding (modified-length-encoding-check x))))))


; Length Encoded List Decoder

(defun decoder-helper (n x)
    (if (= 1 n) x
    (decoder-helper (1- n) (cons (car x) x))))

(defun decoder (x)
    (cond 
    ((null x) '())
    ((listp (car x)) (append (decoder-helper (car (car x)) (cdr (car x))) (decoder (cdr x))))
    (t (cons (car x) (decoder (cdr x))))))
    
; Duplicate The Elements of a List

(defun duplicate (x)
    (if (null x) x
    (cons (car x) (cons (car x) (duplicate (cdr x))))))

; Replicate The Elements of a List Given Number Of Times

(defun replicate-helper (e n)
    (if (= 0 n) '()
    (cons e (replicate-helper e (1- n)))))

(defun replicate (x n)
    (if (null x) x
    (append (replicate-helper (car x) n) (replicate (cdr x) n))))

; Drop Every Nth Elements

(defun drop-helper (x n m)
    (cond
        ((null x) '())
        ((= 0 (mod m n)) (drop-helper (cdr x) n (1+ m)))
        (t (cons (car x) (drop-helper (cdr x) n (1+ m))))))

(defun drop (x n)
    (if (null x) '()
        (drop-helper x n 1)))
    
; Spilt the list into two parts

(defun split (x n)
    (if (and (> n 0) (not (null x)))
    (destructuring-bind (left right) (split (cdr x) (1- n))
    ;(format t "X: ~a LEFT: ~a RIGHT: ~a~%" x left right)
    (list (cons (car x) left) right))
    `(() ,x)))
        
; Extract A Slice From A List

(defun slice (x n m)
    (cond
        ((null x) '())
        ((> n m) '())
        ((= n 1) (car (split x m)))
        (t (slice (cdr x) (1- n) (1- m))))) 

; Rotate A List N Times To The Left

(defun rotate (x n)
    (cond
    ((plusp n) (destructuring-bind (left right) (split x n) (append right left)))
    ((minusp n) (destructuring-bind (left right) (split x (+ (length x) n)) (append right left)))
    (t x)))

; Remove Nth Element

(defun remove-at (x n)
    (cond
        ((null x) '())
        ((= 1 n) (remove-at (cdr x) (1- n)))
        (t (cons (car x) (remove-at (cdr x) (1- n))))))

; Insert At Nth Position

(defun insert-at (n e x) 
    (cond
        ((null x) '())
        ((= n 1) (insert-at (1- n) e (cons e x)))
        (t (cons (car x) (insert-at (1- n) e (cdr x))))))

; Create a list containing all integers within a given range.

(defun range (n m)
    (if (> n m) '()
        (cons n (range (1+ n) m))))

; Extract a given number of randomly selected elements from a list.

(defun get-nth-elem (x n)
    (if (<= n 1) (car x)
        (get-nth-elem (cdr x) (1- n))))

(defun random-select (x n)
    (if (or (null x) (<= n 0)) '()
        (cons (get-nth-elem x (random (length x))) (random-select x (1- n)))))