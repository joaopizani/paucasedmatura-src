---
title: SSH over SSH: down the rabbit hole to bypass firewalls
published: 2011-02-18
pt: pt/blog/tech/ssh-over-ssh
---

Some days ago I needed to work from home, accessing my work desktop (running Linux, of course), so I engaged the great and trustworthy SSH.

    ssh joaopizani@dunkel.bla.ufsc.br

I DIDN'T KNOW, though, that as any secure laboratory, the one in which I work has a firewall, and any external access to port 22 (SSH's port) is blocked.
But we have a fileserver that is open (can be accessed externally through SSH).
So I could log into the fileserver and then, _from there_, log into my work desktop (called _dunkel_).
Using this approach isn't much practical, and file copies and other common operations, like using sshfs were impossible.
So I decided to direct my SSH traffic through an SSH tunnel to get where I wanted to go.
Seems a mess, doesn't it? Relax, it's simple, I'll explain...

![YO DAWG](/files/imgs/2011-02_YODAWGSSH.jpg)

<!--more-->

I used a SSH connection to the open fileserver to build a **tunnel**, a sort of a bridge connecting my home computer to the lab's internal network.
With this tunnel established, any data orginated from my home PC will **seem** to have originated from the fileserver,
and any data reaching the fileserver will be forwarded to my home PC.
The generic command to establish the tunnel goes like this:

```bash
ssh -f -N -L <local_port>:blocked_computer:22 user@open_machine
```

The -L option tells SSH to do all the redirection (build the tunnel).
Options -f and -N tell SSH to establish **only** the tunnel (and execute nothing else) and give back control of the terminal to the user.
`local_port` is the port on your **home PC** and can be any free TCP port; blocked_machine is the name of the not accessible machine behind the firewall.
With **my personal parameters** filled in, the command turned out to be like this:

```bash
ssh -f -N -L 4242:dunkel:22 joaopizani@gateway.bla.ufsc.br
```

![Sketch of a SSH tunnel](/files/imgs/2011-02_tunel.png)

AFTER the tunnel is established, you can connect to port **local_port** on **your PC**, and the magic tunnel will take care of the rest.
The beforehand blocked machine will then welcome you. It's not actually magic, just technology :P

```bash
ssh -p 4242 joaopizani@localhost
```

So this is it!
Soon I should be posting more command-line ninja skillz.
I've been using several of them recently, going back to the good 'n old geeky times :)

