---
title: Mega-sena em Haskell: Um exemplo simples e legal de mônadas e monad transformers
published: 2012-01-06
en: en/blog/haskell/haskell-transformers
---

O meu fraco entendimento de mônadas em Haskell começou há alguns anos atrás,
quando eu ouvi que IO era uma mônada (seja lá o que fosse isso)...
Apesar de ouvir a tão temida palavra "M", eu não me assutei muito e continuei programando meus pequenos programinhas Haskell,
usando "putStrLn", "getLine", "readFile", "writeFile" e etc.
E então, no meu terceiro ano de graudação,
eu decidi implementar uma aplicação gráfica para a manipulação de autômatos finitos, usando GTK ([Gtk2Hs][1]).
Durante o desenvolvimento desse programa, uma grande parte das minhas funções teve seu tipo "infectado" pelo "IO",
então eu pensei que fosse uma boa hora pra começar a aprender mais sobre essa tal de "Mônada".

Daí eu descobri que existem MUITAS mônadas em Haskell,
e que MUITAS delas são bem úteis e populares - mesmo quando você **nem sabe** que elas são mônadas...
Existe a mônada State, mônadas para parsing, as mônadas Reader e Writer, mônadas Error,
a mônada Either, a mônada Maybe e até a mônada List!!!
SIM! `(Maybe a)` e `[a]` são mônadas! :D
Bem, "tudo isso são mônadas e é tudo muito legal, mas quem se importa?", você pode estar se perguntando.
Eu espero dar o **começo** de uma resposta com o exemplo desse post.

<!--more-->

Nesse post eu vou assumir que você tem pelo menos alguma experiência com Haskell, e que já brincou pelo menos com IO (quem sabe com Maybe também, hein?)...

Pois então, existe uma grande tradição anual no Brasil, que é um sorteio da Mega Sena todo dia 31 de Dezembro - a famosa "Mega da Virada".
Esse ano (2011) a minha família fez um bolão de 180 combinações, e eu escrevi um programa para conferir quais dessas combinações tinham os números sorteados.
Eu escrevi o programa em Haskell, CLARO.
E fui - mais uma vez - obrigado a aprofundar meus conhecimentos de mônadas e monad transformers para realizar o trabalho.

O programa deve funcionar assim: O arquivo contendo todas as 180 combinações (cada uma com 6 dezenas) deve ser lido.
Então, 6 rodadas de entrada de dados devem acontecer: em cada rodada, o usuário entra com uma dezena e o programa adiciona essa dezena na parte "sortuda" de cada combinação que a contiver.
Então, as 5 combinações com a maior parte "sortuda" são exibidas na tela. Só para lembrar: seis dessas "rodadas" precisam acontecer.

Eu comecei modelando o programa no estilo "bottom-up", e a primeira coisa que defini foi um tipo de dados para representar uma combinação da Mega-Sena, o tipo "Combination":

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/HaskellLottery/Main.hs?footer=no&slice=9:20"></script>

Note que uma `Combination` tem dois [conjuntos de ints][2], o `lucky` e o `unlucky`.
O `lucky` contém os números pertencentes à combinação e que já foram sorteados, enquanto os `unlucky` são o resto...
A instância de Ord para `Combination` também é interessante: uma combinação é **maior** que outra se o tamanho do seu conjunto "sortudo" é maior.
Eu usei `(flip compare)` na definição só para deixar mais claro que estamos fazendo uma comparação invertida:
ao invés de determinar se é menor ou igual, determinamos se é maior.

O meu próximo passo foi implementar a leitura do arquivo para uma lista de `Combination`.
Essa parte do post pode parecer até simples demais e "fora de contexto", mas eu tentei usar recursos legais de mônadas _até aqui_:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/HaskellLottery/Main.hs?footer=no&slice=22:34"></script>

Por exemplo, comparando os tipos de `makeCombination` e `makeCombinations`, você vê que ambos têm **muito** em comum.
Acho que a maioria das pessoas implementaria makeCombinations como `makeCombinations = map makeCombination`.
Eu só usei [liftM][3] para deixar bem claro que List também é uma mônada.
Portanto, nós estamos "elevando" a função `makeCombination` **ao patamar da mônada List**.
Agora, na definição de `readCombinations`, nós precisamos usar `liftM` mais uma vez, só que para elevar `makeCombinations` **ao patamar da mônada IO**.
A expressão `liftM makeCombinations` tem o tipo `IO [[Int]] → IO [Combination]`, e a expressão `readMatrix` tem tipo `FilePath → IO [[Int]]`,
assim os tipos casam direitinho e podemos usar uma composição elegante, assim :)

    (FilePath → IO [[Int]]) ∘ (IO [[Int]] → IO [Combination]) ⇒ (FilePath → IO [Combination])

Continuando no código, chegamos então à função principal do nosso verificador de loteria: a função `matchWithCombination`, a qual toma como parâmetros um `probe` (dezena recém-sorteada) e uma combinação de seis dezenas, retornando uma nova combinação com conjuntos "sortudo" e "azarado" atualizados com o casamento do `probe`.

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/HaskellLottery/Main.hs?footer=0&slice=36:40"></script>

Nós usamos a função IntSet.intersection para "casar" a dezena `probe` com os números azarados (`unlucky`), e então atualizamos o conjunto sortudo (`lucky`),
unindo-o com a (possível) nova dezena.
A definição de `matchWithCombination` também exemplifica um recurso muito legal na sintaxe do Haskell:
é possível usar E definir funções de forma **infixada**, bastando colocar aspas reversas em volta do nome.

Bem... continuando, vamos à definição de `matchWithCombinations`, que é bem óbvia:
ela é QUASE somente um map (uma "promoção" à mônada List), mas nós precisamos conservar o argumento `probe` (não promovê-lo),
então é por isso que fazemos essa aplicação parcial:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/HaskellLottery/Main.hs?footer=0&slice=41:43"></script>

Nosso programa agora já tem bastantes funcionalidades.
Usando a função `matchWithCombinations`, nós já podemos pegar uma dezena e saber quais são as combinações em que ele aparece.
Dois dos requisitos que tínhamos definido estão faltando, porém:

  * Nós precisamos de entrada (o usuário precisa **digitar** os números no terminal) e de saída (as top 5 combinações devem ser exibidas na tela)
  * Precisamos realizar 6 rodadas de (entrada → processamento → saída)

A função `matchWithCombination` realiza somente UM "passo" de atualização,
portanto nós precisamos ficar fazendo chamadas aninhadas dela e ficar "passando o estado" dos resultados numa cadeia, mais ou menos assim:

    (matchWithCombinations <dezena> (matchWithCombinations <dezena> (matchWithCombinations <dezena> originalCombs)))

Geralmente, para obter esse efeito de "passagem de um estado" entre chamadas de funções, nós usamos a [mônada State][4].
E, como você já deve ter adivinhado, para realizar operações de entrada e saída, nós usamos a toda poderosa **mônada IO**.
É interessante perceber como cada "camada de funcionalidade" no seu programa corresponde a uma camada na **Pilha de mônadas** que o seu programa se torna.
No nosso caso, nós precisamos **combinar** as mônadas "State" e "IO", lembre disso...

Agora, em um pequeno desvio da nossa loucura combinatória, deixe-me mostrar pra vocês a simples e humilde mônada `askForNewNumber` (uma função dentro da mônada IO).
O objetivo de `askForNewNumber` é ler uma linha do terminal e fazer o melhor que puder para transformar o que foi lido em um Int:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/HaskellLottery/Main.hs?footer=0&slice=45:47"></script>

Nós queremos poder utilizar `askForNewNumber` no corpo de uma mônada mais sofisticada, chamada `includeNewNumber`.
A mônada `includeNewNumber` manterá um **estado** que consistirá da nossa lista de combinações, e vai (a cada vez que for chamada) ler um número do terminal e atualizar o estado com as combinações casadas com a dezena recém-lida.
O tipo de `includeNewNumber` tem que ser uma combinação de IO (pois ela usa `askForNewNumber`) e de State. Mas como fazemos para combinar duas mônadas??

Bem, a boa notícia é que geralmente nós podemos combinar duas mônadas em uma **nova mônada**, usando uma coisinha chamada **monad transformers** :P
No nosso caso, queremos "transformar" a uma simples mônada IO em uma mônada combinada "State IO".
Veja a linda definição de "includeNewNumber" com os seus próprios olhos:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/HaskellLottery/Main.hs?footer=0&slice=48:53"></script>

Ao pé da letra, o tipo de `includeNewNumber` é `StateT [Combination] IO ()`, o que significa que aplicamos o **"State Transformer"** à mônada IO, que o tipo do nosso estado é `[Combination]` e que o tipo retornado pela mônada IO é () (unit).
O transformer StateT `envolve` a mônada IO com uma camada de State, então agora a "pilha de funcionalidades" do nosso programa tem oficialmente 2 camadas!
Legal, não?! :D  Antes de continuar, uma pequena explicação: **a mônada IO precisa sempre estar na base da pilha**, principalmente pois todas as outras camadas devem ser "removidas" quando o programa for rodar, e o `IO ()` que sobra é justamente o tipo da função `main`.
A tarefa de "remover" a camada de IO e executar entrada/saída é feita pelo sistema runtime do Haskell, e está fora do nosso controle :)

No corpo da definição de `includeNewNumber`, nós precisamos elevar `askForNewNumber` (usando a função `lift`) para que ela bata com o tipo da camada exterior (StateT).
Após obter o valor em `probe`, nós modificamos o estado guardado pela mônada usando a função `matchWithCombinations probe`.
Agora, com a definição de `includeNewNumber` completa, nós já estamos BEM próximos de ter esse programa PRONTO®.
De fato, estamos tão próximos que já poderíamos chamar `includeNewNumber` seis vezes...
as dezenas seriam lidas do terminal e a lista de combinações seria corretamente atualizada; o único problema é que nada apareceria na tela :(

Claro que vamos implementar essa última funcionalidade restante (exibir as 5 melhores combinações),
mas essa opcionalidade mostra que mônadas (e monad transformers) permitem a escrita de software de uma maneira bastante **modular**,
onde funcionalidades independentes estão implementadas por código independente.
Usar mônadas permite um alto grau de [Separação de Responsabilidades][5].
Vamos então em frente, com a implementação da nossa função mais cheia de funcionalidades possível: `includeAndPrintTop5`:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/HaskellLottery/Main.hs?footer=0&slice=54:58"></script>

Primeiro, nós incluímos uma dezena e extraímos o estado (já atualizado) para `combs`.
Então, passamos `combs` por um pipeline que vai imprimir as 5 maiores combinações na tela.
No final desse pipeline, nós precisamos "elevar" (`lift`) novamente o resultado, para que o valor tipo `IO ()` retornado por putStrLn seja promovido a um `StateT [Combination] IO ()` que desejamos.

Caro leitor, **está na hora!** Vem chegando o fim desse post: vou mostrar pra vocês a implementação da função `main` do nosso programa de loteria...
Ela contém 2 linhas de código! :)

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/HaskellLottery/Main.hs?footer=0&slice=60:63"></script>

Explicações mais fáceis primeiro: na primeira linha nós lemos o arquivo para a variável com o nome sugestivo `initial`.
Então nós precisamos realizar 6 rodadas de `includeAndPrintTop5`, e isso é o que `replicateM_ 6` está fazendo ali.
Se você quiser, pode fazer essa repetição manualmente, assim:

```haskell
execStateT (includeAndPrintTop5 » includeAndPrintTop5 » includeAndPrintTop5 »
            includeAndPrintTop5 » includeAndPrintTop5 » includeAndPrintTop5 » return ()) initial
```

Por fim, nós usamos a função `execStateT` para "desempilhar" o State Transformer e deixar o resto do trabalho para nosso velho amigo IO ().
Os argumentos para execStateT são a mônada State que ele deve "executar" e um estado inicial.
Ele então executa essa mônada e ignora o valor retornado (caso você queira o valor retornado, pode usar `evalStateT`).

PRONTO! TA-DA! :D  Por favor não acredite nessa magia negra que eu disse que fiz.
Pegue o código no meu repositório de "katas" no GitHub (<https://github.com/joaopizani/katas>) e rode você mesmo, modifique-o e brinque com ele...
Divirta-se! :)

PS:

  * Se você já mexeu com listas em Haskell antes, você conhece a função `replicate` de Data.List...
    E, de fato, `replicateM_` e `replicate` funcionam de maneira MUITO similar. Olha só (≡ significa "é equivalente a"):

    ```haskell
    replicate 6 1   ≡ 1 : 1 : 1 : 1 : 1 : 1 : []
    replicateM_ 6 m ≡ m » m » m » m » m » m » (return ())
    ```

  * Se você quer REALMENTE saber como `1 : 1 : 1 : []` e `m » m » m » (return ())` estão relacionados, leia o código-fonte.
    Sério, ele está [AQUI][6].


[1]: <http://projects.haskell.org/gtk2hs/>
[2]: <http://hackage.haskell.org/packages/archive/containers/0.4.2.0/doc/html/Data-IntSet.html>
[3]: <http://www.haskell.org/ghc/docs/latest/html/libraries/base/Control-Monad.html#g:7>
[4]: <http://www.haskell.org/haskellwiki/State_Monad>
[5]: <http://en.wikipedia.org/wiki/Separation_of_concerns>
[6]: <http://www.haskell.org/ghc/docs/latest/html/libraries/base/src/Control-Monad.html#sequence_>
