---
title: Modular XPlatform Vim Config - With LASERS!
published: 2013-03-11
en: en/blog/tech/modular-xplatform-vim-cfg-with-lasers
---

TL;DR: Veja o [README](https://github.com/joaopizani/modular-xplatform-vim-cfg/blob/master/README.md)
no [repositório](https://github.com/joaopizani/modular-xplatform-vim-cfg)

No ano passado eu [publiquei um artigo][1] aqui descrevendo uma "distribuição" para Vim,
que era o resultado de meses de uso DIÁRIO desse editor.
Essa distribuição é totalmente modular e auto-contida.
Além disso, eu tento seguir o princípio de "graceful degradation".
O que isso tudo significa?

  * **Auto-contida** no sentido de que não "espalha" arquivos pelos diretórios, nem interfere com configurações que eventualmente o usuário já possua.
    Você pode colocar o diretório baixado do repositório em um pendrive e usar em qualquer computador

  * **Modular** no sentido de que é constituída de uma série de plugins - não muitos - (gerenciados pelo NeoBundle), e uma série de arquivos contendo "defaults razoáveis" para esses plugins.

  * **Graceful degradation** significa que eu tento fazer o máximo possível, mas exigindo o mínimo possível.
    Além disso, os defaults tentam ser não-invasivos.
    O princípio é de que quanto mais frequente uma ação, mais simples deve ser realizá-la.

A boa notícia é que desde meados do ano passado essa minha "distribuição" de configurações para Vim evoluiu bastante,
e eu considero-a pronta para ser usada pelo público geral de programadores usuários de Vim, ou até mesmo pra quem está só começando a usar esse ótimo editor.

Sem mais delongas, não vale a pena ficar repetindo aqui tudo o que já explicado no arquivo [README][2] no [repositório][3].
Então, vai lá, siga as instruções, teste e veja se você gosta... :)

[1]: </pt/blog/tech/modular-xplatform-vim-cfg>
[2]: <https://github.com/joaopizani/modular-xplatform-vim-cfg/blob/master/README.md>
[3]: <https://github.com/joaopizani/modular-xplatform-vim-cfg>
