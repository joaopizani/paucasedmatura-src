---
title: Transmissor AM com Arduino
published: 2012-04-09
en: en/blog/ac/arduino-am
---

Há dois anos (mais ou menos) eu comprei um [Arduino Duemilanove][1],
depois de ter feito uma disciplina optativa de laboratório de microcontroladores e me empolgado com o assunto...
Segui então os tutoriais clássicos: pisquei LEDs, fiz comunicação usando a porta serial e toquei musiquinhas gerando ondas quadradas...
Mas depois do período de "lua de mel", a plaquinha foi parar na gaveta.

Só recentemente é que eu tive vontade de mexer de novo com o AVR,
e encontrei um amigo empolgado pra projetarmos algo juntos - o [Tarcísio Fischer][2].
Nós decidimos tentar fazer um emissor de rádio AM usando SOMENTE o Arduino.
A idéia é transmitir um sinal AM pra ser recebido em rádios comuns caseiros (tipo rádio-relógio ou à pilha),
e o mais importante é que NENHUM componente analógico deveria ser utilizado.
Tanto a geração da onda portadora (em aprox. 500 KHz), quando a modulação pelo sinal deveriam ser feitas pelo Arduino sozinho.
Assim basta colocar um fio comprido no pino de saída (como na foto) e temos um transmissor AM (de baixa potência :P)

<div id="imgdiv-avr"><style type="text/css" scoped> #imgdiv-avr img { width:450px };</style>

 ![Poor man's Arduino AM Transmitter](/files/imgs/2012-04_arduino-am-sshot.png)

</div>

<!--more-->

Passei alguns dias programando isso, mas no final o sucesso foi épico!  
Coloquei dois vídeos no Youtube detalhando a saga até agora, um gravado em 1º de Abril (juro que é tudo verdade!) e outro gravado ontem.
Prometo pra vocês que no próximo post eu vou publicar o código.
Só estou esperando um dia para revisar o código com o [Tarcísio][3] e então mandar pro GitHub...

Enquanto isso vejam os vídeos :)  
No primeiro episódio o código está cheio de números "hardcoded",
e o transmissor só funciona em 550 KHz AM, emitindo um tom cuja frequência eu nem sei...

<iframe src="http://www.youtube.com/embed/u9-OP354o0E?rel=0" frameborder="0" width="480" height="360"></iframe>

Já no segundo vídeo o código do nosso transmissor evoluiu bastante.
Agora eu separei tudo em bibliotecas estáticas (`.a`).
Uma biblioteca responsável só pela portadora AM (`libavram.a`),
e outra responsável pela modulação dessa portadora de maneira flexível (`libavrtone.a`).
Na verdade a `libavrtone.a` funciona também com um outro "backend".
Eu fiz a `libavrbuzzer.a`, que como o nome diz, pode emitir ondas sonoras quadradas num pino de saída digital.

<iframe src="http://www.youtube.com/embed/SCeraTloUNA?rel=0" frameborder="0" width="480" height="360"></iframe>

Através do diagrama tosco abaixo vocês podem entender (ou não) como os backends (`libavrbuzzer.a` e `libavram.a`)
colaboram com a `libavrtone.a` para fazer tocar musiquinhas no buzzer e em AM:

![AVR Sound Libs](/files/imgs/2012-04_AVRSoundLibs.png)

E por hoje era só pessoal... Hora de dormir e voltar ao trabalho.
Assim que tiver um tempinho coloco o código no GitHub e posto aqui com uns comentários.
Logo vai estar pronto o super foda transmissor morse AM!

[1]: <http://arduino.cc/en/Main/arduinoBoardDuemilanove>
[2]: <http://tarcisiofischer.wordpress.com/>
[3]: <http://tarcisiofischer.wordpress.com/>
