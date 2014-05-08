---
title: A lightweight, fully automatic and elegant torrent setup using RTorrent
published: 2012-08-28
pt: pt/blog/tech/rtorrentrc
---

Some time ago I installed at home a 5Mbps ADSL connection, and so I wanted to have a reliable BitTorrent setup, to enjoy the new bandwidth capacity...
Besides, in the **near** future I will have a 50Mbps connection,
and thus I felt the need for a very "optimized" and fully automatic setup for my torrent file-sharing activities :)

My idea is to use an OLD laptop that I have lying around as a dedicated seedbox, running 24/7.
So, I was looking for a robust, powerful and configurable torrent client (able to run months without having to reboot),
but at the same time, this client needed to use little CPU power and memory.
Fortunately, I found this **fantastic** BitTorrent client: it's called [rTorrent][1],
was developed in pure C++, geared towards performance and reliability, and is a nice console application.

After a lot of googling and trial-and-error, I was able to come up with a very nice rTorrent config file (.rtorrent.rc),
that satisfies all my requirements for an awesome torrenting setup. These requirements are:

  * **Periodical speed throttling:** Download and upload speeds are adjusted depending on the time of day, to not overload my work bandwidth

  * **Close after reaching seed ratio:** Removes a torrent download from the active queue after it has reached a certain seed ratio (for example, 200%)

  * **Start downloads based on the contents of a directory with torrent files:** Monitors a specified directory
    looking for the addition of files with the `*.torrent` extension and starts the corresponding downloads

  * **Separation between active and finished downloads:** Stores files BEING DOWNLOADED in a specific directory
    (`content-in-progress`) and moves finished ones to another (`content-finished`)

This config file (rtorrent.rc) is available at GitHub,
and you can [download it from here](https://raw.github.com/joaopizani/rtorrentrc/master/rtorrent.rc).
After downloading the file, do the following to complete the setup:

```bash
mv [where-you-downloaded-rtorrentrc] ~/.rtorrent.rc
mkdir ~/torrent

mkdir -p ~/torrent/{session,metafiles-{in-progress,finished},content-{in-progress,finished}}
```

Anyways, if you want to know more in-depth what the lines in this file do, I will now make a review of each of this config file's "sections" :)

<!--more-->

The first line in the file tells us in which directory rTorrent stores its internal "session".
This directory should never be deleted while rTorrent is running.

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/rtorrentrc/blob/master/rtorrent.rc?slice=0&footer=no"></script>

Now we define the directory where rTorrent should keep downloaded data **while it's being downloaded**.

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/rtorrentrc/blob/master/rtorrent.rc?slice=1&footer=no"></script>

The following lines define minimum and maximum limits for the number of peer connections while downloading or seeding.
I obtained these numbers by "emprirical" observation during months of usage, and they work very well in my network (with a bandwidth of about 10MB/s).

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/rtorrentrc/blob/master/rtorrent.rc?slice=3:9&footer=no"></script>

The next configuration establishes that after we reach a certain "seed ratio" (in this case, 200%),
the torrent should be automatically closed and removed from rTorrent's list.
This is so that you can collaborate with the spirit of file-sharing, but **not indefinitely** :)
Besides, new downloads are not initiated with too little free disk space:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/rtorrentrc/blob/master/rtorrent.rc?slice=11:19&footer=no"></script>

What follows are miscellaneous settings (enables DHT, cryptography, defines port range), and there's nothing VERY special about them.
The only setting which you should pay attention to is "port range".
You must set this option to a range which is open (forwarded) in case you are behind a router with NAS/firewall.

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/rtorrentrc/blob/master/rtorrent.rc?slice=22:28&footer=no"></script>

Now for a vey important section in the file: we define upload/download speed throttling _depending on the time of the day_.
The settings which follow are the ones which I LIKE THE MOST.
In my case, I want the bandwidth occupation to be smaller in the MORNINGS and EVENINGS (that's when I am most likely at home and using the computer).

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/rtorrentrc/blob/master/rtorrent.rc?slice=31:45&footer=no"></script>

Almost done now; we say to rTorrent that it should monitor a certain directory (`~/torrent/metafiles-in-progress`)
for the addition of files with extension `*.torrent`. Files added to this directory will cause the start of a corresponding download in rTorrent:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/rtorrentrc/blob/master/rtorrent.rc?slice=48:49&footer=no"></script>

And finally, the last lines in the config file ensure that **incomplete** downloads have their **data files** removed,
whenever the corresponding `.torrent` metafile is removed (or when the download is removed from the list in rTorrent).
Besides, finished downloads are moved to a special directory (called `content-finished`),
while the metafile itself is archived for posterity, under `metafiles-finished`.

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/rtorrentrc/blob/master/rtorrent.rc?slice=51:56&footer=no"></script>

So that's all, buddies!
From now on, with rTorrent installed and configured in my seedbox,
I just need to throw any `.torrent` file inside the `metafiles-in-progress` directory, and leave all the rest of the work with rTorrent.
It will ensure that I keep being **fair** to the community (by ensuring a minimal seed ratio) and then put all finished downloads in a special folder,
ready for me to use them :)

If you want to get, use and adapt this configuraton file I have just shown, go again to the beginning of the post,
download the file and follow the instructions...

[1]: <http://libtorrent.rakshasa.no>
