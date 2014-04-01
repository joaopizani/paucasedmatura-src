---
title: Uma configuração para torrent leve, bem automática e até elegante - rtorrentrc
published: 2012-08-28
en: en/blog/tech/rtorrentrc
---

Há algum tempo atrás eu instalei na minha casa uma conexão ADSL de 5Mbps, e queria ter uma boa configuração de BitTorrent, para aproveitar bem a nova capacidade...
Além disso, no futuro **muito próximo** eu vou ter uma conexão de 50Mbps,
daí então a necessidade de um ambiente "otimizado" e automatizado pro meu compartilhamento de arquivos via torrent :)

Minha idéia é usar um computador VELHO que eu tenho aqui como uma máquina de torrent dedicada, ligada 24/7.
Então, eu estava procurando por um cliente de torrent robusto, poderoso e configurável
(para usar por meses sem reiniciar), mas ao mesmo tempo que precisasse de pouca CPU e pouca memória.
Felizmente, eu encontrei esse FANTÁSTICO cliente: ele se chama [rTorrent][2],
foi escrito em C++ puro voltado pra performance e estabilidade, e é uma aplicação de modo texto.

Depois de muita pesquisa no Google e de muita tentativa e erro, eu consegui chegar a um arquivo de configuração do rTorrent (.rtorrentrc)
que satisfaz todos os meus requisitos para um Ótima Configuração BitTorrent®.
Esses requisitos são:

  * **Ajuste periódico de velocidade:** As velocidades de download e upload são ajustadas automaticamente, dependendo do período do dia

  * **Terminar após atingir seed ratio:** Remove um torrent (e seu meta-arquivo .torrent correspondente)
    da lista de downloads após ele ter atingido uma certa proporção de envio (por exemplo, 200%)

  * **Início e parada baseados no conteúdo de um diretório:** Monitora um diretório especificado pela
    adição e remoção de arquivos com extensão .torrent.
    Inicia o download dos adicionados, remove os removidos

  * **Separação entre downloads ativos e já finalizados:** Armazena os arquivos que fazem parte dos torrents SENDO BAIXADOS em
    um diretório especial ("in-progress") e os já finalizados em outro diretório ("finished")

Agora, você pode acreditar em mim, baixar o [arquivo rtorrent.rc diretamente aqui][1] e usá-lo.
Após baixar o arquivo faça o seguinte:

```bash
mv [onde-vc-baixou-o-rtorrentrc] ~/.rtorrent.rc
mkdir ~/torrent

# 1) Caso você AINDA NÃO TENHA uma estrutura prévia onde armazenar seus downloads de torrent
mkdir ~/torrent/{session,metafiles-{in-progress,finished},content-{in-progress,finished}}

# 2) Caso você JÁ TENHA um local favorito onde armazenar torrents em progresso e concluídos
mkdir ~/torrent/{session,metafiles-{in-progress,finished}}
ln -s [caminho-de-downloads-em-progresso] ~/torrent/content-in-progress
ln -s [caminho-de-downloads-concluídos] ~/torrent/content-finished
```

A seguir eu faço uma revisão comentada do que significa cada linha nesse arquivo, acho que é interessante dar uma olhada :)

<!--more-->

A primeira linha já nos diz qual é o diretório onde o rTorrent armazena suas informações durante a execução.
Esse diretório nunca deve ser deletado com o rTorrent rodando.

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/rtorrentrc/blob/master/rtorrent.rc?slice=0&footer=no"></script>

Agora nós definimos o diretório onde o rTorrent deve manter os dados dos torrents ENQUANTO eles estão sendo baixados.

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/rtorrentrc/blob/master/rtorrent.rc?slice=1&footer=no"></script>

Já as próximas linhas controlam limites mínimos e máximos do número de peers enquanto fazendo download ou seeding.
Esses números eu obtive "empiricamente" durante meses de experiência e eles funcionam bem em uma rede de aprox. 10MB/s.

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/rtorrentrc/blob/master/rtorrent.rc?slice=3:9&footer=no"></script>

Agora dizemos que após atingirmos uma porcentagem de "seeding" (no caso, de 200%), o torrent deve ser automaticamente fechado e removido da lista do RTorrent.
Isso para que você contribua com o espírito do compartilhamento, mas COM UM LIMITE :)
Além disso, novos downloads não são iniciados caso haja muito pouco espaço livre no disco:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/rtorrentrc/blob/master/rtorrent.rc?slice=11:19&footer=no"></script>

As próximas linhas tratam de opções diversas (ativa DHT, criptografia, define portas) e devem ser bem auto-explicativas.
A configuração mais importante é a "port range".
Você deve setar essa opção para um intervalo de portas liberadas (forwarded) no seu roteador.

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/rtorrentrc/blob/master/rtorrent.rc?slice=22:28&footer=no"></script>

Uma seção bem importante agora: definimos aqui o ajuste automático de velocidades de download/upload pelo horário.
Essas aí embaixo são as MINHAS preferências, **por favor adapte pra SUA velocidade de conexão e cenário de uso**.
No meu caso, eu quero que o consumo de banda seja MENOR NAS MANHÃS e no começo das noites (é quando eu geralmente estou em casa).

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/rtorrentrc/blob/master/rtorrent.rc?slice=31:45&footer=no"></script>

Ainda, nós dizemos ao rTorrent para monitorar o diretório "~/torrent/metafiles-in-progress" e detectar adições de arquivos do tipo `*.torrent`.
Arquivos adicionados vão causar o início de um download:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/rtorrentrc/blob/master/rtorrent.rc?slice=48:49&footer=no"></script>

Por fim, as seguintes linhas fazem com que downloads INCOMPLETOS tenham os seus **arquivos baixados** deletados sempre que o meta-arquivo .torrent correspondente é deletado - ou o download seja removido manualmente na lista de downloads do rTorrent.
Além disso, os downloads finalizados são movidos para um diretório especial chamado "content-finished",
enquanto o meta-arquivo em si é arquivado para a posteridade, em "metafiles-finished".

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/rtorrentrc/blob/master/rtorrent.rc?slice=51:56&footer=no"></script>

Então, isso é tudo, pessoal!  De agora em diante, com a minha seedbox já com o rTorrent instalado e configurado, basta que eu jogue qualquer arquivo .torrent na pasta "metafiles" e deixe todo o trabalho chato de gerenciamento pro rTorrent.
Ele vai garantir que eu sou **justo** com a comunidade (garantindo uma proporção de seed de 200%) e vai colocar os arquivos já baixados em "finished", prontinhos para que eu os use... :)

Se quiser usar e adaptar essa configuração também, vá até o início do post, baixe o arquivo e siga as instruções...

[1]: <https://raw.github.com/joaopizani/rtorrentrc/master/rtorrent.rc>
[2]: <http://libtorrent.rakshasa.no>
