---
title: Acesse o Twitter usando o Pidgin
published: 2009-07-24
en: en/blog/tech/twitter-pidgin
---

Eu tenho uma certa obsessão por simplicidade e leveza, como muita gente já deve saber :)
Então hoje eu pecebi que com um só ótimo programa - o [Pidgin][1] - eu já acessava as redes MSN, Google Talk e IRC.
Fiquei afim de integrar o Twitter também, e descobri o [Microblog-purple][2].

O Microblog-purple é um plugin para o Pidgin, que permite usar tanto Twitter como Identi.ca e Laconi.ca a partir de uma janela de conversa!
Se alguém der uma twittada em @voce, a mensagem aparece numa janela de chat, permitindo uma espécie de "conversa" bem intuitiva.
Há outras funcionalidades bem legais...

Para instalar e usar o plugin é bem simples.

<!--more-->

As instruções abaixo são para instalar no Ubuntu 9.04, para outros sistemas veja o [site oficial do projeto][3].
Para instalar o pacote com o plugin, copie e cole os seguintes comandos no seu terminal favorito:

  1. Para autorizar o repositório de software do projeto: `sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys DF37ED8B`
  2. Para adicioná-lo na sua lista de repositórios: `echo "deb http://ppa.launchpad.net/sugree/ppa/ubuntu jaunty main" | sudo tee -a /etc/apt/sources.list`
  3. Para atualizar os pacotes disponíveis e instalar o plugin: `sudo aptitude update &amp;&amp; sudo aptitude install pidgin-microblog`

Agora é só ativar o plugin no Pidgin indo em Ferramentas -&gt; Plugins:

![habilitando_plugin](/files/imgs/2009-07_habilitando_plugin.png)

Depois basta configurar sua conta do Twitter como se fosse uma outra conta qualquer:

![cadastrando_conta](/files/imgs/2009-07_cadastrando_conta.png)

E pronto, você já pode ler e escrever suas preciosas mensagens de até 140 caracteres :)

[1]: <http://pidgin.im/>
[2]: <http://code.google.com/p/microblog-purple/>
[3]: <http://code.google.com/p/microblog-purple/>
