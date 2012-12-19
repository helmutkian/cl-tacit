

(defun make-tacit-form (name body)
  (multiple-value-bind (fn declarations docstring) 
      (tcr.parse-declarations-1.0::parse-body body)
    (let ((args (gensym)))
     (remove nil
	     `(,name (&rest ,args)
	        ,@declarations
		,@docstring
		(apply ,@fn ,args))))))

(defmacro deftacit (function-name &body body)
  `(defun ,@(make-tacit-form function-name body)))

(defmacro tacit-let (tacit-forms &body body)
  `(flet ,(loop for (name . fn-body) in tacit-forms
		 collect (make-tacit-form name fn-body))
     ,@body))

(defmacro tacit-let* (tacit-forms &body body)
  `(labels ,(loop for (name . fn-body) in tacit-forms
		 collect (make-tacit-form name fn-body))
     ,@body))

(defun compose (&rest functions)
  (flet ((compose2 (f g) (lambda (&rest args) (funcall f (apply g args)))))
    (reduce #'compose2 functions)))
