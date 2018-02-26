import Data.Char (digitToInt)

intToList :: String -> [Int]
intToList = map digitToInt

packWithNext :: [Int] -> [(Int, Int)]
packWithNext (x:xs) = zip (x:xs) (xs ++ [x])

packWithHalf :: [Int] -> [(Int, Int)]
packWithHalf xs = zip xs (drop midPoint xs ++ take midPoint xs)
  where midPoint = length xs `div` 2

summation :: [(Int, Int)] -> Int
summation = sum . map (\(a, b) -> if a == b then a else 0)

part1 :: String -> Int
part1 = summation . packWithNext . intToList

part2 :: String -> Int
part2 = summation . packWithHalf . intToList

main = do
  s <- readFile "Day1.in"
  -- let s = "1212"
  putStrLn $ show $ intToList s
  putStrLn $ show $ part1 s
  putStrLn $ show $ part2 s