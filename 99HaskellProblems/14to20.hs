-- 14
dupli :: [a] -> [a]
dupli = concatMap (replicate 2)

-- 15
repli :: [a] -> Int -> [a]
repli xs n = concatMap (replicate n) xs

-- 16
dropEvery :: [a] -> Int -> [a]
dropEvery xs n = [ x | (i, x) <- zip [1..] xs, i `mod` n /= 0 ]

-- 17
split :: [a] -> Int -> ([a], [a])
split xs n = (take n xs, drop n xs)

-- 18
slice :: [a] -> Int -> Int -> [a]
slice xs start end = drop (start - 1) $ take end $ xs

-- 19
rotate :: [a] -> Int -> [a]
rotate xs n = drop n xs ++ take n xs
rotate' :: [a] -> Int -> [a]
rotate' xs n = (++) <$> drop n <*> take n $ xs
-- *Main> rotate ['a','b','c','d','e','f','g','h'] 3
-- "defghabc"
-- *Main> rotate ['a','b','c','d','e','f','g','h'] (-2)
-- "ghabcdef"

-- 20
removeAt :: Int -> [a] -> (Maybe a, [a])
removeAt n xs
  | length xs >= n = (Just (xs !! (n - 1)), take (n-1) xs ++ drop n xs)
  | otherwise = (Nothing, xs)
-- *Main> removeAt 2 "abcd"
-- ('b',"acd")
