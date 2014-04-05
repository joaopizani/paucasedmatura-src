---
title: SSH sobre SSH - Entrando pelo cano pra contornar firewalls
published: 2011-02-18
en: en/blog/tech/ssh-over-ssh
---

Esses dias eu precisava acessar remotamente meu desktop da universidade a partir de casa, então parti pra usar o grande, o confiável SSH.

```bash
ssh joaopizani@bla.bla.ufsc.br
```

SÓ QUE, como todo laboratório de respeito, o meu também tem um firewall, e qualquer acesso externo à porta 22 (a porta do SSH) é barrado.
Poŕem nós temos uma máquina coletiva, que pode ser acessada externamente.
Então eu podia acessar a máquina coletiva (_gateway_) e, a partir dela, acessar meu desktop (_dunkel_).
Copiar arquivos, enviar comandos isolados e outras coisas ficavam muito chatas de fazer assim, então eu resolvi passar o SSH por um túnel SSH pra chegar seguro onde eu queria.
Isso mesmo... Calma, já explico:

<div id="imgdiv-dawg"><style type="text/css" scoped> #imgdiv-dawg img { width:450px };</style>

 ![YO DAWG](/files/imgs/2011-02_YODAWGSSH.jpg)

</div>

<!--more-->

Eu usei uma conexão SSH até a máquina aberta para montar um **túnel**, ligando meu computador doméstico até a rede interna do laboratório.
Assim, todo dado trafegado por uma certa porta em meu computador se comporta como se tivesse partido ou chegado da máquina aberta.
O comando (genérico) para montar o túnel é o seguinte:

```bash
ssh -f -N -L <porta_local>:maquina_restrita:22 usuario@maquina_aberta
```

A opção `-L` é a que diz ao SSH para criar um túnel TCP por onde os dados vão trafegar.
As opções `-f` e `-N` só servem para que o SSH **devolva o controle do terminal** e faça **apenas o túnel**.
A `porta_local` é a porta no **seu computador de casa** (pode ser qualquer livre), já `maquina_restrita` é o nome da máquina que está atrás do firewall.
No meu caso específico o comando ficou mais ou menos assim:

```bash
ssh -f -N -L 4242:dunkel:22 joaopizani@gateway.bla.ufsc.br
```

![Diagrama de um túnel SSH](/files/imgs/2011-02_tunel.png)

DEPOIS de estabelecido o túnel, você pode conectar na porta `porta_local` do **seu computador (localhost)**, e magicamente a máquina antes inacessível lhe dará boas-vindas. Na verdade não é feitiçaria, é tecnologia :P

```bash
ssh -p 4242 joaopizani@localhost
```

É isso aí! Dica dada.
Logo vou postar bem mais coisas ninjas de terminal, estou usando muito ultimamente, voltando aos velhos e bons tempos geeks :)

