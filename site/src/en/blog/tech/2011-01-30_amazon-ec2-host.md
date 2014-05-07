---
title: Amazon EC2: My OWN new hosting server, very far from me
published: 2011-01-30
pt: pt/blog/tech/amazon-ec2-host
---

It's been a long time since my last post, and the true reason for this delay is procrastination...
ANYWAYS, there are some excuses also :)
The biggest of them being that I recently moved the blog (and all other personal stuff) to a new host.

Now I have dedicated hosting, with **my own server**.
I now have FULL control over the server: it's mine, I install whatever I want, the operating system of my choice, I turn it on and off at will...
This server of mine is physically placed, however, some 4000km away from me, in the east coast of the US.
"How can that be?!", you might be asking... The answer is: I have a virtual machine on [Amazon EC2][1]

<!--more-->

But what on Earth is Amazon EC2, what does it do??
Well, Amazon EC2 (Elastic Compute Cloud) is a service that allows you, dear user,
to **rent** some of Amazon's computing resources and run you own virtual machine in their datacenters.
It might seem hard, but practically speaking you just get access to a machine like any other, over which you have complete control, you are GOD.
You can install any operating system, access it remotely and use it for any purpose.

In my case, I wanted a very cheap and basic machine over which I could run [Ubuntu Server][2],
an Apache web server with my blog and some other software useful for my daily tasks...
I've chosen to set up a **micro instance**, and the configuration was so easy and cheap that I just **need** to share it with you :)

![Amazon Web Services](http://awsmedia.s3.amazonaws.com/logo_aws.gif)

First of all, how much does it cost?
There's actually a [FREE Service Tier][3], and this marketing action will last until the end of 2011.
Of course I like free stuff, so this is my category of choice...
Here are the steps to request your machine, boot it for the first time and access it (over SSH):

  1. First you need to sign up with Amazon.
     Go to the [registration page][4] and fill in your data, including your payment details.
     Amazon will call the phone number you provided to confirm your identity.

  2. At the end of the first step you will download two files, `cert-<something>.pem` and `pk-<something>.pem`.
     These files are your keys to access EC2 through the command-line tools (the most convenient way).
     Save these files wherever you want and set up environment variables accordingly
     (Amazon's registration page will give you easy instructions on how to do that).

  3. Now you need to install the `ec2-api-tools` into your computer, the computer you're going to use to interact with Amazon.
     In Ubuntu Linux, a simple `sudo aptitude install ec2-api-tools` does the trick.

  4. Let's then create our first **instance** (an Amazon EC2 VM): `ec2-run-instances ami-ccf405a5 --instance-type t1.micro --region us-east-1 --key <key>`.
     The `ami-ccf405a5` parameter is the disk image used to initialize the machine, in this case an Ubuntu Server 10.10 32-bit image.
     You must provide the name of the key created at the registration step.

  5. Your machine is now booting, and in a few seconds will be ready to be accessed remotely!
     To log into your newly created virtual machine, copy it's address, returned by the previous command, and use SSH.
     Something like this: `ssh -i <key> ubuntu@ec2-174-129-217-7.compute-1.amazonaws.com`

  6. Ready to go! Do whatever you want with this Linux server, it's yours! :D

[1]: <http://aws.amazon.com/ec2/>
[2]: <http://www.ubuntu.com/server>
[3]: <http://aws.amazon.com/free/>
[4]: <https://aws-portal.amazon.com/gp/aws/developer/registration/index.html>
