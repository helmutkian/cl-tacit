(in-package :helmutkian.defun-star)

(defun make-function-form (name body)
  (multiple-value-bind (fn declarations docstring) 
      (tcr.parse-declarations-1.0::parse-body body)
    (let ((args (gensym)))
     (remove nil
	     `(,name (&rest ,args)
	        ,@declarations
		,@docstring
		(apply ,@fn ,args))))))

(defmacro defun* (function-name &body body)
  `(defun ,@(make-function-form function-name body)))

(defmacro flet* (function-forms &body body)
  `(flet ,(loop for (name . fn-body) in function-forms
		 collect (make-function-form name fn-body))
     ,@body))

(defmacro labels* (function-forms &body body)
  `(labels ,(loop for (name . fn-body) in function-forms
		 collect (make-function-form name fn-body))
     ,@body))

(defun compose (&rest functions)
  (flet ((compose2 (f g) (lambda (&rest args) (funcall f (apply g args)))))
    (reduce #'compose2 functions)))
