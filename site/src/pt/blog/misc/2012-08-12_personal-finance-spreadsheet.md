---
title: Template de planilha para finanças pessoais
published: 2012-08-12
en: en/blog/misc/personal-finance-spreadsheet
---

Em pouco tempo vai começar uma nova "época" na minha vida.
Vou sair da casa dos meus pais - vou sair do PAÍS, de fato - dividir um apartamento com alguns colegas e viver de maneira totalmente independente.
Ah, um pequeno detalhe: enquanto isso vou cursar um pesado programa de mestrado científico em tempo integral.

Portanto, eu quero ter o mínimo possível de "distrações" e preocupações, para me concentrar melhor nos estudos e pesquisas.
Uma coisa que costuma preocupar muito as pessoas é o dinheiro (em particular a **gestão** do seu dinheiro).
Então eu pensei que podia usar o tempo que tinha antes da grande mudança para implementar uma BOA PLANILHA® de finanças pessoais,
que deixaria meus gastos e receitas **sempre sob meu controle**, ao mesmo tempo em que me **livraria da constante preocupação com as finanças**.
As estimativas, cálculos e saldos ficam a cargo de quem sabe muito bem fazer isso - UM COMPUTADOR.

Agora, acontece que a planilha ficou tão legal que **pode até mesmo ser útil pra mais gente** :), especialmente estudantes e solteiros em geral...
Uma funcionalidade **particularmente legal** dessa planilha é que é possível ter uma data associada a cada transação financeira (entrada ou saída).
Daí, se você escolher **agendar** essa transação, ela vai **aparecer em uma agenda do Google definida por você** :D

Aí vai o link para o template da planilha.
Use-a, modifique-a à vontade e aproveite:

[personal-finance-template](https://docs.google.com/spreadsheet/ccc?key=0Aj5ZTErhNUi2dEI5SHBGWHVTMWd3cFFjNDRqNVp4aFE&usp=sharing#gid=12)

Só vou agora explicar um pouco melhor como se deve usar a planilha e como ela funciona:

<!--more-->

Em primeiro lugar, há dois tipos de "páginas" na planilha: a página "anual" `(year)` e as páginas mensais.
Isso quer dizer que há uma página para cada mês do ano, e mais uma página com uma visão "consolidada" de dados resumidos de todos os meses.
A página "year" não foi feita para ser editada (com exceção de poucos campos sobre os quais falarei em breve),
e mostra - por exemplo - entrada bruta, saída, poupança e fluxo de caixa para cada mês do ano.
Ela também tem um espaço para que sejam incluídas transações "únicas" no ano, como impostos, bonificações, etc.
Aí vai a parte de "resultados" da página anual:

![Resultados mensais e anuais consolidados na página](/files/imgs/2012-08_finance-sheet-year.png)

Outra coisa interessante sobre a página "year" (talvez a MAIS interessante),
é que ela permite que você veja a **distribuição** de suas receitas e despesas, de acordo com tags (categorias) definidas POR VOCÊ.
Você pode ver os montantes absolutos de dinheiro gasto ou recebido por tag, assim como porcentagens de receita e despesa correspondentes a cada tag.
Aí vai então, outra parte da página "year":

![Distribuição de receitas e despesas por tag](/files/imgs/2012-08_finance-sheet-distribution.png)

Claro que para ter dados anuais consolidados, você precisa registrar as suas transações (entradas e gastos) do dia-a-dia, e é pra isso que servem as páginas mensais.
Cada mês tem uma página (todas são muito parecidas), na qual você deve registrar as receitas e despesas relacionadas àquele mês nas regiões correspondentes:

![Exemplo de uma página mensal, com as transações de entrada e saída](/files/imgs/2012-08_finance-sheet-month.png)

Cada transação (de entrada ou de saída) tem um valor, uma tag e uma descrição livre.
Além disso, cada transação pode também ter uma data.
Lembra do que eu falei anteriormente sobre agendamento de transações?
Caso a coluna "Cal" de uma transação tenha o valor "1", então um evento representando essa transação será criado na agenda do Google escolhida por você.
O nome da agenda em que você deseja que as transações agendadas apareçam fica definido em uma célula no canto direito superior da página "year", aqui ó:

![finance-sheet-calendar](/files/imgs/2012-08_finance-sheet-calendar.png)</a>

Ufa, quase terminando... para finalizar o "tutorial" sobre a super-planilha de finanças pessoais, uma explicação sobre **como funciona** o agendamento de transações:
a cada 10 minutos, o script incluído na planilha varre as transações e garante que todas as transações marcadas para agendamento (Cal = 1) estão presentes na sua agenda escolhida.
Você também pode fazer a sincronização a hora que quiser, pelo menu "Scheduler - Schedule all new transactions".

Agora.... TERMINOU! POR HOJE ERA SÓ, PESSOAL!  APROVEITEM! :)
Mais uma vez, aí vaí o link do template de planilha, caso você queira dar uma olhada e/ou usar:
[personal-finance-template](http://drive.google.com/previewtemplate?id=0Aj5ZTErhNUi2dEI5SHBGWHVTMWd3cFFjNDRqNVp4aFE&amp;mode=public)

PS: Na primeira vez em que for rodar o script de sincronização, pode ser necessário que você **autorize-o** para escrever na sua agenda do Google.
Simplesmente clique em "OK - eu autorizo" quando for pedido e deve dar tudo certo :)

