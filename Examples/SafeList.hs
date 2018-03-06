{-# LANGUAGE GADTs #-}

data Empty
data NonEmpty
data SafeList a b where
  Nil :: SafeList a Empty
  Cons :: a -> SafeList a b -> SafeList a c


safeHead :: SafeList a NonEmpty -> a
safeHead (Cons a _) = a


main :: IO ()
main = do
  print $ safeHead (Cons (1::Int) Nil)
  
  -- this gives an error:
  -- print $ safeHead (Nil)
  
  return ()