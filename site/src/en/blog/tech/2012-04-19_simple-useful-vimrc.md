---
title: Make your Vim a bit better: a simple but very useful vimrc
published: 2012-04-19
pt: pt/blog/tech/simple-useful-vimrc
---

Since my second or third year in college I was already flirting with [Vim][1],
as if Vim was THAT girl - you know - the girl of my dreams:
I admired it, I knew it could make my life happier and also less stressful.
On the other hand, I knew Vim would require time, effort and **commitment**.
So after some "one week stands", last year I finally decided to **commit to Vim**.
Well, even though the **honeymoon is over**, I'm still learning more about [vim every day][2], and admiring it more and more.

Enough with the weird girlfriend metaphor,
one of the first things that anyone seriously considering Vim should try to learn is how Vim's configuration system works.
Every single piece of customization for Vim is organized in simple plain text files,
written in a simple but powerful language called [Vimscript][3].
A big part of the power and general awesomeness of Vim comes from the great deal of **extensibility** provided by Vim scripts
(that's how files written in the _Vimscript_ language are known).
In fact, there are hundreds (if not thousands) of useful plugins for Vim - along with some [not so useful but still awesome ones][4].

I use lots of plugins and have them organized in a nice way, but that's another post.
Today, I want to start slowly and just show you what I use as my "basic" Vim configuration file - how my **.vimrc** looks like.

A file called `.vimrc` sitting on the user's home directory is the main point where Vim looks for configuration directives upon startup.
The file below is not exactly my _whole_ `.vimrc`, but a big part of it (the plugin-independent part).
There it goes:

<!--more-->

<script src="https://gist.github.com/2417865.js?file=.vimrc"></script>

Even though it might seem like this file does A LOT of things, still it can be summarized to some **highlights**:

  * It **segregates all metafiles**: Vim has some nice features - persistent undo, persistent views and backups.
    With them you can, respectively, undo changes after closing and reopening a file,
    and jump to the point where you were before closing and recover in case of a crash.
    Sadly, these features can pollute your directories with metafiles (the best-known plague being those files which names end with a tilde).
    The configuration in my `.vimrc` puts ALL THOSE METAFILES in a **centralized** directory defined in the VIMROOT variable (first line of the script).

  * **Solves the tabs vs. spaces flamewar, in favor of spaces**: That's what those 6 lines right in the beginning of the script do.
    The configuration follows these principles:
      + No **actual tab characters (\\t)** are ever going to be inserted in the text being edited.
      + One level of indentation (conceptually) corresponds to 4 spaces.
      + The tab characters present in the files opened by vim will **be displayed** with a width of 4 spaces.
      + Pressing the TAB key on the keyboard will insert 4 spaces.
      + Except when we are editing Makefiles: then an actual tab char will be inserted (the Makefile syntax NEEDS an actual tab there).

  * Sets up the interface nicely, both with and without a GUI (GVim): Number of lines, columns, 256-color mode, and the font, are all set.
    In case of a GUI, the toolbar and menu are removed to make room for more text
    (using a toolbar with Vim is REALLY not needed and I risk saying it's even the WRONG thing to do).

  * **Maps the keys from F5 to F10 for common tasks** such as going to the next compilation error, switching from header to source and vice-versa,
    saving all open files and compiling.

  * Makes it easier to **move between windows**: Vim allows you to split your editing area vertically and horizontally,
    having one file open in each of these "windows".
    But the built-in "shortcuts" for moving from one window to another are _not really that short_. So I shortened them :)

  * Makes it easier to **resize windows**: Once you start editing several files in split windows, you'll WANT to resize these windows.
    And you'll WANT this resizing to be easy. Again, we can't say that the built-in shortcuts are easy, so I MADE THEM be.

With this configuration in place, I hope that Vim becomes **even more** of a pleasure for you to use - as it has been for me.
There are no guarantees in life, however, and you might not like my key mappings, for example.
In this case, PLEASE feel free to suit them to you liking.
And, if you think you found some really interesting variation of my configs, please fork the above gist from GitHub
(again - the link - <http://gist.github.com/2417865>) and submit a pull request :)

**EDIT:** You'll almost certainly need the latest version (7.3) of Vim to enjoy all the nice features I wrote about...
If you use Linux and your distro doesn't still include Vim 7.3 in the repositories,
then you can download the sources (from here - <http://www.vim.org/download.php>) and compile Vim yourself - It's quite easy, really.
In case you use Windows there's also a nice installer in the same address above.

That's all for now, folks!
Soon I'll post more about my greater Vim setup.

[1]: <http://www.vim.org>
[2]: <http://dailyvim.blogspot.com.br/>
[3]: <http://en.wikipedia.org/wiki/Vim_script>
[4]: <http://www.vim.org/scripts/script.php?script_id=1189>
