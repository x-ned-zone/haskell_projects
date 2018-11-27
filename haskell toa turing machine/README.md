## Turing Machine

### Description

The aim is to design and implement a Turing machine that operates only on the following input and output symbols: 
  - {a, b} 
and computes a function 
  - f(x), 
where f(x) outputs only the symbol 'a' if x is a palindrome and outputs the symbol b otherwise. 

A palindrome is a symmetrical string, i.e., if we reverse the order of its symbols, it is still the same string. 

> Running samples, for example:
  ```
  f(bba) = b
  f(baab) = a
  f(abab) = b
  f(aaa) = a
  f(babab) = a
  ```

The input string x can be up to length N = 4, but must contain only the symbols: a; b. 
The Turing machine terminates after the last symbol in the string of symbols has been processed or if it is given an empty string f g.

### Solution and Testing Report 
- The sequence of possible Turing machine state configurations that are used during the computation of f with the input string: aba
  - Input string : "aba"
> Resulting Configurations:

| CurrentState|InputSymbol|OutputSymbol|NewState|**Move/shift**|
| ------------|:---------:|-----------:|-------:|-------------:|
| 1 | A | 'a' | ' ' | B | right |
| 2 | B | 'b' | 'b' | B | right |
| 3 | B | 'a' | 'a' | B | right |
| 4 | B | ' ' | ' ' | C | left  |
| 5 | C | 'a' | ' ' | D | left  |
| 6 | D | 'b' | 'b' | D | left  |
| 7 | D | ' ' | ' ' | A | right |
| 8 | A | 'b' | ' ' | E | right |
| 9 | E | ' ' | ' ' | F | left  |
| 10| F | ' ' | ' ' | K |*transition to accepting state and return 'T'


> Terminology:
- A = <initial state>
- K = <accept  state>         
  - K state -  accepts language without transitioning to new state with new symbol.
- symbol T = 'True'           
  - indicating language accepted!
- ' ' denotes a blank

> How to run and accept input on CMD/Terminal:
  ```
  f "aba" = 'a'
  ```

### Scope guide:
1. Accurate Turing machine implementation for palindrome problem. (25%)
2. Accurate output for all inputs, up to input string length N = 4. (25%)
3. Accurate list of all Turing machine configurations for input: 'aba'. (25%)
4. Turing machine implemented with least number of states. (25%)