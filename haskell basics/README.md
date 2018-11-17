##Haskell basics project

###Functions

- product
  - computes the product of a list of numbers.

- last
  - selects the last element of a non-empty list.

- halve
  - splits a list of even length into two halves.

- safetail
  - returns the tail of a list, and maps empty list to itself rather returning an error.
  - uses (1) a conditional expression, (2) guarded equations, and (3) pattern matching.

> Requires Glasgow Haskell Compiler

> To compile file with functions, use:
  ```
  ghci scriptname.hs
  ```

> To run compiled functions use 'function-name <parameters>'. For e.g:
  ```
  product [1,2,3] = 6
  
  last [1,2,3,4,5] = 5
  
  halve [1,2,3,4,5,6] = ([1,2,3], [4,5,6])
  
  safetail [1,2,3,4,5] = [2,3,4,5]

  ```
