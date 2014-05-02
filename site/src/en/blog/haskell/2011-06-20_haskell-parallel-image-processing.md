---
title: Haskell image processing - easy and automatically parallel
published: 2011-06-20
pt: pt/blog/haskell/haskell-parallel-image-processing
---

One of the topics we learn in the Pattern Recognition course here at [UFSC][1] is pattern recognition devired from image processing.
Our final course project is to implement a selective intrusion detector that uses only a webcam...
This is pretty complicated, and involves several processing steps, much more dificult tham it might seem at a first glance :)

One of the most common processing steps performed to identify objects in an image is [edge detection][2].
Our first course assignment is to implement the [Roberts Cross][3] edge detection algorithm.
Because of my wish to get up-to-speed and review my [Haskell][4] knowledge,
and also because this sort of algorithm fits **perfectly** the functional paradigm, I decided to give Haskell a shot!
I'll then show you the code, the pretty images and report my (almost painless) experience implementing it :P

[1]: <http://ufsc.br>
[2]: <http://en.wikipedia.org/wiki/Edge_detection>
[3]: <http://en.wikipedia.org/wiki/Roberts_Cross>
[4]: <http://www.haskell.org/haskellwiki/Haskell>

![Dutch Haskell](/files/imgs/2011-06_haskell-nl.png)

<!--more-->

One of the strongest selling points of functional programming is that code written according to the paradigm can be easily parallelized.
Roberts edge detection consists, for example, of nothing more than scanning an image, pixel by pixel,
and applying a small matrix of coefficients that calculates the weighted average of brightness (it's called Convolution by the guys at Wikipedia).
Well, this sort of algorithm is INHERENTLY parallel, and we can divide the task among as many threads as we want,
without changing the semantics of the code.
This is **exactly** what the [Repa][5] library does:
it allows you to easily express several algorithms over multidimensional arrays and have them parallelized automatically.

[5]: <http://hackage.haskell.org/package/repa>

Without any more explanation, here goes an example of executing the "Roberts" program on 1 thread, for a 1024x768 image:

**Original image:**

![WoW original](/files/imgs/2011-06_wow.png)

**Edges:**

![WoW edges](/files/imgs/2011-06_wow_.png)

Execution time (some of it is IO-bound):

    real	0m7.112s
    user	0m7.044s
    sys	0m0.020s

Now executing it on 2 and 4 threads, the only difference is that you need to run the program with some arguments on the command line:

    Roberts wow.png wow_bordas.bmp +RTS -N{2,4}

With 2 threads:

    real	0m4.000s
    user	0m7.176s
    sys	0m0.076s

With 4 threads:

    real	0m3.096s
    user	0m8.509s
    sys	0m0.456s

Disconsidering some synchronization overhead, the speedup in execution time is almost linear \o/\o/.
I admit that processing time is still a bit high, but taking into account that I'm a complete newbie, the results are promising!

I'm gonna even show you the code, because it's really beautiful and reasonably small:

<script src="https://gist.github.com/2718546.js"> </script>

A TOTAL of 45 lines of code, including reading and writing from/to files. Amazing, isn't it? :)

