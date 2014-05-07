---
title: Careful when shutting a computer down...
published: 2009-04-05
pt: pt/blog/tech/ssh-turnoff
---

Here goes a funny story: I'm a member of the computer infrastructure team at [PET Computação - UFSC][1].
One of our tasks is to keep the server always running, available, secure and up-to-date.
Mostly this is a not so hard task, but, as says Forrest Gump, shit happens...

<!--more-->

One of these times was last week. When I just arrived at PET's room, everybody was upset, and guess what had happened?
The server was offline. Someone turned it off, but why? Well, it wasn't really intentional...

Remember [when I said][3] that if you are logged in a machine through SSH it's **exactly** as if you were facing the machine?
Well, you can actually turn the machine off.
A friend of mine, casually taking a look at what was going on in the server, had to go away and so he wanted to turn **his** computer off.
He would turn it off at the command prompt, because he is a true [sysadmin][2] :).
But he typed:

```bash
sudo halt
```

Not on his computer, but **on the server**, through SSH.
And then when his computer was kept on, he noticed the shit he just did...
"Well, just turn it on again and everything will be back in place", he thought.
Just thought. After some 5 min showing no sign of life,
an old monitor was plugged and the frightening message "File not found" was shown on the server's screen,
meaning an EPIC FAIL of the bootloader.

After some 2 hours of hardcore command typing everything would indeed go back to normal state, but that's another story...

So, a lesson was learned: **When shutting a computer down, make sure it's YOUR computer**

[1]: <http://pet.inf.ufsc.br>
[2]: <http://en.wikipedia.org/wiki/Sysadmin>
[3]: </en/blog/tech/ssh-sem-senhas-no-passwords>
