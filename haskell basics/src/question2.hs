--Question 2
--selects the last element of a non-empty list.
main :: IO ()    -- Main func is an IO action.
main = return () -- Tell main to do nothing.

last':: [a] -> a
last' x = x !! (length x - 1)
--last' (x:xs) = (x:xs) !! (length (x:xs) - 1)