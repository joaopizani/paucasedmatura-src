---
title: Playing with drawings and animations in Haskell
published: 2012-01-04
pt: pt/blog/haskell/gloss-haskell
---

It's an old adage of the computing profession that "Computer programming is the most fun you can have with your clothes on",
and certainly the most fun you can have with programming is when your program **draws** something on the screen, or when your program shows an **animation**.
It's one of those activities that can make you spend hours late at night...

On December 31, 2011, I spent my morning and afternoon writing a program that would help me check if I had won the national New Year's lottery.
Of course, being such an important program, it HAD to have a nice, beautiful graphical interface.
And of course the language I was going to use was Haskell; after all, I wanted to have some **FUN** writing it :)

<!--more-->

I remembered that some months ago I came across the fantastic [gloss][1] library for Haskell,
but didn't have much time to play with it... so I decided to give "gloss" a try this time.
Gloss is a Haskell library that allows the user to create and run 2D static images, animations and GAMES!
It runs on top of OpenGL, so - if you have a reasonable graphics card - your game can even be fast :)

What I needed to draw in my lottery program was actually too simple and boring (just some colorful numbers),
so in this post we'll create a nicer animation with gloss: we will design a clock!
Yes, a classic analog clock with three dials, sort of...

First of all, a huge part of the stuff that gloss manipulates has the type [Picture][2].
And there are several convenient functions for creating fundamental pictures and transforming one picture into another.
In fact, there is a "rectangleSolid" function, which is exactly what we need to create the dials of our clock.
Here's a black 50px by 200px rectangle:

```haskell
rectangleSolid 50 200
```

We need three of these rectangles for our "clock", one for each dial (seconds, minutes, hours).
And each of them has a differente length.
So this is how we defined our dials:

```haskell
baseLength w = 0.75 * w
secondsDialLength x = baseLength x
minutesDialLength x = secondsDialLength x * 0.75
hoursDialLength x = minutesDialLength x * 0.70

baseDial = rectangleSolid 15
secondsDial x = baseDial (secondsDialLength x)
minutesDial x = baseDial (minutesDialLength x)
hoursDial = baseDial . hoursDialLength
```

I made the length of our dials variable, and it all depends on the parameter of "baseLength", which is "w".
This is going to be the width of our clockface.
You can see that we have three FUNCTIONS defining the dials, so the dial lengths are variable, but the **proportion** between the dials is fixed by us...
Besides, all dials have the same width, so that's why we defined "baseDial = rectangleSolid 15".
We are able to "fixate" or "bind" one parameter of rectangleSolid to 15, thus "baseDial" needs only one more parameter, which is the dial's length.
This ability to "bind" functions partially is a very nice feature of Haskell called "currying".
Chech it out here if you want to know more: [Currying][3].

```haskell
hoursDial = baseDial . hoursDialLength
```

The definition of "hoursDial" in the last line of the block seems to be very different from the others, doesn't it?
hoursDial is still a function, but where is it's length ("x") parameter??
Well, we don't need it, because hoursDial is defined as a **composition** of the functions hoursDialLength and baseDial.
Remember high school?

    (f ∘ g)(x) = f(g(x))

So now compare the two definition of hoursDial below, substituting "baseDial" for "f" and "hoursDialLength" for "g".
Nice, hun?

```haskell
hoursDial x = baseDial (hoursDialLength x)
hoursDial = baseDial ∘ hoursDialLength
```

Very often in Haskell we can use function composition to make code look less verbose (with less "dirt") and easier to read.

Now, going on with our clock! Until now, we have got 3 nice **static** dials. We now need to make them move :)
In gloss, we can make our pictures move by adding an extra parameter to the picture definition: the **time**.
Take a look at this:

```haskell
movingSquare t = rotate (90 * t) (rectangleSolid 100 100)
```

Our "movingSquare" is now an animation. Animations have type (Float → Picture), i.e, they are functions that give us _a picture (a frame) for each instant of time_!
Cool idea, don't you think? The time parameter ("t") is the number of _seconds elapsed since the beginning of the animation_.
Thus, in the example above, we are rotating our little square 90 degrees per second...

But the seconds dial of our clock needs to turn 6 degrees per second (in order to turn 360 degrees in one minute).
And the minutes dial needs to be 60 times slower than the seconds dial, and so on...
Thus, that's how we define the speeds of our dials:

```haskell
secondsRotationSpeed t = 6 * t
minutesRotationSpeed t = secondsRotationSpeed t / 60
hoursRotationSpeed t = minutesRotationSpeed t / 60
```

Our speed functions define how much a dial is turned (degrees), according to the time (seconds) elapsed.
And now, with the speeds defined, we can very easily define our "moving objects" - our animated clock dials:

```haskell
seconds x t = rotate (secondsRotationSpeed t) (secondsDial x)
minutes x t = rotate (minutesRotationSpeed t) (minutesDial x)
hours x t = rotate (hoursRotationSpeed t) (hoursDial x)
```

They still take that length parameter ("x"), but now they also take the time parameter ("t").
And the "core of the movement" here is the function "rotate".
The amount to rotate depends on the time, and the picture to be rotated is parameterized by the length we give ("x").

Well, well, well... We can have now our clock.
It will be very minimalistic (Apple style :P), so it will ONLY contain three dials and nothing more.
If you have some Pictures, and want to build one single Picture out of them all, the appropriately named "pictures" function from gloss can help you:

```haskell
clock x t = pictures [dial x t | dial <- [seconds, minutes, hours]]
```

Our clock is an animation, so it has that trailing time ("t") parameter, plus it has a variable size, which we pass throught the x parameter.
We take each of our animated dials, and apply the SAME parameters to all of them.
What it means, of course, is that "global time" "runs" at the same speed for all dials.
This is not the case when the clock travels close to the speed of light, but nevertheless... :P

As a final touch of elegance, however, I wanted to add the possibility of accelerating time :)
With the function "variableSpeedClock" below, we can make a second in our animation take less (or more) than a second in the real world.
Take a look:

```haskell
variableSpeedClock speed x t = clock x (t * speed)
```

We multiply t by the speed parameter, so (quite obviously) the larger the value of speed, the quicker one "second" will be.

That's it, that's our FULL funky minimalistic analog clock.
We can now RUN the animation by calling the (also appropriately called)
[animate][4] function from gloss:

```haskell
animate (InWindow "GlossClock" (size, size) (200,200)) white (variableSpeedClock speed' size')
```

In case you want to run the code and see the beauty for yourself, there are two possibilities:

  1. Install the [Haskell Platform][5] in your computer (for Ubuntu: "sudo apt-get install haskell-platform"),
     and afterwards install gloss (typing "cabal install gloss").
     You can them grab the full code [here][6], compile it with "ghc --make Clock.hs" and RUN!

  2. Using this [BEAUTIFUL GLOSS WEB INTERFACE][7]:
     Copy the code from [HERE][8], paste it into the text field on the page and click "run"!

And never forget, fiddle with the code, change it and have fun! The code is licensed under Creative Commons sharealike bla bla bla... :D

Thanks to [Ben Lippmeier][9] for creating gloss, and thanks a lot to Chris Smith for creating the gloss web interface.
Chris has also taught an awesome [Haskell for kids][10] course, which was very inspiring to me...
That's how I WANT to teach my kids about computers :)

[1]: <http://gloss.ouroborus.net/>
[2]: <http://hackage.haskell.org/packages/archive/gloss/1.6.0.1/doc/html/Graphics-Gloss-Data-Picture.html>
[3]: <http://www.haskell.org/haskellwiki/Currying>
[4]: <http://hackage.haskell.org/packages/archive/gloss/1.6.0.1/doc/html/Graphics-Gloss-Interface-Animate.html>
[5]: <http://hackage.haskell.org/platform/>
[6]: <http://hpaste.org/56079>
[7]: <http://dac4.designacourse.com:8000/>
[8]: <http://hpaste.org/56080>
[9]: <http://www.cse.unsw.edu.au/~benl/>
[10]: <http://cdsmith.wordpress.com/2011/08/16/haskell-for-kids-week-1/>
