---
title: Multiarchitecture toolchain buildscripts
published: 2012-04-17
pt: pt/blog/tech/multiarch-toolchain-buildscripts
---

As some of you might have known,
lately I've been messing with some embedded systems programming, more specifically with the AVR series of 8-bit microcontrollers.
Well, I also like to be on the so called "bleeding edge" when it comes to software,
always running the latest stable versions of everything...
So the first step when I wanted to program in C for AVR was to get hold of a fairly recent version of the [GNU Compiler Collection][1].

[1]: <http://gcc.gnu.org/>

Some time ago I had trouble trying to compile a complete C/C++ toolchain for AVR,
but this time I summoned all my skill, patience and shell-script kung-fu,
which this time resulted in a QUITE NICE and generic toolchain buildscript, I must say.
But first, before diving into my work, let me just _thank the GCC team from the bottom of my heart!_
You guys (and girls) are great! :D

<!--more-->

Still before I show you the code, here are some important remarks about the script(s),
which BTW you can find here - <https://github.com/joaopizani/multiarch-toolchain-buildscripts> :

  * It works not only for AVR, but for other archs also (tested and confirmed with MIPS, for example).

  * The "script suite" has a generic part (completely immutable) and a file with some variable definitions.
    If you want to compile for another architecture - or add more tools to the build - you just have to redefine SOME of these variables.

  * The scripts are not only multi-target but also multi-host (have been tested on Linux and Mac OS X - both 32 and 64-bit)

  * There are already sensible defaults for AVR and MIPS. In the AVR case, at the end of the build you get:
      + Binutils 2.22
      + GCC 4.7.0
      + AVR-Libc 1.8.0
      + SimulAVR 1.0.0
      + GDB 7.4
      + AVRDude 5.11.1

So, enough propaganda, let me first show you the generic part of the buildscript suite,
which is supposed to be "called" (sourced) from the (target-specific) variable definitions file:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/multiarch-toolchain-buildscripts/blob/master/build_toolchain.sh?slice=4:80&footer=no"></script>

Of course the heart of all action involved in this piece of shell script is the usual pipeline:
**Download packages - Unpack - Configure - Make - Make install**.
All done using some shell-script kung-fu such as shell metaprogramming (using `eval`) and shell arrays.
With this, you can get:

  * A **completely self-contained** toolchain setup for a certain architecture.
    You just need to add the `bin` directory to your path, and to remove the toolchain (in case you don't like it),
    you need only to remove the complete toolchain dir.

  * No need for super-user permission anywhere: the whole download, build and install process is done completely in user land,
    and you define the parent directory where the toolchain will be installed.

  * Completely **incremental** build pipeline: in case anything goes wrong during the build and you have to start it over
    (with another set of configure flags), the build will proceed **from where it stopped**.
    Files are only downloaded if not present, only unpacked if not already unpacked,
    packages are only reconfigured if the flags are different and only the needed parts are rebuilt.
    Furthermore, in the first sign of an error during the build, the whole process is halted, so that you don't keep wasting effort...

Okay, so after taking this look at the generic "core" of the script suite, take now a look at what a target-specific part looks like.
This is a "template", which you should fill with some definitions (mostly target architecture, package versions and configure options).
Fill this and run, it's as simple as that!

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/multiarch-toolchain-buildscripts/blob/master/build_template_toolchain.sh?slice=13:70&footer=no"></script>

WOW, I know, that's a lot of comments... :)
But really, I wanted - as much as possible - everyone to understand what's going on and what the variables mean.
So, after you read the whole thing, don't believe me:
grab the script suite - at <http://github.com/joaopizani/multiarch-toolchain-buildscripts> - and build a toolchain yourself!
For AVR, MIPS, ARM or whatever arch you want...
And of course, help me fix problems with pull requests :)

