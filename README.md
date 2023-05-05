# BlackJack

**Disciplina**: FGA0210 - PARADIGMAS DE PROGRAMAÇÃO - TA <br>
**Nro do Grupo**: 2<br>
**Paradigma**: Funcional<br>

## Alunos

| Matrícula  | Aluno                            |
| ---------- | -------------------------------- |
| 19/0016663 | Lucas Pimentel Quintão           |
| 18/0108344 | Rafael Berto Pereira             |
| 20/0017519 | Eurico Menezes de Abreu Neto     |
| 19/0027088 | Eliás Yousef Santana Ali         |
| 19/0044403 | Victor Souza Dantas Martins Lima |
| 19/0033088 | Lucas Braun Vieira Xavier        |
| 19/0025379 | Brenno Oliveira Silva            |
| 19/0055201 | Matheus Calixto Vaz Pinheiro     |
| 20/0019228 | Gustavo Martins Ribeiro          |

## Sobre

Este repositório contém o projeto do grupo dois, que se trata de uma implementação do jogo Black Jack, na linguagem Haskell. O jogo foi desenvolvido seguindo os princípios básicos do BlackJack e é jogado por apenas uma pessoa além do dealer.

Além da implementação do código, o repositório inclui uma breve documentação do projeto e instruções de como rodar o mesmo.

O projeto foi desenvolvido pelos estudantes da disciplina de Paradigmas de Programação da Universidade de Brasília, com o objetivo de explorar a linguagem Haskell e aplicar os conceitos de programação funcional.

## Screenshots

Adicione 2 ou mais screenshots do projeto em termos de interface e/ou funcionamento.

## Instalação

**Linguagens**: Haskell<br>
**Tecnologias**: Stack<br>

Primeiro é necessário instalar o Haskell, caso ainda não tenha sido feito:

```
sudo apt-get install haskell-platform
```

Também é necessário o Haskell Tool Stack (Stack):

```
sudo apt-get install haskell-stack
```

Em seguida, instale a biblioteca random, que é uma dependência externa usada no embaralhamento:

```
stack install random
```

## Uso
Para rodar, acesse a pasta src/, carregue o arquivo game.hs pelo ghci, e execute a função *main*:

```
cd src/
ghci
Prelude> :l game.hs
*Main> main
```

## Participações e lições aprendidas
Apresente, brevemente, como cada membro do grupo contribuiu para o projeto.
|Nome do Membro | Contribuição | Significância da Contribuição para o Projeto (Excelente/Boa/Regular/Ruim/Nula) |
| -- | -- | -- |
| Rafael Berto Pereira  | Essa matéria foi o meu primeiro contato com o paradigma funcional. A primeira impressão que ficou foi de estranhaza pois essa paradima é muito diferente dos utilizados em C/C++ e /java, por exemplo. Entretanto, após praticar um pouco os exemplos dados em sala eu não senti muita dificuldade de compreender o paradigma. No projeto eu contribui com a modularização do jogo e algumas funções. Atuei mais no módulo "Cards.hs" e na função "inGameMenu" do módulo "Menu.hs". | Excelente |
| Lucas Pimentel Quintão| Neste projeto pude colocar em prática grande parte da teoria vista em sala durante as aulas da matéria. Consegui atuar em todas as partes do projeto desde a idealização, análise dos antigos repositórios com o mesmo tema e no desenvolvimento do jogo. Na parte de desenvolvimento atuei diretamente nas funções inGameMenu, startGameMenu, endsGame, desenvolvimento das novas features e em funções do módulo utils.hs. Acredito que a maior dificuldade foi a mudança na maneira de pensar o código que o paradigma funcional exige e as particularidades da linguagem Haskell| Excelente |
| Victor Souza Dantas Martins Lima| O projeto inicialmente parecia algo simples até por ja existirem algumas implementações para tomar como base, porém, tivemos que repensar diversas coisas e ajustar alguns defeitos encontrados nas outras implementações além de acrescentar novas funcionalidades. Atuei bastante na parte do inGameMenu, endsGame e na função de split que particularmente achei a mais complexa. As maiores dificuldades foram se adptar as particularidades da linguagem, o uso de recursão e identificar em quais locais o código poderia ser reaproveitado e a forma como reaproveitá-lo. | Excelente |
| Brenno Oliveira Silva | Minha contribuição para o projeto consistiu em auxiliar na criação das funções do Utils. As maiores dificuldades no projeto foram em estruturar funções sem utilizar estruturas semelhantes a objetos ou classes. | Boa |


## Vídeo

Adicione 1 ou mais vídeos com a execução do projeto.

## Outros

Quaisquer outras informações sobre seu projeto podem ser descritas a seguir.

## Fontes

- [Como jogar Blackjack: regras e glossário de termos](https://blog.bodog.com/guia-basica-blackjack/)
- [Função para embaralhar](https://wiki.haskell.org/Random_shuffle)
- [Repositório BlackJack 2021](https://github.com/UnBParadigmas2021-2/2021.2_G5_Funcional_Blackjack)
