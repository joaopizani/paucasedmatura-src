---
title: Haskell lottery: a nice and easy example of monads and monad transformers
published: 2012-01-06
pt: pt/blog/haskell/haskell-transformers
---

My humble understanding of monads in Haskell began some years ago, when I heard that IO was a Monad (whatever that was)...
Despite hearing the dreaded "M" word, I wasn't much scared and carried on programming my little Haskell programs,
using `putStrLn`, `getLine`, `readFile`, `writeFile` and etc.
Then, in my 3rd year in college, I decided to implement a graphical app for manipulating finite automata, using GTK ([Gtk2Hs][1]).
During the development of this program, a huge part of my functions started to get "infected" with `IO` in their types,
so I thought it would be a nice idea to think a bit deeper about this "Monad" thing.

At that time I discovered that there are A LOT of monads in Haskell,
and that A LOT of them are useful and popular - even though you might not know that they are monads...
There is the State Monad, Parser monads, Reader and Writer monads, the Error monads, the Either Monad, the Maybe Monad and even the List Monad!!!
YES! `Maybe a` and `[a]` are monads! :D
Well, "all of these things are monads, that's very nice, but why should I care?", you might ask.
I hope to give you just a bit of an answer with the example in this post.

<!--more-->

In this post, I will assume that you have at least some experience with Haskell,
and that you have messed around with at least IO (maybe with Maybe too, hun? :P)...

So, every year we have a tradition in Brazil, which is a big lottery run on December 31st, with a huge prize.
This year my family bought 180 tickets, and I wrote a program to check if any of them had the winning numbers shown on TV.
I wrote this program in Haskell - of course - and this time I was forced to deepen my understanding of monads AND monad transformers to get it done.

The program should work as follows: A file containing all 180 tickets (each with 6 numbers) must be read.
Then 6 rounds of input happen: in each round, the user types a number and the program matches the collection of typed numbers with all tickets.
Then, the 5 tickets with the biggest amount of `lucky` numbers are printed on the screen.
Again, six of these "rounds" must happen.

I started modelling my program from the bottom-up, by defining a datatype to represent a lottery ticket, a `Combination` of lottery numbers:

<script src="http://gist-it.appspot.com/github/joaopizani/katas/blob/blog-05-2012/HaskellLottery/Main.hs?footer=0&slice=9:20"></script>

Notice that a Combination has two [sets of ints][2], a `lucky` and an `unlucky` one.
The lucky one contains the numbers belonging to this combination that "showed up" on TV, while the unlucky ones are the rest...
Also, the Ord instance for Combination is interesting: a combination is **larger** than another if the size of it's lucky set is bigger.
I use `(flip compare)` there just to make clearer that we are defining the notion of "larger" instead of "lesser or equal" (more common).

I then proceeded to implement the parsing of the file into a list of Combination.
This part is a bit out-of-context in this post, but I tried to make nice use of monadic features _even here_:

<script src="http://gist-it.appspot.com/github/joaopizani/katas/blob/blog-05-2012/HaskellLottery/Main.hs?footer=0&slice=22:34"></script>

Comparing the types of `makeCombination` and `makeCombinations`, for example, you see that they have **a lot in common**.
I think that most people would implement makeCombinations as `makeCombinations = map makeCombination`.
I just used [liftM][3] to make very clear that List is a Monad.
Thus, we are lifting the `makeCombination` function **into the List Monad**.
Then, at the definition of `readCombinations`, we have to use `liftM` again, but this time we **lift into the IO Monad**.
So we use `liftM makeCombinations`. The expression `liftM makeCombinations` has type `IO [[Int]] → IO [Combination]`,
and `readMatrix` has type `FilePath → IO [[Int]]`, so the types match nicely and allow an elegant composition, like this :)

    (FilePath → IO [[Int]]) ∘ (IO [[Int]] → IO [Combination]) ≡ (FilePath → IO [Combination])

Going further down the code, we reach the "core" function of our lottery checker:
a function called `matchWithCombination`, which takes a `probe` (a number that showed up on TV) and one combination,
returning a new combination with its lucky and unlucky components updated in case of a `match` with the probe:

<script src="http://gist-it.appspot.com/github/joaopizani/katas/blob/blog-05-2012/HaskellLottery/Main.hs?footer=0&slice=36:40"></script>

We use IntSet.intersection to "match" the probe with the unlucky numbers, then update the current lucky set, by uniting it with the new lucky guy.
The definition of `matchWithCombination` also shows a nice syntactical feature of Haskell:
allowing us to both define AND use functions in **infix** form, by just putting backticks around the function name.
Well.. we now define matchWithCombinations, very obviously: it's ALMOST just a map (a lift to the List Monad),
but we need to keep the probe argument as it is (unlifted), so that's why the partial application:

<script src="http://gist-it.appspot.com/github/joaopizani/katas/blob/blog-05-2012/HaskellLottery/Main.hs?footer=0&slice=41:43"></script>

Our program is now quite full-featured.
Using matchWithCombinations, we can already take a number and see where it appears on all tickets.
Two of the requirements we defined earlier are lacking, though:

  1. We need input (the user needs to **type in** the numbers in the terminal) and output (print the top 5 tickets on the terminal)
  2. We need to perform 6 (input → process → output) "rounds"

Our `matchWithCombinations` function can only do ONE "update" step,
so we need to keep "threading" the results of calls to it in a chain, like this (sort of):

    (matchWithCombinations <user-input> (matchWithCombinations <user-input> (matchWithCombinations <user-input> originalCombs)))

Usually, to accomplish this sort of "threading of a state" between function calls, we use the (obviously named) [State Monad][4].
And, as you might have already guessed, to perform input and output, we use the almighty **IO Monad**.
It's nice to see how each "layer of functionality" in your program corresponds to a layer in the **"Monad onion"** that your program becomes.
So here we need to **combine** State and IO, two monads... Keep this in mind.

In a slight detour of our monad-combining craze, let me introduce you to the simple and humble `askForNewNumber` monad (a function in the IO Monad).
Its task is to read a line of input from the terminal and (do its best) to convert it to an Int:

<script src="http://gist-it.appspot.com/github/joaopizani/katas/blob/blog-05-2012/HaskellLottery/Main.hs?footer=0&slice=45:47"></script>

Now we want to use `askForNewNumber` in a more sophisticated monad, called `includeNewNumber`.
The `includeNewNumber` monad will keep a **state** consisting of our combination list,
and will (each time it's called) read a number from the terminal and update the state with the newly matched combinations.
The type of `includeNewNumber` has to be a combination of IO (because it uses `askForNewNumber`) and State. But how can we combine two monads??

Well, the good news is that we can usually combine two monads into **another monad**, by using this nifty thing called **"monad transformers"** :P
In our case, we want to "transform" mere IO into a `State IO`.
Look at the beautiful definition of `includeNewNumber` by yourself:

<script src="http://gist-it.appspot.com/github/joaopizani/katas/blob/blog-05-2012/HaskellLottery/Main.hs?footer=0&slice=48:53"></script>

Literally, the type of `includeNewNumber` is `StateT [Combination] IO ()`, which means that we applied the **"State Transformer"** to the IO Monad,
the type of our state being `[Combination]` and the type returned by IO being () (the unit type).
StateT "wraps" IO with a layer of State, so now our program "onion" has officially two layers of functionality!
Nice, hun!? :D Before going on, just one little explanation: **IO must always be the innermost layer**,
mainly because when running the program all other layers are "peeled off", and `IO ()` is what we need to give to `main`.
The task of "peeling off" IO itself lays with the Haskell runtime system, and is out of our control :)

In the body of `includeNewNumber`, we need again to lift `askForNewNumber`, so that it resides on the outer StateT layer.
After getting the probe we modify the state held by the monad using `matchWithCombinations probe`.
Now we are VERY close to getting this program DONE®. In fact, we are so close that we could now run `includeNewNumber` six times...
the numbers would be read and the combination list would be updated correctly; the only problem is that nothing would show up on the screen :(

Of course we are going to implement the last requirement (print the top 5 combinations after each round), but this optionality shows that monads
(and monad transformers) allow you to write software in a very **composable** way, in which independent features are implemented in independent code.
A very high [Separation of Concerns][5] indeed.
Let's go on then with the implementation of our "feature full" function: `includeAndPrintTop5`

<script src="http://gist-it.appspot.com/github/joaopizani/katas/blob/blog-05-2012/HaskellLottery/Main.hs?footer=0&slice=54:58"></script>

We first include a new number and get the (already updated) combinations state into `combs`.
Then we pass `combs` through a pipeline which will print the top 5 combs on the screen.
At the end of the pipeline, we need `lift` again, to transform the `IO ()` returned by putStrLn into the desired `StateT [Combination] IO ()`.

Dear reader, **behold!** Now comes the end of this post:
I will show you the implementation of `main` for the lottery program....
With 2 lines of code! :)

<script src="http://gist-it.appspot.com/github/joaopizani/katas/blob/blog-05-2012/HaskellLottery/Main.hs?footer=0&slice=60:63"></script>

First things first: we read the file into the suggestively-named `initial` value.
We also need to perform 6 rounds of `includeAndPrintTop5`. That's what `replicateM_ 6` is doing for us.
If you want, you can do this repetition manually, like this:

```haskell
execStateT (includeAndPrintTop5 » includeAndPrintTop5 » includeAndPrintTop5 »
            includeAndPrintTop5 » includeAndPrintTop5 » includeAndPrintTop5 » return ()) initial
```

Finally, we use execStateT to "peel off" the State Transformer and leave the rest of the job to our friend, IO ().
The arguments to execStateT are the state monad it needs to "exec" and an initial state.
It then runs the monad and doesn't care about what is returned (in case you want the returned value, `evalStateT` is for you).

DONE! TA-DA! :D
Please, do not believe my black magic.
Grab the code on my "katas" GitHub repository <https://github.com/joaopizani/katas> and run for yourself, then change it and play with it...
Have fun :)

PS:

1. If you played with lists before (you should have), you will know the `replicate` function from `Data.List`...
   Indeed, `replicateM_` and `replicate` work VERY similarly. Take a look (≡ means "is equivalent to"):

    ```haskell
    replicate 6 1   ≡ 1 : 1 : 1 : 1 : 1 : 1 : []
    replicateM_ 6 m ≡ m » m » m » m » m » m » (return ())
    ```

   Now you can already start to imagine how List is a monad, can't you? ;)

2. If you want to really know how `1 : 1 : 1 : []` and `m » m » m » (return ())` are related, take a look at the source code.
   Seriously, it's [HERE][6].


[1]: <http://projects.haskell.org/gtk2hs/>
[2]: <http://hackage.haskell.org/packages/archive/containers/0.4.2.0/doc/html/Data-IntSet.html>
[3]: <http://hackage.haskell.org/package/base-4.7.0.2/docs/Control-Monad.html>
[4]: <http://www.haskell.org/haskellwiki/State_Monad>
[5]: <http://en.wikipedia.org/wiki/Separation_of_concerns>
[6]: <http://hackage.haskell.org/package/base-4.7.0.2/docs/Control-Monad.html#sequence_>
