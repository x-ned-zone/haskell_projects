module Question2 where

-- Question 2 

-- function deletes the first occurrence (if any) of a value from a list. 
-- For example, delete 2 [1, 2, 3, 2] should give the result [1, 3, 2].

delete :: Int -> [ Int ] -> [ Int ] 
delete _ [] = []
delete n (x:xs) = [v | v <- (x:xs) , n/=v]