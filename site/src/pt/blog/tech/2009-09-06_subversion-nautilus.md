---
title: Subversion no Linux diretamente pelo Nautilus, sem nenhum programa a mais
published: 2009-09-06
en: en/blog/tech/subversion-nautilus
---

Eu uso muito o Subversion, muito mesmo.
E uso principalmente no Linux, em todos os trabalhos de programação em que participo.
Sempre achei um **pé no saco** usar o SVN pela linha de comando,
e não queria ter que instalar mais um programa no meu computador só de interface gráfica pro SVN.

Na verdade, usar o SVN pela linha de comando é até intuitivo,
o problema é que eu _não gosto muito de ações repetitivas_,
nem sei digitar rápido (muito menos [sem olhar pro teclado][1]).
Então eu achei um fantástico **plugin para o Nautilus** (gerenciador de arquivos do ambiente GNOME),
e era extamente o que eu precisava!

<!--more-->

Tropecei no projeto [NautilusSVN][2] enquanto estava procurando algum projeto pra traduzir na [Launchpad][4].
Ele é um plugin que inclui ações como checkout, update, commit, add e log no menu de contexto do Nautilus.

Atualmente o plugin suporta apenas o sistema Subversion,
mas segundo os desenvolvedores há planos de em breve suportar também outros sistemas, como o Git.
Vamos acabar com o papinho e partir então pra instalação do NautilusSVN.

As instruções abaixo são para instalar o NautilusSVN no **Ubuntu Linux**.
Se você usa alguma outra distribuição, as instruções estão na [página de downloads do projeto][3].
No Ubuntu é só seguir os passos abaixo:

 * Baixe o pacote .deb do site oficial:
   `wget http://nautilussvn.googlecode.com/files/nautilussvn_0.12-1ubuntu2_all.deb`

 * Instale o pacote, junto com todas as suas dependências:
   `sudo gdebi nautilussvn_0.12-1ubuntu2_all.deb`

 * Abra o diálogo "Executar" (atalho Alt+F2) e entre o comando `nautilus -q` para terminar o Nautilus
![Fechando o Nautilus](/files/imgs/2009-09_matando_nautilus.png)

 * Novamente abra o diálogo "Executar" e entre agora com `nautilus` para reiniciar o Nautilus,
   com o plugin para SVN ativado.
![Reiniciando o Nautilus](/files/imgs/2009-09_reiniciando_nautilus.png)

Não é maravilhoso esse mundo do software livre?
Agora commits, updates, checkouts, adds e ignores estão a um clique direito do mouse :)

![nautilussvn_context](/files/imgs/2009-09_nautilussvn_contexto.png)

[1]: <http://en.wikipedia.org/wiki/Touch_typing>
[2]: <http://code.google.com/p/nautilussvn/>
[3]: <http://code.google.com/p/nautilussvn/wiki/Installation>
[4]: <https://launchpad.net>
