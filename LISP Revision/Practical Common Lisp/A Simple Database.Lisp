(defvar *db* nil)

(defun make-record (title artist rating ripped)
    (list :title title :artist artist :rating rating :ripped ripped))

(defun add-record (record)
    (push record *db*))

#||
(add-record (make-record "Roses" "Kathy Mattea" 7 t))
(add-record (make-record "Fly" "Dixie Chicks" 8 t))
(add-record (make-record "Home" "Dixie Chicks" 9 t))

(defun dump-db ()
    (dolist (record *db*)
        (format t "~{~a:~10t~a~%~}~%" record)))
OR
||#

(defun prompt-read (prompt) 
    (format *query-io* "~a: " prompt)
    (force-output *query-io*)
    (read-line *query-io*))

(defun prompt-for-record ()
    (make-record
        (prompt-read "TITLE")
        (prompt-read "ARTIST")
        (or (parse-integer (prompt-read "RATING") :junk-allowed t) 0)
        (y-or-n-p "RIPPED")))

(defun add-records ()
    (loop
        (add-record (prompt-for-record))
        (if (not (y-or-n-p "Add More")) (return))))

(defun save-db (filename)
    (with-open-file (out filename 
            :direction :output 
            :if-exists :supersede) 
        (with-standard-io-syntax (print *db* out))))

(defun load-db (filename)
    (with-open-file (in filename)
        (with-standard-io-syntax 
            (setf *db* (read in)))))

#||
(defun select-by-artist (artist)
    #'(lambda (record)
        (equal (getf record :artist) artist)))
||#

(defun  dump-db ()
    (format t "~{~{~a:~10t~a~%~}~%~}" *db*))

#||
(defun where (&key title artist rating (ripped nil ripped-p))
    #'(lambda (record)
        (and
            (if title    (equal (getf record :title) title) t)
            (if artist   (equal (getf record :artist) artist) t)
            (if rating   (equal (getf record :rating) rating) t)
            (if ripped-p (equal (getf record :ripped) ripped) t))))
||#

(defmacro where (&rest clauses)
    `#'(lambda (record)
        (and 
        ,@(make-comparision-list clauses))))

(defun select (selector-fn)
    (remove-if-not selector-fn *db*))

(defun update (selector-fn &key title artist rating (ripped nil ripped-p))
    (setf *db*
        (mapcar #'(lambda (record)
            (when (funcall selector-fn record)
                (if artist (setf (getf record :artist) artist))
                (if title (setf (getf record :title) title))
                (if rating (setf (getf record :rating) rating))
                (if ripped-p (setf (getf record :ripped) ripped))) record) *db*)) t)

(defun delete-records (selector-fn)
    (setf *db*
        (remove-if selector-fn *db*)))

(defun make-cmp-exp (field value)
    `(equal (getf record ,field) ,value))

(defun make-comparision-list (fields)
    (loop while fields collecting (make-cmp-exp (pop fields) (pop fields))))

