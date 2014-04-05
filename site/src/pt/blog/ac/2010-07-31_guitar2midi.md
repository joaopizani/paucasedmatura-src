---
title: Projeto Guitar2MIDI
published: 2010-07-31
en: en/blog/ac/guitar2midi
---

No último semestre eu fiz muitas disciplinas, muitas mesmo.
A maioria não me interessava, mas uma em particular foi muito interessante.
Era [INE5438 - Laboratório de Microprocessadores e Lógica Programável][1], uma disciplina eletiva de caráter totalmente prático.
O objetivo é dar ao aluno a capacidade de trabalhar com o projeto e a programação de sistemas embarcados, em especial microcontroladores.

Direto ao ponto, nós tínhamos duas partes na disciplina: os exercícios iniciais, que foram 9 ao total (quase um por semana).
Nesses exercícios nós programamos microcontroladores da família **AVR**, em nível crescente de dificuldade; todos os meus exercícios estão publicados nessa página: 
<http://constantijn.alvb.in/labmicro>

A outra metade da nota na disciplina é o tão temido **Projeto Final**.
Nós alunos éramos totalmente livres para escolher o tema e a plataforma a ser usada.
Claro que deixamos essa escolha pra última hora :),
e tínhamos várias idéias interessantes, mas acabei escolhendo fazer o Projeto **Guitar2MIDI** (em grupo com Daniel, Diogo, Maurício e Rodrigo)...
A idéia básica do projeto é fazer um programa que rode em uma plaquinha :) com um microcontrolador.
Você liga uma guitarra nessa plaquinha, e na saída da placa (USB ou Serial, por exemplo) está o MIDI correspondente ao que você está tocando.
Capturando essa saída você pode usar a música tocada no seu editor de partitura/tablatura favorito (GuitarPro, Encore, Finale, etc).

<!--more-->

A saída da guitarra nada mais é que um sinal elétrico analógico, correspondente à ONDA SONORA da nota/acorde tocado no momento.
O trabalho do programa é relativamente complexo: nós temos que detectar qual a frequência da nota sendo tocada, e também qual a sua duração, pra então emitir a representação simbólica dessa nota no formato MIDI.
O esquema abaixo dá uma idéia básica da arquitetura do projeto:

![Blocos funcionais do projeto Guitar2MIDI](http://constantijn.alvb.in/labmicro/projeto/blocos_funcionais.png)

Passamos muito tempo ESTAGNADOS com problemas no equipamento, e começamos a programar mesmo só na última semana (nenhuma novidade :P).
O importante é que no final das contas conseguimos terminar o projeto, e NO PRAZO \o/\o/\o/.
As músicas que o programa consegue reconhecer, porém, são bastante simples e ainda há espaço pra MUITAS melhorias, principalmente no que se refere à detecção de duração.
Sem mais enrolação, se você quiser saber mais sobre o projeto, descobrir COMO a gente fez isso acontecer, quais foram os algoritmos, as idéias que dão base pro negócio e tudo mais, aí vai o link pro relatório completo: <http://constantijn.alvb.in/labmicro/projeto/index.htm>.
Sem falsa modéstia, ele está bem escrito, com várias figurinhas e explicando bem os conceitos envovidos...

Fiquei muito feliz com o projeto como um todo.
Realmente terminá-lo deu aquela ótima sensação de que "eu fiz algo".
Posso arriscar dizer que essa foi a primeira vez, desde a minha entrada na Universidade, que desenvolvi um projeto em grupo com tanta independência, com tanta vontade pessoal, e que deu um resultado tão prático e legal...
Deu até vontade de refazer o projeto com o novo [Arduíno][2] que eu comprei, mas esse já é assunto pra um outro post :D

[1]: <http://www.lisha.ufsc.br/teaching/esl/>
[2]: <http://arduino.cc/>
