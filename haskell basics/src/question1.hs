-- Question 1

main :: IO ()    -- Main func is an IO action.
main = return () -- Tell main to do nothing.

-- product' (x:xs) = x * product xs
product' :: Num a => [a] -> a
product' (x:xs) = product_h (x:xs) 1
-- Tail recursive helper function to avoid delayed multiplications on recursive calls 
product_h [] n = n
product_h (x:xs) n = product_h xs (n*x)
