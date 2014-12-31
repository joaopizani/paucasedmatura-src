---
title: Scripts de compilação de toolchains para múltiplas arquiteturas
published: 2012-04-17
en: en/blog/tech/multiarch-toolchain-buildscripts
---

Como alguns já devem saber, eu andei mexendo ultimamente com programação de microcontroladores,
mais especificamente com a série de microcontroladores de 8 bits da AVR.
E uma "mania" minha é sempre estar com todos meus softwares atualizados, rodando as últimas versões estáveis...
Entãa meu primeiro passo antes de começar a programar em C para o AVR era obter uma versão recente da [GNU Compiler Collection][1].

Há um certo tempo atrás eu já tive muitos problemas tentando compilar um toolchain C/C++ para o AVR,
mas dessa vez eu reuni toda a minha concentração, paciência e habilidade com _shell scripts_,
o que resultou num buildscript até que **bem útil** e genérico.
Antes de mostrar os detalhes de como ele funciona, porém,
eu gostaria de **agradecer** do fundo do meu coração o pessoal que desenvolve o GCC! Vocês são demais! ☺

<!--more-->

Ainda antes de mostrar o código em si, aí vão algumas características dessa "coleção" de scripts, a qual pode
ser obtida no GitHub – <https://github.com/joaopizani/multiarch-toolchain-buildscripts>.

  * Funciona **não somente para o AVR**, mas também para outras arquiteturas (testado e confirmado com MIPS).

  * A "coleção" de scripts consiste de uma parte genérica (que nunca muda) e de um arquivo com a definição de algumas variáveis.
    Caso você deseje compilar o toolchain para outra arquitetura basta redefinir **algumas** dessas variáveis.

  * Os scripts são não somente _multi-target_ mas também **multi-host** (testei no Linux e Mac OS X, tanto 32 quanto 64 bits)

  * Já estão prontos arquivos com definições razoáveis para AVR e MIPS. No caso do AVR, as ferramentas compiladas são as seguintes:
      + Binutils 2.22
      + GCC 4.7.0
      + AVR-Libc 1.8.0
      + SimulAVR 1.0.0
      + GDB 7.4
      + AVRDude 5.11.1

Mas chega de propaganda... vamos ver o código!
Primeiro, vou mostrar a parte genérica da coleção.
Esse shell script deve ser "chamado" a partir do arquivo com a parte específica:

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/multiarch-toolchain-buildscripts/blob/master/common.sh?footer=0"></script>

Apesar do código um pouco complexo, o núcleo de toda a ação no script é o tradicional pipeline:
**Baixar pacotes - Descompactar - Configurar - Compilar - Instalar**.
Tudo isso é feito usando um pouco de shell kung-fu como, por exemplo, metaprogramação (usando eval) e arrays.
O uso desse script resulta em:

  * Uma instalação **completamente auto-contida** para uma certa arquitetura.
    Só é necessário adicionar o diretório `bin/` da instalação ao `PATH`.
    Para remover o toolchain, basta remover o diretório-pai onde tudo foi instalado.

  * Não há necessidade de permissões de super-usuário:
    todo o processo de download, extração, compilação e instalação é feito no diretório definido pelo usuário,
    e portanto não precisa de acesso administrativo.

  * Processo de build totalmente **incremental**: caso algum erro ocorra durante o processo e seja necessário reiniciá-lo,
    ele irá prosseguir **de onde parou**.
    Pacotes só serão baixados caso não estejam num cache local, somente serão descompactados
    caso ainda não tenham sido, só serão reconfigurados caso as flags tenham mudado, etc.
    Além disso, ao primeiro sinal de erro todo o processo é abortado, para evitar compilações inúteis...

Agora, depois de conhecer a parte genérica, dê uma olhada como parece um arquivo com definições de variáveis.
O código abaixo é um "template" que deve ser preenchido com as definições
(sobretudo arquitetura-alvo, versões dos pacotes e flags de configuração).
É só preencher e rodar...

<script src="http://gist-it.sudarmuthu.com/github/joaopizani/multiarch-toolchain-buildscripts/blob/master/build_template.sh?footer=0"></script>

Sim, eu sei, é um monte de comentários... ☺
Mas eu realmente queria que ficasse óbvio o que está acontecendo em cada linha e qual é o significado de cada variável.
E por fim, você não precisa acreditar quando eu digo que funciona:
baixe a coleção de scripts do GitHub – <http://github.com/joaopizani/multiarch-toolchain-buildscripts> e compile um toolchain você mesmo!
Para AVR, MIPS, ARM, SPARC ou alguma outra arquitetura bizarra que você quiser...
E, por favor, se achar algum problema me avise com um _pull request_ :)

[1]: <http://gcc.gnu.org/>
