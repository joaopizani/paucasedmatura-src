---
title: Interact with Twitter from within Pidgin
published: 2009-07-24
pt: pt/blog/tech/twitter-within-pidgin
---

I have a kind of obsession with simplicity, as everybody knows :)
So today I noticed that only one great program - [Pidgin][1] - handles all my needs with MSN, Google Talk and IRC.
Today I wanted to have some Twitter suport into Pidgin, and I found [Microblog-purple][2].

[1]: <http://pidgin.im/>
[2]: <http://code.google.com/p/microblog-purple/>

Microblog-purple is a plugin that enables Pidgin to connect to Twitter, as well as with Identi.ca and Laconi.ca,
and then you can follow and post updates from the chat window!
If someone tweets you, then a new chat window pops up, and you can answer him/her in a very intuitive way.
There're a lot of other great functionality...

It's very easy to install and use the plugin.

The instructions below are for Ubuntu 9.04, but for other OSes there are instructions in the project's [official site][3].
To install the plugin in you Ubuntu, copy-paste the exact following commands into your terminal window:

[3]: <http://code.google.com/p/microblog-purple/>

  1. Authorization of the projects repository: `sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DF37ED8B`

  2. Adding the repository to your sources.list:
     `echo "deb http://ppa.launchpad.net/sugree/ppa/ubuntu jaunty main" | sudo tee -a /etc/apt/sources.list`

  3. Updating the package list and installing the plugin: `sudo aptitude update && sudo aptitude install pidgin-microblog`

Now, to activate the plugin go to Tools -> Plugins in Pidgin:

![Enabling the plugin](/files/imgs/2009-07_habilitando_plugin.png)

Then type your Twitter account info as if it were any other protocol that Pidgin supports:

![Registering the account](/files/imgs/2009-07_cadastrando_conta.png)

Now you're ready to publish and read your beloved 140-char updates :)

