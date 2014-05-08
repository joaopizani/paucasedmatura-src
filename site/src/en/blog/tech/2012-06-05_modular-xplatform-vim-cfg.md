---
title: A portable, powerful, organized and self-contained configuration tree for Vim
published: 2012-06-05
pt: pt/blog/tech/modular-xplatform-vim-cfg
---

**UPDATE (2013-03-11):** After several months of daily usage and continuous improvement,
my Vim config tree [changed substantially](/en/blog/tech/modular-xplatform-vim-cfg-with-lasers) (for the better).

It is already a well-known fact that I love Vim.
I use it for programming, for technical AND non-technical writing (combined with LaTeX)
and - of course - just for fun sometimes (within my definition of fun).
I had several "long attempts" at using Vim,
but only in the last months I really decided to concentrate on _extracting_ the maximum I could from Vim and use it _everyday, for everything suitable_.

During this journey, I knew I would be tinkering with **a lot** of configuration and plugins, and therefore I wanted to make customization as easy as possible.
Also, I wanted to use Vim wherever I happened to be working, and so I needed to make my Vim setup as multiplatform and self-contained as possible.
Ideally, I would just have to have a vim-cfg directory on a pendrive and **feel at home** in whichever Linux or Windows computer I might be working at.

These goals have been almost 100% achieved.
So for extra fame and glory, I uploaded this [modular and cross-platform vim setup][1] to GitHub.
I won't go into much detail about this setup because the README (shown in the link above)
already does a good job at teaching you how to install and use the functionalities provided.

<!--more-->

Besides being a _framework_ in which you can easily do your own customization _while maintaining modularity and portability_,
this setup also includes a lot of "reasonable defaults", which are customizations I have come to like during these last months of heavy Vim usage.
My goal when defining which customizations to include was to **reduce repetitive work, by making the most frequent actions use the least keystrokes**.
The use case I had in mind was a programmer using Vim every day :)  Here are some of these customizations:

  * **One-stroke keybindings for frequent actions:** Navigating the filesystem, compiling and navigating compiler errors,
    navigating a source file by jumping to tags, moving between and resizing split windows...

  * **Segregated metafiles:** Keeps `.swp`, `xyz~`, and other silly Vim metafiles in a centralized directory, out of your way.

  * **Easy and organized plugin management:** Using [NeoBundle][2].

  * **Combines Vim internal make command with parallel builds:** As I already described in a [previous blog post][3].

  * **Easy tag management:** Tags are generated, regenerated on demand and managed automatically,
    without getting in your way, by using [vim-easytags][4].

Now go ahead and try it out!
Clone the repository and follow the installation instructions on `README.md`.
As a last but very important remark,
I'd like to thank **from the bottom of my heart** all the developers that wrote the AWESOME plugins I'm using.
They are making my (and will make your) life easier! They deserve all the props...
I feel as if I am "standing on the shoulders of giants" :)

[1]: <http://github.com/joaopizani/env.modular-xplatform-vim-cfg>
[2]: <https://github.com/Shougo/neobundle.vim>
[3]: </en/blog/tech/vim-parallel-make>
[4]: <http://github.com/xolox/vim-easytags>
