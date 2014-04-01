---
title: Haskell Ants EDSL: Projeto prático do curso "Advanced Functional Programming"
published: 2013-03-02
en: en/blog/haskell/haskell-ants-edsl
---

No segundo período do meu mestrado em Ciência da Computação na Universidade de Utrecht eu cursei (e gostei muito de) uma disciplina chamada "Advanced Functional Programming".
Lá aprendemos muito sobre a teoria de "como funciona" uma linguagem de programação funcional (mais especificamente, Haskell).
Mas também colocamos a "mão na massa", e desenvolvemos vários projetos práticos, sendo o [maior de todos][1] o qual descrevo neste post.

Fiz esse trabalho junto com meus amigos [Liewe Thomas van Binsbergen][2] e o cara gente fina com o maior nome que já vi na vida:
o lusitano **João Miguel Queiroz de Ataíde Agorreta de Alpuim**.
Como projeto final no curso,
cada "time" de estudantes tinha que submeter uma candidatura para um concurso que envolvia a simulação de formigas num ambiente natural.
Essa "tarefa" foi a selecionada para o
[concurso de programação da International Conference on Functional Programming em 2004][3]...

<!--more-->

A [descrição oficial da tarefa][4] define uma linguagem Assembly para o "cérebro" das formigas, e as colônias de formigas de dois times lutariam em rodadas de um campeonato (com mapas aleatórios a cada rodada), e onde o objetivo em cada rodada do campeonato era ter mais comida em seu ninho ao fim de um certo período de tempo.
O concurso rodava num simulador, e aí vai um "screenshot animado" pra dar uma idéia a vocês do que acontece:

![Ants Simulator](/files/imgs/2013-03_ants-edsl-animation.gif)

Nesse exemplo somos a colônia de formigas "vermelhas", e competindo contra o campeão absoulto de todos os anos, em azul.
Apesar de nesse exemplo estarmos perdendo feio (pouca comida no nosso ninho), na competição com as outras equipes da turma, não fomos tão mal assim.

Mas enfim, [o projeto (publicado no GitHub)][5] trata não de programação em Assembly de formiga,
mas de Advanced Functional Programming in Haskell, portanto, o que diabos esse projeto tem a ver com Haskell:
simples, a nossa tarefa era a de implementar uma Linguagem de Domínio Específico Embutida em Haskell (Embedded Domain-Specific Language),
que permitisse expressar em alto nível de abstração as estratégias que quiséssemos que nossas formigas tivessem.
O produto final do projeto tem então dois componentes principais:

  * **Biblioteca EDSL:** Uma API de alto nível, composta de algumas estratégias "fundamentais",
    e de combinators que constroem estratégias complexas a partir de estratégias mais simples

  * **Estratégias em si:** Usando a API desenvolvida, deveríamos submeter duas estratégias (programas em assembly de formiga)
    que iriam competir em um campeonato com o resto da turma

A nossa EDSL foi desenvolvida em uma arquitetura de camadas, onde a aplicação das funções acessíveis pelo usuário gerava um valor de um tipo de dados **AntImperative**, que depois então era convertido (compilado) para o assembly de formiga.
Esse modelo de EDSL é chamado de "deep-embedded".
Na figura abaixo têm-se uma idéia de como ficou organizado o projeto:

![uu-ant-gen-layers](/files/imgs/2013-03_uu-ant-gen-layers.png)

Só pra que vocês tenham uma idéia de como se parece uma estratégia escrita na nossa "linguagem" de alto nível, aí vai uma das estratégias que submetemos:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/haskell-ants-edsl-afp2012/blob/master/uu-ant-gen/Game/UUAntGen/Frontend/AntStrategies.hs?slice=158:185&footer=no"></script>

Esta estratégia em particular era baseada no fato de que as formigas que nasciam nos cantos do ninho (o ninho tem formato hexagonal) desenham "rodovias" de feromônios, que servem para que as formigas carregando comida possam achar o caminho de volta para casa.
Além disso, as formigas que encontram comida deixam um "rastro" de feromônios também indo em direção a rodovia principal, construindo assim "estradas locais".

Por fim, como "prêmio" pra você que teve paciência de ler até aqui :),
há os slides da apresentação que fizemos sobre o projeto (clique na imagem para fazer download):

[![slides-ants-edsl-afp2012](/files/imgs/2013-03_slides-ants-edsl-afp2012.png)](/files/other/2013-03_presentation-ants-edsl-afp2012.pdf)

Era só isso por enquanto!
Logo que finalizar mais projetos interessantas, conto aqui para vocês...
Até a próxima! :)

[1]: <https://github.com/joaopizani/haskell-ants-edsl-afp2012>
[2]: <http://www.linkedin.com/pub/liewe-thomas-van-binsbergen/3a/587/659>
[3]: <https://alliance.seas.upenn.edu/~plclub/cgi-bin/contest/index.php>
[4]: </files/other/2013-03_icfp-contest-2004-rules.pdf>
[5]: <https://github.com/joaopizani/haskell-ants-edsl-afp2012>
