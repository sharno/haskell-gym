import Data.Char (digitToInt)

captcha :: Int -> String -> Int
captcha n xs =
  sum [ digitToInt x | (x, y) <- zip xs rotated, x == y ] 
  where rotated = drop n xs ++ take n xs

part1 :: String -> Int
part1 = captcha 1

part2 :: String -> Int
part2 xs = captcha (length xs `div` 2) xs

main = do
  s <- readFile "Day1.in"
  -- let s = "1212"
  putStrLn $ show $ part1 s
  putStrLn $ show $ part2 s