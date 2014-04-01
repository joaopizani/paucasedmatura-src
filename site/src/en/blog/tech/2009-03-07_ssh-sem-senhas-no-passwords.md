---
title: SSH with no need for passwords
published: 2009-03-07
pt: pt/blog/tech/ssh-sem-senhas-no-passwords
---

I use Linux, **a lot**. At home and at work.
A very useful tool for Linux users is [SSH][1] (Secure Shell).
It allows you to login and execute commands in a remote machine.
The advantage provided by SSH is that the whole connection is **encrypted**, thus,
even if bad guys are "listening" to your connection, you are still safe.
I use SSH every day, and something that always annoyed me was **to have to type a password at each connection**.
And a different password for each computer which I logged into.
Now this annoyance belongs to the past :)
In a few steps you will never more need to type passwords for logging into remote machines, **remaining safe**.

[1]: <http://pt.wikipedia.org/wiki/SSH>

<!--more-->

**What's the trick?**

Well... there's really no trick :) What we'll do is to **change the way we prove to the server we are who we claim to be.**
Most times passwords are used for this _authentication_.
The server supposes that I keep my password secret, so if some "joaopizani" typed the correct password, it must be the real "joaopizani"...
Looks pretty safe, don't you think?

Truth is, not so much... People must remember the password, and often make ridiculous choices (birth date is just an example).
Even if we suppose that the passwords are strong enough, we still have to type a different password for each computer we want to log in.
How to solve these problems???
Using _authentication with cryptographic keys_.
Surely you already heard of cryptography used for exchanging secret messages, but it can also be used to prove you are yourself...


**And how these keys work?**

To do SSH logins without the need to type passwords you must create a _keypair_ for yourself.
One of these keys in the pair is called the _private key_, because only you should keep it, very safely, and it shouldn't be on any remote machine.
The other key in the pair is (guess what...) the _public key_.
As the name implies, you can distribute this key freely and it must be present in all computers which you want access through SSH.
Now, how does the server know that the right person is trying to login? It's simple, he makes a **challenge**, like this:

  1. You establish the connection, and you claim you are `userx`
  2. The server looks for the _public key_ of userx on his list of all public keys allowed
  3. The server encrypts a secret and random string (the challenge) with the public key of userx and sends it to the client
  4. The client of userx uses its _private key_ to decrypt the challenge from the server, and sends back the answer.
  5. The server checks the answer. If its equal to the original challenge, then userx is the right guy!

This is called a **challenge-response protocol**.
Notice that if some text is encrypted with userx's _public key_, then only userx's _private key_ can decrypt it.
Now, what are the advantages of this over using passwords? There are several:

  1. You send the SAME public key to all the places you want to log into. No more need to memorize dozens of passwords.

  2. Your private key (the big secret) is **really private**.
     Nobody needs your private key to check your identity, and you need to send it nowhere. Keep it safe and you're safe.

  3. Now one big advantage: If you don't need to type passwords anymore, then no human being is needed to connect.
     This makes SSH a very useful tool for use in scripts.


**Step-by-step configuration:**

If you used SSH in your computer before, chances are that you already have everything installed correctly.
We now just need to create the pair for you, and to upload your public key to the machine(s) you use very often.
The following two commands will do it:

  1. `ssh-keygen -t rsa`
  2. `ssh-copy-id <remote_user>@<remote_machine>`

The first command creates a keypair for you, using the [RSA][2] cryptographic algorithm.
The second command takes your public key at ~/.ssh/id_rsa.pub and adds it to the server's list of allowed public keys.
When the second command is executed, it will ask you to type your remote password.
This is the **last time** you'll type this password. Enjoy!

[2]: <http://en.wikipedia.org/wiki/RSA>

Mind that for each machine you want to log into, you must issue the second command appropriately.

