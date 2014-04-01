---
title: Como montar diretórios remotos usando o SSHFS
published: 2009-05-19
en: en/blog/tech/sshfs-mount
---

Há algum tempo atrás escrevi [um post][1] sobre como utilizar o SSH sem precisar digitar senhas,
e com isso tornar o login num servidor remoto bem mais simples.
Descobri há pouco tempo que o SSH pode também servir para você montar diretórios remotos, de uma maneira bem fácil.

Imagine que você tem um computador em casa com 1TB de HD onde armazena suas dezenas de filmes, músicas e tudo mais.
E você tem também um netbook levinho e com bastante bateria, mas nenhum HD, e você sempre usa uma rede de alta velocidade.
Qual é a solução? Use o SSHFS e acesse os arquivos do seu PC de casa como se fossem locais.

<!--more-->

Vamos então ao passo-a-passo para instalar, configurar e usar o SSHFS (todos os passos devem ser executados na máquina CLIENTE):

  * **Instalar o pacote "sshfs"**: Para quem usa o Ubuntu Linux basta executar dois comandos para instalar o SSHFS e tudo o que ele precisa,
    em muitas outras distribuições há um pacote equivalente. Para o Ubuntu:

    ```bash
    sudo aptitude update && sudo aptitude install sshfs
    ```

  * **Criar no cliente o diretório onde serão montados os conteúdos remotos:** Nesse passo você deve criar o diretório na máquina local onde deve
    "aparecer" o diretório remoto. A sugestão é criar a pasta dentro de /mnt, porém você pode criar em algum outro lugar de sua preferência...
    Depois de criada a pasta, você deve colocar o seu usuário como dono dela.

    ```bash
    sudo mkdir /mnt/arquivos-casa
    sudo chown <seu_usuario> /mnt/arquivos-casa
    ```

  * **Adicionar seu usuário no grupo "fuse" para ter permissão de montar e desmontar o diretório:** Você já tem permissão acessar os arquivos remotos,
    pois é o dono do diretório de montagem. Porém, por padrão, só o root pode montar sistemas de arquivos.
    Para que seu usuário comum posso montar o SSHFS, você deve adicionar seu nome de usuário no grupo "fuse".
    Para fazer isso basta usar o comando:

    ```bash
    sudo adduser <nome_de_usuario> fuse
    ```

  * **Reiniciar o computador:**Isso é necessário para que os módulos de kernel do FUSE (Filesystem in USErspace) sejam carregados.
    Se você **tem preconceito :)** contra reboots, pode também digitar `sudo modprobe fuse` que tem o mesmo efeito.

  * **Montar e usar:** Basta agora montar o conteúdo remoto e usar. Alguns exemplos legais de como usar:
    para ouvir suas músicas e ver seus vídeos como se fossem locais, para editar arquivos, fazer trabalhos, etc.
    Para montar se usa o seguinte comando:

    ```bash
    sshfs <nome_de_usuario_remoto>@<endereco_remoto>:<diretorio_remoto>  <diretorio_local>
    ```

  * **Desmontar quando acabar de usar:** Quando você não for mais usar o conteúdo remoto, pode desmontar o diretório através do comando:

    ```bash
    fusermount -u <diretorio_local>
    ```

Em um próximo post eu vou ensinar como deixar todo esse processo de montagem totalmente **automático**, usando o autofs, um fantástico software.
Com o autofs você configura os diretórios remotos que mais usa e eles estarão disponíveis assim que o computador é ligado.
Eles são montados automaticamente quando você precisa e desmontados quando não precisa mais.
Mesmo sem o autofs, porém, o sshfs já é MUITO útil.

[1]: </pt/blog/tech/ssh-sem-senhas-no-passwords>
