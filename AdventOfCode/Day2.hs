-- stringsToInts :: [String] -> [Int]
-- stringsToInts xs = map (read n :: Int

checksum1 :: String -> Int
checksum1 = sum . map (\l -> maximum l - minimum l) . map (map read . words) . lines

checksum2 :: String -> Int
checksum2 = sum . map rowChecksum . map (map read . words) . lines
  where rowChecksum xs = sum [ x `div` y | x <- xs, y <- xs, x `mod` y == 0, x /= y ]

main :: IO ()
main = do
  s <- readFile "Day2.in"
  -- let s = "1212"
  putStrLn $ show $ checksum1 s
  putStrLn $ show $ checksum2 s