# `type` vs `data` vs `newtype`

## `type`
- The `type` keyword is for making type synonyms. What that means is that we just give another name to an already existing type so that the type is easier to refer to.
- We use type synonyms when we want to make our type signatures more descriptive by giving types names that tell us something about their purpose in the context of the functions where they're being used.

## `newtype`
- The `newtype` keyword is for taking existing types and wrapping them in new types, mostly so that it's easier to make them instances of certain type classes.
- When we use newtype to wrap an existing type, the type that we get is separate from the original type.
- When we use record syntax in our newtype declarations, we get functions for converting between the new type and the original type: namely the value constructor of our newtype and the function for extracting the value in its field.
- The new type also isn't automatically made an instance of the type classes that the original type belongs to, so we have to derive or manually write them.
- In practice, you can think of newtype declarations as data declarations that can only have one constructor and one field. If you catch yourself writing such a data declaration, consider using newtype.

## `data`
- The `data` keyword is for making your own data types and with them, you can go hog wild.
- They can have as many constructors and fields as you wish and can be used to implement any algebraic data type by yourself. Everything from lists and Maybe-like types to trees.

## Summary:
- If you just want your type signatures to look cleaner and be more descriptive, you probably want type synonyms.
- If you want to take an existing type and wrap it in a new type in order to make it an instance of a type class, chances are you're looking for a newtype.
- And if you want to make something completely new, odds are good that you're looking for the data keyword.

