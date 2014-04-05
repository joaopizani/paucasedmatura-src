---
title: Experimentar o Android ICS (Ice Cream Sandwich) na VirtualBox
published: 2012-02-19
en: en/blog/tech/android-ics-virtualbox
---

Há um tempo atrás eu escrevi dizendo que tinha recém-comprado um tablet Android.
De fato, eu tenho me interessado bastante por Android ultimamente...
E lendo a seção de [Android do Reddit][1] na última semana eu (re)descobri um projeto muito interessante.
O [Android-x86][2].

<div id="imgdiv-x86"><style type="text/css" scoped> #imgdiv-x86 img { width:300px };</style>

 ![Android x86](/files/imgs/2012-02_Android-x86.png)

</div>

O Android-x86 é um esforço da comunidade para portar todas as versões do Android disponíveis pelo AOSP (Android Open-Source Project) para a plataforma x86.
Assim, o Android pode ser executado em computadores como, por exemplo, os Asus EEE PCs, Dell, Hp, etc...
O mais legal ainda é que o pessoal também está se esforçando no Android-x86 para que o suporte à VirtualBox seja o mais completo possível,
assim um desenvolvedor Android pode testar seus aplicativos na VirtualBox, ao invés de usar o emulador (lento) que vem junto com o SDK...

Daí através de um post no Reddit eu conheci o trabalho de um desenvolvedor romeno, que contribui com o porte do Android 4.0
para a VirtualBox e publica imagens ISO diárias do build mais recente no seu blog ([http://www.buildroid.org/blog][3]).
O que eu fiz foi pegar a ISO de lá, criar uma máquina virtual na VBox, instalar e configurar, e colocar uns aplicativos do Google (GMail, YouTube, Maps, Android Market, etc.).
Aí vai o resultado final dessa minha "configuração" toda :D

<!--more-->

![Android 4.0 na VirtualBox no Ubuntu :)](/files/imgs/2012-02_android-x86-ss.png)

O sistema funciona muito bem, com internet, áudio, vídeo, e todos os aplicativos do Google sincronizando e funcionando sem nenhum travamento.
Essa imagem que eu configurei vem com o Android Market,
e você pode até mesmo instalar coisas do Market dentro do seu Android Virtual \o/\o/.  
Depois de fazer toda a configuração, eu "empacotei" a máquina virtual num arquivo tipo [OVA][5]
pra que todo mundo possa usar e brincar sem passar trabalho :)

Aí vai a imagem, pronta pra você **baixar, importar na VirtualBox e usar**: [Androidx86-ICS-VBox][4]

Tá facil de usar, mas se você quiser saber COMO que eu fiz pra conseguir isso, quais configurações, aí vai a receita:

  * Baixei a imagem ISO do site do Marius: <http://www.buildroid.org/Download/android-x86-vm-20120130.iso.gz>
  * Criei uma máquina virtual na VBox do tipo "Linux 2.6", com disco virtual de 4GB expansível
  * Configurei a VM pra colocar no CD-ROM a ISO baixada e desativei o "absolute pointing device" (assim o mouse funciona OK no Android"
  * Com a VM fazendo boot pelo ISO, testei o Android como live CD, e, depois de confirmar que tudo funcionava, instalei o Android no disco virtual sda1.
  * Com o Android rodando, transferi via SDK (adb) os aplicativos do Google (<http://goo-inside.me/gapps/gapps-ics-20120215-signed.zip>)
  * Com tudo rodando OK, empacotei a VM pronta para a imagem OVA que vocês veem acima :)

É isso aí!
Agora tô feliz, testando vários aplicativos que pretendo usar quando meu tablet Android chegar! :)
Quando eu programar alguma coisa pra Android, posso também testar meus própriois programas rodando na VirtualBox! \o/\o/

Mais uma vez, a VM **prontinha pra usar** que eu preparei pra vocês está AQUI: [Androidx86-ICS-VBox][4]


[1]: <http://www.reddit.com/r/Android>
[2]: <http://www.android-x86.org>
[3]: <http://www.buildroid.org/blog>
[4]: <https://mega.co.nz/#!bVN0GKRD!GSBzVlcjpu4GFZJYA5WpmzKf6-N_jkJzA8TsiS2pfvA>
[5]: <http://en.wikipedia.org/wiki/Open_Virtualization_Format>
