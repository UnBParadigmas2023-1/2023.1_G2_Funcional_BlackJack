-- module Menu (startGameMenu, inGameMenu, mainMenu) where
module Menu (mainMenu, isMoneyEnough, startGameMenu, inGameMenu) where

import Cards
import Control.Monad
import Data.Array.IO
import Data.Char (digitToInt, ord)
import Utils

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
  let playerHandValue = getHandValue playerHand
  let dealerHandValue = getHandValue dealerHand
  case option of
    "1" -> do
      if isMoneyEnough money 10
        then do
          putStrLn $ "Apostando: " ++ show 10
          inGameMenu 10 money playerHand dealerHand _deckShuffled playerHandValue dealerHandValue
        else do
          putStrLn "\n\n\nDinheiro insuficiente para a aposta minima. Você QUEBROU!"
          putStrLn "\n\n\nIniciando nova partida... \n\n\n\nSelecione o que deseja fazer:\n"
          mainMenu 2000
    "2" -> do
      if isMoneyEnough money 50
        then do
          putStrLn $ "Apostando: " ++ show 50
          inGameMenu 50 money playerHand dealerHand _deckShuffled playerHandValue dealerHandValue
        else do
          putStrLn "\n\n\n\n\nDinheiro insuficiente. Escolha uma aposta de menor valor:"
          startGameMenu money
    "3" -> do
      if isMoneyEnough money 100
        then do
          putStrLn $ "Apostando: " ++ show 100
          inGameMenu 100 money playerHand dealerHand _deckShuffled playerHandValue dealerHandValue
        else do
          putStrLn "\n\n\n\n\nDinheiro insuficiente. Escolha uma aposta de menor valor:"
          startGameMenu money
    "4" -> do
      if isMoneyEnough money 250
        then do
          putStrLn $ "Apostando: " ++ show 250
          inGameMenu 250 money playerHand dealerHand _deckShuffled playerHandValue dealerHandValue
        else do
          putStrLn "\n\n\n\n\nDinheiro insuficiente. Escolha uma aposta de menor valor:"
          startGameMenu money
    "5" -> do
      if isMoneyEnough money 500
        then do
          putStrLn $ "Apostando: " ++ show 500
          inGameMenu 500 money playerHand dealerHand _deckShuffled playerHandValue dealerHandValue
        else do
          putStrLn "\n\n\n\n\nDinheiro insuficiente. Escolha uma aposta de menor valor:"
          startGameMenu money
    "6" -> do
      putStrLn "Voltando..."
      mainMenu 2000

-- exemplo de passagem de parametros da funcao abaixo:
-- inGameMenu 5 2000 [("Hearts", '2'), ("Diamonds", '7')] [("Hearts", '4'), ("Diamonds", '5')] [("Hearts", 'X'), ("Diamonds", 'X')] 9 20
inGameMenu :: Int -> Int -> [([Char], Char)] -> [([Char], Char)] -> [([Char], Char)] -> Int -> Int -> IO ()
-- Esses parametros são passdos no momento em que ela eh chamada pela primeira vez
-- na função startGameMenu
inGameMenu bet totalMoney playerHand dealerHand deckShuffled playerHandValue dealerHandValue
  | playerHandValue > 21 = endsGame bet totalMoney playerHand deckShuffled dealerHand playerHandValue dealerHandValue
  | otherwise = do
    putStrLn $ "\nSua mão:\n" ++ printHand playerHand
    putStrLn $ "\nMão do dealer:\n" ++ printHand dealerHand
    putStrLn ".------.\n\
            \|      |\n\
            \|      |\n\
            \|      |\n\
            \|      |\n\
            \`------'\n"
    putStrLn $ "Valor da sua mão: " ++ show playerHandValue
    putStrLn $ "Valor da mão do dealer: " ++ show dealerHandValue

    putStrLn $ "\n\nSeu dinheiro: $ " ++ show totalMoney
    putStrLn $ "\n----------------------------------------\n" ++ "Escolha sua acao: "
    putStrLn "1 - Dobrar aposta"
    putStrLn "2 - Comprar carta"
    putStrLn "3 - Fechar mao\n"
    option <- getLine

    case option of
      "1" -> do
        let new_bet = bet * 2
        if isMoneyEnough totalMoney new_bet
          then do
            if checkEqualCards playerHand then do
              endsGame new_bet totalMoney playerHand deckShuffled dealerHand playerHandValue dealerHandValue
            else do
              let new_playerHand = head deckShuffled : playerHand
              let new_playerHandValue = getHandValue new_playerHand
              let new_deckShuffled = drop 1 deckShuffled
              endsGame new_bet totalMoney new_playerHand new_deckShuffled dealerHand new_playerHandValue dealerHandValue
          else do
            putStrLn "\n\n\n\n\nDinheiro insuficiente. Você não pode dobrar sua aposta"
            inGameMenu bet totalMoney playerHand dealerHand deckShuffled playerHandValue dealerHandValue
      "2" -> do
        let new_playerHand = head deckShuffled : playerHand
        let new_playerHandValue = getHandValue new_playerHand
        let new_deckShuffled = drop 1 deckShuffled
        inGameMenu bet totalMoney new_playerHand dealerHand new_deckShuffled new_playerHandValue dealerHandValue
      "3" -> do
        putStrLn "Fechando mao...\n"
        endsGame bet totalMoney playerHand deckShuffled dealerHand playerHandValue dealerHandValue

endsGame :: Int -> Int -> [([Char], Char)] -> [([Char], Char)] -> [([Char], Char)] -> Int -> Int -> IO ()
endsGame bet totalMoney playerHand deckShuffled dealerHand playerHandValue dealerHandValue
  | playerHandValue > 21 = do
    printHands playerHand dealerHand playerHandValue dealerHandValue
    putStrLn "ESTOROU!!! \n"
    putStrLn "Dealer vence!\n"
    let new_money = totalMoney - bet
    startGameMenu new_money
  | dealerHandValue > 21 = do
    printHands playerHand dealerHand playerHandValue dealerHandValue
    putStrLn "DEALER ESTOROU! \n"
    putStrLn "Você vence!\n"
    let new_money = totalMoney + bet
    startGameMenu new_money
  | length dealerHand >= 2 && dealerHandValue > playerHandValue = do
    printHands playerHand dealerHand playerHandValue dealerHandValue
    putStrLn "Dealer vence!\n"
    let new_money = totalMoney - bet
    startGameMenu new_money
  | length dealerHand >= 2 && dealerHandValue < playerHandValue = do
    printHands playerHand dealerHand playerHandValue dealerHandValue
    putStrLn "Você vence!\n"
    let new_money = totalMoney + bet
    startGameMenu new_money
  | length dealerHand >= 2 && dealerHandValue == playerHandValue = do
    printHands playerHand dealerHand playerHandValue dealerHandValue
    putStrLn "Vocês empataram\n"
    putStrLn "Push!"
    let new_money = totalMoney
    startGameMenu new_money
  | otherwise = do
    let dealerHandValueBeforeBuy = getHandValue dealerHand
    let new_dealerHand = buyDealerCards dealerHand deckShuffled dealerHandValueBeforeBuy
    let dealerHandValueAfterBuy = getHandValue new_dealerHand
    endsGame bet totalMoney playerHand deckShuffled new_dealerHand playerHandValue dealerHandValueAfterBuy
