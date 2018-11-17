import Question1
import Question3
import Question5

-- Question 6

-- Using your answers to the previous parts, define a function: that returns all expressions whose list of values is a permutation of the given list and whose value is the given value.
-- For example, solve [1, 2, 3, 4] 10 should return all expressions e for which
-- values e is a permutation of [1, 2, 3, 4] and eval e -> 10.

main::IO()
main = return()

-- To generate all subsequences of a list of integers permutated for expressions.
subs :: [Int] -> [[Int]]
subs [] = [[]]
subs (x:xs) = subs xs ++ map (\e-> x:e) (subs xs)

-- permutation of all subsequences of the list
perm_subs::[Int]-> [[Int]]
perm_subs []     = [[]]
perm_subs (x:xs) = [ perm | sub_i <- tail(subs (x:xs)), perm <- perms sub_i ]

solve :: [ Int ] -> Int -> [ Expr ]
solve (x:xs) x_value = if elem x_value (x:xs) then [(Val x_value)]
                       else [ expr_i | perm_i <- perm_subs (x:xs), expr_i <- exprs perm_i, eval expr_i == [x_value] ] 
