
(asdf:defsystem #:cl-tacit
  :depends-on (#:tcr.parse-declarations-1.0)
  :components ((:file "package")
	       (:file "tacit" 
		      :depends-on ("package"))))


