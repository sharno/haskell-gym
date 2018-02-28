primesTo :: Int -> [Int]
primesTo m = [x
  | x<-[1..m]
  , all (\n -> x `mod` n /= 0) [2..(floor $ (sqrt::Double->Double) $ fromIntegral x)]
  ]

main :: IO ()
main = do
  putStrLn $ show $ primesTo 10000