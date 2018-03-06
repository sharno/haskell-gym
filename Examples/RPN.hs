rpn :: String -> String
rpn = unlines . map (show . process . words) . lines

process :: [String] -> Int
process = head . foldl f []
  where f (x:y:rest) "+" = x+y:rest
        f (x:y:rest) "*" = x*y:rest
        f (x:y:rest) "-" = y-x:rest
        f nums num = read num:nums

main :: IO ()
main = interact rpn