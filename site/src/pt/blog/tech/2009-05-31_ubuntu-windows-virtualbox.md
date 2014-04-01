---
title: Como instalar o Ubuntu dentro de uma máquina virtual no Windows
published: 2009-05-31
en: en/blog/tech/ubuntu-windows-virtualbox
---

Este é um tutorial especial pra quem usa Windows, ouve todo mundo falar bem do Linux, tem vontade de testar, mas não quer ter que reparticionar e formatar o HD.

A [VirtualBox][1] é uma **máquina virtual**, ou seja, um software que é capaz de agir como se fosse um computador.
Você pode rodar a VirtualBox em qualquer sistema operacional, e dentro da VirtualBox pode instalar qualquer outro.

É aí que entra esse tutorial.
Vou mostrar como instalar a VirtualBox no Windows e então instalar o [Ubuntu Linux][2] dentro da VirtualBox.
Esse tutorial foi feito como parte das minhas atividades no grupo [PET Computação - UFSC][3].

[1]: <http://www.virtualbox.org/>
[2]: <http://www.ubuntu.com/>
[3]: <http://pet.inf.ufsc.br>

<!--more-->

Esse material foi elaborado com base no Ubuntu 8.10, porém nada que influencie no tutorial mudou com as novas versões.
Pra quem gotsta de aprender as coisas visualmente, eu publiquei um [screencast][4] com todo o processo de instalação no YouTube.

Lá vai o passo-a-passo para instalar o Ubuntu sem medo :)


**Instalando a VirtualBox e criando uma máquina virtual onde ficará o Ubuntu.**

  * Faça o download da VirtualBox mais recente (versão para Windows) no [site oficial][1]

  * Execute o arquivo de instalação baixado e aceite a licença.
    Obs: se você usa um computador compartilhado, é preciso ter acesso de administrador para instalar programas.

  * Um aviso será mostrado dizendo que durante a instalação pode cair a conexão com a Internet. Prossiga.

  * Clique em "Install" para iniciar a instalação.

  * Vai ser mostrado um aviso pedindo se você aceita a instalação do _driver_ da VirtualBox. Aceite.

  * Após o fim da instalação será aberto o programa pela primeira vez. Preencha o formulário de registro que vai aparecer.

  * No canto superior esquerdo da janela, clique em "Novo" para criar uma máquina virtual.

  * Clique em "próximo", e na tela que aparecerá preencha o nome da máquina a ser criada e escolha "Linux" como sistema operacional e "Ubuntu" como versão.

  * Escolha a quantidade de memória RAM que será usada pela máquina virtual.
      1. Para o Ubuntu, o mínimo de RAM é de 384MB.
      2. Obs: É bom lembrar que TODA a quantidade escolhida aqui será "emprestada" do seu Windows quando for ligada a MV.

  * Agora chegou a hora de criar um disco rígido virtual onde será instalado o Ubuntu.
    Um HD virtual nada mais é que um arquivo comum que ficará numa pasta qualquer, mas que a MV verá como se fosse seu HD quando iniciar.
      1. Clique em "Novo" para criar um novo HD Virtual.
      2. Clique em próximo e, na tela que aparecerá, escolha "Armazenamento dinamicamente expansível".
         Assim o HD virtual só ocupará o espaço que estiver sendo usado pelo sistema dentro da MV.
      3. Escolha o tamanho do HD virtual. Para o Ubuntu se recomenda no mínimo 5GB.
      4. Clique em "Finalizar"

  * De volta ao assitente de configuração da MV, clique em "Próximo" e em "Finalizar". Pronto! Esse foi o último passo da criação da máquina virtual.


**Instalando o Ubuntu a partir da imagem do CD**

Vamos instalar o Ubuntu mais recente na máquina virtual que acabamos de criar a partir do arquivo .iso
baixado diretamente do [site oficial][2]. 
Vamos então configurar a máquina virtual para fazer o boot pelo CD e instalar o Ubuntu. É bastante simples:

  * Selecione a MV recém-criada e clique em "Configurações"

  * Entre na seção "CD/DVD-ROM", habilite "Montar drive de CD/DVD" e escolha "Arquivo de imagem .ISO"

  * Vai abrir então o "Gerenciador de mídias virtuais". Clique em "Acrescentar" e localize o arquivo .ISO de instalação do Ubuntu.
    Clique então em "Selecionar" e feche o Gerenciador de Mídias Virtuais.

  * De volta à janela de configurações da VM, clique em "OK" na parte de baixo da janela. 
    Agora o CD de instalação do Ubuntu já está inserido na MV.

  * Clique em "Iniciar" para dar boot na MV. Vai ser mostrado um diálogo avisando sobre como entrar e sair com o teclado da MV.

  * O instalador do Ubuntu vai iniciar. 
    Escolha o idioma e escolha "Instalar o Ubuntu" na lista de opções. Aguarde enquanto é carregado o programa de instalação.

  * Agora vão os passos para instalar o Ubuntu. Essa é a parte mais fácil de todo o processo :)
      1. Escolha o idioma do sistema e clique em "Próximo"
      2. Escolha sua localidade no mapa, para definir o fuso horário e clique em "Próximo"
      3. Selecione um layout de teclado na lista e teste digitando algumas palavras com acento na caixa de texto. Clique então em "Próximo"
      4. Na tela de particionamento do HD, deixe tudo como está e clique em "Próximo"
      5. Preencha seus dados pessoais e a senha para fazer login no sistema. Próximo!
      6. Clique em "Instalar". Pronto! Em 6 telas! Não tem mais fácil.

  * Depois de mais ou menos uns 20 minutos a instalação vai estar concluída.
    Clique no ícone de CD na barra de status da máquina virtual e escolha "Desmontar CD-ROM" para retirar o CD da VM. 
    Clique então em "Reiniciar Agora".

[4]: <http://www.youtube.com/watch?v=wUln3JuE7iU>
