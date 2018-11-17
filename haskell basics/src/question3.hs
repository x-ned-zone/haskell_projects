--Question 3
--splits an even length list into two halves.
main :: IO ()    -- Main func is an IO action.
main = return () -- Tell main to do nothing.

halve' :: [a] -> ([a], [a])
halve' [] = ([], [])
halve' x =
    if (length x) `mod`2==0
    then halve_it x 0 ((length x) `div` 2) []
    else ([], [])
halve_it (x:xs) i mid h1 =
    if i < mid
    then halve_it xs (i+1) mid (h1++[x])
    else (h1 , x:xs)
