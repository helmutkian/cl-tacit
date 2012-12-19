# cl-tacit

## Description

**cl-tacit** is a utility that allows for the point-free definition of functions either at the top-level or locally.


## DEFTACIT

DEFTACIT allows for defining functions at the top-level using lambdas or closure-returning functions, much like DEFINE in Scheme.

### Syntax

**DEFTACIT** *name* [[ *doc-string* ] | [ *declarations* ]] *expression*

*name* - Name of the function.

*doc-string* - Optional documentation string.

*declarations* - Optional declaration directives.

*expression* - Point-free or lambda expression.

### Example

````lisp
(deftacit add-1-and-sum
  (compose #'sum (curry #'mapcar #'1+)))

(add-1-and-sum '(1 2 3))
=> 9

````

## TACIT-LET


TACIT-LET allows for defining functions in the lexical environment using lambdas or closure-returning functions, much like LET in Scheme.

### Syntax

**TACIT-LET** ((*name* [[ *doc-string* ] | [ *declarations* ]] *expression*)*) *body*

*name* - Name of the function

*doc-string* - Optional documentation string.

*declarations* - Optional declaration directives.

*expression* - Point-free or lambda expression


### Example

````lisp
(tacit-let ((not-eql (complement #'eql)))
  (not-eql 11 22))
  
=> T
````

## TACIT-LET*

TACIT-LET* allows for defining functions in the lexical environment using lambdas or closure-returning functions. TACIT-LET* evaluates its bindings sequentially allow for recursive or sequential definitions much like LETREC or inner DEFINE in Scheme.

### Syntax

**TACIT-LET*** ((*name* [[ *doc-string* ] | [ *declarations* ]]  *expression*)*) *body*

*name* - Name of the function

*doc-string* - Optional documentation string.

*declarations* - Optional declaration directives.

*expression* - Point-free or lambda expression

### Example
````lisp
(tacit-let* ((prod (curry #'reduce #'*))
          (prod-plus-one (compose #'1+ #'prod)))
  (prod-plus-one '(1 2 3)))
  
=> 7
````
