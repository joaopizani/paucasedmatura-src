---
title: Podcasts no Linux pela linha de comando: fácil e MUITO prático
published: 2013-03-08
en: en/blog/tech/podcasts-linux
---

Ultimamente eu tenho voltado aos velhos tempos em que comecei esse blog, no que se trata da maneira como uso computadores.
Cada vez mais estou usando programas simples, sem frescuras, sem interface "bonita", mas que **fazem** o que prometem e são **práticos**.
Ficar em dia com os meus podcasts favoritos e sincronizar meu MP3 player com a pasta de podcasts era uma tarefa para a qual eu nunca tinha encontrado um programa decente.
Nunca TINHA :), pois agora tenho uma solução elegante, automática e que simplesmente funciona, eu quase nem percebo que ela existe...

Agora eu uso o [podget][1] para ficar sempre em dia com meus podcasts favoritos.
O podget permite que você defina categorias de podcasts,
ele deleta automaticamente episódios antigos (você define o quão antigo deve ser pra ser deletado).
Para instalá-lo no Ubuntu, como sempre, um simples:

```bash
sudo aptitude install podget
```

é suficiente. Você pode configurar o podget editando o arquivo ".podget/podgetrc" no seu diretório pessoal.
As configurações são bem **simples** e fáceis de entender, e o arquivo tá bem explicadinho.

<!--more-->

Depois que você definiu quais são os podcasts que você quer acompanhar, e qual o diretório onde o podget deve salvar os episódios, basta executar:

```bash
podget
```

para que o podget verifique todos os podcasts e baixe os episódios inéditos, além de remover os que já estão muito antigos do seu disco.
Ele cria também uma playlist com os episódios recentes, para que você ouça facilmente (sem procurar) tudo aquilo que ainda não ouviu.

Isso já é simples e eficiente, mas eu sou fanático por deixar as coisas automáticas. :P
Então usei o [Anacron][3], uma maneira muito simples também de se executar tarefas agendadas.
O Anacron pode fazer muitas coisas legais, mas o que eu queria era bem simples:
diariamente checar por atualizações nos meus podcasts favoritos, automaticamente (sem nada aparecer na minha tela nem eu precisar digitar/clicar em nada).
Pra configurar isso bastou o seguinte comando:

```bash
echo "1 7 podcastupdate podget" | sudo tee -a /etc/anacrontab
```

Esse comando "adiciona" no final da tabela de tarefas do Anacron a nossa tarefa de sincronização de podcasts.
O nome da tarefa é "podcastupdate" e o programa a ser executado chama-se "podget".
A frequência de execução da tarefa é a cada "1" dias e ela deve ser executada "7" minutos após o computador ser ligado.

Assim, com essa configuração, você vai ter uma pasta no seu computador contendo seus podcasts favoritos, sempre atualizada e nunca muito grande (arquivos antigos são removidos).
Tudo isso sem você precisar digitar/clicar em NADA, automaticamente!
Legal, mas e se você costumar ouvir seus podcasts no celular/iPod/MP3/whatever?
Então precisamos de mais um software para **sincronizar** o conteúdo do MP3 Player com a pasta de podcasts no seu computador.

Pra essa tarefa também existe um shell script bem pequeno e simples, o [cpafter][4].
Ele copia arquivos de um diretório origem para um diretório destino, mas copia **somente os mais recentes que uma determinada data**.
Aí está a utilidade dele, nós vamos querer transferir pro MP3 player só os episódios recentes de podcasts, aquilo que já ouvimos e deletamos do player não deve ser **recopiado**.
Faça o seguinte pra baixar e configurar o cpafter:

```bash
mkdir ~/cpafter &amp;&amp; cd ~/cpafter
wget http://bash-cpafter.googlecode.com/files/cpafter-v03.tar.gz
tar xzf cpafter-v03.tar.gz
echo "PATH=$PATH:/home/<seu_usuario>/cpafter" >> ~/.bash_profile
source .bash_profile
```

Claro, se você entende bastante de shell não precisa seguir exatamente esses passos, siga seus instintos! :)
Após esses passos, agora sempre que você quiser atualizar o conteúdo do seu MP3 player basta ligá-lo no PC e executar algo como:

```bash
cpafter.sh -f -a <data_limite> -s <origem> -t <destino>
```

Na `<data_limite>` você deve colocar uma data no formato aaaammdd.
Todos os arquivos mais velhos que essa data não serão copiados. `<origem>` e `<destino>` são diretórios auto-explicativos, eu creio :)
Agora pronto! É só executar esse pequeno comandinho a cada 2 dias, por exemplo, e você sempre estará em dia :]

Eu ainda estou tentando deixar todo o processo mais automático ainda.
Principalmente a parte de sincronização...
Mas se eu conseguir mesmo deixar a solução ainda mais bonita, daí vira assunto pra um outro post. Até lá!

[1]: <http://sourceforge.net/projects/podget/>
[3]: <http://pt.wikipedia.org/wiki/Anacron>
[4]: <http://code.google.com/p/bash-cpafter/>
