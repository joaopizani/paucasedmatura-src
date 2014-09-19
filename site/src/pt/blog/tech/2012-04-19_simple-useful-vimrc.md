---
title: Deixe seu Vim um pouco melhor: um vimrc simples mas útil
published: 2012-04-19
en: en/blog/tech/simple-useful-vimrc
---

Desde o meu primeiro ou segundo ano na Universidade eu já flertava com [Vim][1]:
Eu a admirava, eu sabia que ela poderia deixar minha vida mais fácil e produtiva.
Por outro lado, eu sabia que usar Vim de verdade exigiria tempo, esforço e **comprometimento**.
Então só no ano passado, depois de "ficarmos" por algum tempo juntos, foi que eu decidi **me comprometer**.
Bem, mesmo com a lua de mel já terminada, eu ainda estou aprendendo muito sobre [vim a cada dia][2], e o admirando cada vez mais.

Agora deixando o sentimentalismo de lado,
uma das primeiras coisas que qualquer pessoa usando o Vim no dia-a-dia deve conhecer é como funciona o seu sistema de configuração.
Toda a personalização do editor é organizada em torno de simples arquivos de texto puro, escritos na linguagem [Vimscript][3].
E uma grande parte do poder e da robustez do Vim vem justamente da flexibilidade que esses "Vim scripts" fornecem.
De fato, há centenas (senão milhares) de plugins muito úteis para o Vim - e alguns [nem tão úteis mas muito legais][4].

Eu uso um monte de plugins e os tenho organizados de uma maneira eficiente, mas vamos deixar isso para outro post.
Hoje eu quero começar pelo básico e mostrar para vocês como é o meu arquivo principal de configuração do Vim - meu `.vimrc`.

<!--more-->

Um arquivo com o nome `.vimrc` no diretório home do usuário é o local onde o Vim procura por diretivas de configuração quando inicia.
O arquivo abaixo não é **exatamente** todo o meu `.vimrc`, mas a maior parte dele (tudo o que é independente de plugins).
Aí vai:

<script src="https://gist.github.com/2417865.js?file=.vimrc"></script>

Pode parecer que o arquivo acima faz **um monte** de coisas, mas na verdade tudo pode ser resumido nos seguintes pontos:

 * **Isolamento dos arquivos com metadados**: O Vim tem algumas funcionalidades bastante úteis, desfazer persistente,
   marcas e visões persistentes e backups automáticos.
   Isso faz com que você possa desfazer e refazer mudanças num arquivo mesmo depois de tê-lo fechado e aberto novamente, possa
   abrir um arquivo diretamente no ponto onde estava antes de fechá-lo e recuperar o estado antes de uma queda de energia, por exemplo.
   Infelizmente, essas funcionalidades podem poluir os seus diretórios de projetos com arquivos de metadados
   (sendo o exemplo mais conhecido os arquivos terminados em til).
   A configuração no meu `.vimrc` coloca **todos esses metadados** em um diretório **centralizado**,
   definido pela variável `VIMROOT` (primeira linha do script).

 * **Resolve o problema de tabs vs. espaços, a favor de espaços**: É isso que fazem aquelas 6 linhas logo no início do script.
   A configuração segue os seguintes princípios:
     + Nenhum **caracter tab literal (\t)** jamais é inserido no arquivo sendo editado.
     + Um nível de indentação (conceitualmente) corresponde a 4 espaços.
     + Os tabs literais que possam existir em arquivos abertos pelo Vim são **mostrados** com a largura de 4 espaços.
     + Pressionar a tecla TAB no teclado resulta na inserção de 4 espaços no buffer sendo editado.
     + Exceto quando se está editando Makefiles: isso pois a sintaxe de Makefiles exige tabs literais (\\t).

 * Configura a interface, tanto GUI (GVim) como no console:
   fixa número de linhas, colunas, usa modo de 256 cores, fixa a fonte usada, etc.
   No caso de uma GUI, tanto a barra de ferramentas como o menu são escondidos para dar lugar a mais texto
   (usar uma barra de ferramentas com o Vim **não é necessário**, e se você usa está _fazendo isso errado_).

 * **Mapeia as tecla de F5 a F10 para tarefas comuns** como pular para o próximo erro de compilação ou próximo
   resultado de busca, alternar entre arquivos `.h` e `.c(pp)` e compilar o código.

 * Torna mais fácil se **movimentar entre janelas**: o Vim lhe permite dividir a área de edição verticalmente e horizontalmente,
   e editar arquivos diferentes em cada uma dessas "janelas".
   Mas os atalhos padrão para se mover entre essas janelas são **compridos demais**. Então eu os encurtei ☺

 * Torna bem mais fácil **redimensionar janelas**: se você usa janelas no Vim, inevitavelmente irá querer redimensioná-las.
   E você vai querer um **atalho fácil** Pra fazer isso.
   Mais uma vez, não se pode dizer que os atalhos padrão são fáceis, então eu **os tornei** fáceis.

Usando esse arquivo de configuração, eu espero que usar o Vim se torne **ainda mais agradável** para você – como foi para mim.
Porém, eu não posso garantir a satisfação de ninguém, e você pode odiar meus atalhos – por exemplo.
Nesse caso, sinta-se LIVRE para adaptar as configurações às suas necessidades.
E caso você tenha alguma configuração interessante para compartilhar, por favor dê um fork no gist com as configurações no
GitHub (<http://gist.github.com/2417865>) e submeta um _pull request_ ☺

**EDIT:** Você provavelmente vai precisar da versão mais recente (7.3) do Vim para poder aproveitar todas as funcionalidades que eu descrevi acima...
Caso você use Linux e a sua distribuição ainda não tenha o Vim 7.3 nos repositórios, você pode baixar o código-fonte
(daqui - <http://www.vim.org/download.php>) e compilar você mesmo – é bastante simples e tranquilo.
Já caso você use Windows, há um instalador pronto para usar também no mesmo endereço acima.

Isso é tudo por enquanto, pessoal!
Logo vou postar mais sobre como está organizada toda a minha configuração do Vim.


[1]: <http://www.vim.org>
[2]: <http://dailyvim.blogspot.com.br/>
[3]: <http://en.wikipedia.org/wiki/Vim_script>
[4]: <http://www.vim.org/scripts/script.php?script_id=1189>
