module Question1 where

-- Predefined

data Expr = Val Int | App Op Expr Expr   --deriving (Show)
data Op = Add | Mul  --deriving (Show)

instance Show Op where
  show Add = "+"
  show Mul = "*"

-- Override the print function for expressions to extract the numbers and add parentheses
instance Show Expr where
  show (Val n) = show n  -- replace with "n"
  show (App o l r) = paren l ++ show o ++ paren r
    where
      paren (Val x) = show x
      paren exp       = "(" ++ show exp ++ ")"

-- To do

-- Eliminates duplicate expressions which happen due to commutative/associative properties of add/mul ... 
-- ( For e.g  1+(2*3) and (2*3)+1 both = 7 ... So optimize to ensure we accept only expr that have l <= r and eliminate the other where l > r

optimize:: Op-> Int-> Int-> Bool
optimize Add l r = l<=r
optimize Mul l r = l>r

-- Question 1
-- Evaluate an expression to its integer value
eval :: Expr -> [Int]
eval (Val n) = [n]
eval (App Add el er) = [ res1+res2 | res1<-eval el, res2<-eval er, optimize Add res1 res2 ]
eval (App Mul el er) = [ res1*res2 | res1<-eval el, res2<-eval er, optimize Mul res1 res2 ]

-- Returns the list of integer values contained in an expression
values :: Expr -> [ Int ]
values (Val n) = [n]
values (App _ exp1 exp2) = values exp1 ++ values exp2
