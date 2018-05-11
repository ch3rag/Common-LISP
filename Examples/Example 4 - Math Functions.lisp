;Mathematical Functions 

(format t "(+ 2 3) = ~a ~%" (+ 2 3))
;5

(format t "(- 7 8) = ~a ~%" (- 7 8))
;-1

(format t "(/ 5 4) = ~a ~%" (/ 5 4))
;5/4

(format t "(/ 5 4.0) = ~a ~%" (/ 5 4.0))
;1.25

(format t "(* 2 3) = ~a ~%" (* 2 3))
;6

(format t "(mod 17 3) = ~a ~%" (mod 17 3))
;2

(format t "(rem 17 3) = ~a ~%" (rem 17 3))
;2

(format t "(expt 4 2) = ~a ~%" (expt 4 2))
;16

(format t "(sqrt 81) = ~a ~%" (sqrt 81))
;9

(format t "(exp 1) = ~a ~%" (exp 1))
;2.7182817

(format t "(eq 'Hello 'Hello) = ~a ~%" (eq 'Hello 'Hello))
;T

(format t "(floor 5.5) = ~a ~%" (floor 5.5))
;5

(format t "(ceiling 5.5) = ~a ~%" (ceiling 5.5))
;6

(format t "(max 5 10) = ~a ~%" (max 5 10))
;10

(format t "(min 5 10) = ~a ~%" (min 5 10))
;5

(format t "(oddp 5) = ~a ~%" (oddp 5))
;T

(format t "(evenp 5) = ~a ~%" (evenp 5))
;NIL

(format t "(numberp 2) = ~a ~%" (numberp 2))
;T

(format t "(null nil) = ~a ~%" (null nil))
;T

(format t "(log 1000 10) = ~a ~%" (log 1000 10))
;3

;Some Other Functions
;sin, cos, tan, asin, acos, atan
