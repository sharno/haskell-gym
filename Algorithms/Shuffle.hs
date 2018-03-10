import System.Random
import Data.Function

shuffle :: RandomGen g => [a] -> g -> ([a], g)
shuffle [] gen = ([], gen)
shuffle xs gen = (x:(fst $ shuffle (left ++ right) newGen) , newGen)
  where
    (i, newGen) = randomR (0, length xs - 1) gen
    x = xs !! i
    left = take i xs
    right = drop (i+1) xs


main :: IO ()
main = do
  ([1..6]::[Int]) & shuffle & getStdRandom >>= print
