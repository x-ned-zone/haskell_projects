-- Turing Machine Simulator for palindrome detecting program

-- A Turing Machine's double infinite tape [left head right]:
data Tape cell = Tape [cell] cell [cell]
-- This Turing Machine is a 5-tuple but with the 2 elements in the transition function .. making it a 7 tupple :
-- alphabet            : TM [alphab]
-- set of states       : [state]
-- initial state       : state
-- initial tape        : (Tape alphab)
-- transition function : (state -> Tape alphab -> Maybe (state, Tape alphab))
data TM alphab state = TM [alphab] [state] state (Tape alphab) (state-> Tape alphab-> Maybe(state, Tape alphab))

-- Create infinite block cells for tape
blank = repeat ' '

-- shift/move the tape head to the left or right by one position :
moveLeft  (Tape (l:ls) h rs) = Tape ls l (h:rs)
moveRight (Tape ls h (r:rs)) = Tape (h:ls) r rs
-- Write a new symbol to the tape:
write (Tape ltape head_ rtape) a = Tape ltape a rtape

-- (f-> Tape g-> Maybe(f, Tape g))
-- instance Show TM where
--   show (TM la ls state tape ff ) = show ("symbol: " ++ la ++ ", state: " ++ state)

-- TM Palindrome Program to detect langauge of palindromes using state diagram format:
-- iSymb : input symbol
-- < CurrentState, InputSymbol, OutputSymbol, NewState >

-- tmPalindrome c_state iSymb@(Tape _ headx _) =
tmPalindrome :: Char -> Tape Char -> Maybe (Char, Tape Char)
tmPalindrome c_state (Tape (l:ls) x_head (r:rs)) =
  case (c_state, x_head) of
    -- starts with 'a'
    ('A','a') -> Just ('B', moveRight (write iSymb ' '))
    -- starts with 'b'
    ('A','b') -> Just ('E', moveRight (write iSymb ' '))
    -- starts with ' '
    ('A',' ') -> Just ('K', write iSymb 'T') -- <accept>
    -- Starts with a followed by {'a','b'}* = 'a...'
    ('B','a') -> Just ('B', moveRight iSymb)
    ('B','b') -> Just ('B', moveRight iSymb)
    ('B',' ') -> Just ('C', moveLeft iSymb)  -- reached the end with blank ' ' (Reversing->left)  [ 'a'????? <- ' ']
    ('C','a') -> Just ('D', moveLeft (write iSymb ' '))
    ('C','b') -> Just ('K', write iSymb 'F') -- <reject>
    ('C',' ') -> Just ('K', write iSymb 'T') -- <accept>
    ('D','a') -> Just ('D', moveLeft iSymb)
    ('D','b') -> Just ('D', moveLeft iSymb)
    ('D',' ') -> Just ('A', moveRight iSymb)
    -- Starts with b followed by {'a','b'}* = 'b...'
    ('E','a') -> Just ('E', moveRight iSymb)
    ('E','b') -> Just ('E', moveRight iSymb)
    ('E',' ') -> Just ('F', moveLeft iSymb)  -- reached the end with blank ' ' (Reversing->left)  [ 'b'????? <- ' ']
    ('F','b') -> Just ('G', moveLeft (write iSymb ' '))
    ('F','a') -> Just ('K', write iSymb 'F')   -- <reject>
    ('F',' ') -> Just ('K', write iSymb 'T')   -- <accept>
    ('G','a') -> Just ('G', moveLeft iSymb)
    ('G','b') -> Just ('G', moveLeft iSymb)
    ('G',' ') -> Just ('A', moveRight iSymb)
    ('K','T') -> Nothing
    ('K','F') -> Nothing
    ('K','S') -> Nothing
    _         -> error (show "Error detected : input symbol-> " ++ show x_head ++ ", state->" ++ [c_state] ++ " ... LANGUAGE NOT RECOGNIZED!!")
    where iSymb = (Tape (l:ls) x_head (r:rs))
    -- _         ->  error (show c_state ++ show a)

-- Run the Turing Machine until reach a halt state (Nothing):
-- print ("<currentState ("++c_state++"), InputSymbol : ("++iSymb++")" ++ ", newState ("++newSt++"), outputSymbol : ("++iSymb++")")
runTMachine :: TM a s -> Tape a
runTMachine (TM alph_i state_i state0 tape0 ftape) =
  case ftape state0 tape0 of
      Nothing        -> tape0
      Just (st1, tp1) -> runTMachine (TM alph_i state_i st1 tp1 ftape)

-- @funcion f to run turing machine
--          run turing machine with initial setup (Tape blank x (xs ++ blank)) )
f (x:xs) | h=='T' = 'a'
         | h=='F' = 'b'
         | h=='S' = ' '
         where
    (Tape ls h rs) = runTMachine ( TM " abTF"                            -- initial symbols
                                      ['A','B','C','D','E','F','G','K']  -- set of states
                                      'A'                                -- initial state
                                      (Tape blank x (xs ++ blank))       -- initial tape with infinite left right blocks
                                      tmPalindrome                       -- transition (state & symbol) function
                                  )
-- ===========================================================================
-- INPUT / OUTPUT ... UNIT TESTING
-- ===========================================================================
input1, input2, input3, input4, input5 :: String
input1 = "bba"
input2 = "baab"
input3 = "abab"
input4 = "aaa"
input5 = "babab"
input6 = " "

utest =
  do
    print "Unit testing ... "
    print ("f("++input1++") == 'b' : ", f input1 == 'b')
    print ("f("++input2++")== 'a' : ", f input2 == 'a')
    print ("f("++input3++")== 'b' : ", f input3 == 'b')
    print ("f("++input4++") == 'a' : ", f input4 == 'a')
    print ("f("++input5++")== 'a' : ", f input5 == 'a')
    print ("f("++input6++")== 'a' : ", f input6 == 'a')
