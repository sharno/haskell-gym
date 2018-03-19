data LinkedList a = Empty | Item a (LinkedList a) deriving (Show)

reverse :: LinkedList a -> LinkedList a
reverse Empty = Empty
reverse l = r l Empty
  where
    prepend a rest = Item a rest

    r Empty list = list
    r (Item a rest) list = r rest (prepend a list)
