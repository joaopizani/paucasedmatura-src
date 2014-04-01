---
title: Install Google Chrome easily on Ubuntu Linux
published: 2009-08-15
pt: pt/blog/tech/google-chrome-ubuntu-linux
---

At the time when [Google Chrome][1] was released, I couldn't wait to test it, mainly because of the faster Javascript engine.
I imagined my e-mail, my calendar, everything running as fast as a bolt of lightning :)

But then Google made the stupid decision to release Chrome only for Windows,
the OS that I'd never use in my day-to-day tasks, **even** if it was free...

So, all of a sudden, my friend JJ said the he had just installed Chrome in his eeePC running Ubuntu.
It's a HIGHLY EXPERIMENTAL version, but it works just nice...
It will make a huge difference in your browsing speed, mainly if you have a netbook.
Here are the steps to install it:

But before anything else: We are going to install [Chromium][2]. No, it's not "Google Chrome".
That's because Google has completely released the Chrome source code under an open license, and then the **Chromium project** was born.
Apart from the name and the Google trademark, Chrome and Chromium are completely the same.

Now to the stuff that matters:
To install the Chromium browser in you Ubuntu machine, copy-paste the following commands into your favorite terminal:

  * To put Chromium's repository in your package sources list: `sudo add-apt-repository ppa:chromium-daily/ppa && sudo apt-get update`
  * Finally, to install Chromium: `sudo apt-get install chromium-browser`

Voilá! Now you can use you favorite browser in your favorite operating system :D

Optional: If you want to completely remove the Firefox browser from your computer (which is **not recommended**),
just issue the following command to remove all firefox-related packages:

    sudo aptitude purge firefox3.0{,-{branding,gnome-support}}

[1]: <http://www.google.com/chrome/?hl=pt-BR>
[2]: <https://launchpad.net/~chromium-daily/+archive/ppa>
