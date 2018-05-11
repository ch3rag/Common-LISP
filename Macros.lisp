;MACROS 

;defmacro function is used to define MACROS

;MACRO defintion Starts

(defmacro setTo20(num) 
	(setq num 20)
	(print num)
	)

;END OF DEFINITION

(setq num 10)
(print num)
(setTo20 num) 
;RETURNS 10


(defmacro incrementBy(num value) 
	(print (+ num value)))

(incrementBy 10 5)
;Prints 15

(defmacro printEight()
	(print(+ 3 5)))

(printEight)
;Prints 8

(defmacro printTen()
	'(+ 5 5))

(print (printTen))
;Expands to (print (+ 5 5))
;Which is then evaluated and printed
