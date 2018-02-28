a :: Int
a = 265149

step :: Int -> Int -> Int -> Int -> Int
step x y level n
  | n == 1                     = abs x + abs y
  
  | x ==  level && y == -level = step (x+1)  y    (level+1) (n-1) -- lower right corner - new level
  | x ==  level && y ==  level = step (x-1)  y     level    (n-1) -- upper right corner
  | x == -level && y ==  level = step  x    (y-1)  level    (n-1) -- upper left  corner
  | x == -level && y == -level = step (x+1)  y     level    (n-1) -- lower left  corner
  
  | x ==  level                = step  x    (y+1)  level    (n-1) -- right edge
  | x == -level                = step  x    (y-1)  level    (n-1) -- left  edge
  | y ==  level                = step (x-1)  y     level    (n-1) -- upper edge
  | y == -level                = step (x+1)  y     level    (n-1) -- lower edge

  | otherwise = -1

main :: IO ()
main = do
  putStrLn $ show $ step 0 0 0 a