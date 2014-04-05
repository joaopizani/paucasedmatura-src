---
title: Ambiente de programação C++/Qt no Eclipse
published: 2009-02-27
en: en/blog/tech/eclipse-cpp-qt
---

[![Flattr this](http://api.flattr.com/button/flattr-badge-large.png)](http://flattr.com/thing/317547/Remote-Pair-Programming-with-Eclipse target="_blank")

Esse semestre vou participar de um projeto de desenvolvimento em [C++][cpp], é uma ferramenta para o auxílio ao ensino de Cálculo Numérico.
Logo vou falar mais detalhes sobre o projeto em outro post.
E escolhemos usar o [Eclipse] (com o plugin [CDT] e integração com o framework Qt) como ambiente de programação para o projeto.  
Já que eu tinha que fazer a instalação, resolvi então aproveitar e gravar um screencast de todo o processo e colocar no youtube.
Escrevi também esse tutorial.
Pra quem estiver iniciando no mundo C++ vindo do Java, essa é uma boa alternativa de ambiente.
Vamos então pôr as **mãos na massa!**

[cpp]: <http://en.wikipedia.org/wiki/C%2B%2B>
[Eclipse]: <http://www.eclipse.org>
[CDT]: <http://eclipse.org/cdt>

<!--more-->

**1. Opcional: Instalar plugin SVN (Subversive)**

Para quem não o conhece, o Subversion (SVN) é um excelente sistema de controle de versão.
Ele permite que várias pessoas trabalhem programando juntas sem que uma atrapalhe a outra, além de que qualquer alteração no código controlado com SVN é reversível.
O Eclipse pode usar o SVN com o plugin **Subversive**.
Para instalar a versão mais recente do Subversive, siga os passos abaixo:

 * Visite o [site oficial][1] do plugin Subversive, e vá até a seção **downloads**
 * Na seção "Latest Release", copie o endereço do update-site;
 * No Eclipse, acesse Help -&gt; Software Updates -&gt; Available software;
 * Clique em "Add site" e cole o endereço do update-site, e dê OK;
 * Selecione para instalação os itens conforme a figura abaixo: ![mncpp_subversive](/files/imgs/2009-02_mncpp_subversive.jpg)

 * Instale e reinicie o Eclipse quando pedido;
 * Vamos agora instalar os **SVN Connectors**. Eles são necessários, sem instalá-los você não vai conseguir conectar num repositório;
 * Copie este [update-site][2] da equipe oficial de desenvolvimento;
 * Faça o mesmo procedimento para adicionar o update-site no seu Eclipse e instale os componentes conforme a figura abaixo:
   ![mncpp_svn_connectors](/files/imgs/2009-02_mncpp_svn_connectors.jpg)
 * Instale e reinicie o Eclipse quando pedido.

**2. Instalar plugin Eclipse CDT**

O CDT (C/C++ Development Tooling) é o plugin do Eclipse que contém todas as ferramentas para desenvolvimento em C e C++, por exemplo: Auto-complete, Compilação, Highlight, Wizards para criação e importação de projetos, Refactor, etc.
Para instalá-lo, vamos usar o update-site oficial da equipe de desenvolvimento:

 * No [site oficial][3] do CDT, copie o endereço do update-site para a versão mais recente;
 * Faça o mesmo procedimento como anteriormente para adicionar o update-site no seu Eclipse;
 * Dessa vez selecione os componentes a serem instalados de acordo com a figura:
   ![mncpp_cdt_repo](/files/imgs/2009-02_mncpp_cdt_repo.jpg)
 * Confirme a instalação e reinicie quando pedido.

**3. Instalar pacotes p/ desenvolvimento Qt**

Se você seguiu o tutorial até aqui, você tem um ambiente completo de desenvolvimento C/C++ usando Eclipse.
Para poder desenvolver usando o framework Qt, você deve primeiro instalar os pacotes do Qt no seu sistema.
Caso você use Windows, na página de downloads do Qt há uma versão para seu sistema.
Caso você uma distribuição Linux, você pode _instalar os pacotes de desenvolvimento Qt da sua distribuição_ **ou** _compilar o framework Qt por completo_.
Como exemplo no tutorial estão os pacotes a serem instalados para quem usa a distribuição **Ubuntu Linux**: `sudo aptitude install qt4-{dev-tools,demos,qtconfig,doc,designer,assistant,linguist} ~nlibqt4`

**4. Instalar o "Qt Eclipse Integration"**

O Qt Eclipse integration é um plugin desenvolvido pela _Trolltech_ (fabricante do Qt), para tornar o Eclipse um ambiente completo de desenvolvimento em Qt.
Com esse plugin você pode criar e editar os _forms_ de interface, criar e importar projetos Qt e utilizar as ferramentas de build do Qt de dentro do Eclipse.
Para instalar siga os passos abaixo:

 * Visite a página de downloads do Qt Eclipse Integration
 * Mova o arquivo baixado para a **pasta onde está a pasta "eclipse"** :).
   Por exemplo, minha pasta eclipse é /home/joao/eclipse, então o arquivo baixado tem que ficar em /home/joao.
 * Desempacote o arquivo usando o comando: "tar xzf &lt;nome-do-arquivo&gt;"
 * Execute o eclipse pela linha de comando com o parâmetro "-clean". "./eclipse -clean"
 * Vá em Window, Preferences, Qt, e forneça o caminho das pastas onde está instalado o Qt, segundo a figura abaixo:
   ![mncpp_qt_paths](/files/imgs/2009-02_mncpp_qt_paths.jpg)
 * Pronto, agora já funciona! Aqui está um exemplo do plugin em ação:
   ![mncpp_eclipsecdt_works](/files/imgs/2009-02_mncpp_eclipsecdt_works.jpg)


**Vídeo do tutorial no YouTube:**

Eu também fiz um screencast com legendas seguindo passo-a-passo e fazendo a instalação.
Pra aqueles que aprendem mais fácil com os olhos, aí está o link:

[Screencast do tutorial no YouTube](http://www.youtube.com/watch?v=Ce-Cfp24WGw)

[1]: <http://www.eclipse.org/subversive/>
[2]: <http://www.polarion.org/projects/subversive/download/eclipse/2.0/update-site/>
[3]: <http://www.eclipse.org/cdt/downloads.php>
