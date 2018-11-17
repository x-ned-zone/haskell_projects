module Question5 where
import Question1
import Question4

-- Question 5

-- Using split, define a function: that returns all expressions whose list of values is a given list. 
-- For example, exprs [1, 2, 3] should return all e for which values e = [1, 2, 3].

exprs :: [ Int ]-> [ Expr ]
exprs [ ] = []
exprs [n] = [ (Val n) ]
exprs (x:xs) = [ exp | (p1,p2) <- split(x:xs),  exp1 <-(exprs p1), exp2 <-(exprs p2), exp <- explore exp1 exp2 ]

explore :: Expr -> Expr -> [Expr]
explore exp1 exp2 = [ (App op exp1 exp2) | op <- operators ]
operators = [Add, Mul]
