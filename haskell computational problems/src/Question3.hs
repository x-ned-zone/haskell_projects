module Question3 where
import Question2

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

