---
title: Custom Linux kernel for netbooks
published: 2009-08-01
pt: pt/blog/tech/linux-kernel-netbooks
---

If you (like me) are a happy owner of a netbook and run **Ubuntu Linux** as your operating systems, I bring good news:
the website Array.org has a [package repository][1] with a version of the Linux kernel specially suited to our little but beloved machines :)

Several optimizations were done to this special kernel,
leading to faster boot times and a generally more responsive system, among other advantagens.
To achieve this,
the drivers for some of the devices more commonly found in netbooks are **compiled as part of the kernel, and not loaded as modules**.
Also, the support for some devices that are **never** present in netbooks (such as CD-ROM drives) is disabled.

Several netbook makers and models are supported,
among them my beloved MSI Wind, Asus EEE PC, Dell mini, Acer Aspire One, HP mininote, etc.
The supported models can be found in the [repository's homepage][2].

The steps to install this kernel in your netbook running **Ubuntu 9.04** are pretty simple.
If you use any other version of Ubuntu take a look at the [official installation tutorial][3].
For the 9.04 version, copy/paste EXACTLY the following commands in you terminal:

  1. To add the repository's GPG key into your keyring: `sudo apt-key adv  --keyserver keyserver.ubuntu.com  --recv-keys FD0C2C24`
  2. To add array.org into your package sources list: `echo "deb http://www.array.org/ubuntu jaunty main" | sudo tee -a /etc/apt/sources.list`
  3. To update the package availability information and install the custom kernel: `sudo aptitude update && sudo aptitude install linux-netbook`

**Tip 1:** If you have an Asus EEE PC, you can use `linux-netbook-eeepc` in the 3rd step, instead of `linux-netbook`.
This netbook-eeepc kernel is EVEN MORE suited to the special characteristics of your netbook.

**Tip 2:** If you want to ignore future update notifications for the generic kernels, issue the following command:
`sudo aptitude purge linux-generic linux-image-generic linux-restricted-modules-generic`

**Tip 3:** To remove COMPLETELY any generic kernel in your system (this is **not recommended**),
use: `sudo apt-get remove linux-.*-generic`.
Only do this after testing that the netbook kernel works appropriately.

Enjoy your faster netbook!

PS: Thanks to my friend [José João Junior][4], for showing me the amazing effect this custom kernel has in his EEE PC :)

[1]: <http://array.org/ubuntu/>
[2]: <http://array.org/ubuntu/>
[3]: <http://array.org/ubuntu/setup.html>
[4]: <http://wwwexe.inf.ufsc.br/~jose.joao.junior/>
