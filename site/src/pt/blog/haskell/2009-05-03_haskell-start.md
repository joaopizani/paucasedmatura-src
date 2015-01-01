---
title: Haskell - Por que aprender e como começar
published: 2009-05-03
en: en/blog/haskell/haskell-start
---

Atualmente estou aprendendo e gostando cada vez mais da linguagem de programação [Haskell][1].
Com ela você consegue MUITO facilmente raciocinar sobre código, e é muito mais fácil dividir seu problema em sub-problemas (o que nós programadores adoramos).
Ela é ainda uma linguagem segura, com muitas bibliotecas e com uma comunidade grande e ativa em todo o mundo.
Essa minha paixão por Haskell começou, ironicamente, quando fui obrigado a aprendê-la na disciplina **Paradigmas de Programação** do meu curso.
Vou tentar mostrar então porque você deveria aprender Haskell, mesmo que não obriguem você...

<!--more-->

Aí vão alguns motivos para aprender Haskell como sua próxima linguagem:

  * **Haskell faz você pensar de um jeito diferente**: Haskell é uma linguagem [puramente funcional][2].
    A execução de um programa é tratada como o cálculo do valor de funções, a partir da combinação de funções mais básicas.
    Em um programa funcional,
    a ÚNICA influência de uma função é seu valor de retorno a ÚNICA coisa que pode influenciar no retorno de uma função são seus parâmetros.
    Isso significa que numa linguagem funcional não há variáveis, estado, efeitos colaterais, nada disso.
    Parece impossível programar assim, não é mesmo?
    Pelo contrário, é uma ótima maneira de se programar, muita gente profissional sabe disso.

  * **Haskell é rápida**: Você não precisa _necessariamente_ perder performance porque está programando em alto nível.
    Não se estiver programando funcionalmente. Em vários benchmarks, Haskell se mostrou no mesmo nível de eficiência do que C.
    Veja o [comentário][3] do organizador do mais famoso benchmark de linguagens.

  * **Haskell é elegante**: Isso sim é importante. Veja, por exemplo, a função fatorial implementada em Haskell:

```haskell
fatorial :: Integer -> Integer
fatorial 0 = 1
fatorial n = n * fatorial (n-1)
    ```

  * É quase idêntica à _definição_ matemática! Você pode inclusive ver na primeira linha o domínio e o contra-domínio da função.
    Mesmo sendo recursiva, o compilador **otimiza** essa função e a deixa tão rápida quanto a versão iterativa.

  * **Haskell é usada na VIDA REAL**: Linguagens elegantes há milhares por aí.
    Haskell porém, é usada todo dia, no mundo inteiro, em [várias áreas][4].
    É usada, inclusive, na indústria de software, onde sua segurança e a facilidade de se garantir a corretude dos programas é um diferencial pra quem a usa.

  * **Haskell é segura**: A linguagem evita que vários erros sejam cometidos. Não há necessidade de alocação explícita de memória.
    Além disso, Haskell é uma linguagem fortemente e estaticamente tipada.
    Em Haskell toda expressão tem um tipo, e toda função tem tipos de entrada e tipo de saída.
    Esses tipos são verificados em tempo de compilação. Porém você não vai digitar muito mais por causa disso.
    Isso pois Haskell é capaz de **sempre inferir (adivinhar)** o tipo das expressões, a partir dos tipos das sub-expressões que a compoem.

  * **Haskell é divertida**: Sim, é verdade! Só programando você vai descobrir isso.

Pra aqueles que agora estão com vontade de aprender a programar em Haskell, vou dar algumas referências de por onde começar.
Coletei esses endereços durante meu último ano de paixão pela linguagem. Aproveite!

**Experimente Haskell AGORA no seu navegador - Um tutorial interativo: [Try Haskell!][5]**

**Tutorial Básico: [Learn you a Haskell for Great Good!][6]**

Esse tutorial é perfeito pra quem quer aprender de um jeito divertido.
Foi o primeiro tutorial que eu segui do começo ao fim, e ele explica bem os conceitos da linguagem com muitos exemplos.

**Como instalar Haskell: [Site do compilador Haskell][7]**

Nessa página estão todos os downloads do GHC, o compilador e interpretador Haskell mais utilizado.
Uma dica pra quem usa Ubuntu: é só digitar `sudo apt-get install ghc6 ghc6-doc ghc6-prof`

**[Como estruturar um projeto Haskell][8]**

Essa página ensina como deve ser a estrutura de um projeto de programação em Haskell, quais são as ferramentas recomendadas pra se programar na linguagem, etc.
Altamente recomandada a leitura.

**Para quem terminou o básico: [Escreva em Haskell um interpretador em 48 horas][9]**

Seguindo esse tutorial em 48 horas ou mais :), você vai escrever um interpretador completo para a linguagem de programação Scheme.
É bem acessível pra quem já concluiu o primeiro tutorial...


[1]: <http://www.haskell.org>
[2]: <http://pt.wikipedia.org/wiki/Programação_funcional>
[3]: <http://www.haskell.org//pipermail/haskell/2006-June/018127.html>
[4]: <http://www.haskell.org/haskellwiki/Haskell_in_practice>
[5]: <http://tryhaskell.org>
[6]: <http://learnyouahaskell.com/>
[7]: <https://www.haskell.org/ghc/download>
[8]: <http://www.haskell.org/haskellwiki/How_to_write_a_Haskell_program>
[9]: <http://en.wikibooks.org/wiki/Write_Yourself_a_Scheme_in_48_Hours>
