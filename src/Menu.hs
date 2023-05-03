-- module Menu (startGameMenu, inGameMenu, mainMenu) where
module Menu (mainMenu, isMoneyEnough, startGameMenu, inGameMenu) where

import Cards
import Control.Monad
import Data.Array.IO

isMoneyEnough :: Int -> Int -> Bool
isMoneyEnough money minValue
  | money <= minValue = False
  | otherwise = True

mainMenu :: Int -> IO ()
mainMenu money = do
  putStrLn "Menu Principal: "
  putStrLn "1 - Iniciar partida"
  putStrLn "2 - Fechar\n"
  option <- getLine
  case option of
    "1" -> startGameMenu money
    "2" -> putStrLn "Finalizando...\n"

startGameMenu :: Int -> IO ()
startGameMenu money = do
  putStrLn $ "Seu dinheiro: $ " ++ show money
  putStrLn "\nEscolha sua acao: "
  putStrLn "1 - Apostar 10"
  putStrLn "2 - Apostar 50"
  putStrLn "3 - Apostar 100"
  putStrLn "4 - Apostar 250"
  putStrLn "5 - Apostar 500"
  putStrLn "6 - Voltar para o menu principal"

  option <- getLine
  deckShuffled <- shuffle deck
  let playerHand = head deckShuffled : [deckShuffled !! 1]
  let dealerHand = [deckShuffled !! 2]
  let _deckShuffled = drop 3 deckShuffled
  case option of
    "1" -> do
      if isMoneyEnough money 10
        then do 
          putStrLn $ "Apostando: " ++ show 10
          inGameMenu 10 (money -10) playerHand dealerHand _deckShuffled
        else do
          putStrLn "Dinheiro insuficiente para a aposta minima. Você QUEBROU!"
          putStrLn "\n\n\nIniciando nova partida... \n\n\n\nSelecione o que deseja fazer:\n"
          mainMenu 2000
    "2" -> do
      if isMoneyEnough money 50
        then do
          putStrLn $ "Apostando: " ++ show 50
          inGameMenu 50 (money -50) playerHand dealerHand _deckShuffled
        else do
          putStrLn "\n\n\n\n\nDinheiro insuficiente. Escolha uma aposta de menor valor:"
          startGameMenu money
    "3" -> do
      if isMoneyEnough money 100
        then do
          putStrLn $ "Apostando: " ++ show 100
          inGameMenu 100 (money -100) playerHand dealerHand _deckShuffled
        else do
          putStrLn "\n\n\n\n\nDinheiro insuficiente. Escolha uma aposta de menor valor:"
          startGameMenu money
    "4" -> do
      if isMoneyEnough money 250
        then do
          putStrLn $ "Apostando: " ++ show 250
          inGameMenu 250 (money -250) playerHand dealerHand _deckShuffled
        else do
          putStrLn "\n\n\n\n\nDinheiro insuficiente. Escolha uma aposta de menor valor:"
          startGameMenu money
    "5" -> do
      if isMoneyEnough money 500
        then do
          putStrLn $ "Apostando: " ++ show 500
          inGameMenu 500 (money -500) playerHand dealerHand _deckShuffled
        else do
          putStrLn "\n\n\n\n\nDinheiro insuficiente. Escolha uma aposta de menor valor:"
          startGameMenu money
          
    "6" -> do
      putStrLn ("escolheu 6")
      mainMenu 2000


-- exemplo de passagem de parametros da funcao abaixo:
-- inGameMenu 5 2000 [("Hearts", '2'), ("Diamonds", '7')] [("Hearts", '4'), ("Diamonds", '5')] [("Hearts", 'X'), ("Diamonds", 'X')]
inGameMenu :: Int -> Int -> [([Char], Char)] -> [([Char], Char)] -> [([Char], Char)] -> IO ()
-- Esses parametros são passdos no momento em que ela eh chamada pela primeira vez
-- na função startGameMenu
inGameMenu bet totalMoney playerHand dealerHand deckShuffled = do
  putStrLn $ "\nSua mão:\n" -- implementar: ++ (printHand playerHand)
  putStrLn $ "Mão do dealer:\n" -- implementar: ++ (printHand dealerHand)

  -- inserir aqui <FUNÇAO QUE COMPARA SE PASSOU DE 21>
  putStrLn $ "Seu dinheiro: $ " -- implementar: ++ show totalMoney
  putStrLn $ "\n----------------------------------------\n" ++ "Escolha sua acao: "
  putStrLn "1 - Dobrar aposta"
  putStrLn "2 - Comprar carta"
  putStrLn "3 - Fechar mao\n"
  option <- getLine

  case option of
    "1" -> do
      putStrLn "Clicou 1... \n"
      inGameMenu bet totalMoney playerHand dealerHand deckShuffled
    "2" -> do
      putStrLn "Clicou 2... \n"
      inGameMenu bet totalMoney playerHand dealerHand deckShuffled
    "3" -> do
      putStrLn "Fechando mao...\n"

      inGameMenu bet totalMoney playerHand dealerHand deckShuffled