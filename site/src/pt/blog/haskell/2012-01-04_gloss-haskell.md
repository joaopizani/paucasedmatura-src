---
title: Voltando a ser criança, e se divertindo desenhando... em Haskell
published: 2012-01-04
en: en/blog/haskell/gloss-haskell
---

Um velho ditado da Computação diz que "Programar computadores é a coisa mais divertida que se pode fazer estando vestido",
e com certeza um dos "tipos" de programação mais divertido é quando o seu programa **desenha** algo na tela,
ou quando seu programa mostra uma **animação**.
É uma daquelas atividades que pode manter você acordado tarde da noite...

Em 31 de Dezembro de 2011 eu passei minha manhã e tarde inteiras escrevendo um programa que me ajudaria a conferir o resultado da Mega-Sena da virada.
Claro que, sendo um programa tão importante, ele PRECISAVA ter uma interface gráfica legal e bonita.
E claro que a linguagem escolhida para escrevê-lo foi Haskell; afinal, eu queria me **divertir muito** programando.

<!--more-->

Eu lembrava que há alguns meses atrás eu tinha encontrado uma ótima biblioteca Haskell,
chamada [gloss][1], mas não tive muito tempo para brincar com ela...
Mas dessa vez eu decidi que daria uma chance à gloss.
A biblioteca gloss permite ao programador criar e rodar imagens, animações e até JOGOS de uma maneira muito fácil em Haskell.
Ela roda sobre OpenGL, então - se você tiver uma placa gráfica razoável - seus jogos podem ficar até bem rápidos :)

O que eu precisei desenhar no meu programa de Mega-Sena era bem simples e chato (só alguns números coloridos),
então neste post nós vamos criar algo mais interessante com o gloss: Um relógio! Sim, um clássico relógio analógico, com ponteiros e tudo...

Primeiramente, grande parte dos valores que você vai manipular usando o gloss são do tipo [Picture][2].
E existem várias funções convenientes para criar Pictures fundamentais e transformar uma Picture em outra.
De fato, existe uma função "rectangleSolid", que foi exatamente o que usamos para criar os três ponteiros do nosso relógio.
Aí vai um exemplo de um retângulo preto de 50px por 200px.

```haskell
rectangleSolid 50 200
```

Nós precisamos de três retângulos para o nosso "relógio", um para cada ponteiro (segundos, minutos, horas).
E cada um deles tem um comprimento diferente. Então é assim que definimos  os ponteiros:

```haskell
baseLength w = 0.75 * w
secondsDialLength x = baseLength x
minutesDialLength x = secondsDialLength x * 0.75
hoursDialLength x = minutesDialLength x * 0.70
baseDial = rectangleSolid 15
secondsDial x = baseDial (secondsDialLength x)
minutesDial x = baseDial (minutesDialLength x)
hoursDial = baseDial . hoursDialLength
```

Eu fiz com que o comprimento dos ponteiros seja variável, e tudo depende do parâmetro de `baseLength`, que é `w`.
Esse `w` será a largura/altura do "painel" onde o relógio está.
Você pode então observar que temos três FUNÇÕES definindo o tamanho dos ponteiros, mas que a a **proporção** entre os comprimentos foi fixada...
Além disso, todos os ponteiros têm a mesma largura, então é por isso que definimos `baseDial = rectangleSolid15`.
Nós temos a chance, em Haskell, de "fixar" ou "ligar" apenas um parâemtro de rectangleSolid para 15, assim `baseDial` precisa de apenas mais um parâmetro, que é o comprimento do ponteiro.
Essa capacidade de "fixar" funções parcialmente é muito proeminente em Haskell e é chamada de "currying".
Se você quiser saber mais é só dar uma olhada aqui: [Currying][3]

```haskell
hoursDial = baseDial . hoursDialLength
```

A definição de `hoursDial` na linha acima parece um pouco diferente da definição dos outros ponteiros, não?
Bem, `hoursDial` ainda é uma função, mas cadê o seu parâmetro??
Ele não é necessário, pois hoursDial está definida como a **composição** das funções hoursDialLength e baseDial.
Você lembra do que aprendeu na escola? :P

**(f ∘ g)(x) = f(g(x))**

Então compare as duas definições equivalentes de hoursDial abaixo, substituindo `baseDial` por `f` e `hoursDialLength` por `g`.
Legal, não?

```haskell
hoursDial x = baseDial (hoursDialLength x)
hoursDial = baseDial ∘ hoursDialLength
```

Muito frequentemente em programação funcional a composição é usada para deixar o código menos verboso (mais limpo) e mais fácil de ler.

Agora, continuando com o nosso relógio!
Até agora, temos 3 ponteiros **estáticos**. O próximo passo é fazer com que eles se mexam :)
Usando o gloss, nós podemos fazer com que nossas Pictures sejam animadas apenas adicionando um argumento extra na sua definição: o argumento **tempo**.
Olha só:

```haskell
movingSquare t = rotate (90 * t) (rectangleSolid 100 100)
```

O `movingSquare` é uma animação.
Animações têm o tipo `Float → Picture`, ou seja, elas são **funções** que nos dão uma Picture (um frame) a cada instante de tempo!
Essa é uma definição bem elegante, não?
O parâmtero de tempo (`t`) representa quantos _segundos se passaram desde o início da animação_.
Portanto, no exemplo acima, nosso pequeno quadrado está rodando a uma velocidade de 90 graus por segundo...

Mas o ponteiro dos segundos precisa girar 6 graus/segundo (para fazer uma volta inteira em 1 minuto).
E o ponteiro dos minutos precisa girar 60 vezes mais devagar que o ponteiro dos segundos, e assim por diante...
Portanto, é da seguinte maneira que definimos as velocidades de rotação dos ponteiros:

```haskell
secondsRotationSpeed t = 6 * t
minutesRotationSpeed t = secondsRotationSpeed t / 60
hoursRotationSpeed t = minutesRotationSpeed t / 60
```

Essas funções de velocidade definem quantos graus de rotação um ponteiro deve ter, de acordo com o tempo decorrido em segundos.
E então agora, com as velocidades definidas, nós podemos muito facilmente definir nossos objetos móveis, os nossos ponteiros animados do relógio:

```haskell
seconds x t = rotate (secondsRotationSpeed t) (secondsDial x)

minutes x t = rotate (minutesRotationSpeed t) (minutesDial x)
hours x t = rotate (hoursRotationSpeed t) (hoursDial x)
```

Note que os ponteiros animados continuam recebendo o parâmetro de comprimento (`x`), mas que eles têm um parâmetro extra (`t`).
E que o "núcleo de movimento" está na função `rotate`.
O quanto precisa-se rodar depende do tempo `t`, e a figura a ser rodada é parametrizada pelo comprimento que damos (`x`).

Enfim... podemos agora definir o relógio em si.
Ele vai ser bem minimalístico (no estilo Apple :P), então ele vai ter SOMENTE 3 ponteiros e nada mais.
Caso você possua várias Pictures definidas e queira agrupá-las todas em uma Picture (meu caso), a função `pictures` do gloss pode fazer isso para você:

```haskell
clock x t = pictures [dial x t | dial &lt;- [seconds, minutes, hours]]
```

Nosso relógio é uma animação, e por isso ele recebe o parâmetro `t`.
Além disso os ponteiros têm comprimento variável, e isso é passado pelo parâmetro `x`.
Para construir a animação do `relógio inteiro`, nós pegamos cada um dos ponteiros animados, e passamos os MESMOS parâmetros para todos.
O que isso quer dizer é que o "tempo universal" "passa" com a mesma velocidade para todos os ponteiros...
Claro que se o relógio estivesse próximo da velocidade da luz isso não seria válido, mas deixa pra lá... :P

Como um "toque final" de elegância, eu quis adicionar a posssibilidade de acelerar ou retardar o tempo :)
Com a função `variableSpeedClock` abaixo, nós podemos fazer com que um segundo em nossa animação passe mais rápido (ou mais devagar) que um segundo no mundo real.
A definição de `variableSpeedClock` ficou assim:

```haskell
variableSpeedClock speed x t = clock x (t * speed)
```

Nós multiplicamos t pelo parâmetro de velocidade (`speed`), então - obviamente - quanto maior a velocidade, mais rápido um "segundo" vai passar no nosso relógio.

Por hoje era isso, pessoal!
Esse é o nosso super elegante e minimalista relógio analógico.
Agora podemos RODAR a animação chamando a função [animate][4] do gloss:

```haskell
animate (InWindow "GlossClock" (size, size) (200,200)) white (variableSpeedClock speed' size')
```

Caso você queira rodar o código e ver a beleza com seus próprios olhos, há duas possibilidades:

  * Instale a [Haskell Platform][5] no seu computador (no Ubuntu é só `sudo apt-get install haskell-platform`),
    e instale o gloss (com o comando `cabal install gloss`). 
    Você pode então pegar o código completo do relógio [AQUI][6], compilá-lo com `ghc --make Clock.hs` e RODAR!

  * Use a ótima [Interface Web do Gloss][7]: Copie o código [DAQUI][8], cole-o no campo de texto da interface gloss web e clique em "run"!

Ah, e não esquece de brincar com o código, alterá-lo e se divertir!
O código está sob licença Creative Commons non-bla bla bla... :D

Muito obrigado ao [Ben Lippmeier][9] por ter criado o gloss,
e muitíssimo obrigado ao Chris Smith por ter criado a interface web para o gloss.
O Chris também deu um curso muito legal, o [Haskell for kids][10], que me inspirou...
É ASSIM que eu quero ensinar os MEUS FILHOS a programar :)


[1]: <http://gloss.ouroborus.net/>
[2]: <http://hackage.haskell.org/packages/archive/gloss/1.6.0.1/doc/html/Graphics-Gloss-Data-Picture.html>
[3]: <http://www.haskell.org/haskellwiki/Currying>
[4]: <http://hackage.haskell.org/packages/archive/gloss/1.6.0.1/doc/html/Graphics-Gloss-Interface-Animate.html>
[5]: <http://hackage.haskell.org/platform/>
[6]: <http://hpaste.org/56079>
[7]: <http://dac4.designacourse.com:8000/>
[8]: <http://hpaste.org/56080>
[9]: <http://www.cse.unsw.edu.au/~benl/>
[10]: <http://cdsmith.wordpress.com/2011/08/16/haskell-for-kids-week-1/>
