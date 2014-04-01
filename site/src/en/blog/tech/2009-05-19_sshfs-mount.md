---
title: Mount remote directories using SSHFS
published: 2009-05-19
pt: pt/blog/tech/sshfs-mount
---

Some time ago I [posted][1] about how to use SSH without typing passwords,
thus making the login into a remote server much simpler.
Recently I've found that SSH allows you to mount remote directories, in a very easy way.
Only the SSH daemon is needed in the server for this mounting to work.

Imagine that at home you have a PC with a 1TB harddrive where all your movies and music are stored.
And that you also have a lightweight netbook, but with little storage, and that you have access to broadband Internet.
If you want to access you files in the netbook, what is the solution? Use SSHFS and play the file **as if they were local**.

And now to the few steps on installing, setting up and using SSHFS (all of the following steps are done on the CLIENT side):

  * **Install the "sshfs" package:** Almost every Linux distro has a package with a similar name to "sshfs", most probably identical.
    For the users of Ubuntu Linux, two commands are enough to install SSHFS and all of its dependencies:

    ```bash
    sudo aptitude update && sudo aptitude install sshfs
    ```

  * **In the client machine, create the directories to mount the remote contents into:**
    Now you must create the local directory under which the remote contents will "appear".
    The convention in the Linux world is to put this directory under /mnt, but you can put it somewhere else if you want...
    After the directory is created, your user must be given ownership.

    ```bash
    sudo mkdir /mnt/remote-files
    sudo chown <my_user_name> /mnt/remote-files
    ```

  * **Add yourself to the "fuse" group, so that you can mount and unmount the remote contents:** You already have permission in the /mnt/remote-files folder,
    because you own it. But, by default, the only user with permisson to MOUNT filesystems is the root user.
    For allowing a normal user to mount SSHFS, you must add it to the "fuse" group. like this:

    ```bash
    sudo adduser <user_name> fuse
    ```

  * **Reboot the machine:** This is necessary for the FUSE kernel modules (Filesystem in USErspace) to be loaded.
    If you really have an issue against rebooting you PC, you can also issue the following command, with the same effects as rebooting: `sudo modprobe fuse`.

  * **Mount and use (i.e, be happy!):** You can now mount your favorite remote contents with SSHFS.
    Some nice examples: playing music and videos as if they were local, edit documents and spreadsheets, etc.
    To mount a remote directory use the following command:

    ```bash
    sshfs <remote_user_name>@<remote_machine_address>:<remote_directory>  <local_directory>
    ```

  * **Unmount when finished:** When not using the remote content anymore, you can easily unmount the directory with:

    ```bash
    fusermount -u <local_directory>
    ```

In a next post I'll show how you can automatize the complete mounting and unmounting using autofs, a great Linux tool.
Using autofs you can configure some remote directory you use often, and it will always be at your fingertips, mounted automatically just when you need it and unmounted when you don't. But even without autofs, sshfs is already VERY useful.

[1]: </en/blog/tech/ssh-sem-senhas-no-passwords>
