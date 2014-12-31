---
title: Run Android ICS (Ice Cream Sandwich) on VirtualBox
published: 2012-02-19
pt: pt/blog/tech/android-ics-virtualbox
---

Some time ago I wrote a post here, saying that I had just bought an Android tablet.
In fact, I've been recently very interested in Android...
And last week, while reading the [Android Reddit][1], I (re)discovered a very nice initiative:
[Android-x86][2].

<div id="imgdiv-x86"><style type="text/css" scoped> #imgdiv-x86 img { width:200px };</style>

 ![Android-x86](/files/imgs/2012-02_Android-x86.png)

</div>

Android-x86 is a community-driven effort to port all versions of Android made available through the AOSP (Android Open-Source Project) to the x86 platform.
Thus, Android can be executed in computers such as Asus EEE PCs, or in PCs from Dell, HP, etc...
Even cooler is the fact that a team of developers is also making sure that Android support to VirtualBox is as good as possible.
This way, an Android developer can test his/her apps inside VirtualBox,
without having to use the (very slow) Android Emulator - that comes bundled with the SDK...

Also through a post on Reddit I came to know the work of a romanian developer that helps with porting Android 4.0 to VirtualBox,
and publishes daily work-in-progress ISO images on his blog (<http://www.buildroid.org/blog>).
What I then did was to download the latest ISO available there, create and configure a nice VirtualBox machine, install and configure Android.
As a "bonus", I also installed a bunch of Google apps (GMail, YouTube, Maps, Android Market, etc.).
There it goes, a glorious screenshot with the result of all this "tuning" :D

<!--more-->

![Android 4.0 on VirtualBox on Ubuntu :)](/files/imgs/2012-02_android-x86-ss.png)

The system itself works VERY WELL, I'm very well impressed.
Internet, audio, video, and all Google apps worked out-of-the-box, with no crashes until now.
This setup that I created has the Android Market installed,
so you can even install Market apps directly into your virtual Android \o/\o/.
After doing all the configuration, installation and tuning of the system,
I "packaged" the VM into an [OVA][3] file, so that everyone can play with it, with no effort :)

There it goes the OVA image, ready for you to **download, import into VirtualBox and use**: [Androidx86-ICS-VBox][4]

The pre-configured VM above makes it all an easy process.
BUT, if you really want to know how I performed the configuration, there it goes the "recipe":

  * Downloaded the latest ISO image from Marius's blog:  <http://android-x86.sceners.org/en/?p=523>

  * Created a VM in VirtualBox with "Linux 2.6" as its type, and attached an expansible virtual disk of 4GB

  * Loaded the downloaded ISO into the VM's virtual CD drive, and disabled "absolute pointing device" in the VM settings.
    This way the mouse works correctly inside Android.

  * With the VM booting from the ISO, I tested the system as a live CD, and, after making sure everything worked,
    installed Android into the virtual disk.

  * With Android correctly installed, and using ADB,
    I transferred and installed the Google apps package (<http://goo-inside.me/gapps/gapps-ics-20120215-signed.zip>).

  * With everything tested, I packaged the VM into the OVA file that you see above :)

That's all, folks!
Now I'm a happy guy, testing a lot of the apps that I intend to install onto my tablet when it arrives! :)
And, as soon as I code something for Android, I can also use this VM to test my own apps! \\o/\\o/

Once again, the **ready to use** virtual machine image of Android ICS is available HERE: [Androidx86-ICS-VBox][4]

[1]: <http://www.reddit.com/r/Android>
[2]: <http://www.android-x86.org>
[3]: <http://en.wikipedia.org/wiki/Open_Virtualization_Format>
[4]: <https://mega.co.nz/#!bVN0GKRD!GSBzVlcjpu4GFZJYA5WpmzKf6-N_jkJzA8TsiS2pfvA>
