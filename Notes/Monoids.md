Monoids: when you take 2 things of the same type and combine them to get a thing of the same type of the previous 2 things

(It's a collection of things plus a rule for combining them and that rule satisfies meta-rules)

the meta-rules for combining the things:
- Associativity `(f . g) . h = f . (g + h)`
- Existence of Identity `f . id = id . f`
- doesn't have to satisfy Commutativity `f . g /= g . f`

like function composition:
```hs
f :: a -> a
g :: a -> a

h :: a -> a
h = f . g
```

Rules could be relaxed to accomodate for composition of functions with different types

```hs
g :: a -> b
f :: b -> c

h :: a -> c
h = f . g
```

We don't have commutativity anyway so composing `g . f` is not possible for these types anymore for these types but that doesn't disagree with our rules
