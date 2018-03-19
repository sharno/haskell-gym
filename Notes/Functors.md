2 functors laws:
- **law 1:**
Mapping `id` over a Functor should give the same result of `id Functor`
```hs
fmap id Functor = id Functor
```

- **law 2:**
Composing 2 functions and mapping them over a functor is the same as mapping the first function over the functor and mapping the second function over the result of the first.
```hs
fmap (f . g) Functor = fmap f $ fmap g Functor
```

If we can show that some type obeys both functor laws, we can rely on it having the same fundamental behaviors as other functors when it comes to mapping.

The <*> function is really interesting. It has a type declaration of `f (a -> b) -> f a -> f b`. Does this remind you of anything? Of course, `fmap :: (a -> b) -> f a -> f b`. It's a sort of a beefed up fmap. Whereas fmap takes a function and a functor and applies the function inside the functor, <*> takes a functor that has a function in it and another functor and sort of extracts that function from the first functor and then maps it over the second one. When I say extract, I actually sort of mean run and then extract, maybe even sequence. We'll see why soon.

This:
```hs
ghci> [ x*y | x <- [2,5,10], y <- [8,10,11]]
[16,20,22,40,50,55,80,100,110]
```
is similar to this:
```hs
ghci> (*) <$> [2,5,10] <*> [8,10,11]
[16,20,22,40,50,55,80,100,110]
```

`<$>` is the `infix fmap`

`<*>` is the `applicative fmap`

It's easier to see that we're just calling * between two non-deterministic computations. If we wanted all possible products of those two lists that are more than 50, we'd just do:
```hs
ghci> filter (>50) $ (*) <$> [2,5,10] <*> [8,10,11]
[55,80,100,110]
```

There's `liftA2` in `Control.Applicative` standard library
```hs
liftA2 :: (Applicative f) => (a -> b -> c) -> f a -> f b -> f c  
liftA2 f a b = f <$> a <*> b  
```

which we can think of as
```hs
(a -> b -> c) -> (f a -> f b -> f c)
```
When we look at it like this, we can say that liftA2 takes a normal binary function and promotes it to a function that operates on two functors.

Like normal functors, applicative functors come with a few laws. The most important one is the one that we already mentioned, namely that
```hs
pure f <*> x = fmap f x holds
```
As an exercise, you can prove this law for some of the applicative functors that we've met in this chapter.The other functor laws are:
```hs
pure id <*> v = v

pure (.) <*> u <*> v <*> w = u <*> (v <*> w)

pure f <*> pure x = pure (f x)

u <*> pure y = pure ($ y) <*> u
```

---

