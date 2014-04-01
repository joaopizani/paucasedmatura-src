---
title: Google Chrome (Chromium) fácil fácil no Ubuntu Linux...
published: 2009-08-15
en: en/blog/tech/google-chrome-ubuntu-linux
---

Fiquei muito empolgado na época em que foi lançado o navegador [Google Chrome][1],
principalmente porque nele o javascript é mais rápido. 
Ficava imaginando meu e-mail, minha agenda, tudo abrindo mais rápido :)

Mas então o Google fez a sacanagem de lançar o Chrome só pra Windows,
o sistema que eu NÃO iria usar no meu dia-a-dia, nem que fosse de graça...

Eis então que meu amigo JJ apareceu todo empolgado na última semana, dizendo que tinha instalado o Chrome no seu eee PC com Ubuntu.
É uma versão ALTAMENTE EXPERIMENTAL, mas funciona...
Vai fazer uma grande diferença na sua velocidade de navegação, principalmente se você usa um netbook. Aí vão os passos para instalar:

<!--more-->

Antes de começar, uma observação:
o programa que vamos instalar é o [Chromium][2], isso mesmo, não é "Google Chrome".
Isso porque a Google liberou totalmente o código-fonte do Chrome para criar um projeto de software livre, mas para ser livre não pode ter a marca registrada da empresa.
Fora o logotipo bonitinho, é exatamente a mesma coisa.

Para instalar o Chromium no Ubuntu, copie e cole no seu terminal favorito os seguintes comandos:

  * Para colocar o endereço do repositório na lista de fontes de software:

    ```bash
    sudo add-apt-repository ppa:chromium-daily/ppa && sudo apt-get update
    ```

  * Para finalmente instalar o Chromium:

    ```bash
    sudo apt-get install chromium-browser
    ```

Voila! Agora você já pode usar seu _navegador favorito_ no seu _sistema operacional favorito_ :D

Opcional: Se você quiser tirar para sempre o Firefox do seu computador - o que _não é recomendado_, pode remover todos os pacotes relacionados ao Firefox com o seguinte comando:

```bash
sudo aptitude purge firefox3.0{,-{branding,gnome-support}}
```

[1]: <http://www.google.com/chrome/?hl=pt-BR>
[2]: <https://launchpad.net/~chromium-daily/+archive/ppa>
