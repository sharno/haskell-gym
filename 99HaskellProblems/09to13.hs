-- 09. Pack consecutive duplicates of list elements into sublists. If a list contains repeated elements they should be placed in separate sublists.
pack :: Eq a => [a] -> [[a]]
pack = foldr f []
  where
    f e [] = [[e]]
    f e outer@(inner@(y:_):xs)
      | e == y = (e:inner):xs
      | otherwise = [e]:outer
-- test: pack ['a', 'a', 'a', 'a', 'b', 'c', 'c', 'a', 'a', 'd', 'e', 'e', 'e', 'e']
-- result: ["aaaa","b","cc","aa","d","eeee"]

-- 10. Run-length encoding of a list. Use the result of problem P09 to implement the so-called run-length encoding data compression method. Consecutive duplicates of elements are encoded as lists (N E) where N is the number of duplicates of the element E.
encode :: Eq a => [a] -> [(Int, a)]
encode = map (\s -> (length s, head s)) . pack
-- ghci>encode "aaaabccaadeeee"
-- [(4,'a'),(1,'b'),(2,'c'),(2,'a'),(1,'d'),(4,'e')]

-- 11. Modify the result of problem 10 in such a way that if an element has no duplicates it is simply copied into the result list. Only elements with duplicates are transferred as (N E) lists.
data ListItem a = Single a | Multiple Int a deriving (Show)
encodeModified :: Eq a => [a] -> [ListItem a]
encodeModified = map f . encode
  where
    f (1, b) = Single b
    f (a, b) = Multiple a b

-- 12. Given a run-length code list generated as specified in problem 11. Construct its uncompressed version.
decodeModified :: [ListItem a] -> [a]
decodeModified [] = []
decodeModified (Single a:rest) = a : decodeModified rest
decodeModified (Multiple n a:rest) = replicate n a ++ decodeModified rest

-- 13. Implement the so-called run-length encoding data compression method directly. I.e. don't explicitly create the sublists containing the duplicates, as in problem 9, but only count them. As in problem P11, simplify the result list by replacing the singleton lists (1 X) by X.
encodeDirect :: Eq a => [a] -> [ListItem a]
encodeDirect = foldr f []
  where
    f i [] = [Single i]
    f i xs@(Single a:rest)
      | a == i = Multiple 2 i:rest
      | otherwise = Single i:xs
    f i xs@(Multiple n a:rest)
      | a == i = Multiple (n+1) i:rest
      | otherwise = Single i:xs

