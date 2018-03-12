
data Tree a = Empty | Node a (Tree a) (Tree a)

-- Depth first traversal
dft :: Tree a -> [a]
dft Empty = []
dft (Node a left right) = [a] ++ dft left ++ dft right

bft :: Tree a -> [a]
bft t = helper [t]
  where
    helper [] = []
    helper trees = foldr values [] trees ++ (helper $ concatMap subs trees)

    subs Empty = []
    subs (Node _ left right) = [left, right]

    values Empty acc = acc
    values (Node a _ _) acc = a:acc

tree :: Tree Int
tree = Node 1 (Node 2 (Node 4 Empty Empty) (Node 5 Empty Empty)) (Node 3 (Node 6 Empty Empty) (Node 7 Empty Empty))
