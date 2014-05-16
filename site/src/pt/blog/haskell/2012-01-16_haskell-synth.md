---
title: Um Sintetizador em Haskell - Brincando com geração de som
published: 2012-01-16
en: en/blog/haskell/haskell-synth
---

Há algum tempo atrás, em uma nublada tarde de sexta-feira, eu estava sem nada para fazer.
Eu e meus [amigos do PET][1] começamos a conversar sobre a filosofia Unix,
em particular sobre como tudo no Unix é um arquivo, até [dispositivos][2] são representados como arquivos...
Então eu pensei: a placa de som é um arquivo! O que acontece se eu escrever nesse arquivo?!
Começamos então a escrever muitas coisas (PDFs, /dev/urandom, código-fonte e algumas imagens) na placa de som, e foi bem divertido :)

Mas então nós resolvemos aumentar a diversão e jogar bytes mais "organizados" para a placa - bytes gerados por um programa.
E que melhor ferramenta para fazer geração de dados do que Haskell?!
Então eu comecei a escrever naquela tarde meu primeiro sintetizador de áudio,
e depois de poucas horas ele estava pronto e - incrivelmente - funcionando.
Eu fiquei tão empolgado com o resultado que simplesmente **precisava** compartilhar esse código com o resto do mundo :)

Meu sintetizador em Haskell toma como entrada um "arquivo de partitura", descrevendo a melodia a ser gerada.
Esse arquivo de entrada tem uma sintaxe bem semelhante à do bom e velho "Nokia Ringtone Composer"...
O programa lê a melodia desse arquivo e produz um monte de bytes na saída padrão.
Se você redirecionar a saída padrão para a placa de som, vai ouvir suas musiquinhas favoritas!
Bom, vamos começar o tour pelo código do sintetizador:

<!--more-->

Esse tour vai ser no estilo "top-bottom":
primeiro, vamos ver o módulo Main e os principais passos no processamento,
depois iremos um pouco mais fundo, analisando algumas das funções mais importantes dos outros módulos.
Pra começar, aí vai o módulo `Main` inteiro:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/ToneSynthesizer/ToneSynthesizer.hs?footer=0"></script>

Como pode-se ver na segunda linha da função `main`, nosso programa precisa de 2 parâmetros de linha de comando:
`file` e `bpmStr` (que é transformado em um Int chamado `bpm`).
O parâmetro `file` é o nome do arquivo de partitura, e `bpm` é o andamento em que a melodia deve ser tocada (in batidas por minuto - BPM).
Com os parâmetros em mãos, nós fazemos o parsing da partitura usando a função `parseFromFile` (do [Parsec][3]).
Essa função toma como parâmetros um parser a ser aplicado e o nome do arquivo do qual será lida a entrada para o parser.
O nosso parser `score` está definido em um arquivo separado (`Melody.hs`) e não vai ser explicado...
Você pode vê-lo baixando o código-fonte completo no final do post.

A função `parseFromFile` tem tipo `Parser a → String → Either ParseError a`, o que significa que seu resultado é um dentre (`Either`):
um resultado correto (`Right [Note]`) ou um erro (`Left ParseError`).
Nós então aplicamos a função [either][4] sobre `parsedScore` para decidir o que fazer de acordo com o caso do resultado:
caso o resultado seja um parse correto, a função `id` é aplicada (o que não o altera);
já caso um erro tenha sido encontrado, aplicamos (error ∘ show) - o que mostra a mensagem de erro na saída padrão e mata o programa.
O próximo "grande passo" de processamento é transformar a partitura lida em uma melodia **concreta**.

A partitura lida é uma sequência de notas musicais com durações relativas (1, 1/2, 1/4, etc.) e alturas abstratas (Dó, Ré, Mi, etc.),
então a função `concrete bpm` é responsável por _absolutizar_ a duração e altura de cada uma dessas notas.
Seu tipo é:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/ToneSynthesizer/Parameters.hs?footer=0&slice=20:21"></script>

Ela toma um `Tempo` e uma `Note` como parâmetro e produz um par representando o som concreto,
onde o primeiro elemento é a frequência desse som (em Hz) e o segundo elemento é sua duração (em segundos).

Depois que temos a lista de pares sonoros a serem tocados (`concreteMusic`), nós chegamos ao último e mais importante passo, que é de fato gerar a sequência de amostras e jogá-las na saída, usando `concreteMusic` como **guia no processo de geração**.
Essa geração é feita por `produceStream`. Para cada par de frequência e duração `(f,t)`, é feito o seguinte:

  * As amostras para uma onda quadrada (infinita) de frequência `f` são geradas, chamando-se `signal f`.
  * Esse sinal é então "fatiado" para se obter um pedaço de duração `t`, chamando-se `slice t`.

E por fim, toda essa sequência de "fatias de ondas" é concatenada em uma única [ByteString][5] que vai para a saída padrão...
Vamos agora um pouco mais fundo,
até o arquivo `Signal.hs`, e ver as definições de `signal` e `slice`, assim como de algumas funções auxiliares:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/ToneSynthesizer/Signal.hs?footer=0&slice=8:"></script>

Primeiro de tudo: nosso sinal sendo gerado é uma onda sonora.
E a característica mais marcante das ondas é que elas são **periódicas**, ou seja, elas são apenas a repretição infinita de um certo **padrão**.
Por isso temos a função `period`, que - dado o número de amostras a gerar e a forma de onda desejada - gera uma lista de amostras seguindo aquela forma.
Então é assim que a função `signal` usa `period` para fabricar uma onda:
ela pega a frequência passada e calcula (de acordo com a taxa de amostragem) **quantas amostras há em um período**.
Ela então chama a função `period` para gerar um `singlePeriod`, que é então empacotado em uma ByteString infinita e repetitiva.
A função `silence` só serve para gerar um período "burro" (com apenas uma amostra) para quando precisamos de uma pausa.
O período de silêncio não precisa ter mais de uma amostra, pois vai virar uma ByteString infinita de 0s de qualquer maneira...

A função `cycleAndPack` recebe um período (`[Int]`) e o transforma em uma [ByteString][6] infinita.
Seu tipo já é bastante auto-explicativo.
A parte `(map fromIntegral)` transforma `[Int]` em `[Word8]`, que então serve de entrada para `B.pack`, que de fato cria a ByteString,
que é repetida infinitamente por `B.cycle`.

Vamos agora então **fatiar** as ondas! :)
O objetivo da função `slice` é transformar uma onda infinita de uma frequência em um trecho de onda, com a duração desejada em segundos.
O tipo de `slice` é:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/ToneSynthesizer/Signal.hs?footer=0&slice=8:9"></script>

O tipo deixa bem claro que `slice` é uma função que transforma ByteStrings.
Sua definição também ajuda a entender o que ela faz:
fatiar uma ByteString infinita nada mais é do que **pegar (take)** `n` dos seus primeiros elementos, onde `n` é o produto to tempo desejado (em segundos) pela taxa de amostragem (em Hz).

Antes de continuar a mostrar mais código, eu vou fazer um pequeno desvio no assunto pra mencionar duas características de Haskell que nos ajudam a expressar esse programa de uma maneira tão elegante (e ao mesmo tempo eficiente):

  * **Lazyness:** Devido ao fato de que, em Haskell, toda avaliação de expressões é lazy por padrão,
    nós pudemos representar as ondas sonoras como sequências infinitas de amostras, separando as responsabilidades de geração e utilização.

  * **Transparência referencial:** A pureza de Haskell garante que toda função é transparente.
    Portanto, o valor de **qualquer expressão** só precisa ser computado **uma única vez**, e pode substituir qualquer ocorrência daquela expressão no programa.
    Isto é importante pois - em uma mesma melodia - várias notas vão ter a mesma frequência (e portanto resultar em ondas idênticas).
    Graças à transparência referencial, é **garantido** que `signal f` só é computado uma vez para cada valor de f,
    e assim só temos uma onda para cada frequência em nossa melodia.

OK, agora tendo entendido como `signal` e `slice` funcionam, o quebra-cabeças do sintetizador está quase completamente resolvido.
O único mistério restante é como o arquivo de entrada (no formato Nokia Composer) é lido.
Porém - como eu já disse antes - o parser da entrada é relativamente fácil de entender, e usa só funções básicas do Parsec.
Ele (o Parser) é o maior bloco de código em todo o programa, por isso eu vou mostrar somente uma versão resumida aqui - e nem vou comentá-la.
Você pode baixar o código completo no final do post e dar uma olhada mais profunda...
Aí vai então, o "núcleo" do nosso parser de partitura:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/ToneSynthesizer/Melody.hs?footer=0&slice=18:25"></script>

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/ToneSynthesizer/Melody.hs?footer=0&slice=59:"></script>

Agora um pouco de diversão, para fechar o post com chave de ouro:
eu incluí algumas melodias de exemplo no tarball do sintetizador; e rodei o sintetizador com essas melodias, gerando arquivos MP3 para poder postar aqui.
Olha só, música eletrônica, usando Haskell! :P

  * **Europe - The Final Countdown:**
      + Song score:

            p4, p8, b16, a16, b4, e4, p4, p8, c'16, b16, c'8, b8, a4, p4, p8, c'16, b16, c'4,
            e4, p4, p8, a16, g16, a8, g8, f#8, a8, g4, p8, f#16, g16, a4, p8, g16, a16, b8, a8,
            g8, f#8, e4, c'4, b2, p4, b16, c'16, b16, a16, b1`

      + MP3: [Audio file](/files/other/2012-01_finalcountdown.mp3)

  * **Zelda Main Theme:**
      + Song score:

            a#4, f4, f8, f16, a#16, a#16, c'16, d'16, d#'16, f'2, p8, f'8, f'8, f#'16, g#'16,
            a#'2, p8, a#'8, a#'8, a#'8, g#'16, f#'16, g#'8, g#'16,  f#'16, f'2`

      + MP3: [Audio file](/files/other/2012-01_zelda.mp3)

Finalmente, como sempre, chegamos à parte que REALMENTE importa: O Código Fonte.
O código desse sintetizador, assim com o de vários outros `protótipos` meus, está no repositório "Katas" no GitHub (<https://github.com/joaopizani/katas>).
Você pode baixar um zip com o código do repositório ou cloná-lo e brincar à vontade...
Eu recomendo FORTEMENTE que você use o [cabal-dev][7] para compilar de maneira organizada todos os seus projetos Haskell,
então caso você deseje seguir minha recomendação, os comandos para compilar e rodar (no Unix/Linux) o sintetizador são os seguintes:

    cd ToneSynthesizer
    cabal-dev install
    ./cabal-dev/bin/tonesynthesizer songs/<melodia>  | aplay -t raw -f U8 -r 16000

Por hoje era isso, pessoal!
Aceito todo tipo de crítica e sugestão pra melhor o código.
Mandem à vontade!
Happy Coding! :)

[1]: <http://pet.inf.ufsc.br/membros>
[2]: <http://en.wikipedia.org/wiki/Device_file>
[3]: <http://hackage.haskell.org/package/parsec-3.1.2>
[4]: <http://www.haskell.org/ghc/docs/latest/html/libraries/base-4.4.1.0/Data-Either.html>
[5]: <http://hackage.haskell.org/package/bytestring-0.9.2.0>
[6]: <http://hackage.haskell.org/package/bytestring-0.9.2.0>
[7]: <http://hackage.haskell.org/package/cabal-dev>
