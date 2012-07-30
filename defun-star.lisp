
(in-package :com.helmutkian.defun-star)

(defmacro with-gensyms (names &body body)
  `(let ,(loop for name in names
	       collect `(,name (gensym)))
     ,@body))

(defun append* (&rest things)
  (reduce (lambda (thing list)
	    (append (if (listp thing)
			thing
			(list thing))
		    list))
	  things
	  :initial-value nil
	  :from-end t))

(defun make-fun-form (name expr &key doc-string)
  (with-gensyms (args)
    `(,@(append* name doc-str) (&rest ,args) (apply ,expr ,args))))

(defun make-lexical-form (form)
  (if (> length form 2)
      form
      (apply #'make-fun-form form)))

(defmacro defun* (name &rest body)
  `(defun 
       ,@(multiple-value-call 
	  #'make-fun-form
	  name
	  (if (stringp (car body))
	      (values (second body) :doc-string (first body))
	      (values (car body))))))

(defmacro flet* (forms &body body)
  `(flet ,@(mapcar #'make-lexical-form forms)
    ,@body))

(defmacro labels* (forms &body body)
  `(labels ,@(mapcar #'make-lexical-form forms)
     ,@body))

(defvar test
  '(flet* ((foo (x) (1+ x))
	   (bar (compose #'1+ #'sum)))
    (foo (bar '(1 2 3)))))
