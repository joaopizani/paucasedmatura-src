---
title: Processamento de imagens em Haskell - fácil e automaticamente paralelo
published: 2011-06-20
en: en/blog/haskell/haskell-parallel-image-processing
---

Na disciplina de Reconhecimento de Padrões aqui da UFSC, um dos assuntos tratados é o processamento e o reconhecimento de padrões em imagens.
O nosso trabalho final da disciplina vai ser fazer um alarme que detecta ladrões por uma webcam...
E isso é bastante complicado e envolve vários processos, bem mais difícil do que parece :)

Um dos processamentos mais comuns realizados sobre imagens quando se deseja identificar objetos é a [detecção de bordas][1].
O nosso primeiro trabalho de processamento de imagens foi então implementar o [Método de Roberts][2] para a detecção de bordas.
Como eu estava afim de re-exercitar meus conhecimentos em Haskell e como esse tipo de processamento é perfeito para o paradigma funcional, resolvi me aventurar!
Vou então mostrar pra vocês o código, as imagens bonitinhas de exemplo e relatar minha experiência (quase indolor) :P

![Dutch Haskell](/files/imgs/2011-06_haskell-nl.png)

<!--more-->

Uma das propagandas mais fortes da programação funcional
é que os programas que foram escritos seguindo à risca esse paradigma podem ser paralelizados automaticamente.
A detecção de bordas por Roberts consiste em nada mais do que aplicar um matriz de coeficientes sobre cada pixel de uma imagem,
fazendo uma espécie de "média ponderada" dele com seus vizinhos.
ORA, esse "cada pixel" é incrivelmente paralelo:
de fato, podemos dividir essa varredura em quantas threads nos for mais conveniente, sem alterar o significado do algoritmo.
E é exatamente isso que a biblioteca de arrays paralelos [Repa][3] faz:
ela te permite expressar os mais diversos algoritmos sobre arrays multidimensionais, e é capaz de os paralelizar automaticamente.

Sem mais bla bla bla, aí vai então um exemplo de execução do programa "Roberts" com uma imagem de 1024x768 pixels, com 1 thread:

Imagem original:

![WoW original](/files/imgs/2011-06_wow.png)

Bordas:

![WoW bordas](/files/imgs/2011-06_wow_.png)

Tempo de execução (boa parte dominado por IO):

    real	0m7.112s
    user	0m7.044s
    sys	0m0.020s

Agora com 2 e 4 threads, a única diferença é que na linha de comando eu chamo o programa assim:

    Roberts wow.png wow_bordas.bmp +RTS -N{2,4

Os resultados foram os seguintes:

  * 2 threads:

        real	0m4.000s
        user	0m7.176s
        sys	0m0.076s

  * 4 threads:

        real	0m3.096s
        user	0m8.509s
        sys	0m0.456s

Ou seja, tirando uns overheads de comunicação, a aceleração do tempo de execução é quase linear \o/\o/\o/.
Eu admito que o tempo de processamento ainda está um pouco alto,
mas considerando que eu sou um novato total na biblioteca (a conheci antes de ontem) acho o resultado bem bom!
Vou até mostrar o código, de tão bonito e relativamente curto que ficou:

<script src="https://gist.github.com/2718546.js"> </script>

TOTAL de 45 linhas de código, incluindo leitura/escrita em arquivos. Legal não?! :)

[1]: <http://en.wikipedia.org/wiki/Edge_detection>
[2]: <http://en.wikipedia.org/wiki/Roberts_Cross>
[3]: <http://hackage.haskell.org/package/repa>
