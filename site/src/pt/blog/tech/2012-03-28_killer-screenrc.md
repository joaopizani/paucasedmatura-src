---
title: GNU Screen: a configuração dos vencedores
published: 2012-03-28
en: en/blog/tech/killer-screenrc
---

**UPDATE (2013-03-01):** [Nova versão][1] das configurações descritas neste post, mais organizadas e com mais funcionalidades.

Há uns 3 ou 4 anos eu conheci um ótimo programa chamado "GNU Screen"...
Para quem nunca ouviu falar, o [GNU Screen][2] é um "multiplexador de terminais", ou um "gerenciador de janelas em modo texto".
Com o Screen, você pode ter vários terminais virtuais ocupando o mesmo terminal "físico" (real).
Além disso, você pode "desvincular" uma sessão do Screen de um terminal, deixando assim em plano de fundo os programas que lá rodam,
e voltar depois para ver o que aconteceu.
Esse era de fato meu principal "caso de uso" para o Screen,
eu usava Screen + SSH para poder fechar uma conexão, mas mesmo assim deixar programas rodando na máquina remota...

Bem, após esse período de "descoberta", eu abandonei o Screen por bastante tempo...
Até que recentemente eu decidi tentar usá-lo no meu dia-a-dia mais uma vez, e ver se havia novidades.
E **sim**, o Screen evoluiu bastante e eu descobri que ele é **muito mais útil** do que eu pensava.
Então, após ter misturado dicas de configuração pescadas por toda a Internet,
eu vos apresento o arquivo de configuração **screenrc dos vencedores**.

<!--more-->

O arquivo em sim é fácil de entender e está bem comentado.
Mas antes de mostrá-lo, deixe-me só resumir o que ele faz:

 * **Atalhos simples:** Por padrão, o Screen tem uns atalhos de teclado _bastante_ difíceis de usar.
   Pra alguns comandos _nem sequer existe_ um atalho.
   Então eu implementei alguns simples atalhos como F3/F4 para janela anterior/próxima e
   Ctrl+(cima/baixo/direita/esquerda) para navegação entre regiões na tela.

 * **Janelas padrão:** Eu decidi fazer com que o Screen sempre carregue 4 janelas quando inicia.
   São dois _shells_ para "trabalho", um _shell_ para "diversão" e uma janela com um interpretador python.
   Claro que você pode alterar para o interpretador de sua linguagem favorita :)

 * **Atalho para redimensionar regiões:** Um dos pontos fortes do Screen é que você pode dividir a tela
   (horizontalmente e verticalmente) para mostrar várias janelas ao mesmo tempo.
   Mas por padrão, os comandos para redimensionar essas regiões são um _pesadelo_.
   Com o meu `screenrc`, você aperta F2 para entrar em "modo de redimensionamento"
   e então pode usar as teclas h/j/k/l para aumentar/diminuir a largura ou altura da região atual.

 * **Layouts padrão:** O Screen pode lembrar de um certo arranjo de regiões na tela (um layout) e associá-lo com um nome.
   Meu arquivo de configuração define três layouts prontos para usar, com - respectivamente - uma, duas e três regiões.
   Você pode mudar de layout usando Ctrl-F3 (layout anterior) e Ctrl-F4 (próximo layout).

Agora então, depois desse resumo nada curto, vai o código pra você se divertir...
Não pare de ler aqui, ainda há mais boas notícias após o código ☺

<script type="text/javascript" src="https://gist.github.com/2718397.js?file=.screenrc"></script>

Cole o código acima em um arquivo chamado `.screenrc` no seu diretório `home` e aproveite!

Como deu pra perceber, com esse arquivo de configuração, também vem "de brinde" uma barra de status legal, suporte a 256 cores,
a capacidade de mudar o foco de uma janela pra outra simplesmente clicando nela e de navegar pelo scrollback buffer com a rodinha do mouse.
Pra honrar aquele velho ditado sobre 1000 palavras e 1 imagem, aí vai o screenshot da minha sessão atual de Screen:

![Awesome GNU Screen](/files/imgs/2012-03_gnu_screen_ss.png)

Antes de terminar o post, ainda um último aviso:
é preciso uma versão **bastante recente** do Screen para que todas as configurações passadas acima funcionem,
e infelizmente a maioria das distribuições Linux vêm com versões _muito antigas_ do Screen incluído.
Então você tem duas alternativas:
baixa e compíla o Screen (o que é mais fácil do que parece), ou - caso use Ubuntu - instala-o do PPA **ppa:eugenesan/ppa**.
Os seguintes comandos servem pra instalar o Screen no Ubuntu, usando o PPA indicado:

```bash
sudo aptitude purge screen  # desinstala o screen atual
sudo apt-add-repository ppa:eugenesan/ppa
sudo aptitude update
sudo aptitude install screen  # instala o screen mais recente
```

Por hoje é tudo pessoal, me digam aí o que vocês acham! :)

[1]: </pt/blog/tech/screenrc-ftw 'Novo screenrc, ainda mais perfeito'>
[2]: <http://www.gnu.org/software/screen/>
