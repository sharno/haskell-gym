import Data.Array

fib :: Integer -> Integer
fib m = fibs!m
  where
    fibs = listArray (0, m) (0 : 1 : [ fibs!(i-1) + fibs!(i-2) | i <- [2..m] ])
