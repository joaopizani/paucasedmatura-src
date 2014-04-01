---
title: Não se repita (DRY): use macros no Vim
published: 2011-12-28
en: en/blog/tech/vim-macros
---

Meu último post aqui no blog foi há MUITO tempo atrás, eu sei, mas eu ainda estou vivo, acreditem! :)
E hoje o assunto do post vai ser um pouco mais técnico:  vou falar sobre as poderosas macros do Vim!
Quem me conhece sabe muito bem que eu admiro - e uso bastante - o editor de texto [Vim][1].

Então... estava eu programando umas coisas em Java há uns dias, usando vim,
e tive a necessidade de substituir vários blocos de código _similares mas não idênticos_ por um nome de variável que eu tinha recém-fatorado.
Eram blocos de código _BEM GRANDES_ que tinham que ser substituídos, com variações sutis, então um simples _find/replace_ não seria suficiente...

<!--more-->

Eu comecei tentando usar o tradicional truque da tecla ".":
Eu substituí o primeiro bloco pela variável, e então prossegui selecionando cada bloco subsequente e apertando ".".
Era eficiente, mas não tanto quanto eu precisava.
Ia demorar DEMAIS para que eu andasse por todo o arquivo até substituir os **mais de 200** blocos de código :O
Então percebi que havia chegado a hora de usar um recurso do vim que eu tinha conhecido só recentemente: macros!

As macros do vim são um mecanismo BASTANTE genérico:
você começa a gravar uma macro e então tudo que você faz - cada movimento, cada edição, tanto em modo normal quanto em modo insert, visual, etc. - é capturado.
Então você pode dar **replay** na macro e os comandos são repetidos exatamente como você os fez.
Isso pode ser muito útil, muita gente tende a subestimar a utilidade **gigante** desse recurso.
Eu espero ilustrar um pouquinho dessa utilidade com o meu exemplo da "vida real".
Aqui vai um dos blocos de código que eu estava mexendo, antes e depois da transformação que eu precisava fazer:

```java
// <antes>
put(bnome_en, new ValidationRule() {
    protected ValidationResult check(String userInput) {
        if(isEmpty(userInput)) return ValidationError.empty;
        else return intact(userInput);
    }
});
// <depois>
put(bnome_en, BaseRules.nonEmptyRule);
```

Depois de experimentar um pouco, eu descobri que o que eu precisava fazer era mudar tudo que estava entre "new" e "})" (o parênteses que fechava a classe anônima) para "BaseRules.emptyRule".
Então meus comandos foram:

  * Procurar por "new"
  * Entrar em modo visual
  * Procurar por "})"
  * Ativar o comando "change"
  * Digitar "BaseRules.emptyRule"
  * Voltar ao modo normal
  * Descer uma linha e deletar a linha atual (para se livrar de uma linha chata em branco)

Para começar a gravar uma macro no vim, você digita `q<letra-minuscula>`, e a macro vai ser **armazenada** no registro de nome `<letra-minuscula>`.
Você vai precisar se lembrar dessa letra quando quiser dar replay na macro mais tarde.
A minha sequência EXATA de teclas pressionadas para gravar a macro foi a seguinte:

    qn/new&lt;CR&gt;v/})&lt;CR&gt;cBaseRules.nonEmpty&lt;ESC&gt;jddq

onde `<CR>` significa Enter e `<ESC>` significa Escape.
Note que eu armazenei a macro no registro `n`, e que no final da minha sequência de comandos eu pressionei novamente a tecla `q` para **terminar a gravação**.
Agora tudo o que eu precisava era clicar em cima de um bloco de código e digitar:

    @n

Ou seja, a tecla arroba `@`, seguida do nome do registro onde a macro está armazenada.
E BOOM! Funcionou muito bem. Então eu ganhei confiança e digitei:

    50@n

Isso significa que eu executei a macro repetidamente 50 vezes.
Funcionou e foi muito bonito :D  Conclusão: macros no vim são úteis E fáceis de usar; elas até fazem sentido!
Então, caro futuro usuário, novato ou avançado do vim, sempre que você perceber que está repetindo uma tarefa e ela é mais complexa que um _find/replace_,
aperte "q" e comece a gravar uma macro :)

Dica importante: uma macro é completamente INSENSÍVEL a contexto, ou seja, EXATAMENTE os mesmos comandos (inclusive os mesmos deslocamentos) vão ser realizados no replay, não importa a região onde você executar a macro.
O segredo então é você utilizar de recursos como busca ("/") durante a gravação para ter certeza que está no "lugar certo" onde fazer a edição...

[1]: <http://en.wikipedia.org/wiki/Vim_(text_editor)>
