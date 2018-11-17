--Question 4
--Define safetail using only 1, 2, 3: 
main :: IO ()    -- Main func is an IO action.
main = return () -- Tell main to do nothing.

--(1) Conditional expression
safetail_cond:: Eq a => [a] -> [a]
safetail_cond xs = 
    if xs == []
    then []
    else safetail_helper xs  
safetail_helper (x:xs) = xs

--(2) Guarded equations
safetail_guard:: Eq a => [a] -> [a]
safetail_guard xs | xs == []  = []
              | otherwise = safetail_ghelper xs
safetail_ghelper (x:xs) = xs

--(3) Pattern matching
safetail_patt:: Eq a => [a] -> [a]
safetail_patt [] = []
safetail_patt (x:xs) = xs
