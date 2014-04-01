---
title: Usando SSH sem senhas
published: 2009-03-07
en: en/blog/tech/ssh-sem-senhas-no-passwords
---

Eu uso Linux, **muito**. Uso no computador pessoal e no trabalho.
Uma ferramenta muito útil pra Linux é o [SSH][1] (Secure Shell).
Ele permite que você se logue e execute comandos numa máquina remota.
A vantagem é que toda a conexão é **criptografada**, assim mesmo se alguém estiver "ouvindo" sua conexão você fica seguro.
Eu uso bastante o SSH, e uma coisa que sempre me irritou era **ter que digitar uma senha a cada conexão**.
Além disso, uma senha diferente pra cada computador em que eu conectava! Agora isso é coisa do passado :)
Em poucos passos eu vou ensinar você a nunca mais precisar digitar senha pra se conectar por SSH, e mesmo assim continuar seguro.

<!--more-->

**Qual é a mágica?**

Não é feitiçaria, é tecnologia... :) O que nós vamos fazer é mudar a **maneira como dizemos ao servidor "Eu sou eu mesmo"**.
Na maioria das vezes usamos uma senha pra fazer essa autenticação.
O computador acredita que somente eu sei a minha senha, e se "joaopizani" digitou a senha certa então é porque é ele mesmo que está tentando se conectar...
Parece bom, não é mesmo?

Nem tanto... Em cada computador que conectamos temos que digitar uma senha (possivelmente) diferente.
Além disso, a senha, que **supostamente só você devia saber**, tem que ficar guardada no computador remoto também.
E a cada vez que você conecta, tem que digitar a maldita senha.
Como resolver esses problemas? Usando _autenticação por chaves criptográficas_.

**E como funcionam essas chaves?**

Para se autenticar no SSH pra sempre de forma automática e sem usar senha você deve criar um _par de chaves_ pra você.
Uma dessas chaves é chamada de _chave privada_, pois só você deve ficar com ela, e ela não deve ficar em nenhum computador remoto.
A outra chave do par é a (adivinha...) _chave pública_. Como o nome já diz, essa chave você deve colocar em todos os computadores em que você quer logar por SSH.
Agora, como o servidor sabe que é você mesmo tentando logar :) ? É simples, ele lhe **desafia**, desse jeito:

 * Você tenta conectar no servidor, e diz que seu nome de usuário é _nome-x_
 * O servidor tem uma tabela com chaves públicas, e ele vê que existe nessa tabela a _chave pública_ de nome-x (se não existisse, a conexão seria recusada).
 * O servidor criptografa uma palavra secreta (o desafio) com a chave pública de nome-x e manda pro cliente
 * O cliente nome-x usa a sua _chave privada_ pra decifrar o desafio e manda a palavra decifrada de volta para o servidor.
 * O servidor confere a resposta. Se ela bater com o desafio original, então nome-x não é um impostor! :)

Se um texto é cifrado com a chave pública de nome-x, **só a chave privada de nome-x** pode decifrá-lo.
Agora, quais são as vantagens de usar chaves ao invés de senhas? Tem várias, entre elas:

 * Você envia a mesma chave pública para todos os lugares onde quiser se conectar. Nunca mais fique decorando senhas de lugares diferentes.
 * Sua chave privada é **privada de verdade**. Ninguém precisa ver ela pra autenticar. Guarde ela bem e a segurança é perfeita.
 * Se a conexão não pede mais senha, você pode conectar em máquinas remotas sem ninguém na frente do teclado pra digitar. Isso é muito útil pra backups e outros tipos de tarefas automatizadas.

**Configuração passo-a-passo:**

No seu computador, digite os seguintes comandos:

```bash
ssh-keygen -t rsa
ssh-copy-id usuario-remoto@maquina-remota
```

O primeiro vai pedir uma _passphrase_. Deixe ela em branco. Ele vai gerar seu par de chaves.
O segundo comando copia a sua chave pública para a máquina remota. Ele vai pedir sua senha.
Essa é a última vez que você digita senha pra entrar nessa máquina. Nunca mais!

Pra cada máquina que você quer logar sem senha, execute o segundo comando. É só isso!

[1]: <http://pt.wikipedia.org/wiki/SSH>
