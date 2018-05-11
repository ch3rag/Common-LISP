;Program To Read Name From User And Print Hello

(format t "What's Your Name ? : ")

(defvar *name* (read))
;* * are used as naming convection for global variables

(defun sayHello (*name*)
	(format t "Hello, ~a!~%" *name*))

(sayHello *name*)
