The `:sprint` command prints the value of an expression without causing it to be evaluated

```hs
Prelude> :sprint x
x = _
```

If we define `x` and `y` as:
```hs
Prelude> let x = 1 + 2 :: Int
Prelude> let y = x + 1
Prelude> :sprint x
x = _
Prelude> :sprint y
y = _
```

The `seq` function evaluates its first argument, here `y`, and then returns its second argument in this case, just `()`.

```hs
Prelude> seq y ()
()
```
Now let’s inspect the values of `x` and `y`:

```hs
Prelude> :sprint x
x = 3
Prelude> :sprint y
y = 4
```

Let’s see what happens when a data structure is added:
```hs
Prelude> let x = 1 + 2 :: Int
Prelude> let z = (x,x)
```
This binds `z` to the pair `(x,x)`. The `:sprint` command shows something interesting:
```hs
Prelude> :sprint z
z = (_,_)
```

The variable `z` itself refers to the pair `(x,x)`, but the components of the pair both point to the unevaluated thunk for `x`. This shows that we can build data structures with unevaluated components.
Let’s make `z` into a thunk again:
```hs
Prelude> import Data.Tuple
Prelude Data.Tuple> let z = swap (x,x+1)
```
The `swap` function is defined as:
```hs
swap (a,b) = (b,a)
```
This `z` is unevaluated as before:
```hs
Prelude Data.Tuple> :sprint z z= _
```
The point of this is so that we can see what happens when `z` is evaluated with `seq`:
```hs
Prelude Data.Tuple> seq z ()
()
Prelude Data.Tuple> :sprint z
z = (_,_)
```

The `seq` function evaluates its argument only as far as the first constructor, and doesn’t evaluate any more of the structure. There is a technical term for this: We say that seq evaluates its first argument to `weak head normal form (WHNF)`. The term normal form on its own means “fully evaluated”.
```hs
Prelude Data.Tuple> seq x ()
()
Prelude Data.Tuple> :sprint z
z = (_,3)
```

Same applies to lists:
```hs
Prelude> let xs = map (+1) [1..10] :: [Int]

-- Nothing is evaluated yet:
Prelude> :sprint xs
xs = _

-- Now we evaluate this list to weak head normal form:
Prelude> seq xs ()
()
Prelude> :sprint xs
xs = _ : _

-- We have a list with at least one element, but that is all we know about it so far. Next, we’ll apply the length function to the list:
Prelude> length xs
10

-- The length function is defined like this:
length :: [a] -> Int
length [] = 0
length (_:xs) = 1 + length xs

-- It will descend the structure of the list, evaluating the list cells but not the elements.
Prelude> :sprint xs
xs = [_,_,_,_,_,_,_,_,_,_]

Prelude> sum xs
65
Prelude> :sprint xs
xs = [2,3,4,5,6,7,8,9,10,11]
```

