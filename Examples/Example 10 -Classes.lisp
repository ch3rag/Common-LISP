;CLASSES 

#|| 

(defclass <class name> (<inherited_classes>,...)
	((<data_member_1>
		:initarg :<key>
		:initform: <default_value>
		:accessor <accessor_name>
		:reader <getter_name>
		:writer <setter_name>
		...
		)
	(data_member_2
		...
		)))
||#

(defclass animal()
	(name
	sound))

(defparameter *dog* (make-instance 'animal))

(setf (slot-value *dog* 'name) "Tommy")
(setf (slot-value *dog* 'sound) "Woof")

(format t "~a Says ~a! ~%"
	(slot-value *dog* 'name)
	(slot-value *dog* 'sound))


(defclass employee()
	((name
		:initarg :name ;defines key to be initialized form
		:initform (error "MUST PROVIDE A NAME!")
		:accessor employee-name ;creates getter and setters
		)
	(age 
		:initarg :age
		:initform "AGE NOT DEFINED!" ;if no args provided
		:reader get-employee-age
		:writer set-employee-age
		)))


(defparameter *emp_1* (make-instance 'employee :name "CHIRAG SINGH"))

(format t "EMPLOYEE NAME : ~a AND AGE : ~a ~%" (employee-name *emp_1*) (get-employee-age *emp_1*))

(set-employee-age 18 *emp_1*)
(setf (employee-name *emp_1*) "VISHAL SINGH")

(format t "EMPLOYEE NAME : ~a AND AGE : ~a ~%" (employee-name *emp_1*) (get-employee-age *emp_1*))

;GENERIC FUNCIONS
;Functions with name, arguments and empty body

(defgeneric print-employee-data (employee))

(defmethod print-employee-data ((emp employee))
	(format t "EMPLOYEE NAME : ~a AND AGE : ~a ~%" 
		(slot-value emp 'name)
		(slot-value emp 'age)))

(print-employee-data *emp_1*)

(defgeneric set-employee-name (newname employee))

(defmethod set-employee-name(name (emp employee))
	(setf (slot-value emp 'name) name))

(set-employee-name "BHARAT SINGH" *emp_1*)

(print-employee-data *emp_1*)

;INHERITANCE EXAMPLE

(defclass clerks (employee) ())

;CLERKS INHERIT BASE CLASS EMPLOYEE

(defparameter *clerk_1* (make-instance 'clerks :name "DAVID" :age 18))

(print-employee-data *clerk_1*)
