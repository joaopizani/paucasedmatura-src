---
title: Updated screenrc: Even more perfect!
published: 2013-03-02
pt: pt/blog/tech/screenrc-ftw
---

Almost one year ago I wrote a [post][1] about GNU Screen, a great terminal multiplexer which I enjoy very much...
This post was about my screenrc config file,
which had accumulated a lot of useful customizations I gathered from the net during years of daily usage.

Well, while the "core" of these customizations remains the same, some things changed in the last months:
I organized and refactored the configuration even more, published it on [GitHub][2]
with a very nice README file and also added some new functionalities...

Some of the keyboard shortcuts were improved, some were added, but the biggest additions are related to Screen's **multiuser** mode:
something which is very useful for remote pair-programming sessions.
So, there you have it, take a look at the simple [instructions][3]
and start using Screen in a much more efficient and **comfortable** way :)

**PS:** To be able to unleash all the power of all the customizations, you need to be running a reasonably recent version of Screen.
Unfortunately, most Linux distros are unreasonable, and still ship very old versions of Screen...
If you use some Debian-based distro, you can download [the screen .deb package (from Debian Unstable)][4].
In the case you use Arch Linux, there is a [recent Screen package on AUR][5].

**EDIT (2014-05-01):** GNU Screen version 4.1.2 was released, and Arch Linux includes it in its repositories.

[1]: </en/blog/tech/gnu-screen-config-winners>
[2]: <https://github.com/joaopizani/env.screenrc-ftw>
[3]: <https://github.com/joaopizani/env.screenrc-ftw/blob/master/README.md>
[4]: <http://packages.debian.org/wheezy/screen>
[5]: <https://aur.archlinux.org/packages/screen-git>
