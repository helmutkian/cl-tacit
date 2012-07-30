
# DEFUN*

## Description

DEFUN* is a utility that allows for the point-free definition of functions either at the top-level or locally.


## DEFUN*

DEFUN* allows for defining functions at the top-level using lambdas or closure-returning functions, much like DEFINE in Scheme.

### Syntax

**DEFUN* ** _name_ [[_doc-string_]] _expression_

_name_ - Name of the function.
_doc-string_ - Optional documentation string.
_expression_ - Point-free or lambda expression.
### Example

````
(defun* add-1-and-sum
  (compose #'sum (curry #'mapcar #'1+)))

> (add-1-and-sum '(1 2 3))
> 9

````

## FLET*


FLET* allows for defining functions in the lexical environment using lambdas or closure-returning functions, much like LET or inner DEFINE in Scheme.

In addition, FLET* allows you to mix the usual lambda-list style function definitions with point-free ones.

### Syntax

**FLET* ** ([(_name_ _expression_) | (_name_ _args_ _function-body_])  ...) _body_

_name_ - Name of the function
_expression_ - Point-free or lambda expression

### Example

````
(flet* ((not-eql (compose #'not #'eql))
        (average (nums) (/ (sum nums) (length nums))))
  (not-eql (average some-arbitrary-values) 22))
````

### Note

This library current does not provide common point-free operators such as CURRY or COMPOSE.
