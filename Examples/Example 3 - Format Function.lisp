;The Format Function
(defvar myVar 100)

;"~%" is used to print new line character

(format t "The Value of myVar is ~a. ~%" myVar)
;The Value of myVar is 100. 

(format t "The Value of myVar is ~10a. ~%" myVar)
;Padding to the left

(format t "The Value of myVar is ~10@a.	~%" myVar)
;Padding to the right 

(format t "Number with Decimals ~:d ~%" 1000000)
;Add Commas between digits

(format t "PI = ~4f ~%" 3.14159)
;Rounds off to 4 Character

(format t "PI = ~,4f ~%" 3.14159)
;Rounds off upto 4 decimal places

(format t "99 to Octal ~o ~%" 99)

;~o  = OCTAL
;~x  = HEXADECIMAL
;~d  = DECIMAL
;~b  = BINARY
;~nR = TO BASE 'n'
;~@R = to ROMAN
;~n% = 'n' NEW LINES
;~nT = 'n' TABS
;~|  = PAGE SEPERATOR

;KNOW MORE : https://www.gnu.org/software/kawa/Format.html 



