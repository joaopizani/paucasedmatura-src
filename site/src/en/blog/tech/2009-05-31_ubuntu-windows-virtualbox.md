---
title: Installing Ubuntu inside a virtual machine in Windows
published: 2009-05-31
pt: pt/blog/tech/ubuntu-windows-virtualbox
---

This is a tutorial aimed at the people that always used Windows, heard a lot about Linux,
want to test it, but don't want to repartition nor format the hard drive.

[VirtualBox][1] is a **virtualization** software package, it's a program able to act as if it was an entire new computer.
You can run VirtualBox over any operating system, and inside VirtualBox any other OS can be run.

I'm gonna show you how to install VirtualBox on Windows and then install [Ubuntu Linux][2] inside of VirtualBox.
This tutorial and the accompanying screencast were made as part of my activities in the [PET Computação - UFSC][3] group,
of which I'm part of.

These materials were written when Ubuntu was on version 8.10, but no significant changes were made in regard to the steps described here.
For those who prefer to learn visually, I published a [screencast][4] on YouTube with the complete tutorial.

And here come the steps to fearlessly install Ubuntu :)

[1]: <http://www.virtualbox.org/>
[2]: <http://www.ubuntu.com/>
[3]: <http://pet.inf.ufsc.br>
[4]: <http://www.youtube.com/watch?v=wUln3JuE7iU>


### Installing VirtualBox and creating a virtual machine

  1. Download the most recent VirtualBox package (Windows version) at the [official website][5]

  2. Execute the downloaded file and accept the terms of use. Obs: Admin rights are needed in order to do the installation.

  3. A warning will be shown saying that the Internet connection may hang during the installation process. Proceed.

  4. Click "install" to begin the installation.

  5. A warning will be shown asking you to confirm the installation of the VirtualBox driver files. Accept it.

  6. After the installation finishes, VirtualBox will run and a registration form will appear. Fill the form and proceed.

  7. In the upper-left corner of the window, click "New" to create a new virtual machine.

  8. Click "next" and fill in the desired name for the new virtual machine. Then choose "Linux" as operating system and "Ubuntu" as version.

  9. Choose the amount of RAM that will be given to the VM.
       + For Ubuntu, the minumum required is 384MB.

  10. Now it's time to create a virtual disk to connect to the VM.
      A virtual disk is just another file in your Windows filesystem, but that will be used by the VM as a hard disk.
        + Click "New" to open the New Virtual Disk wizard.
        + Click next, and then choose "Dinamically expanding storage".
            - By choosing this option, the disk file will have only the necessary size to host the CURRENT contents of the Ubuntu system.
        + Then choose the size of the virtual disk. For Ubuntu, the recommended size is at least 5GB.
        + Click "Finish"

  11. And back to the main VM creation wizard, click "Next" and them "Finish". Now you're ready to begin installing Ubuntu in your new VM!

[5]: <http://www.virtualbox.org/>


### Installing Ubuntu from the CD ISO image

Now let's install the most recent Ubuntu version on the virtual machine we've just created:
we're installing it from the `.iso` file, downloaded from the [official site][6].
The first step is to configure the VM to boot from the CD (CD image).
Then we'll do the installation itself.

  1. Select the recently created VM and click "Settings"

  2. Go to the "CD/DVD-ROM" panel, enable "Mount CD/DVD-ROM" drive, then choose ".ISO image file"

  3. Then the "Virtual Media Manager" will open.
     Click "Add" and find Ubuntu's .ISO image. The click "Select" in the bottom-right corner of the window.

  4. Back to the VM settings window, click then "OK" so that the changes are applied.
     Now the Ubuntu installation CD is already in the VM's CD drive.

  5. Back to the main window of VirtualBox, click "Start" to boot the Ubuntu VM.
     A dialog will show you how to capture and release the keyboard from the VM.

  6. The Ubuntu installer will start.
     Choose the language to use during installation and then, from the menu, choose "Install Ubuntu".
     Wait a few seconds while the install wizard is loaded.

  7. Now it's time for the easiest part: The Ubuntu installation in itself :)
       1. Choose the language for the installed system, click "Next"
       2. Choose your location on the map, click "Next"
       3. Select a keyboard layout, and test it in the text box below. Click "Next"
       4. On the partitioning screen, accept the defaults and click "Next"
       5. Fill in your personal details, and the username and password to log into the system. "Next"!
       6. Click "Install". After some 20min the installation will be complete.

  8. After the installation is complete right-click the little CD icon
     in the statusbar of the VM window and choose "Unmount CD/DVD-ROM" to eject the installation CD off the VM.
     Now click "Reboot now" on the final screen of the Ubuntu wizard. You're done!

[6]: <http://www.ubuntu.com/>
