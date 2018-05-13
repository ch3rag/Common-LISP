;FILE I/O

(with-open-file (my-stream
	"text.txt"
	:direction :output
	:if-exists :supersede)
(princ "HELLO THERE, THIS IS LISP!"))

(let ((in (open "text.txt" :if-does-not-exist nil)))
	(when in
		(loop for line = (read-line in nil)
			while line do (format t "~a~%" line))
		(close in)))
