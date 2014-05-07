---
title: Don't repeat yourself (DRY): Use vim macros!
published: 2011-12-28
pt: pt/blog/tech/vim-macros
---

It's been a long time since the last post, but FEAR NO MORE, dear readers, for I am still alive. :)
And this time I will talk about something a bit more technical: the almighty vim macros!
For those who know me, it's no secret that I admire - and use - the [vim][1] text editor.

So... I was doing some Java programming these days, using vim,
and I came across the problem of replacing several _similar but not equal_ pieces of code with a variable name I had just factored out.
There were _big_ blocks of code to be replaced by this name, with slight variations, so simple find/replace was not an option...

<!--more-->

I started with the traditional "." key trick: I manually replaced the big block with the identifier in the first time,
and then proceeded to select each subsequent block and press ".".
It was efficient, but not enough, as I still had to skim through the file selecting each _similar but not equal_ block and pressing ".".
It was going to take just **too much time** to replace the approx. 200 blocks I needed :O
So it was time to use a feature of vim I recently heard about: macros!

Macros in vim are a VERY generic mechanism:
your start recording a macro and then everything you do is recorded - every movement, every edit, in normal mode as in insert - _whatever_ mode.
Then your **replay** your macro and the commands are repeated **exactly**.
This can be very useful, and I hope to illustrate this usefulness with my concrete example.
Here's my typical block of code, before and after the transformation I needed to do:

```java
// <before>
put(bnome_en, new ValidationRule() {
    protected ValidationResult check(String userInput) {
        if(isEmpty(userInput)) return ValidationError.empty;
        else return intact(userInput);
    }
});
// <after>
put(bnome_en, BaseRules.nonEmptyRule);
```

After fidgeting a bit, I found that what I needed to do
was to change everything between `new` and `})` (the closing of the anonymous class parameter) to `BaseRules.emptyRule`.
So my commands were:

  * search for `new`
  * enter visual mode
  * search for `})`
  * activate "change" command
  * type `BaseRules.nonEmptyRule`
  * go to normal mode
  * go down one line and delete the current line (get rid of annoying extra whitespace)

To start recording a macro in vim, your press _q<lower-case-letter>_, and the macro will be **stored** in the register identified by _<lower-case-letter>_.
You'll need this letter to replay the macro later.
My EXACT sequence of keypresses to record the entire macro were then:

    qn/new<CR>v/})<CR>cBaseRules.nonEmpty<ESC>jddq

where `<CR>` is carriage-return (enter) and `<ESC>` is the escape key.
Notice that I've stored the macro in the `n` register, and that in the end of my command sequence I pressed `q` again to **stop the recording**.
Now I only went to wherever I wanted to perform a _big code block substitution_ and typed

    @n

That is, the _at_ (`@`) key, followed by the name of the register where the macro was stored.
And BOOM! It worked like a charm. So I gained confidence and tried:

    50@n

That means I repeated the macro 50 times.
It worked and was beautiful :D  Conclusion: macros in vim are useful AND easy to use, they even make sense!
So, dear prospective, novice or veteran vim user, whenever you're repeating yourself and it's harder than a simple find/replace,
press `q` and record a macro :)

Important tip:  Macros in vim are **completely context-free**.
What this means is that the **exact same** sequence of commands (including the same motions) will be executed when you replay the macro,
regardless of where (in the file) you replay it.
So, my tip is: always use features like search (`/`) when recording a macro, so that you know you are in the right place when editing...

[1]: <http://en.wikipedia.org/wiki/Vim_(text_editor)>
