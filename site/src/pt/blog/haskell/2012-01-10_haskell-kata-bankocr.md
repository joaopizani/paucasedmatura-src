---
title: Haskell Kata - BankOCR
published: 2012-01-10
en: en/blog/haskell/haskell-kata-bankocr
---

Há algum tempo atrás eu e meus amigos da Universidade tínhamos o costume de fazer uma sessão de Coding Dojo a cada 15 dias, e era MUITO LEGAL.
Se você não imagina o que seja um Coding Dojo, ele é - basicamente - uma reunião onde um pequeno grupo de programadores (de 5 a 20) se diverte e exercita suas capacidades de programação através de uma **metodologia pragmática**.
Mais detalhes sobre o que é e como funciona um Dojo estão no blog do [Coding Dojo UFSC][1].

Após alguns Dojos, o pessoal saía tão empolgado com o problema que decidia resolvê-lo de novo, em casa, usando sua linguagem favorita...
Eu mesmo, algumas vezes, resolvi alguns problemas do Dojo em Haskell, e quero postar aqui no blog alguns desses problemas (e claro, as soluções funcionais :D).
No primeiro dessa série de posts vamos tratar do [BankOCR][2].

<!--more-->


Descrição do problema
---------------------
O "OCR" no nome do problema já dá mais ou menos uma idéia do que se trata:
queremos fazer um tipo de reconhecimento de caracteres, só que bem mais simples que reconhecimento ótico...

A entrada pro nosso programa é um simples arquivo de texto, mas que contém uma espécie de "matriz de 7 segmentos" onde estão dígitos numéricos.
Assim:

      _  _     _  _  _  _  _
    | _| _||_||_ |_   ||_||_|
    ||_  _|  | _||_|  ||_| _|

Onde cada dígito tem uma "altura" de 3 "segmentos" (linhas no arquivo) e também uma "largura" de 3 colunas.
A tarefa do programa é então interpretar esse arquivo de entrada e responder na saída padrão com o número correspondente,
que no caso do exemplo acima seria "123456789".

Na [descrição oficial do problema][3] há vários incrementos ao desafio,
incluindo ler vários desses números, fazer validações dos números lidos, pequenas correções de erro na leitura, etc.
Mas nossa implementação só cobre o básico mesmo, que é,
dado uma sequência horizontal de dígitos bem formados, jogar na saída o número correspondente.


Solução em Haskell
------------------

**ATENÇÃO: Spoiler à frente. Se quiser tentar você mesmo resolver esse problema, NÃO CONTINUE LENDO.**

A minha solução em Haskell para esse desafio ficou, creio eu, bastante idiomática e relativamente fácil de entender.
Além disso, ficou também bem curta.
Tirando a tabela de dígitos (que é a parte não-inteligente do programa) o código tem menos de 10 linhas (com imports e tudo).
Aí vai o código --- sem a tabela inteira:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/katas/blob/blog-05-2012/BankOCR/OCR.hs?footer=0&slice=0:16"></script>

O nosso programa é um típico **filtro** Unix, o que quer dizer que o texto de entrada vai vir pela entrada padrão e o resultado do processamento vai ser jogado na saída padrão.
O requisito de que nosso programa funcionasse dessa maneira levou a usar a função "interact" no main.
Ela tem o seguinte tipo:

```haskell
interact ∷ (String → String) → IO ()
```

Ou seja, ela toma como argumento uma **função de String para String** e realiza I/O com ela.
A função "interact" adiciona interação à função que ela recebe, "interact" conecta a entrada padrão na saída padrão,
fazendo o conteúdo **passar pela função** por nós definida.

A função "parse" tem alguns pontos interessantes e talvez não tão óbvios que merecem comentário:

  * A função `transpose` é da biblioteca padrão (o "Prelude"), e trabalha sobre listas de listas.
    Ela transforma linhas em colunas e vice-versa (tá, essa era óbvia :P)

  * `lines` também é do Prelude, e tem tipo `String → [String]`.
    Ela pega uma String e a separa nas quebras de linha, retornando uma lista de linhas.

  * A função `lookup` busca um valor numa tabela associativa simples.
    Uma tabela simples em Haskell é uma lista de duplas `[ (chave, valor) ]`

  * `lookup` retorna um valor do tipo `Maybe Char`. Isso pois em geral a chave procurada pode não estar na tabela (ela **talvez** esteja lá).
    Para transformar um `Maybe Char` no `Char` que queremos, usamos `fromJust`.
    Claro que, se `fromJust` for chamado "por nada" :P (passando `Nothing`), exceções de tempo de execução CABREIRAS ocorrerão.
    Mas nós o usamos pois temos CERTEZA que todos os dígitos estão na tabela... :P

  * A função `chunk` é do módulo Data.List.Split, e tem tipo `[a] → [[a]]`.
    Ela faz exatamente o que o nome sugere: retorna "grupos" de elementos da lista de origem, onde todos os grupos tem o tamanho desejado.

  * Sobre o uso de `dummy`: Há uma coluna em branco como separadora entre os dígitos.
    Isso faz com que possamos ler todos os dígitos com largura 4 (EXCETO O PRIMEIRO).
    Para não me chatear tratando casos de contorno, eu forcei o primeiro dígito a também ter 4 colunas - adicionando uma coluna `dummy`.
    Essa `tática` de transformar casos de contorno em casos normais pra depois tratar todos por igual é BEM frequente em programação funcional

Podemos rodar o programa assim:

    joaopizani@rabbithole:~$ cat twohundredfiftysix
     _   _   _
     _| |_  |_
    |_   _| |_|

    joaopizani@rabbithole:~$ cat twohundredfiftysix | ./OCR
    256

Claro que você não precisa acreditar na minha palavra, e pode confirmar que funciona você mesmo.
É só pegar o código completo no meu repositório de katas no GitHub (<https://github.com/joaopizani/katas/blob/blog-05-2012/BankOCR/OCR.hs>), compilar e rodar.
Ele precisa do pequeno módulo "Data.List.Split" pra funcionar, então os comandos pra rodar ficam assim:

```bash
cabal install split
ghc --make OCR.hs
cat <seu-arquivo> | ./OCR
```

Obrigado pela leitura e divirta-se! :)

[1]: <http://pet.inf.ufsc.br/dojo/o-que-eh-dojo>
[2]: <http://codingdojo.org/cgi-bin/wiki.pl?KataBankOCR>
[3]: <http://codingdojo.org/cgi-bin/wiki.pl?KataBankOCR>
