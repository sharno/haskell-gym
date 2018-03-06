We need compositionality (to control complexity) for values with context, so we made monads (we couldn't compose the functions returning monads unless we have bind operator)

```hs
f :: a -> Maybe a
g :: a -> Maybe a

-- composing 2 functions:
h :: a -> Maybe a
h = \x -> (f x >>= g)
```

as functions are possible to compose now, so functions live in a Monoid, and the values (like: Maybe a) live in a Monad


```hs
f :: Monad m => a -> m a
g :: Monad m => a -> m a
```

Monads are useful for side effects, IO, database queries ... etc

the bind operator is like function composition operator, it has to obey the meta-rules:
- Associativity
- Existence of Identity `return`

```hs
ghci> :t return
return :: Monad m => a -> m a
```

In C# LINQ, it's designed as a Monad, so
- `>>=` is `selectMany`
- `Monad m => m a` is `IEnumerable<a>`

That gave the power to LINQ to work as a query language for any kind of data type like SQL, XML, JSON ... etc

Same like monoids we can compose functions that give different types but we flip the order of functions for the bind operator `\x -> g x >>= f` instead of `f . g` because of syntactic difference

```hs
g :: Monad m => a -> m b
f :: Monad m => b -> m c

h :: Monad m => a -> m c
h = \x -> (g x >>= f)
```

Useful types:

```hs
(>>=) :: Monad m => m a -> (a -> m b) -> m b

(.) :: (b -> c) -> (a -> b) -> a -> c
```
