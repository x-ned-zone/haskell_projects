main::IO()
main = return ()

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

-- Question 2 
-- function deletes the first occurrence (if any) of a value from a list. 
-- For example, delete 2 [1, 2, 3, 2] should give the result [1, 3, 2].
delete :: Int -> [ Int ] -> [ Int ] 
delete _ [] = []
delete n (x:xs) = [v | v <- (x:xs) , n/=v]

-- Question 3 
-- function perms: returns all permutations of a list, given by all possible re-orderings of its elements. 
-- For example, perms [1, 2, 3] should return:
-- [ [1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1] ]
-- 	 Algorithm: The idea is to one by one extract all elements, place them at first position and recur for remaining list.
perms :: [ Int ] -> [ [ Int ] ]
perms [] = [[]]
perms listx = perm_aux listx listx

-- auxiliar function
perm_aux :: [ Int ] -> [ Int ] -> [ [ Int ] ] 
perm_aux [] _ = [[]]
perm_aux (x:xs) remLst = [[m]++p | m <- (x:xs), p <- perm_aux (delete m remLst) (delete m remLst) ]

-- filterRemList

subs :: [Int] -> [[Int]]
subs [] = [[]]
subs (x:xs) = subs xs ++ map (\e-> x:e) (subs xs)

-- Question 4
-- 4. Define a function: that returns all splits of a list into two non-empty parts that append to give the original list. 
-- For example, split [1, 2, 3, 4] should return:
-- [ ( [1], [2, 3, 4] ), ( [1, 2], [3, 4]), ( [1, 2, 3], [4] ) ]
-- Split list into list of pairs [ ([Int], [Int]), .... ]
split :: [ Int ] -> [([Int],[Int])]
split [] = [([],[])]
split listx = (split_aux listx [] [])  -- [([],listx)] ++  ++ [(listx,[])]

-- Auxiliary function to split'
split_aux :: [Int] -> [Int]-> [([Int],[Int])]-> [([Int],[Int])]
split_aux (x:xs) buffer all_pairs = if length xs == 0  then all_pairs
                                    else split_aux xs (buffer ++ [x]) (all_pairs++[(buffer++[x], xs)])

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

-- Question 6
-- Using your answers to the previous parts, define a function: that returns all expressions whose list of values is a permutation of the given list and whose value is the given value.
-- For example, solve [1, 2, 3, 4] 10 should return all expressions e for which
-- values e is a permutation of [1, 2, 3, 4] and eval e -> 10.

solve :: [ Int ] -> Int -> [ Expr ]
solve (x:xs) x_value = [ expr_i | perm_i <- [ p | sub_i <- tail(subs (x:xs)), p <- perms sub_i ], expr_i <- exprs perm_i, ( eval expr_i == [x_value] ) ]
