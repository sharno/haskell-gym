-- https://www.hackerrank.com/challenges/functions-or-not/problem

strToPair :: String -> (Int, Int)
strToPair = (\[x, y] -> (read x, read y)) . words

isFunction :: [(Int, Int)] -> Bool
isFunction xs = all sameY xs
  where
    sameY (x, y) = all (==y) [b | (a, b) <- xs, a == x]

is :: Bool -> String
is True = "YES"
is False = "NO"

main :: IO ()
main = do
  t <- readLn :: IO Int
  results <- mapM (\_ -> do
    n <- readLn :: IO Int
    mapM (\_ -> fmap strToPair $ getLine) [1..n]
    ) [1..t]
  mapM_ (putStrLn . is . isFunction) results
