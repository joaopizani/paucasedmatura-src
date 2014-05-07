---
title: Use subversion on Linux directly through the Nautilus file manager
published: 2009-09-06
pt: pt/blog/tech/subversion-nautilus
---

I use Subversion, a lot.
And most of the time I use it in Linux, to manage all my programming projects.
I've always thought that using SVN through its command-line was a **pain in the ass**,
and I also didn't want to install yet another program just to have a graphical interface to Subversion.

Actually, SVN's command-line interface is intuituve.
Problem is that I really _dislike repetitive tasks_,
and I cannot type very fast (at least not [without looking at the keyboard][1]).
So I found an absolutely fantastic **Nautilus plug-in** for the task, and it was just what I was looking for!

I bumped into the [NautilusSVN][2] project while looking for some open-source project to help translate.
It's a plugin enabling you to perform actions such as checkout, update, commit, add and log right at the Nautilus context menu.

Currently the plug-in supports only the Subversion VCS (as the name implies), but,
according to the developers, soon there will be support for other systems, such as Git.
Let's then quit the chit-chat and proceed to install NautilusSVN.

The following instructions are to install NautilusSVN on **Ubuntu Linux**.
If you use any other distro, there are instructions on the [project's download page][3].
For Ubuntu, just follow these steps:

  1. Get the `.deb` package from the project's site: `wget http://nautilussvn.googlecode.com/files/nautilussvn_0.12-1ubuntu2_all.deb`

  2. Install the package, along with its dependencies: `sudo gdebi nautilussvn_0.12-1ubuntu2_all.deb`

  3. Open the "Run" dialog (`Alt+F2`) and type in the command `nautilus -q` to close nautilus:
     ![killing_nautilus](/files/imgs/2009-09_matando_nautilus.png)

  4. Open the "Run" dialog again, but this time type `nautilus` to restart Nautilus, now with the SVN plugin active.

![Restarting Nautilus](/files/imgs/2009-09_reiniciando_nautilus.png)

Isn't the world of Open Source wonderful?!
Now commits, updates, checkouts, adds and ignores are one right-click away :)

![Nautilus context menu](/files/imgs/2009-09_nautilussvn_contexto.png)

[1]: <http://en.wikipedia.org/wiki/Touch_typing>
[2]: <http://code.google.com/p/nautilussvn/>
[3]: <http://code.google.com/p/nautilussvn/wiki/Installation>
