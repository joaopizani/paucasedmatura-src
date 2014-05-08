---
title: Modular XPlatform Vim Config - With LASERS!
published: 2013-03-11
pt: pt/blog/tech/modular-xplatform-vim-cfg-with-lasers
---

TL;DR: See the [README file][1] on the [repository][2]

Around June 2012 I [wrote a post here][3] describing my very own Vim config "distribution",
the result of several months of DAILY, intensive use (and tuning and refactoring) of this editor.
This distribution is completely modular and self-contained.
Besides, I tried to follow closely the principle of "graceful degradation".
But, what does that all mean?

  * **Self-contained** means that, using Vim with this config distribution will not "spill over" files all over your filesystem.
    They will ALL be in a SINGLE directory. To clean everything up, just delete that single place.
    Also, you can move the distro wherever you want, you can put it on a thumbdrive and use it on any computer.

  * **Modular** means easier to understand and adapt/improve, both for me and for other people.
    The "distro" is made of a consistent and small choice of plugins, along with files containing "reasonable defaults" for these plugins.

  * **Graceful degradation** means that I try to do the most that I can, but imposing as little requirements on your system as possible.
    If something can't be enabled, it just _stays out of the way_, with no annoying errors.
    Also, the defaults try to be as non-invasive as possible.
    The most frequent an action is, the simplest it should be to perform it.

So the good news is that since last summer this vim distribution improved a lot,
and I consider it now stable and useful enough to be interesting to the general public of programmers using Vim for work and fun,
as well as for beginners who want to see this awesome editor in its full glory...

So without further ado, it's pointless to repeat here what is already being said in the [README][1] file,
hosted on the [GitHub repository of the project][2].
Go there, follow the instructions, have some fun, see if you like it and send me some criticism/suggestions :)

[1]: <https://github.com/joaopizani/modular-xplatform-vim-cfg/blob/master/README.md>
[2]: <https://github.com/joaopizani/modular-xplatform-vim-cfg>
[3]: </en/blog/tech/modular-xplatform-vim-cfg>
