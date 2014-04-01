---
title: Uma árvore de configurações Vim poderosa, multiplataforma e totalmente auto-contida
published: 2012-06-05
en: en/blog/tech/modular-xplatform-vim-cfg
---

**UPDATE (2013-03-11):** Após muitos meses de uso e adaptação contínuos,
a árvore de configurações [mudou consideravelmente](/pt/blog/tech/modular-xplatform-vim-cfg-with-lasers).

Acho que todo mundo já sabe que eu sou um fã e usuário **hardcore** do Vim.
Eu uso o Vim para programar, para escrever conteúdo técnico **e** não-técnico (com LaTeX), e - também - só por diversão (no meu conceito hacker de diversão :D).
Eu já tinha tentado usar o Vim "de verdade" por várias vezes, mas somente nos últimos meses tenho me concentrado em _extrair_ o máximo possível do Vim e utilizá-lo _todo dia, o dia inteiro, para tudo que eu puder_.

Durante esse tempo, eu sabia que mexeria **muito** com todo tipo de configuração e plugins, e portanto quis tornar a customização do Vim bastante simples.
Eu também gostaria de usar a "minha" configuração do Vim em qualquer computador em que eu estivesse trabalhando, então eu precisei deixar a "árvore" de configuração o mais multiplataforma e auto-contida possível.
Idealmente, eu só teria que carregar um pendrive contendo o diretório "vim-cfg" e poderia **me sentir em casa** em qualquer computador Linux, Windows ou Mac em que estivesse trabalhando.

Posso dizer que esses objetivos foram QUASE 100% atingidos.
Então - pra ficar famoso :P - eu disponibilizei essa [árvore de configuração Vim modular e multiplataforma][1] no GitHub.
Não vou explicá-la com muitos detalhes, pois o arquivo README.md incluso já ensina bem como instalar e usar o pacote.

<!--more-->

Além de ser um _framework_ em que você pode facilmente incluir SUAS próprias personalizações - _mantendo modularidade e portabilidade_ - a minha "árvore" também inclui vários "defaults razoáveis", os quais são personalizações que achei muito úteis nesses últimos meses de uso intensivo do Vim.
O principal critério que usei ao decidir quais personalizações incluir no "pacote" foi o
de **reduzir o trabalho repetitivo, fazendo com que as ações mais frequentes necessitem do menor número de toques no teclado.**.
O "caso de uso" que tive em mente ao escolher essas personalizações era o de um programador usando o Vim no seu dia-a-dia :)
Aí vão alguns exemplos do que foi incluído:

  * **Atalhos de uma tecla para ações frequentes:** Navegar pela árvore de diretórios,
    compilar código-fonte e navegar pela lista de erros de compilação, explorar um arquivo usando tags, redimensionar e navegar entre janelas de edição (splits)...

  * **Meta-arquivos centralizados:** Mantém arquivos do tipo .swp, xyz~ e outros meta-arquivos do Vim em um diretório _centralizado_,
    sem ficar poluindo o diretório de trabalho do usuário.

  * **Gerenciamento fácil e organizado de plugins:** Usando o [NeoBundle][2].

  * **Combina o comando "make" interno do Vim com builds paralelos:** Como eu já descrevi em um [post anterior][3].

  * **Gerenciamento e geração facilitados de tags:** Tags para navegação de código-fonte são geradas,
    regeradas sob demanda e automaticamente gerenciadas em uma localização centralizada pelo [vim-easytags][4].

Agora vá em frente e experimente usar essa árvore de configuração!
É muito fácil voltar atrás caso você não goste, basta apagar o diretório (tudo está auto-contido).
Clone o [repositório][1] e siga as instruções no arquivo `README.md`.
Por fim, eu quero deixar registrado meu agradecimento sincero a todos os desenvolvedores dos plugins que estou usando.
Eles estão tornando a minha vida **mais simples**!
Usando todos esses plugins pra facilitar meu dia-a-dia de programação com o Vim, me sinto "apoiado nos ombros de gigantes" :)

[1]: <http://github.com/joaopizani/modular-xplatform-vim-cfg>
[2]: <https://github.com/Shougo/neobundle.vim>
[3]: </pt/blog/en/2012/05_vim-parallel-make>
[4]: <http://github.com/xolox/vim-easytags>
