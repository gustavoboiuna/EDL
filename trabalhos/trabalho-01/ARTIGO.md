![logo](http://www.lua.org/images/lua-logo.gif)

# Introdução
Lua é uma linguagem de programação de alto nível, interpretada, *open source* e de fácil aprendizado. De acordo com seu [site oficial][SiteOf]:
>Lua é uma linguagem poderosa, rápida e leve, projetada para estender aplicações.

# Origens e Influências
Lua foi criado por uma equipe de desenvolvedores da [Tecgraf](http://www.tecgraf.puc-rio.br/pt/index.html) (Grupo de Tecnologia em Computação Gráfica) da [PUC-Rio](http://www.puc-rio.br/index.html) (Pontifícia Universidade Católica do Rio de Janeiro) em 1993. Ela sofreu influência de inúmeras linguagens, dentre elas: 
* Lisp
* Icon
* Scheme
* Pascal
* CLU
* C++
* SNOBOL
* Modula

Todo o desenvolvimento da linguagem teve como base duas outras linguagens que eram utilizadas na época pela Tecgraf, SOL e DEL. Vê-se também a influência de linguagens como Lisp e Scheme na decisão de tornar a tabela sua principal estrutura de dados.
# Classificação
Lua é uma linguagem imperativa, procedural, tipada dinamicamente. É multi-paradigma e portanto pode ser utilizada em diversos paradigmas diferentes, como: programação orientada a objetos, imperativa, funcional e reflexiva.  
# Avaliação Comparativa
Sua semântica extensível é um de seus pontos fortes, do qual podem serem adicionadas novas funcionalidades sem alterar características anteriores. Lua é usada principalmente em aplicações industriais (como o Adobe's Photoshop Lightroom), com ênfase em sistemas embutidos (como o *middleware* Ginga para TV digital) e jogos (como *World of Warcraft* e *Angry Birds*). Lua tem como seu ponto principal a portabilidade de seus programas e a fácil integração com outras linguagens de programação, servindo como potencializador de outros programas já existentes.
# Exemplos de Código Representativos
* **Hello World**:  
```
print "Olá, Mundo!"
```
* **Fatorial Recursivo**:
```
function fatorial (n)
    if n == 0 then return 1
    else return n * fatorial (n-1)
    end
end
```
O tratamento das funções como variáveis de primeira classe é mostrado no exemplo a seguir, onde o comportamento da função “print” é modificado:
```
do
   local oldprint = print -- Grava a variável “print” em “oldprint”
   print = function(s)    -- Redefine a função “print”
      if s == "foo" then
         oldprint("bar")
      else
         oldprint(s)
      end
   end
end
```
Qualquer chamada da função “print” agora será executada através da nova função, e graças ao escopo léxico de Lua, a função “print” antiga só será acessível pelo nova.  
Lua também suporta funções closure, como demonstrado abaixo:
```
function makeaddfunc(x) -- Retorna uma nova função que adiciona x ao argumento
   return function(y)
      return x + y
   end
end
plustwo = makeaddfunc(2)
print(plustwo(5)) -- Prints 7
```
Um novo “closure” é criado para a variável x cada vez que a função “makeaddfunc” é chamada, de modo que a função anônima a ser retornada sempre irá acessar seu próprio parâmetro x. O “closure” é gerenciado pelo coletor de lixo (garbage collector) da linguagem, tal como qualquer outro objeto.   
Uma característica essencial de Lua é a semântica Extensível, e o conceito de “metatables” permite que as tabelas Lua sejam personalizadas em poderosas e exclusivas formas. O exemplo a seguir mostra uma tabela “infinita”. Para qualquer valor “n”, “fibs [n]” dará o enésimo número Fibonacci usando programação dinâmica.
```
fibs = { 1, 1 } -- Valores iniciais de fibs[1] e fibs[2].
setmetatable(fibs, {
  __index = function(name, n) -- Função chamada se fibs[n] não existir
    name[n] = name[n - 1] + name[n - 2] -- Calcula e grava fibs[n].
    return name[n]
  end
})
```
# Bibliografia
* Wikipédia: https://pt.wikipedia.org/wiki/Lua_(linguagem_de_programa%C3%A7%C3%A3o)
* Wikipedia (em inglês): https://en.wikipedia.org/wiki/Lua_(programming_language)
* Site Oficial da Linguagem: http://www.lua.org/portugues.html

[SiteOf]: http://www.lua.org/portugues.html
