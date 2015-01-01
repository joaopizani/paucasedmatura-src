---
title: GNU Screen config for the winners
published: 2012-03-28
pt: pt/blog/tech/gnu-screen-config-winners
---

**UPDATE (2013-03-01)**: [New version](/en/blog/tech/screenrc-ftw)
of the config file described in this post available, more organized and with new exciting features :)**

Some 3 or 4 years ago I met a nice software called "GNU Screen" for the first time...
For those of you who never heard about it, [GNU Screen][1] is a "terminal multiplexer, or, a text-mode window manager".
With Screen, you can have several virtual terminal "windows" in only one real terminal.
Also, you can "detach" a Screen session from a terminal,
leaving the programs in that session running in the background, and then come back to look what happened.
This was actually my main use case: I used screen for quitting an SSH connection but leaving something running...

[1]: <http://www.gnu.org/software/screen/>

Well, after this first "honeymoon" period, I mostly abandoned Screen for a long time.
Only recently I decided to give it another chance, to see what has evolved.
And YEAH, I found that Screen has evolved a lot and can be much more useful than I tought.
So, after mashing up several pieces of configuration from all over the web, I now present you the **GNU Screen killer config** file.

<!--more-->

Hold on, I'm going to show you the file in a second.
It's nicely commented and easy to understand, but just let me first summarize what it's all about:

  1. **Nicer keybindings:** Screen has some hard to use shotcut keys.
     For some actions, there are even NO shortcuts.
     So I chose some nice mappings like F3/F4 for previous/next window and Ctrl+(left/right/up/down) for directional navigation between regions.

  2. **Default windows:** I have chosen to make Screen always launch 4 windows on startups.
     Two "work" shells, one shell for "media" and one for testing programming stuff (currently Python is being launched).
     They are all nicely named...

  3. **Easy region resizing:** No more typing long commands just to resize a region...
     By typing F2 screen enters "resize mode", and then you can use h/j/k/l keys to increase/decrease the width and length of a region.

  4. **Default layouts:** Also, one nice recent feature of screen is layout management.
     Screen can remember a particular arrangement of horizontal/vertical splits and you can toggle between these "layouts".
     In my killer config file, I setup three layouts, respectively, with one, two and three regions.
     You can change layout by using Ctrl-F3/Ctrl-F4 (prev layout/next layout).

So, after this (too long, I suspect) summary, here comes the code.
Keep reading after that, there are still some good news :)

<script type="text/javascript" src="https://gist.github.com/2718397.js?file=.screenrc"></script>

Paste this code into a file called ".screenrc" in your home directory, and have fun!

As you could notice, with this killer screenrc file, we also get a nice status bar, 256 colors,
the ability to change focus by clicking on the region and to scroll the rollback buffer by using the mouse's wheel.
Here's a screenshot of my **awesome** terminal:

![Nicely configured GNU Screen](/files/imgs/2012-03_gnu_screen_ss.png)

Just one last remark: you need a pretty recent GNU Screen version to be able to use this config,
and unfortunately most Linux distros come prebundled with PAINFULLY old versions of it.
So you have two alternatives: either download and compile Screen from source (it's not as hard as you might think),
or - in case you use Ubuntu - use this PPA: **ppa:eugenesan/ppa**.
Here is how to install the latest screen in Ubuntu, using the PPA:

```bash
sudo aptitude purge screen  # removes current Screen
sudo apt-add-repository ppa:eugenesan/ppa
sudo aptitude update && sudo aptitude install screen  # installs new screen
```

That's all, folks! :)

