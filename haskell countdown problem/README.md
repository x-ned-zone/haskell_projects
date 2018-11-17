## The countdown problem

### Description
> In the countdown problem a function (arithmetic expression) must be constructed that calculates a given result from a given set of N numbers. 
All numbers must be positive integers (including intermediate results), and each of the source numbers can be used at most once when constructing the expression.

### Tasks
> Implement Haskell functions that solve the countdown problem efficiently:
  - Solution should reject expressions that fail to evaluate and not evaluate redundant expressions (exploiting algebraic properties to reduce the number of generated expressions).
  - Assume only the following operators are used in constructing expressions: [+, -, *, /] from a list of N positive integers and one positive integer value that must be calculated.

> For example,
- given the integer array: [1, 3, 7, 10, 25, 50] and arithmetic operators: [+, -, *, /], construct an expression whose value is: 765:
  - One possible solution is: ( 25 - 10 ) * ( 50 + 1 ) = 765

#### Scope guide:
1. Adequate documentation throughout (10%)
2. type and function definitions for handling numeric expressions (20%)
3. combinatorial functions for list manipulation (20%)
4. A function that suitably formalises expressions as solutions given a list of numbers and a target value (10%)
5. function for rejecting expressions that fail to evaluate (20%)
6. function to avoid evaluating redundant expressions (20%) 

> running sample
  ```
  main :: IO ()
  main = print (solutions'' [1, 3, 7, 10, 25, 50] 765)
  ```