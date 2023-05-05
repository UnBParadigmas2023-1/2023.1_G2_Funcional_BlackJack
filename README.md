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

Agora, para rodar, acesse a pasta src/, carregue o arquivo game.hs pelo ghci, e execute a função *main*:

```
cd src/
ghci
Prelude> :l game.hs
*Main> main
```

## Uso

Explique como usar seu projeto, caso haja algum passo a passo após o comando de execução.

## Vídeo

Adicione 1 ou mais vídeos com a execução do projeto.

## Outros

Quaisquer outras informações sobre seu projeto podem ser descritas a seguir.

## Fontes

- [Como jogar Blackjack: regras e glossário de termos](https://blog.bodog.com/guia-basica-blackjack/)
- [Função para embaralhar](https://wiki.haskell.org/Random_shuffle)
