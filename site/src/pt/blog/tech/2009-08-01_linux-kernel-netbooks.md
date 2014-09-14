---
title: Kernel do Linux customizado para netbooks
published: 2009-08-01
en: en/blog/tech/linux-kernel-netbooks
---

Se você é (como eu) um feliz proprietário de um netbook e usa **Ubuntu Linux** como sistema operacional, tenho uma boa notícia:
o site Array.org contém um [repositório][1] de pacotes com uma versão do kernel do Linux
especialmente para as nossas pequenas mas queridas máquinas...

<!--more-->

Várias otimizações são feitas no kernel especial,
levando a melhores tempos de boot, um sistema com respostas mais rápidas, entre outras vantagens.
Isso é conseguido fazendo com que alguns drivers de dispositivos comuns em netbooks
sejam **embutidos no kernel, e não compilados como módulos**.
Além disso, o suporte a vários tipos de hardware que os netbooks em geral não têm (como por exemplo CD-ROMs) é eliminado.

Vários modelos de netbooks são suportados, entre eles meu MSI Wind, Asus EEE PC, Dell mini, Acer Aspire, HP mininote, etc.
Os modelos que são suportados estão logo na [página inicial do repositório][2].

Para instalar o kernel no seu netbook com Ubuntu 9.04 é bastante simples.
Se você usa alguma outra versão do Ubuntu, consulte o [tutorial oficial de instalação][3].
Para o 9.04 basta copiar e colar EXATAMENTE os três comandos abaixo no seu console:

 * Para adicionar a chave do repositório, permitindo o acesso:
  `sudo apt-key adv  --keyserver keyserver.ubuntu.com  --recv-keys FD0C2C24`

 * Para adicionar array.org na lista de repositórios:
  `echo "deb http://www.array.org/ubuntu jaunty main" | sudo tee -a /etc/apt/sources.list`

 * Para atualizar a lista de pacotes e instalar a versão do kernel para netbooks:
  `sudo aptitude update  &&  sudo aptitude install linux-netbook`

**Dica 1:** Se você usa um Asus EEE PC, pode usar `linux-netbook-eeepc` no terceiro passo ao invés de `linux-netbook`

**Dica 2:** Caso você não queira mais receber as atualizações dos kernels genéricos, use o comando

```bash
sudo aptitude purge linux-generic linux-image-generic linux-restricted-modules-generic
```

**Dica 3:** Para remover COMPLETAMENTE qualquer versão de kernel genérico no seu sistema, e deixar só o de netbooks, use:

```bash
sudo apt-get remove linux-.*-generic
```

Faça bom proveito do seu linux tunado pra netbooks!

PS: Agradecimento ao meu amigo [José João Júnior][4] por mostrar
o efeito INCRÍVEL que esse kernel modificado fez no EEE PC dele :)

[1]: <http://array.org/ubuntu/>
[2]: <http://array.org/ubuntu/>
[3]: <http://array.org/ubuntu/setup.html>
[4]: <http://wwwexe.inf.ufsc.br/~jose.joao.junior/>
