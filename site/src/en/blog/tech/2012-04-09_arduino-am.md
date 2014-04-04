---
title: Arduino AM transmitter
published: 2012-04-09
pt: pt/blog/tech/arduino-am
---

Two years ago I bought an [Arduino Duemilanove][1], after having completed a course in college about microcontrollers...
I then followed the classic tutorials that every beginner (every n00b) follows:
LED blinking, serial communication and square wave generation for playing "music" with a buzzer...
But after this "honeymoon" period,
I suddenly didn't feel so enthusiastic about the whole thing anymore and put my Arduino to a good rest in my desk drawer.

Only recently I felt like tinkering with my little AVR µController again,
and luckily I could find a friend that shared the same enthusiasm - [Tarcísio Fischer][2].
Together, we decided we were going to design and code an AM radio transmitter made of only one Arduino.
The idea is to emit the AM signal so that it can be received by cheap, commodity radios you can find around the house,
and this project's MOST important point is that NO analog component whatsoever should be used.
The generation of the carrier wave itself (at approx. 550KHz), as well as the generation of the modulating signal should all be done by the Arduino alone.
Then we can just stick a long wire (an antenna) into a digital output and enjoy our radio \o/

<div id="imgdiv-am"><style type="text/css" scoped> #imgdiv-am img { width:500px };</style>

 ![Poor man's Arduino AM Transmitter](/files/imgs/2012-04_arduino-am-sshot.png)

</div>

<!--more-->

Well, we spent some good days programming the whole thing, but I shall say the results are pretty EPIC!
I posted the first two videos on YouTube of what is supposed to be an Arduino AM trilogy:
the first one was posted on April, 1st (but I SWEAR it's all true) and the second one yesterday.
The source code will be posted as soon as possible:
I'm only waiting for a code review session with [Tarcísio][2] and then we can send it to GitHub...

Meanwhile, a bit of fun. Enjoy the videos!  In the first episode, the transmitter itself Works®, but the code is still full of hardcoded "magic" numbers.
The transmitter can only generate a carrier of 550KHz, and I had no idea what the signal frequency was:

<iframe src="http://www.youtube.com/embed/u9-OP354o0E?rel=0" frameborder="0" width="480" height="360"></iframe>

Then in the second episode you can already see some big improvements (although the improvements will be much more obvious when you read the code):
Everything is now nicely modularized and split into separate static libraries (.a files).
One library (libavram.a) is resposible for carrier wave generation, and the other (libavrtone.a) for modulating this carrier in a flexible way.
Well, really, libavrtone.a can also use a different "backend":
I've written libavrbuzzer.a that, as the name implies, is responsible for toggling a digital pin on demand from liabavrtone - so as to generate a sound wave.

<iframe src="http://www.youtube.com/embed/SCeraTloUNA?rel=0" frameborder="0" width="480" height="360"></iframe>

I hope that through the following weird and completely non-standard diagram you can get a clue of how libavrtone.a collaborates with both backend libraries to play frequencies, respectively, on a buzzer and through AM radio:

![AVR Sound Libs](/files/imgs/2012-04_AVRSoundLibs.png)

So that's all for now, folks...
Time to go back to high-level C++ work and "normal" life for a while.
As soon as I can find some time, I'll upload the AVR AM code to GitHub and also post it here on the blog with some comments.
Soon our mighty Arduino Morse AM transmitter will be DONE®.

[1]: <http://arduino.cc/en/Main/arduinoBoardDuemilanove>
[2]: <http://tarcisiofischer.wordpress.com/>
