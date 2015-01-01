---
title: Haskell: why should you learn and how to begin
published: 2009-05-03
pt: pt/blog/haskell/haskell-start
---

I'm currently learning and liking more and more the [Haskell][1] programming language.
In Haskell you can VERY easily reason about your code
and it's also very easy to break-up the problem you're solving into smaller subproblems (what programmers always love).
Haskell is also secure, has a comprehensive library collection and a big active user community all over the globe.
My fondness of Haskell began, ironically, when I was forced to learn it, doing the course on [Programming Paradigms][2] in college.
So in this post I try to show why you should learn Haskell, even if you're not forced to...

Here are some reasons why Haskell should be your next language:

  * **Haskell makes you think differently**: Haskell is a [functional language][3].
    A program's execution is seen as the evaluation of functions, defined through combination of more "basic" functions.
    In a functional program, the ONLY effect of a function being evaluated is the produced value,
    and the ONLY influence to the function's value are its parameters.
    It means that a functional language has no variables, no explicit state and no side-effects.
    It seems impossible to program under such constraints, don't you think?
    On the contrary, it's a great way of programming, a lot of skilled developers know that.

  * **Haskell is fast**: You don't _necessarily_ need to loose performance because you're using a higher level of abstraction.
    Not if you're programming functionally. Haskell has recently shown a level of efficiency when compiled very similar to that of C.
    Besides, the compiler infrastructure is evolving VERY quickly.
    See [here][4] the comments directed at Haskell by the organizer of the Internet's most famous language benchmark.

  * **Haskell is elegant**: It really matters to easily understand the code. Take a look at the following factorial implementation:

    ```haskell
    factorial :: Integer -> Integer
    factorial 0 = 1
    factorial n = n  factorial (n-1)
    ```

  * **Haskell is used in the REAL WORLD**: There are thousands of beautiful languages out there.
    But Haskell is used everyday, worldwide, in [several fields][5].
    It's used on the software industry, where its security and the ease to guarantee correctness increase the value of the software product.

  * **Haskell is safe**: The design of the language keeps the programmer far from several errors.
    There's no need for manual memory management, and Haskell's a _strongly and statically typed_ langauge.
    Every Haskell expression has a type, and every function has domain and codomain types.
    These types are checked at compile time and won't give you runtime errors.
    This doesn't mean, however, more code. The Haskell compiler is _always able to infer_ the type of an expression and will guarantee coherence.

  * **Haskell is fun**: This is serious, believe me! :)
    But you only find out how much fun if you get your hands dirty ;)

And for those who now want to learn Haskell, I'm giving some links for where to start. I've collected these materials during the last year. Enjoy!

  * A taste of Haskell in your browser, an interactive tutorial: [Try Haskell!][6]

  * Introductory tutorial: [Learn you a Haskell for Great Good!][7]
      + This tutorial is for those who want to learn having fun.
        It was the first tutorial I followed from the first to the last chapter, and it explains very well the language's concepts.

  * How to install Haskell: [The Glorious Haskell Compiler website][8]
      + Here you can download GHC, the most popular Haskell compiler AND interpreter.
        For those who use Ubuntu it's enough to type: `sudo apt-get install ghc6 ghc6-doc ghc6-prof`

  * [How to structure a Haskell project][9]
      + In this page you learn how a Haskell project should be organized, recommended development tools, etc. Highly recommended.

  * For those who have finished the introduction: [Write yourself a interpreter in 48 hours][10]

Following this tutorial in 48 hours or more :)
you'll be able to write a complete interpreter for the Scheme programming language.
Its perfectly targeted at those who have just finished the introductory tutorial I gave above.

[1]: <http://www.haskell.org>
[2]: <http://en.wikipedia.org/wiki/Programming_paradigms>
[3]: <http://pt.wikipedia.org/wiki/Programação_funcional>
[4]: <http://www.haskell.org//pipermail/haskell/2006-June/018127.html>
[5]: <http://www.haskell.org/haskellwiki/Haskell_in_practice>
[6]: <http://tryhaskell.org>
[7]: <http://learnyouahaskell.com/>
[8]: <https://www.haskell.org/ghc/download>
[9]: <http://www.haskell.org/haskellwiki/How_to_write_a_Haskell_program>
[10]: <http://en.wikibooks.org/wiki/Write_Yourself_a_Scheme_in_48_Hours>
