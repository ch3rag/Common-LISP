(defvar myList '("Cricket" "Football" "Soccer" "Volleyball" "Chess"))

(setf myList (cons "Carrom" myList))
;Inserts Carrom at the front of the list
;cons creates a new list and doesn't affect orginal list
;Therefore we need to reset the value of myList

(print (car myList))
;("Carrom") ==>First Atom in the list

(print (cdr myList))
;("Cricket" "Football" "Soccer" "Volleyball" "Chess")
;Everything except first item

;Getting Second item

(print (cadr myList))

;Getting third item

(print (caddr myList))

;Check if a object is a list
;LISTP => T if object is a list else false

(if (listp myList) 
	(print "IS A LIST")
	(print "NOT A LIST"))

;LIST IS USED TO CREATE A NEW LIST

(print (list 1 2 "HEY"))

;MEMBER IS USED TO CHECK IF A ELEMENT IS A MEMBER OF THE LIST OR NOT

(setf myList '(1 2 3 4 5))

(if (member 4 myList)
	(print "4 IS A MEMBER OF myList")
	(print "4 IS NOT A MEMBER OF myList"))

;nth Function is used to get nth item from the list

(format t "~%4th ITEM IN myList is ~a" (nth 4 myList))

;Append is used to combine multiple lists

(print (append '(1 2) '(3 4 5) '(6 7 8)))

;Prints (1 2 3 4 5 6 7 8)

;Push is used to push items at front of a list

(defparameter *alpha* '("A" "B" "C" "D"))

(push "Z" *alpha*)

(print *alpha*)

;("Z" "A" "B" "C" "D")

;PLIST : Lisp has associated with each symbol a kind of tabular data structure called a property list (plist for short)

;SYNTAX ==> '(:KEY_1 ASSOCIATED_VALUE_1 :KEY_2 ASSOCIATED VALUE_2 ...)

(defparameter employee '(:ID 1 :name "David" :age 18 :gender "Male"))

(defvar *employee-list* nil)

(push employee *employee-list*)

(setf employee '(:ID 2 :name "Steven" :age 20 :gender "Male"))

(push employee *employee-list*)

(dolist (temp *employee-list*)
	(format t "~%~{~a : ~a ~}" temp))


;ALIST : An association list is a conventional data structure that is often used to implement simple key-value databases.
;It consists of a list of entries in which each entry is a pair. The key of each entry is the car of the pair and the value of each entry is the cdr.

#|| 

ASSOCIATION LIST ::=  '( (KEY1 . VALUE1)
                         (KEY2 . VALUE2)
                         (KEY3 . VALUE3)
                         …
                       )
||#

(defparameter employee '((name (Chris Clare))
						(age (18))
						(gender (Male))))


(format t "~%Name Data Employee is : ~a ~%" (assoc 'name employee))

(format t "Name of Employee is : ~a ~%" (cadr (assoc 'name employee)))


