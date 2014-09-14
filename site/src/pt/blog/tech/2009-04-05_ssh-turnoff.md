---
title: Cuidado ao desligar um computador...
published: 2009-04-05
en: en/blog/tech/ssh-turnoff
---

Aqui vai uma estorinha engraçada:
Eu sou um membro da equipe de Infra-estrutura computacional do [PET Computação - UFSC][1].
E uma das nossas tarefas é manter nosso servidor sempre rodando, disponível, atualizado e seguro.
Na maioria do tempo essa é uma tarefa não muito difícil,
mas tem vezes em que, como diria Forrest Gump, [merdas acontecem][2]...

<!--more-->

Uma dessas vezes foi na semana passada.
Chegando na sala do PET o pessoal tava agitado, e o que tinha acontecido?
O servidor estava fora do ar. Ele tinha sido desligado.
E por quê deligaram ele? Bem, foi sem querer...

Lembra [quando eu disse][5] que se você estiver acessando uma máquina por SSH é exatamente como se estivesse na frente dela?
Você pode inclusive desligar a máquina. Um amigo meu, que tava dando uma olhada no servidor,
tinha que sair e resolveu desligar seu computador e ele quis desligar pela linha de comando, pois ele é um legítimo [sysadmin][3] :).
O problema é que ele digitou:

    sudo halt

Não no SEU computador, mas no servidor, logado por SSH.
E então quando o SEU computador ficou ligado por tempo demais ele percebeu a cagada...
"Bom, agora é só ligar de novo e tudo volta ao normal", pensou ele.
Só pensou, pois depois de uns 5 minutos sem sinal de vida,
ele ligou um monitor velho no server e viu a mensagem "File not found" no bootloader [GRUB][4], ou seja, FODEU.
Depois de umas 2h de digitação de comandos underground, aí sim tudo voltaria ao normal.
Mas essa já é uma outra estória...

A moral que fica por enquanto é: **Quando for desligar seu computador, tenha certeza ABSOLUTA que é o SEU computador**.

[1]: <http://pet.inf.ufsc.br>
[2]: <http://en.wikipedia.org/wiki/Shit_happens>
[3]: <http://en.wikipedia.org/wiki/Sysadmin>
[4]: <http://en.wikipedia.org/wiki/GRUB>
[5]: </pt/blog/tech/ssh-sem-senhas-no-passwords>
