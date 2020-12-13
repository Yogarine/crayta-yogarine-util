# Yogarine Util

This is a package for [Crayta](https://www.crayta.com) that contains a
collection of utility classes.

It is exclusively focussed on Lua coding. It currently contains two scripts /
Classes:

## `Util`
This class contains some generic convenience functions:

  - `Util.Average(collection)`<br/>
    Calculates the average of all items provided. This also works with classes
    that override the add function, like Vector and Rotation. This means you can
    use this to create an average Vector by providing it a list of vectors.

  - `Util.DumpVar(data)`<br/>
    This will dump the contents of the provided variable in a readable form.
    Very useful for debugging!

## `Stack`
This is a table which allows you to have a fixed amount of items, overwriting
the oldest item each time. It also has a convenient Stack:Average() function.

### `Stack` Example

```lua
local stack = self:GetEntity().stack:New(3)  -- Stack will only contain 3 items.
-- [...]
stack:Push(position)
local averagePosition = stack:Average()
```

## How to Use
You can use these classes by attaching this script to an entity and retrieving
it from other scripts through self:GetEntity().util or self:GetEntity().stash.
For your convenience there is also a Util template which is basically just a
Script Folder with the util and stash scripts already attached to it.

I plan to extend this package with a lot more functions and classes as I need
them. Also, if you have any suggestions yourself let me known!
