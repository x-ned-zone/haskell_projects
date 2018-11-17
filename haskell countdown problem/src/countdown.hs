-- =======================================================================================================================
-- @author Masixole Ntshinga
-- NTSMAS016
-- Functional Programming 2
-- =======================================================================================================================

import Debug.Trace 

-- =======================================================================================================================
-- Data constructors

data Opr = Add | Sub | Mul | Div  -- deriving (Show)
data Expr = Val Int | E Opr Expr Expr --deriving (Show)

-- override the print function for operators to replace the word operator with its equivalent symbol
instance Show Opr where
  show Add = "+"
  show Sub = "-"
  show Mul = "*"
  show Div = "/"

-- override the print function for expressions to extract the numbers and add parentheses
instance Show Expr where
  show (Val n) = show n  -- replace with "n"
  -- show (E o l r) = "(" ++ show l ++ ")"  ++ show o ++ "(" ++ show r ++ ")" 
  show (E o l r) = paren l ++ show o ++ paren r
    where
      paren (Val x) = show x
      paren exp       = "(" ++ show exp ++ ")"

-- =======================================================================================================================

optimal::[Int]->[[Int]]
optimal [] = [[]]
optimal (x:xs) = [x:xs]

-- @isnatural validates 2 integers and returns a bool if they're are natural numbers. Prevents zero division
isnatural:: Opr->Int->Int->Bool
isnatural Add l r = l<=r
isnatural Mul l r = l>r
isnatural Sub l r = (l-r)>0            -- to avoid negative results
isnatural Div l r = (r /= 1) && (l `mod` r) == 0   -- to avoid zero division

-- =======================================================================================================================
-- Combinatorial functions

-- Split list into list of pairs [ ([Int], [Int]), .... ]
break' :: [Int] -> [([Int],[Int])]
break' [] = [([],[])]
break' listx = (break_aux listx [] [])  -- [([],listx)] ++  ++ [(listx,[])]
-- Auxiliary function to break'
break_aux :: [Int]-> [Int]-> [([Int],[Int])]-> [([Int],[Int])]
break_aux  (x:xs) buffer all_pairs = if length xs == 0  then all_pairs
                                     else break_aux xs (buffer ++ [x]) (all_pairs++[(buffer++[x], xs)])

-- @permutations generates permutations of values in a list
-- @param list - list of values to permutate
-- 	 Algorithm: The idea is to one by one extract all elements, place them at first position and recur for remaining list.
-- ** Credit to [ GeekeForGeeks.com ] for [ Description of the 'permutations' algorithm ]
permutations ::[Int] -> [[Int]]
permutations [] = [[]]
permutations listx = perm_aux listx listx

-- auxiliar function
perm_aux ::[Int] -> [Int] -> [[Int]] 
perm_aux [] _ = [[]]
perm_aux (x:xs) remLst = [[m]++p | m <- (x:xs), p <- perm_aux (filterRemList remLst m) (filterRemList remLst m) ]

-- @filterRemList Auxiliar function to filter 'x' out of filterRemList
filterRemList :: [Int]-> Int -> [Int]
filterRemList lst x = [elem | elem <- lst, elem/=x]

-- @subseqs :
subseqs :: [Int] -> [[Int]]
subseqs [] = [[]]
subseqs (x:xs) = subseqs xs ++ map (\sb-> x:sb) (subseqs xs)

-- @perm_choices Returns the list of permutations of all subsequences of a list.
-- use tail to remove heading empty list[] item in first position of the list
perm_choices :: [Int] -> [[Int]]
perm_choices []  = []
perm_choices ls = [ ch | sub_seq <- tail (subseqs ls), ch <- (permutations sub_seq)]

-- =======================================================================================================================
-- expression generator functions

-- @expressions generates all sorts of expressions with potential evaluation success from the list of values provided
expressions :: [Int] -> [(Expr, Int)]
expressions []  = []
expressions [n] = [(Val n, n) | n>0]
expressions ns  = [(exp, value) | (ls, rs) <- break' ns, l <- expressions ls, r <- expressions rs, (exp, value) <- (explore (fst l) (fst r)) ]

-- @explore Create/explore all possible combinations of operators on given expression.
-- Avoid redundant expressions which will not evaluate eventually. 
-- Rather store Expressions with successful evaluations earlier rather than later. format [(Expr, value), .... ]
explore :: Expr -> Expr -> [(Expr, Int)]
explore l r = [ ((E op l r), eval' (E op l r)!!0) | op <- [Add, Sub, Mul, Div], isnatural op ((eval' l)!!0) ((eval' r)!!0) ] -- 
-- explore l r = map (\op-> (E op l r) else pass) [Add, Sub, Mul, Div]

-- =======================================================================================================================
-- solutions generator functions

-- @eval evaluates the given expression (with possible sub evaluations of sub-expressoin) to return a result of the expression in a list
eval' :: Expr -> [Int]
eval' (Val n) = [n | n > 0]
eval' (E Add l r) = [ el+er | el<-eval' l, er<-eval' r, isnatural Add el er]
eval' (E Mul l r) = [ el*er | el<-eval' l, er<-eval' r, isnatural Mul el er ]
eval' (E Sub l r) = [ el-er | el<-eval' l, er<-eval' r, isnatural Sub el er]
eval' (E Div l r) = [ el`div`er | el<-eval' l, er<-eval' r, isnatural Div el er ]

-- @solutions generate a list permutations from the values given, 
--           then from the given list, generate a list of expressions whose values evaluate successfully to give the target value
solutions :: [Int] -> Int -> [Expr]

solutions lst target = if elem target lst then [(Val target)] else 
     [ expr | perm_expr <- (perm_choices lst), (expr, output) <- (expressions perm_expr), eval' (expr) == [target] ]


-- main = return () -- Tell main to do nothing.
main :: IO ()    -- Main func is an IO action.
main = print (solutions [8, 3, 2, 13, 25, 50] 589 )
-- main = print (solutions [1, 3, 7, 10, 25, 50] 765)
-- main = print (solutions [10, 3, 11, 9, 33, 78] 111)

--listv = [1,3,7,10,25,50]
--target   : 765
--solutions : [(1 + 50) * (25 − 10), ..... ]

-- =======================================================================================================================
