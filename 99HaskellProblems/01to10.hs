-- Find the last element of a list.
myLast :: [a] -> Maybe a
myLast [] = Nothing
myLast (x:[]) = Just x
myLast (_:xs) = myLast xs

-- Find the last but one element of a list.
myButLast :: [a] -> Maybe a
myButLast [] = Nothing
myButLast (_:[]) = Nothing
myButLast (x:_:[]) = Just x
myButLast (_:xs) = myButLast xs

-- Find the K'th element of a list. The first element in the list is number 1.
elementAt :: [a] -> Int -> Maybe a
elementAt list@(x:xs) n
  | length list < n = Nothing
  | n == 1 = Just x
  | otherwise = elementAt xs (n-1)

-- Find the number of elements of a list.
myLength :: Foldable f => f a -> Int
myLength = foldr (const (+1)) 0
-- const is amazing it takes 2 arguments and always gives the first without change
-- const x _ = x
-- so feeding it a function in the first element makes it take a third argument
-- the function gets applied to the third argument (the accumulator here)

-- Reverse a list.
myReverse :: Foldable f => f a -> [a]
myReverse = foldl (flip (:)) []

-- Find out whether a list is a palindrome. A palindrome can be read forward or backward; e.g. (x a m a x).
isPalindrome :: Eq a => [a] -> Bool
isPalindrome s = s == reverse s

isPalindrome' :: Eq a => [a] -> Bool
isPalindrome' = (==) <*> reverse
--                  ^^^^^ this is genius

-- Flatten a nested list structure.
-- We have to define a new data type, because lists in Haskell are homogeneous
data NestedList a = Elem a | List [NestedList a]
flatten :: NestedList a -> [a]
flatten (Elem a) = [a]
flatten (List a) = concatMap flatten a
-- test: flatten (List [Elem 1, List [Elem 2, List [Elem 3, Elem 4], Elem 5]])

-- Eliminate consecutive duplicates of list elements.
compress :: Eq a => [a] -> [a]
compress [] = []
compress [a] = [a]
compress (x:y:xs)
  | x == y = compress (y:xs)
  | otherwise = x : compress (y:xs)
--compress "aaaabccaadeeee"

-- Pack consecutive duplicates of list elements into sublists. If a list contains repeated elements they should be placed in separate sublists.
pack :: Eq a => [a] -> [[a]]
pack = foldr f []
  where
    f e [] = [[e]]
    f e outer@(inner@(y:_):xs)
      | e == y = (e:inner):xs
      | otherwise = [e]:outer
-- test: pack ['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e']
-- result: ["aaaa","b","cc","aa","d","eeee"]

-- Run-length encoding of a list. Use the result of problem P09 to implement the so-called run-length encoding data compression method. Consecutive duplicates of elements are encoded as lists (N E) where N is the number of duplicates of the element E.
encode :: Eq a => [a] -> [(Int, a)]
encode = map (\s -> (length s, head s)) . pack
-- ghci>encode "aaaabccaadeeee"
-- [(4,'a'),(1,'b'),(2,'c'),(2,'a'),(1,'d'),(4,'e')]

