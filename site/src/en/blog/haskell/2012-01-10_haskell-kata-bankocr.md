---
title: Haskell Kata: Bank OCR
published: 2012-01-10
pt: pt/blog/haskell/haskell-kata-bankocr
---

Some time ago I used to attend (twice per month) "Coding Dojo UFSC", the programming practice meeting organized by me and my friends at college...
Sadly these meetings are not being organized anymore, but they were AWESOME.
If you still don't know what a Coding Dojo is, all details are [HERE][1],
but - put simply - a Coding Dojo is a regular meeting where a small group of computer programmers (typically 5 to 20 in a room)
exercise their programming skill through **mindful practice** and a **rigid methodology**.
In a Dojo, the most important is not solving the problem or being "the best", not at all.
The point is to feel at the end that you have - individually and as a group - improved your skill.

Our Dojos were pretty exciting, indeed,
to the point that sometimes we would each rush home after the Dojo to try and solve the problem in our favorite language/framework.
I solved some of these short programming challenges in Haskell,
and I now want to post them here in the blog so that more people can enjoy the - supposed :) -  beauty of the code and give suggestions.
In the first of this hopefully long series of posts, we are going to play with [BankOCR][2].

<!--more-->

## Problem description

The acronym "OCR" in the problem description gives the hint: we want to recognize characters.
But our task is much easier than building a full-fledged optical recognizer...

Our program's input is going to be a text file containing digits from 0 to 9 in a "LED-display-like" format.
Like this:

      _  _     _  _  _  _  _
    | _| _||_||_ |_   ||_||_|
    ||_  _|  | _||_|  ||_| _|

Our input text file has only one line of "7-segment" digits,
where each digit has a height of 3 "segments" (lines) and a width also of 3 "segments" (columns).
Our program must read the contents of this file and print the corresponding number on the standard output,
which for the above example would be `123456789`.

In the [official problem description][3], there are several additional usage scenarios for this challenge:
recognizing several lines of digits, validating the numbers and using error-correcting codes to return good numbers even with "dirty" input.
We are going, however, to tackle only the basic challenge, which is to recognize a single line of well-formed digits.


## Haskell solution

**SPOILER ALERT:  DO NOT KEEP READING if you want to try solving this problem for yourself.**

I believe that a Haskell solution for this problem turned out very idiomatic and relatively easy to understand.
Besides, it is also very short: ignoring the lookup table, we have only around 10 lines of code!
There it goes, the relevant part of the solution:

<script src="http://gist-it.appspot.com/github/joaopizani/katas/blob/blog-05-2012/BankOCR/OCR.hs?footer=0&slice=0:16"></script>

Our solution is a typical [Unix filter][4],
and this very much justifies our usage of the `interact` function to define main...
The `interact` function has the following type:

```haskell
interact ∷ (String → String) → IO ()
```

`interact` takes a **function from String to String** as parameter and does Input/Output with the help of this function.
One way to express what `interact` does is by saying that it connects standard input to standard output,
but allowing the information to be **transformed by the user function** as it flows through :)

Now for some commentary on the core of our recognizer, the `parse` function:

  * The `transpose` function is in the standard library (the `Prelude`), and works over lists of lists (matrices).
    It turns lines into columns and vice-versa (pretty obvious :P)

  * `lines` is also in the Prelude, and has type `String → [String]`.
    It takes a big String and breaks it down to a list of smaller Strings, one per line

  * The `lookup` function returns a value from an associative table.
    In Haskell, an associative table is just a list of pairs: `[ (key, value) ]`

  * `lookup` gives us a value of type `Maybe Char`. That because, generally speaking, the key might not be in the table (it **maybe** is there).
    So, to transform a `Maybe Char` in the `Char` that we want, we use `fromJust`.
    Of course that if we pass `Nothing` (a nonexistent value) to `fromJust`, the program will crash.
    We are only using `fromJust` here because WE ARE SURE that all digits are in the table...

  * The `chunk` function is in the `Data.List.Split` module, and does what its name (and parameter) suggests:
    returns same-sized groups of elements from its input list

  * About `dummy`: The problem description states that there's a blank column between any two digits (as a separator).
    So, effectively,  we could treat each digit as having 4 columns - EXCEPT FOR THE FIRST ONE.
    So, to avoid handling corner cases, I forced the first digit to also have 4 columns by adding a dummy column to it.
    This "strategy" of transforming a corner case into a normal one and THEN treating all cases equally is VERY often found in functional programs

Well, after understanding how it works, we can now run the program, like this:

    joaopizani@rabbithole:~$ cat twohundredfiftysix
     _   _   _
     _| |_  |_
    |_   _| |_|

    joaopizani@rabbithole:~$ cat twohundredfiftysix | ./OCR
    256

Of course you don't have to believe me, and you can check that the program work by yourself.
Copy the code from my "katas" repository on GitHub (<https://github.com/joaopizani/katas/blob/blog-05-2012/BankOCR/OCR.hs>), compile it and run it!
There's a small dependency on the `Data.List.Split` module, so the commands for compiling your source file and running the program are as follows:

    cabal install split
    ghc --make OCR.hs
    cat <input-file> | ./OCR

That's all, folks!  Thanks for reading and have FUN coding in Haskell...
In case you have any suggestion or you want to criticize the solution in any way, please do so in the comments :)

[1]: <http://codingdojo.org/cgi-bin/wiki.pl?WhatIsCodingDojo>
[2]: <http://codingdojo.org/cgi-bin/wiki.pl?KataBankOCR>
[3]: <http://codingdojo.org/cgi-bin/wiki.pl?KataBankOCR>
[4]: <http://en.wikipedia.org/wiki/Filter_(Unix)>
