---
title: Haskell Ants EDSL: Implementation project in the "Advanced Functional Programming" course
published: 2013-03-02
pt: pt/blog/haskell/haskell-ants-edsl
---

In the second term of my master's programme in Computing Science at [Utrecht University][1],
I followed (and liked very much) a course called "Advanced Functional Programming".
In this course, we study the theory that underpins the inner workings of functional programming languages (and in particular, Haskell).
But, theory apart, we also developed a lot of practical assignments,
[the largest of which][2] I describe in this post.

I developed this project together with my colleagues [Liewe Thomas van Binsbergen][3]
and the portuguese guy with the longest name I've ever seen: **João Miguel Queiroz de Ataíde Agorreta de Alpuim**.
As a final project for the course, each "team" of students had to submit an entry to a competition
that involved the simulation of ants searching for food in an environment. This "task" was also the one selected for the
[programming contest of the International Conference on Functional Programming in 2004][4]...

<!--more-->

The [official task description][5] defines an assembly language for the ants,
and that the ant colonies of the two teams will fight in "rounds" in a championship (with random maps chosen for each round);
in each round the goal is to collect the most food possible at your anthill after a certain amount of time.
The championship was run in a simulator, and the following animated gif shows how a small part of a simulation might look like:

![Ants Simulator](/files/imgs/2013-03_ants-edsl-animation.gif)

In this example, our team is the "red" team, and we are competing agains the all-time winner (in blue).
Even though in this particular example we are losing by a long shot (there is little food in our hill), we weren't so bad when competing with our classmates...

Anyways, [the project (uploaded to GitHub)][6] is not about ant assembly,
but about Advanced Functional Programming, so you might ask "What the hell does this all have to do with Haskell?".
The answer is simple: our real task was to implement an Embedded Domain-Specific Language (EDSL) in Haskell,
allowing to express with a **high level of abstraction** the strategies we wanted our ants to follow.
The "deliverables" of the project, thus, were twofold:

  * **Ant EDSL library:** A high-level API, made of fundamental strategies and of combinators allowing the user to build more complex strategies from simpler ones.

  * **The strategies themselves:** Using the developed API, we needed to hand in two strategies (ant assembly files),
    that would take part in the championship against the rest of the class.

Our EDSL was developed with a layered architecture,
where the the evaluation of user-accessible functions in the API resulted in a value of type **AntImperative**,
that was then converted (compiled) to proper ant assembly.
This paradigm of EDSL is called "deep-embedded".
In the following figure, you can have an idea of how the project is structured:

![uu-ant-gen "layers"](/files/imgs/2013-03_uu-ant-gen-layers.png)

Also, here it goes one of the basic strategies we submitted for the contest, so that you can have an idea of how it "feels" to write strategies in our EDSL:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/haskell-ants-edsl-afp2012/blob/master/uu-ant-gen/Game/UUAntGen/Frontend/AntStrategies.hs?slice=158:185&footer=no"></script>

This particular strategy was based in the fact that ants born in the hill's corners (each anthill had 6 corners) would draw "highways" with pheromones,
that would mark a quick way for other ants to go back home whenever needed.
Besides this, ants that found food would also leave a "trail" of pheromones leading to the highways, and these trails would consist a kind of "local roads".

Finally, as a prize for your pacience in reading this post until here :), you can take a look at the slides that we prepared for the presentation of the project (click on the image to start the download):

[![slides-ants-edsl-afp2012](/files/imgs/2013-03_slides-ants-edsl-afp2012.png)](/files/imgs/2013-03_presentation-ants-edsl-afp2012.pdf)

That's it!
As soon as I have another cool project to show you guys, I will tell more about it here...
See you soon! :)

[1]: <http://en.wikipedia.org/wiki/Utrecht_university>
[2]: <https://github.com/joaopizani/haskell-ants-edsl-afp2012>
[3]: <http://www.linkedin.com/pub/liewe-thomas-van-binsbergen/3a/587/659>
[4]: <https://alliance.seas.upenn.edu/~plclub/cgi-bin/contest/index.php>
[5]: </files/imgs/2013-03_icfp-contest-2004-rules.pdf>
[6]: <https://github.com/joaopizani/haskell-ants-edsl-afp2012>
