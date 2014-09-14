---
title: Nova hospedagem - Amazon EC2: Meu próprio servidor, bem longe de mim
published: 2011-01-30
en: en/blog/tech/amazon-ec2-host
---

Já faz um bom tempo que não posto nada nesse blog, e a razão verdadeira pra isso é a minha cara de pau e preguiça mesmo...
**Porém**, há algumas desculpas ☺
A maior de todas é que eu transferi o blog (e todas as minhas outras coisas pessoais) pra uma nova hospedagem.

Dessa vez eu tenho **hospedagem própria**, ou seja, meu próprio servidor.
Eu tenho controle **total** sobre ele, instalo o que quiser, o sistema que quiser, desligo e ligo quando quiser...
O único detalhe é que esse meu servidor está em algum lugar (desconhecido) a uns 4000km de distância da minha casa.
Como assim?! Eu agora tenho uma máquina virtual no [Amazon EC2][1]

<!--more-->

Mas o que é o Amazon EC2, pra que serve??
O Amazon EC2 (Elastic Compute Cloud) é um serviço que permite a você, caro usuário,
**alugar** os recursos computacionais da Amazon e rodar uma máquina virtual sobre os datacenters deles.
Na prática isso quer dizer que você ganha uma máquina (cujo hardware você escolhe dentre vários "níveis")
sobre a qual você tem total controle, você é DEUS.
Pode instalar qualquer sistema operacional, acessar remotamente e usá-la para qualquer propósito.

No meu caso eu queria uma máquina bem pequena e barata pra eu poder rodar um [Ubuntu Server][2],
um servidor web Apache (com o blog) e mais alguns brinquedinhos úteis.
Pra conseguir essa configuração foi muito mais fácil do que eu esperava, então não custa dividir aqui com vocês...

![Amazon Web Services](http://awsmedia.s3.amazonaws.com/logo_aws.gif)

Primeiro de tudo, quanto custa?
Existe uma [categoria de serviço que é GRÁTIS][3] (só até o fim do ano), e é essa que eu uso, claro.
Tá, agora, o passo-a-passo pra registrar sua máquina, dar o primeiro boot e acessar:

 1. Você precisa criar a conta na Amazon. Vá até a [página de registro][4] e preencha tudo, incluindo cartão de crédito.

 2. Ao final do processo você vai baixar dois arquivos, um chamado `cert-<bla>.pem` e o outro chamado `pk-<bla>.pem`
   Esses arquivos são as chaves pra você acessar o serviço EC2 através dos programas por linha de comando (a maneira mais prática).
   Salve esses arquivos onde quiser e sete as variáveis de ambiente de acordo com as instruções do site.

 3. Agora, basta baixar o pacote ec2-api-tools no seu computador,
   o computador que você vai usar para interagir com o serviço Amazon.
   No Ubuntu, um simples `sudo aptitude install ec2-api-tools` faz o serviço.

 4. Vamos criar a nossa **instância** então:

    ```bash
    ec2-run-instances ami-ccf405a5 --instance-type t1.micro --region us-east-1 --key <chave>
    ```

   + O parâmetro _ami-ccf405a5_ é a imagem de disco para a máquina, no nosso caso é Ubuntu Server 10.10 32-bit.
   Você deve fornecer o nome da chave que criou no fim do registro da conta.

 5. A sua máquina já está iniciando, pronto! Pra acessar remotamente,
   basta copiar o endereço retornado pelo comando anterior e entrar nela por SSH, usando a sua chave.
   Algo mais ou menos assim:

    ```bash
    ssh -i &lt;chave&gt; ubuntu@ec2-174-129-217-7.compute-1.amazonaws.com
    ```

 6. Pronto! Faça o que quiser com esse servidor Linux, ele é seu! :D


[1]: <http://aws.amazon.com/ec2/>
[2]: <http://www.ubuntu.com/server>
[3]: <http://aws.amazon.com/free/>
[4]: <https://aws-portal.amazon.com/gp/aws/developer/registration/index.html>
