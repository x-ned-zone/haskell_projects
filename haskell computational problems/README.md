## Computational problems


### Tasks
Implement Haskell functions that provide solutions to the following six computational problems.

- eval & values
  - functions for arithmetic expressions
  - evaluate an expression to its integer value, and return the list of integer values contained in an expression.

- delete
  - deletes the first occurrence (if any) of a value from a list.

- perms
  - produces all permutations of a list, given by all possible re-orderings of its elements.

- split
  - produces all splits of a list into two non-empty parts that append to give the original list.

- exprs
  - produces all expressions whose list of values is a given list.

- solve
  - produces all expressions whose list of values is a permutation of the given list and whose value is the given value.


Running samples / examples:
  ```
  delete 2 [1, 2, 3, 2] = [1, 3, 2]
  perms [1, 2, 3]       = [ [1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1] ]
  split [1, 2, 3, 4]    = [ ( [1], [2, 3, 4] ), ( [1, 2], [3, 4]), ( [1, 2, 3], [4] ) ]
  exprs [1, 2, 3]       = all e for which values e = [1, 2, 3].
  solve [1, 2, 3, 4] 10 = produce all expressions e for which 'values e' is a permutation of [1, 2, 3, 4] and 'eval e' = 10.
  
  ```