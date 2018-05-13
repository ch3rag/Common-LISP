;DATA STRUCTURES

;ARRAYS

(defparameter myArray (make-array 3))

(setf (aref myArray 0) "CHIRAG")
(setf (aref myArray 1) "BHARAT")
(setf (aref myArray 2) "AMAR")


(dotimes (i 3)
	(format t "A[~a] : ~a ~%" i (aref myArray i)))

;INITIALIZATION

(setf myArray (make-array 2
	:initial-contents '(23 45)))

(dotimes (i 2)
	(format t "A[~a] : ~a ~%" i (aref myArray i)))


;2-D ARRAYS

(setf myArray (make-array '(3 3)
	:initial-contents '((1 2 3) (4 5 6) (7 8 9))))

(dotimes (i 3)
	(dotimes (j 3)
		(format t "A[~a][~a] : ~a ~%" i j (aref myArray i j))))

;HASH TABLES 

(defparameter myHashTable (make-hash-table))

(setf (gethash '102 myHashTable) '(Chirag Singh))
(setf (gethash '103 myHashTable) '(Bharat Singh))

(format t "~a ~%" (gethash '103 myHashTable))

(maphash (lambda (key value)
	(format t "KEY : ~a Value : ~a ~%" key value)) myHashTable)

;REMOVING ITEMS

(remhash '102 myHashTable)

;STRUCTURES

(defstruct employee id name age)

;AUTOMATICALLY CREATS GENERIC MAKERS, ACCESSORS etc.

(setq emp_1 (make-employee
	:id 1
	:name "CHIRAG SINGH"
	:age 20))

(format t "EMPLOYEE NAME : ~a ~%ID : ~a ~%AGE : ~a ~%"
	(employee-name emp_1)
	(employee-id emp_1)
	(employee-age emp_1))

(write emp_1)
;PRINTS STRUCT TO CONSOLE
