---
title: Alguns comandos mágicos e muito úteis de shell
published: 2011-04-09
en: en/blog/tech/shell-magic
---

Já falei várias vezes aqui no blog sobre como usar a Filosofia Unix me ajuda muito no dia-a-dia, nas tarefas que preciso fazer.
Trabalhar em máquinas remotas usando SSH, ficar em dia com meus podcasts e sincronizar o MP3 Player automaticamente, ultrapassar um firewall e ver arquivos remotos como se fossem locais, tudo isso fica muito fácil no Linux.

O que me deixa mais feliz ainda é quando eu consigo resolver um problema prático em UMA LINHA no shell (interpretador de comandos do Linux).
Acho os famosos "one-liners" tão bonitos que tenho que compartilhar pelo menos alguns com vocês :)

<!--more-->

Então, sem mais enrolação, aí vão alguns comandos MUITO úteis e práticos.
Primeiro vai o comando em si, e depois a explicação do que ele faz:

```bash
rm $(find . | grep ~$)
```

O primeiro comando é o mais simples, mas é bem útil.
Ele apaga todos aqueles arquivos de "backup", cujo nome termina em ~ (til) de um diretório e subdiretórios.
Não sei quanto a vocês, mas esses arquivos simplesmente enchem meu saco e às vezes quero sumir com eles de toda uma árvore de diretórios.
É só usar o comando acima :)

<script src="https://gist.github.com/2718522.js"></script>

Esse aí já é bem comprido, e provavelmente vai ocupar 4 linhas no terminal, mas mesmo assim eu considero que ele tem "1 linha lógica".
Esse comando mágico converte todos os arquivos .wma da sua biblioteca de músicas para .mp3.
Claro, basta substituir "wma" por "ogg", "flac", etc, que funciona com qualquer tipo de arquivo de áudio.
Você precisa do mplayer e do lame pra ele funcionar... Bonito, não?

Tá, agora o último: 

```bash
youtube-dl -t --extract-audio --audio-format=mp3 <youtube_playlist_url>
```

O "youtube-dl" é um script python muito bem feito, você pode baixá-lo na página do desenvolvedor, aqui: <http://rg3.github.com/youtube-dl/>.
Você também precisa do FFMPEG instalado pra que esse comando funcione.
O que ele faz é simples mas também muito útil: ele baixa (em alta qualidade) e converte para MP3 todos os vídeos de uma playlist do youtube.
Um exemplo de playlist legal aí:

  * <http://www.youtube.com/view_play_list?p=771D06F88E51ACED> (música clássica de qualidade :P)

Por enquanto é só, à medida que eu descobrir mais feitiçarias pra facilitar o dia-a-dia, posto aqui!
Comentem aí e coloquem os comandos mágicos que vocês usam!

