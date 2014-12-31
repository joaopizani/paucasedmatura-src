---
title: Haskell Kata - Conway's Game of Life
published: 2012-01-20
en: en/blog/haskell/haskell-kata-game-of-life
---

Hoje eu vou falar sobre mais uma experiência de [Code Kata][1] que eu tive usando Haskell.
Dessa vez o código não veio diretamente de um Coding Dojo, mas foi uma "evolução" do código que produzimos em um Coding Dojo na UFSC.

Nessa reunião do Dojo, nós decidimos resolver o problema [Game Of Life][2].
Pra quem ainda não conhece essa famosa invenção do Conway, o artigo na Wikipedia é bem esclarecedor...
O objetivo básico do problema que estávamos tentando resolver era - dada uma configuração inicial do tabuleiro - evoluí-lo em uma geração e
mostrar o tabuleiro evoluído na tela.

Tentamos resolver, e resolvemos o problema \o/,
MAS - como sempre - eu estava com muita vontade de resolver o mesmo problema usando Haskell (ao invés de Python).
Então eu cheguei em casa, escrevi o código Haskell em mais ou menos 30min, ele **funcionou** e estava conciso e elegante...
Na verdade, eu achei que foi tão fácil que resolvi enfrentar um desafio maior, algo **gráfico**, porquê não?
Resolvi usar mais uma vez a fantástica biblioteca gráfica [Gloss][3],
e mais uma vez fiquei impressionado com os resultados.

<!--more-->

Vamos lá, começar a nossa rotina de um Kata em Haskell, primeiro descrevendo o problema em si e depois explicando a bela solução em Haskell para ele...

Descrição do problema
---------------------

(A descrição abaixo foi impiedosamente traduzida do respectivo [artigo][4] na Wiki do Coding Dojo,
como estava em 2012-01-19)

Esse Kata envolve calcular a próxima geração do Jogo da Vida de Conway, dada qualquer configuração incial.
Para mais detalhes sobre o assunto, dê uma olhada na [Wikipedia][5].

Tudo começa com um grid bidimensional de células, onde cada célula pode estar viva ou morta.
Nesta versão do problema, o grid é finito e não existe vida além das bordas.
Para o cálculo da próxima geração do grid, as seguintes regras devem ser seguidas:

  * Qualquer célula viva com menos de dois vizinhos vivos morre, como se fosse por "isolamento".
  * Qualquer célula viva com mais de três vizinhos vivos morre, como se fosse por "superpopulação".
  * Qualquer célula viva que possuir dois ou três vizinhos vivos continua viva.
  * Qualquer célula morta com exatamente três vizinhos vivos torna-se viva.

A tarefa do Kata é escrever um programa que aceita como entrada um grid arbitrário de células, e produza uma saída semelhante mostrando a próxima geração.

### Entrada e saída

A entrada da configuração inicial é feita através de um arquivo de texto com o seguinte formato:

    ........
    ....*...
    ...**...
    ........

A saída, nesse caso, deveria ser o seguinte:

    ........
    ...**...
    ...**...
    ........

Este formato foi escolhido por ser fácil de reconhecer em um grande número de linguagens.
OBS: Ele é MUITO fácil de reconhecer em Haskell :)


## "Solução" proposta em Haskell

**ALERTA: NÃO CONTINUE LENDO se você quer tentar resolver esse problema por si mesmo**

Como eu ia dizendo no começo do post, meu código não é exatamente uma solução para o problema, mas uma evolução sobre ela.
Meu código ultrapassa uma simples solução de duas maneiras:

  * Ele trata de mais de uma geração: de fato, é uma simulação interativa
  * Possui uma interface gráfica para exibir a simulação enquanto acontece

Apesar de o código ficar maior devido a essas funcionalidades extras, ele ainda é bem conciso e legível,
totalizando aproximadamente 150 linhas (com bastante espaço em branco).
E para que fique tudo ainda mais fácil de entender, nós vamos começar nosso "tour" pelo código pelo módulo que trata do problema "original" e "puro": primeiro vamos examinar as funções que lêem e evoluem o tabuleiro em uma geração.
Para começar, o parser que reconhece uma configuração inicial (imports omitidos):

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/GlossGameOfLife/Parser.hs?footer=0&slice=7:"></script>

Esse parser foi escrito usando a biblioteca Haskell [Parsec][6], que é fácil de usar, eficiente, popular,
e permite que se expresse **em Haskell** a gramática a reconhecer, de uma forma bastante concisa e legível.
O Parsec é uma biblioteca de **parser combinators**, o que significa que com ele construímos parsers "grandes" pela combinação de parsers mais simples,
que por sua vez são combinações de parser ainda mais simples, e assim por diante...
até chegarmos nos parsers primitivos fornecidos pelo Parsec como - por exemplo - `char`, usado para definir o parser de uma célula morta no código acima.

De fato, os parsers `dead` (para uma célula morta) e `alive` (para uma célula viva) são os mais básicos do módulo, e o que fazem é bem simples:
eles **mapeiam** um ponto ou uma letra 'O' maiúscula para False ou True, respectivamente.
Podemos analisar as assinaturas de tipo de `char` e `fmap` para saber mais precisamente o que cada uma dessas funções faz:

```haskell
fmap ∷ (a → b) → f a → f b
char ∷ Char → Parser Char
map ∷ (a → b) → [a] → [b]
```

Primeiramente, vamos falar um pouco sobre `char`.
O tipo exato de `char` (segundo a [documentação do Parsec][7])
é genérico e usa classes de tipos.
Porém, o tipo mostrado acima para `char` é uma especialização válida para o contexto em que está sendo usada.
Pode-se ver que a função `char` toma um caractere como parâmetro e nos retorna um **Parser que reconhece** aquele caractere.
Porém, nós queremos que `dead` seja do tipo `Parser Bool`, ou seja, um parser que retorna um valor booleano;
então precisamos de uma função que converta `Parser Char` em `Parser Bool`...
E é aí que [fmap][8] entra em cena pra nos ajudar!

Dá pra ver que não só o nome, mas também o tipo de `fmap` é bem parecido com o de `map`.
Na verdade, `fmap` é apenas uma generalização de `map`: enquanto `map` funciona com listas, `fmap` funciona com qualquer tipo de contêiner.
Portanto, a função `fmap` serve para o nosso propósito, pois qualquer valor de tipo `Parser a` é uma mônada, e toda mônada é um contêiner (a palavra complicada para contêiner é [Functor][9]).
O último detalhe interessante é a **função que mapeamos sobre (char '.') e (char 'O')**:
a função `const` significa que estamos descartando um argumento, que **não nos importa o valor retornado pelo Parser**;
contanto que o parser seja bem-sucedido, não interessa o char que ele retorna.

O restante do parser é mais fácil de entender, agora que você já entende o básico.
A função mais importante - a única exportada - do módulo (`parseBoardFromFile`) é a única que ainda merece algum comentário:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/GlossGameOfLife/Parser.hs?footer=0&slice=15:"></script>

Essa função toma um nome de arquivo como entrada (`FilePath` é só um sinônimo de `String`) e realiza algumas ações de Entrada/Saída (ler o arquivo e fazer parse de seus conteúdos).
Como resultado dessas ações, ela retorna uma matriz de valores booleanos (essa matriz é o nosso tipo `Board` \o/).
A função [parseFromFile][10] vem com o Parsec,
e faz exatamente o que o nome sugere, sendo que o seu tipo de retorno é `Either ParseError [[Bool]]`.
Pelo fato de `result` ter esse tipo, nós usamos a função [either][11] sobre ele.
A função `either` é usada sempre que é preciso **decidir o que fazer com base em um valor de tipo _Either_**.
No nosso caso, se o resultado é um parse correto, nós retornamos a matriz sem alterá-la (é isso que `id` faz, nada).
Porém, se o resultado é um erro de parsing, nós convertemos esse erro para uma string e terminamos o programa exibindo a mensagem (isso é o que `(error ∘ show)` está fazendo).

Agora... chega de parsing, e vamos ao que realmente importa: evoluir um tabuleiro por uma geração.
Esse sub-problema é tratado no módulo `Evolution`. As funções mais importantes de tal módulo são `evolve` e `eval`.
A função `eval` recebe uma posição do tabuleiro e nos diz se aquela posição deve estar viva ou morta na próxima geração, de acordo com sua vizinhança.
Já a função `evolve` recebe um tabuleiro inteiro e basicamente aplica `eval` sobre cada célula para criar a próxima geração;
com um pequeno detalhe: somente as células **interiores** são analisadas, ou seja, todas as células da borda são consideradas **sempre mortas**.
Aí vai o código para `eval` e `evolve`:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/GlossGameOfLife/Evolution.hs?footer=0&slice=8:24"></script>

A função `aliveNeighbours` recebe um tabuleiro e um par de coordenadas, retornando **quantas das 8 células que a cercam** estão vivas.
Sua definição é bem óbvia e sem sagacidade, portanto nem vou explicá-la - você vai ter que acreditar que ela funciona :)

Com o código que vimos até agora o problema original do Kata já está quase resolvido - só precisaríamos escrever funções para fazer a formatação do tabuleiro em texto...
MAS! Mas iremos fazer algo bem mais legal: nós vamos exibir a simulação em uma interface gráfica, assim:

![Gosper glider gun \o/\o/\o/](http://i.imgur.com/jCLp2.gif)

Antes que fiquem muito empolgados, preciso avisá-los: O módulo que descreve como desenhar os gráficos é o maior de todo o programa (com aprox.
50 linhas). Porém, se você rodar o programa e assistir à FANTÁSTICA simulação que ele mostra, vai concordar comigo que 50 linhas está **de bom tamanho :)**

De qualquer maneira, 50 linhas ainda é muito pra se colocar em um post, então só vou mostrar aqui as funções mais importantes - que são `drawModel`, `layout` e `activate`.
Aí vai o código delas:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/GlossGameOfLife/Drawing.hs?footer=0&slice=27:32"></script>

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/GlossGameOfLife/Drawing.hs?footer=0&slice=49:63"></script>

Vamos começar pela mais fácil de todas: `activate`.
Ela recebe uma matriz de `Picture` (quadrados) e atribui uma cor para cada um, sendo que a cor a ser atribuída depende do estado daquela posição no tabuleiro subjacente (célula viva ou morta).
A maneira com que implementamos `activate` é BEM típica de programação funcional, e se beneficia muito de avaliação _lazy_.
Primeiro, nós aplicamos `paintersFromBoard`, que tem tipo:

```haskell
paintersFromBoard ∷ [[Bool]] → [[Picture → Picture]]
```

Ela recebe um tabuleiro e o transforma em uma **matriz de funções**.
Mais especificamente, cada elemento nessa matriz é uma função de pintura, que transforma uma Picture alterando a sua cor.
Agora nós temos 2 coisas a serem combinadas:

  * Uma matriz de quadrados com cor indefinida (por default são mostrados pretos)
  * Uma matriz de "funções de pintura", uma para cada quadrado desses

Para combiná-las da maneira mais óbvia, usamos a função `applyFunctionMatrix` (não mostrada).
Sua definição é bem simples, mas típica de programas funcionais:
`applyFunctionMatrix` é definida _promovendo-se_ (liftM) o uso de `applyFunctionList` para a lista externa da matriz (a lista de linhas).
`applyFunctionList` tem a seguinte bela definição:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/GlossGameOfLife/Drawing.hs?footer=0&slice=42:43"></script>

Continuando ainda no módulo `Drawing`, nós chegamos à função `layout`.
O objetivo dessa função é - dada uma lista de figuras "não-posicionadas" (estando todas umas sobre as outras) - espalhá-las com um espaço entre cada duas,
de forma a que preencham uma linha horizontal ou vertical.
Nós queremos que a "sequência" resultante de figuras fique centralizada no ponto onde todas as figuras estão **atualmente posicionadas** (sobrepostas) - e é por isso que calculamos o índice base (`middle`) como sendo metade do tamanho da lista.
Nós então usamos a função `move` para deslocar cada figura de `i` passos na direção `dir`.
A função `move` conhece o tamanho das células, e por isso só precisamos dizer de quantos "passos" queremos deslocar uma figura - e então `move` se encarrega de fazer o deslocamento com precisão de pixels.

Por último, a função mais importante dentre todas no módulo `Drawing` - o coração da simulação: `drawModel`.
O seu tipo, `Board → Picture`, já nos diz o quão importante ela é.
A cada passo de simulação, o modelo (tabuleiro) é atualizado por uma chamada a `evolve`; então, a função `drawModel` é usada pelo
[motor de simulação do Gloss][12] para renderizar o modelo como uma Picture.
A definição de `drawModel` é um simples pipeline com os passos:

  * Crie uma matriz de ordem l × c, com quadrados de tamanhos iguais - por default eles são todos pretos e posicionados em (0,0)
  * Pinte os quadrados de acordo com o modelo
  * Posicione os quadrados - igualmente espaçados - em um grid

Senhoras e senhores, tendo visto como executar um passo da simulação (`evolve`) e como renderizar o modelo (`drawModel`), vocês já entenderam QUASE tudo sobre o programa.
Vou agora apenas mostrar como o uso da função [simulate][13]
do Gloss conecta todas as peças do nosso programa.
A nossa função `main` é basicamente uma chamada a `simulate`, mais ou menos assim:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/GlossGameOfLife/GlossGameOfLife.hs?footer=0&slice=11:"></script>

A função `simulate` precisa de 6 parâmetros, e por mais que isso possa parecer complicado, todos eles são bem razoáveis:

  * **display:** define como o gloss deve mostrar a simulação - tamanho e posição da janela, etc.
  * **bg:** cor de fundo para a área de desenho.
  * **fps:** quantos passos de simulação devem ocorrer em um segundo de tempo real.
  * **initial:** o estado inicial do modelo (lido do arquivo).
  * **drawModel:** uma função que transforma o modelo em uma `Picture`.
  * **step function:** uma função que avança o modelo em uma iteração. Usamos o lambda para ignorar alguns parâmetros irrelevantes para nós.


PRONTO! TADA!
Como sempre, você pode baixar o pacote do código-fonte (em formato cabal) do meu repositório de katas no GitHub (<https://github.com/joaopizani/katas/tree/blog-05-2012/GlossGameOfLife>),
compilar e rodar da seguinte maneira:

```bash
cd GlossGameOfLife
cabal-dev install
```

Divirta-se!

[1]: <http://codekata.pragprog.com>
[2]: <http://www.codingdojo.org/cgi-bin/index.pl?action=browse&id=KataGameOfLife>
[3]: <http://hackage.haskell.org/packages/archive/gloss/1.6.0.1/doc/html/Graphics-Gloss.html>
[4]: <http://www.codingdojo.org/cgi-bin/index.pl?action=browse&id=KataGameOfLife>
[5]: <http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life>
[6]: <http://hackage.haskell.org/package/parsec-3.1.2>
[7]: <http://hackage.haskell.org/packages/archive/parsec/3.1.2/doc/html/Text-Parsec-Char.html#v:char>
[8]: <http://hackage.haskell.org/package/base-4.7.0.2/docs/Control-Monad.html#v:fmap>
[9]: <http://learnyouahaskell.com/making-our-own-types-and-typeclasses#the-functor-typeclass>
[10]: <http://hackage.haskell.org/packages/archive/parsec/3.1.2/doc/html/Text-Parsec-ByteString.html#v:parseFromFile>
[11]: <https://hackage.haskell.org/package/base-4.7.0.2/docs/Data-Either.html>
[12]: <http://hackage.haskell.org/packages/archive/gloss/1.6.0.1/doc/html/Graphics-Gloss-Interface-Simulate.html>
[13]: <http://hackage.haskell.org/packages/archive/gloss/1.6.0.1/doc/html/Graphics-Gloss-Interface-Simulate.html#v:simulate>
