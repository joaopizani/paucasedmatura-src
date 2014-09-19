---
title: Make paralelo integrado ao Vim - detectando o número de cores
published: 2012-05-28
en: en/blog/tech/vim-parallel-make
---

Eu sou um grande fã do Vim... Um grande fã.
Você pode ler uma declaração de amor minha pelo Vim [no último post][1],
junto com algumas dicas úteis que eu coletei em meses de uso diário – todas organizadas em um arquivo `.vimrc`.
Mas hoje eu vou falar sobre uma nova dica de configuração bastante útil pro Vim:
Vamos fazer com que a integração do Vim com `make` realize builds paralelos ☺

Se você programa em C/C++, ou usa o [GNU Make][2] para outras coisas, já deve saber que ele é capaz de realizar **builds paralelos**.
Se você ainda não sabia, enriqueça seu conhecimento [aqui][3].
E, caso você use o Vim para escrever seu código C/C++, então você também já deve saber
que o Vim tem uma ótima integração com sistemas de build - através do seu comando `:make`.
Para saber mais sobre o assunto você pode simplesmente digitar `:help make` no seu Vim,
o que eu acabei de fazer, pois estou escrevendo esse post no Vim...

A questão central deste post é: Seria muito legal se pudéssemos combinar builds paralelos com o comando `:make` do Vim, não?
É claro que você pode digitar `:make -j [n]` a cada vez que for compilar um projeto, mas isso se torna rapidamente chato...
Uma idéia melhor (depois de consultar `:help make`) seria tentar atribuir o valor `make -j [n]` à
variável `makeprg` - mas nesse caso **qual seria o valor de "n" que você colocaria lá?**
O meu objetivo é sempre ter minhas configurações do Vim de tal maneira que possa
usá-las em **várias máquinas diferentes (casa, trabalho, etc.)** e em **vários sistemas operacionais**, então o
**realmente ideal** seria poder configurar `makeprg` para chamar `make` com n igual ao **número de _cores_ disponível no sistema**.
Isso é exatamente o que eu descobri recentemente como fazer, e isso é exatamente o que eu vou mostrar pra vocês.

<!--more-->

O seguinte trecho de Vimscript – que você pode tranquilamente copiar e colar no seu `.vimrc` – funciona
tanto no Windows como na grande maioria de sistemas Unix-like (Linux e BSD, mas **não no Mac OS X**).

<script src="https://gist.github.com/joaopizani/2816940.js"></script>

No Windows uma variável de ambiente chamada `NUMBER_OF_PROCESSORS` está definida, e nesse caso basta usar o seu valor.
Já em sistemas Unix-like nós obtemos essa informação do [sistema de arquivos virtual procfs][4],
mais especificamente do arquivo `/proc/cpuinfo`.
Isso é feito usando o **grep** para filtrar as linhas que são "cabeçalhos" de seções descrevendo cada _core_,
e contando quantas dessas linhas existem.
No caso extremo em que nenhuma detecção tenha sido bem-sucedida, se assume que `n = 1`.

Dois pontos positivos da configuração feita por esse trecho de código são:

  * **Ela é não-invasiva:** Pelo fato de que não altera nada além do valor padrão da variável `makeprg`,
    você pode tranquilamente colocar esse código no início do seu `.vimrc` sem medo de interferência com outras configurações.

  * **Também é não-restritiva:** A opção `-j[n]` passada ao make não restringe de maneira alguma o seu comportamento.
    Você pode continuar usando quaisquer outras opções que vinha utilizando anteriormente.

Por isso é tudo, pessoal! Agora, preparem-se que...
logo, logo eu vou publicar a minha suíte completa de configuração Vim: multiplataforma, modular e fácil de personalizar ☺

[1]: </pt/blog/2012/04_simple-useful-vimrc>
[2]: <http://www.gnu.org/software/make>
[3]: <http://www.gnu.org/software/make/manual/make.html#Parallel>
[4]: <http://en.wikipedia.org/wiki/Procfs>
