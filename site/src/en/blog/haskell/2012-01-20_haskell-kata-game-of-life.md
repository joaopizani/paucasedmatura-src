---
title: Haskell Kata: Conway's Game of Life
published: 2012-01-20
pt: pt/blog/haskell/haskell-kata-game-of-life
---

Hi everybody! Today I am going to write about another [Code Kata][1] experience I had using Haskell.
This time the code didn't come directly from a Coding Dojo (live meeting with friends), but rather from an "enhancement" over the solution we wrote at a meeting.

In that Coding Dojo we wanted to solve the [Game Of Life][2] problem.
The goal was mainly to - given an initial configuration - evolve the world in one generation and print back this evolved state.
For those of you who never heard about Conway's Game of Life, its article on Wikipedia can be very clarifying.

So we did it, and we solved the problem, but - as always - I wanted very badly to try to solve the same problem using Haskell (instead of Python).
At home, I coded it up in Haskell in around 30min, and the code was concise and elegant...
In fact, this was so easy that I decided I needed some bigger challenge, something **graphical**, why not?
Then I gave the awesome [Gloss][3] graphics library another chance,
and I was AGAIN impressed with the results.

<!--more-->

So let's start our Haskell Kata routine, by first describing the problem itself and then the beautiful Haskell solution...

## Problem Description

_(This problem description is blatantly copied from the correspondent Coding Dojo Wiki [entry][4], as of 2012-01-19)_

This Kata is about calculating the next generation of Conway's Game of Life, given any starting position.
Take a look at [Wikipedia][5] for background.

You start with a two-dimensional grid of cells, where each cell is either alive or dead.
In this version of the problem, the grid is finite, and no life can exist off the edges.
When calculating the next generation of the grid, follow these rules:

  * Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
  * Any live cell with more than three live neighbours dies, as if by overcrowding.
  * Any live cell with two or three live neighbours lives on to the next generation.
  * Any dead cell with exactly three live neighbours becomes a live cell.

You should write a program that can accept an arbitrary grid of cells, and will output a similar grid showing the next generation.

### Input and Output

The input starting position is given through a text file that looks like this:

    ........
    ....x...
    ...xx...
    ........

And the output could look like:

    ........
    ...**...
    ...**...
    ........

This format was chosen because it is very easily parsed in most languages.
OBS: It is VERY, VERY easily parsed in Haskell :)


## Proposed "solution" in Haskell

**SPOILER ALERT: DO NOT KEEP READING if you want to try solving this problem for yourself.**

As I said in the beginning of the post, my code isn't really a solution to the given problem, but rather an improvement over it.
It improves a simple solution in two ways:

  1. It handles more than one generation. It is actually a live simulation
  2. It has a graphical interface to display the simulation

Even though the code is bigger (because of these enhancements) it is still very concise and readable, totaling some 150 lines of code (with lots of whitespace).
And to keep it simple, we are going to start our tour of the solution by the module that deals with the "original" problem:
we are going to look first at the functions to read and evolve the board for one generation.
First of all, the parser for a starting position (imports omitted for brevity):

<script src="http://gist-it.appspot.com/github/joaopizani/katas/blob/blog-05-2012/GlossGameOfLife/Parser.hs?footer=0&slice=7:"></script>

Our parser was written using the easy-to-use, efficient and popular [Parsec][6] library for Haskell,
that allows us to describe a format to be recognized (a **grammar**) in Haskell itself, in a very readable and concise way.
Parsec is a **parser combinator** library, which means that we build our "big" parser by combining smaller parsers,
which are built by combining even smaller ones, and so on...
until we reach the primitive parsers that come with Parsec like, for example, `char`, used to define the parser for a dead cell in the first line of the code above.

Indeed, the parsers `dead` (for a dead cell) and `alive` (for a live cell) are the most fundamental, and what they do is pretty simple:
they **map** a dot or an upper-case 'O' to False or True, respectively.
We can take a look at the type signatures of `char` and `fmap` if we want to know more precisely what they do:

```haskell
fmap ∷ (a → b) → f a → f b
char ∷ Char → Parser Char

map ∷ (a → b) → [a] → [b]
```

First of all, let's talk about `char`. The exact type of `char` (as in the [Parsec documentation][7])
is more general and uses type classes. The type shown above, however,
is a valid specialization of the general type, suiting our usage.
You can see that `char` takes a character and gives us a **Parser that recognizes** that character.
However, we want `dead` to be of type `Parser Bool`, that is, a parser that returns a boolean; so we need a function that converts `Parser Char` to `Parser Bool`...
And that's the point where [fmap][8] comes to help us!

You can see that not only the name, but also the type of `fmap` is very similar to that of `map`.
In fact, `fmap` is a generalization of `map`: while `map` works only over lists, `fmap` works over any container.
Well, then `fmap` is applicable to our situation, that's because anything of type `Parser a` is a monad,
and any monad is a container (_the fancy word for container is ["Functor"][9]_).
The last interesting detail is the function that we map over (char '.') and (char 'O'):
The usage of `const` means that **we don't care about what the Parser returns**, as long as it succeeds, we return either a True or a False.

The remaining parser code is even simpler; the top-level function in the parser module (`parseBoardFromFile`) is the only one that still deserves some commentary:

<script src="http://gist-it.appspot.com/github/joaopizani/katas/blob/blog-05-2012/GlossGameOfLife/Parser.hs?footer=0&slice=15:"></script>

This function takes a file name as input (`FilePath` is just a synonym for `String`) and performs some IO actions (reading the file and parsing its contents).
As a result of these actions, it returns a matrix of booleans (that is, our `Board` \o/).
The function [parseFromFile][10] comes from Parsec,
and it does exactly what its name says, with a return type of `Either ParseError [[Bool]]`.
Because `result` has this type, we use the [either][11] function in the next line.
The `either` function is used whenever you need to **decide what to do based on a value of type Either**.
In our case, if the result is a correctly parsed matrix, we return it as-is (that's what `id` does for us).
But if it's an erroneous parse, then we convert the ParseError to a string and terminate the program showing the error message
(that's what `(error ∘ show)` does for us).

Enough for parsing now, and on to what really matters: evolving a board one generation.
We take care of this task in the Evolution module.
The most important functions of this module are `evolve` and `eval`.
`eval` is given a position on the board and returns whether the cell in that position should be dead or alive, based on its surroundings.
`evolve` is given a board and just applies `eval` all over it to create the next-generation board.
With one important consideration: it only looks at the inner cells in the board, i.e, all border cells are considered **always dead**.
Here's the code for `eval` and `evolve`:

<script src="http://gist-it.appspot.com/github/joaopizani/katas/blob/blog-05-2012/GlossGameOfLife/Evolution.hs?footer=0&slice=8:24"></script>

The function `aliveNeighbours` takes a board and a pair of coordinates, returning **how many** of the 8 surrounding cells are alive.
Its definition is pretty boring and straightforward, so I won't explain it - you'll have to believe that it works :)

So, the code that we saw so far almost solves the original Kata problem - we only needed to add some pretty-printing of the board...
BUT! But we are going to do something much nicer, much cooler: we are going to display our simulation in a graphical interface, like this:

![The "Gosper glider gun" \o/\o/\o/](http://i.imgur.com/jCLp2.gif)

Before getting too excited, I have to warn you: the module dealing with drawing the graphics is the largest one (It has around 50 lines of code).
However, if you run the program for yourself and watch the AWESOME resulting simulation, you'll realize that 50 lines is a **very good mark :)**

Anyways, 50 lines is still too much to be embedded in a blog post, so I'll only give you the highlights - namely, the functions `drawModel`, `layout` and `activate`.
Here's their code:

<script src="http://gist-it.appspot.com/github/joaopizani/katas/blob/blog-05-2012/GlossGameOfLife/Drawing.hs?footer=0&slice=27:32"></script>

<script src="http://gist-it.appspot.com/github/joaopizani/katas/blob/blog-05-2012/GlossGameOfLife/Drawing.hs?footer=0&slice=49:63"></script>

Let's begin with the easiest one: `activate` takes a matrix of pictures (all of them are squares) and assigns a color to each one,
with the color depending on whether that position of the matrix is active or not in the underlying Game of Life board.
The way in which we implemented `activate` is VERY typical in functional programming, and benefits largely from lazy evaluation.
First, we apply `paintersFromBoard`, which has type:

```haskell
paintersFromBoard ∷ [[Bool]] → [[Picture → Picture]]
```

It takes the board and transforms it into a **matrix of functions**.
More specifically, each function in this matrix is a painter, transforming a picture into a new one by changing its color.
Now we have two things to combine:

  1. A matrix of default-colored squares (by default they are all black)
  2. A matrix of "painter functions", one for each square

To combine these, we use `applyFunctionMatrix` (not shown above).
Its definition is very straightforward, but also very typical of functional programming languages.
We define `applyFunctionMatrix` by "lifting" the usage of `applyFunctionList` to the outer list of the matrix (the list of lines).
`applyFunctionList` is beautifully defined as follows:

Continuing in the Drawing module, we reach `layout`.
The purpose of this function is to - given a list of "unplaced" pictures (all overlapping each other) - spread
them with some padding between each other so that they fill a horizontal or vertical line.
We want the resulting "array" of pictures to be centered around the point where all overlapping pictures **currently are** - that's why we calculate the "middle" index as being half of the list's length.
We then use `move` to displace each picture by `i` steps in direction `dir`.
The `move` function knows the size of the cells, so we only need to pass it how many `steps` we want to displace a cell,
and a pixel-exact translation will be done for us.

<script src="http://gist-it.appspot.com/github/joaopizani/katas/blob/blog-05-2012/GlossGameOfLife/Drawing.hs?footer=0&slice=42:43"></script>

At last, the most important function in the drawing module - the core of the simulation: `drawModel`.
Its type, `Board → Picture`, already tells us how much important it is.
At each simulation step, the model is transformed by a call to `evolve`;
then, our function `drawModel` is called by the [Gloss Simulation Engine][12] to render to model into a Picture.
The definition is a simple pipeline with the following steps:

  1. Create a l × c matrix of same-sized squares - by default they are all black and placed at (0,0)
  2. Paint the squares according to the model
  3. Place them - equally spaced - in a nice grid

Ladies and gentlemen, having understood how to do a simulation step (`evolve`) and how to display the model (`drawModel`), we are almost DONE.
I am only going to show you how the [simulate][13] function from Gloss connects these pieces together.
Our main function is basically just a call to `simulate`, like this:

<script src="http://gist-it.appspot.com/github/joaopizani/katas/blob/blog-05-2012/GlossGameOfLife/GlossGameOfLife.hs?footer=0&slice=11:"></script>

The `simulate` function takes 6 parameters, and while it might seem too much, they all actually make sense:

  1. **display:** defines how gloss is going to show the simulation - the size and position of the window, etc.
  2. **bg:** background color for the drawing area
  3. **fps:** how many simulation steps happen in one second of real time
  4. **initial:** the initial model (that we read from the file)
  5. **drawModel:** a function that transforms the model into a `Picture`
  6. **step function:** a function to advance the model one iteration. We use the lambda to ignore some parameters that are irrelevant for us

THAT'S IT! TADA! Now we are done.
As always, you can download the _cabalized_ package with the source code from my
GitHub repository (<https://github.com/joaopizani/katas/tree/blog-05-2012/GlossGameOfLife>), build and run it as follows:

    $ cd GlossGameOfLife
    $ cabal-dev install

Have fun!

[1]: <http://codekata.pragprog.com>
[2]: <http://codingdojo.org/cgi-bin/wiki.pl?KataGameOfLife>
[3]: <http://hackage.haskell.org/packages/archive/gloss/1.6.0.1/doc/html/Graphics-Gloss.html>
[4]: <http://codingdojo.org/cgi-bin/wiki.pl?KataGameOfLife>
[5]: <http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life>
[6]: <http://hackage.haskell.org/package/parsec-3.1.2>
[7]: <http://hackage.haskell.org/packages/archive/parsec/3.1.2/doc/html/Text-Parsec-Char.html#v:char>
[8]: <http://www.haskell.org/ghc/docs/latest/html/libraries/base-4.4.1.0/Control-Monad.html#v:fmap>
[9]: <http://learnyouahaskell.com/making-our-own-types-and-typeclasses#the-functor-typeclass>
[10]: <http://hackage.haskell.org/packages/archive/parsec/3.1.2/doc/html/Text-Parsec-ByteString.html#v:parseFromFile>
[11]: <http://www.haskell.org/ghc/docs/latest/html/libraries/base-4.4.1.0/Data-Either.html#v:either>
[12]: <http://hackage.haskell.org/packages/archive/gloss/1.6.0.1/doc/html/Graphics-Gloss-Interface-Simulate.html>
[13]: <http://hackage.haskell.org/packages/archive/gloss/1.6.0.1/doc/html/Graphics-Gloss-Interface-Simulate.html#v:simulate>
