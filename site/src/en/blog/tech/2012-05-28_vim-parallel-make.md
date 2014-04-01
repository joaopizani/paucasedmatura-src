---
title: Integrating parallel make to Vim detecting how many CPU cores you have
published: 2012-05-28
pt: pt/blog/tech/vim-parallel-make
---

I love Vim. I really do.
You can read a truly romantic declaration in my [last post about it][1],
along with some tips that I collected during months of daily Vim usage - all condensed into a nice .vimrc file.
But today, let's add yet another very useful feature to this swiss army's knife - Let's make Vim's `make` feature trigger parallel builds :)

If you write C/C++ code, or by any other means are a user of [GNU Make][2],
you should already know that it's capable of **parallel builds**. If you didn't, then [be enlightened][3].
And, if you use **Vim** to write your C/C++ code,
then you should also know about it's very useful build system integration - triggered by the `:make` command.
To know more about this topic, just check `:help make` in you Vim - I did it right now, as I'm writing this post in Vim...

The thing is: it would be nice to have parallel builds combined with Vim's `:make` command, wouldn't it?
Yeah, you can always type `:make -j [n]` any time you want to build a project, but that'd be really boring, wouldn't it?
A better idea (after checking `:help make`) might be to assign the `makeprg` setting to `make -j [n]` - but then **what number "n" would you put in there**?
My goal is to have my Vim configs in a way that can be used on a lot of **different machines (home, work, etc.)** and **different OS's**,
so the REALLY IDEAL thing would be to setup `makeprg` to call `make` with n equal to the **amount of processor cores available**.
That's exactly what I recently found out how to do, and that's exactly what I'll teach you now. :D

<!--more-->

The following piece of Vim script - which can be copy-pasted right away into your `.vimrc` - will work both
in Windows and in most Unix-like systems (Linux and BSD, but NOT Mac OS X).

<script src="https://gist.github.com/joaopizani/2816940.js"></script>

In Windows the environment variable `NUMBER_OF_PROCESSORS` is defined, in which case we just use it's (numerical) value.
In Unix-like systems we grab the needed information from the [procfs virtual filesystem][4],
more specifically from the `/proc/cpuinfo` file.
We do this by using **grep** to filter the lines that are "headers" of sections describing each processor core, and then count how many of them there are.
In case nothing "intelligent" could be done, the fallback is to use sequential make, i.e, to assume n = 1...

Two nice things about this setup are:

  * **It's non-invasive:** Because it doesn't alter in any way anything other than `makeprg`,
    you can safely put this in your `.vimrc` without fear of interference with any of your other configs.

  * **It's non-restrictive:** The `-j[n]` option given to make doesn't restrict in any way it's behaviour.
    You can continue using any other option you might be using following the `:make` command.

So, guys (and girls), this is enough for today!
Hold on to your seats because... pretty soon I'm going to be publishing my whole suite of cross-platform, modular and easily customizable Vim configs!

[1]: </en/blog/2012/04_simple-useful-vimrc>
[2]: <http://www.gnu.org/software/make>
[3]: <http://www.gnu.org/software/make/manual/make.html#Parallel>
[4]: <http://en.wikipedia.org/wiki/Procfs>
