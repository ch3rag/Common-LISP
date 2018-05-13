;Functions 


(defun printHello ()
	(print "Hello!")
	(terpri))

(printHello)

(defun getAvg (num_1 num_2)
	(/ (+ num_1 num_2) 2))

(format t "AVERAGE OF 10 AND 20 IS ~a ~%" (getAvg 10 20))

(defun printList (w x &optional y z)
	;&optional defines optional parameters
	(format t "LIST IS : ~a ~%" (list w x y z)))

(printList 1 2 3)

(defvar total 0)

(defun sumList (&rest nums)
	;&rest turns passed parameters to a list
	(dolist (num nums)
		(setf total (+ total num)))
	(format t "TOTAL IS : ~a ~%" total))

(sumList 1 2 3 4 5)

(defun print-list (&optional &key x y z)
	(format t "LIST IS ~a ~%" (list x y z)))

(print-list :x 1 :z 2 :y 3)

;return-from <funtion_name> <expression> is used to return specific values from the function

(defun difference (num_1 num_2)
	(return-from difference (- num_1 num_2)))

(format t "10 - 2 is ~a ~%" (difference 10 2)) 

(defparameter *hero-size*
	'((Superman (6 ft 3 in)(230 lbs))
		(Flash (6 ft 0 in)(190 lbs))
		(Batman (6 ft 2 in)(210 lbs))))

;QUASI - QUOTING 

(defun get-hero-data (size)
	(format t "~a ~%" 
		`(,(caar size) 's Height is ,(cadar size) and weight is ,(caddar size))))

(get-hero-data *hero-size*)

;MAPCAR #`FUNCTION_NAME LIST
;MAPS A FUCNTION OVER A LIST

(defun is-a-number (&rest nums)
	(format t "Numbers Are : ~a ~%" (mapcar #'numberp nums)))	

(is-a-number 1 2 3 'a 'b 'c 6 7 8)

;flet is used to define local Functions

#||

	(flet 		((<function_1_name> (<args>)
				<statements>)
				(<function_2_name> (<args>)
				<statements>)
				...)
				;DEFINITION PART ENDS
				<statements>
				...)

||#


(flet ((double-it (num)
	(* num  2))
	(triple-it (num)
		(* num 3)))
	(format t "DOUBLE OF 10 IS ~a AND TRIPLE IS ~a" (double-it 10) (triple-it 10)))

;Labels is equivalent to flet except that the scope of the defined function names for labels encompasses the function definitions themselves as well as the body.


(labels ((double-it (num)
	(* num 2))
	(triple-it (num)
	(* 3 (double-it num))))
	(format t "DOUBLE AND TRIPLE 10 IS ~a ~%" (triple-it 10)))

;PASSING AND GETTING MULTIPLE VALUES FROM THE FUNCTIONS

(defun get-squares (num_1 num_2)
	(values (expt num_1 2) (expt num_2 2)))

(multiple-value-bind (square_of_num_1 square_of_num_2) (get-squares 4 7)
	(format t "SQUARE OF 4 IS ~a AND SQUARE OF 7 IS ~a ~%" square_of_num_1 square_of_num_2)) 


;HIGHER ORDER FUNCTIONS
;USING FUNCTIONS AS DATA


(defun times-3 (x) (* x 3))
(defun times-4 (x) (* x 4))

(defun multiples (mult-fun max-num)
	(dotimes (x max-num)
		(format t "~a : ~a ~%" x (funcall mult-fun x))))

(multiples #'times-3 10)

;LAMBDAS 
;Allows to create anonymous functions

(defvar myList '(1 2 3 4 5 6 7 8 9 10))

(print (mapcar (lambda (x)
			(* x 2)) myList))


