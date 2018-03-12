import System.Random

-- 21
insertAt :: a -> [a] -> Int -> [a]
insertAt x xs n = take (n-1) xs ++ [x] ++ drop (n-1) xs
-- Prelude> insertAt 'X' "abcd" 2
-- "aXbcd"

-- 22
range :: Int -> Int -> [Int]
range s e = [s..e]

-- 23
rndSelect :: RandomGen g => [a] -> Int -> g -> ([a], g)
rndSelect [] _ gen = ([], gen)
rndSelect xs n gen
  | n <= 0 = ([], gen)
  | otherwise =  (x:(fst $ rndSelect (left++right) (n-1) newGen), newGen)
    where
      (i, newGen) = randomR (0, length xs - 1) gen
      x = xs !! i
      left = take i xs
      right = drop (i+1) xs
-- test: getStdRandom $ rndSelect "hello there" 3

-- 24
diffSelect :: RandomGen g => Int -> Int -> g -> ([Int], g)
diffSelect n hi = rndSelect [1..hi] n
-- test: getStdRandom $ diffSelect 6 49

-- 25
rndPermu :: RandomGen g => [a] -> g -> ([a], g)
rndPermu xs = rndSelect xs (length xs)

-- 26
combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations n xs = [ y:x | (i, y) <- zip [1..] xs , x <- combinations (n-1) (drop i xs) ]
