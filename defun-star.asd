
(defsystem defstar*
  :components 
    (:file "package")
    (:file "defun-star" :depends-on ("package")))


