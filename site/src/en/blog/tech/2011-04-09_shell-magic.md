---
title: Some very useful and quite magical shell commands
published: 2011-04-09
pt: pt/blog/tech/shell-magic
---

Several times I've already posted here in the blog about how the [Unix philosophy][1] helps me accomplish day-to-day tasks more easily.
Working on remote machines using SSH, staying up-to-date with my favorite podcasts and synchronizing them to my MP3 Player,
bypassing firewalls and using remote files as if they were local, all these are easier tasks in Linux...

It makes me even happier, though, when I'm able to accomplish one of these tasks using a SINGLE LINE shell command.
I find some "one-liners" so beautiful that I must share them with you :)

<!--more-->

So, let's start.
Some "magic" commands follow, and bellow each of them there's a quick description of what they do:

```bash
rm $(find . | grep ~$)
```

Our first "magic" command is, of course, the simplest.
It deletes all those "backup" files (ended in a "~") from a directory tree.
I really get tired of them sometimes, so to wipe them out once and for all, go to the directory and type the above command :)

<script src="https://gist.github.com/2718522.js"> </script>

This is a bit lengthy, and might fill 4 lines of your terminal, but I consider this magic command to have only 1 "logic line".
What it does is to convert all WMA files of your music library to MP3.
You can, of course, substitute "wma" for "ogg", "flac", etc, and it will work also.
You only need the `mplayer` and `lame` packages for this to work. Beautiful, don't you think?

OK. So now for the last one:

```bash
youtube-dl -t --extract-audio --audio-format=mp3 <youtube_playlist_url>
```

"youtube-dl" is a very useful python program, you can download it at the developer's site: <http://rg3.github.com/youtube-dl>.
You also need FFMPEG for this command to work.
What this beautiful command does is to download (in high quality) and convert all videos of a youtube's playlist to MP3.
Here it goes an example of a quite nice youtube playlist for you to enjoy:
<http://www.youtube.com/view_play_list?p=771D06F88E51ACED> (classical music at its best :P)

For now that's all, folks!
As I discover new shell magic I'll surely post it here.
Please comment and leave your favorite commands too!

[1]: <http://en.wikipedia.org/wiki/Unix_philosophy>
