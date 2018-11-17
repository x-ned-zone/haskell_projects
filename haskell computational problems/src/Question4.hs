module Question4 where

-- Question 4

-- 4. Define a function: that returns all splits of a list into two non-empty parts that append to give the original list. 
-- For example, split [1, 2, 3, 4] should return:
-- [ ( [1], [2, 3, 4] ), ( [1, 2], [3, 4]), ( [1, 2, 3], [4] ) ]

split :: [ Int ] -> [([Int],[Int])]
split [] = [([],[])]
split listx = (split_aux listx [] [])  -- [([],listx)] ++  ++ [(listx,[])]

-- Auxiliary function to split'
split_aux :: [Int] -> [Int]-> [([Int],[Int])]-> [([Int],[Int])]
split_aux (x:xs) buffer all_pairs = if length xs == 0  then all_pairs
                                    else split_aux xs (buffer ++ [x]) (all_pairs++[(buffer++[x], xs)])
