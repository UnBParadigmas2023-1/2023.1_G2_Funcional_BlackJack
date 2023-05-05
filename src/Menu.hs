-- module Menu (startGameMenu, inGameMenu, mainMenu) where
module Menu (mainMenu, isMoneyEnough, startGameMenu, inGameMenu) where

import Cards
import Control.Monad
import Data.Array.IO
import Data.Char (digitToInt, ord)
import Utils
import Utils (getHandValue, isMoneyEnough)

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
  -- Caso de SPLIT:
  -- let playerHand = ("Hearts", '2') : [("Clubs", '2')]
  let dealerHand = [deckShuffled !! 2]
  let _deckShuffled = drop 3 deckShuffled
  let playerHandValue = getHandValue playerHand
  let dealerHandValue = getHandValue dealerHand
  case option of
    "1" -> do
      if isMoneyEnough money 10
        then do
          putStrLn $ "Apostando: " ++ show 10
          inGameMenu 10 money playerHand dealerHand _deckShuffled playerHandValue dealerHandValue True
        else do
          putStrLn "\n\n\nDinheiro insuficiente para a aposta minima. Você QUEBROU!"
          putStrLn "\n\n\nIniciando nova partida... \n\n\n\nSelecione o que deseja fazer:\n"
          mainMenu 2000
    "2" -> do
      if isMoneyEnough money 50
        then do
          putStrLn $ "Apostando: " ++ show 50
          inGameMenu 50 money playerHand dealerHand _deckShuffled playerHandValue dealerHandValue True
        else do
          putStrLn "\n\n\n\n\nDinheiro insuficiente. Escolha uma aposta de menor valor:"
          startGameMenu money
    "3" -> do
      if isMoneyEnough money 100
        then do
          putStrLn $ "Apostando: " ++ show 100
          inGameMenu 100 money playerHand dealerHand _deckShuffled playerHandValue dealerHandValue True
        else do
          putStrLn "\n\n\n\n\nDinheiro insuficiente. Escolha uma aposta de menor valor:"
          startGameMenu money
    "4" -> do
      if isMoneyEnough money 250
        then do
          putStrLn $ "Apostando: " ++ show 250
          inGameMenu 250 money playerHand dealerHand _deckShuffled playerHandValue dealerHandValue True
        else do
          putStrLn "\n\n\n\n\nDinheiro insuficiente. Escolha uma aposta de menor valor:"
          startGameMenu money
    "5" -> do
      if isMoneyEnough money 500
        then do
          putStrLn $ "Apostando: " ++ show 500
          inGameMenu 500 money playerHand dealerHand _deckShuffled playerHandValue dealerHandValue True
        else do
          putStrLn "\n\n\n\n\nDinheiro insuficiente. Escolha uma aposta de menor valor:"
          startGameMenu money
    "6" -> do
      putStrLn "Voltando..."
      mainMenu 2000

-- exemplo de passagem de parametros da funcao abaixo:
-- inGameMenu 5 2000 [("Hearts", '2'), ("Diamonds", '7')] [("Hearts", '4'), ("Diamonds", '5')] [("Hearts", 'X'), ("Diamonds", 'X')]
inGameMenu :: Int -> Int -> [([Char], Char)] -> [([Char], Char)] -> [([Char], Char)] -> Int -> Int -> Bool -> IO ()
-- Esses parametros são passdos no momento em que ela eh chamada pela primeira vez
-- na função startGameMenu
inGameMenu bet totalMoney playerHand dealerHand deckShuffled playerHandValue dealerHandValue playerWantsSplit
  | playerHandValue > 21 = do
    money <- endsGame bet totalMoney playerHand deckShuffled dealerHand playerHandValue dealerHandValue
    startGameMenu money
  | length playerHand == 2 && verifySplitPossibility playerHand && playerWantsSplit = do
    putStrLn $ "\nSua mão:\n" ++ printHand playerHand
    putStrLn $ "\nMão do dealer:\n" ++ printHand dealerHand
    putStrLn "Você recebeu cartas iguais! Deseja dobrar a aposta e jogar duas mãos simultaneamente? (s/n)\n"
    decisao <- getLine
    let splitBet = 2 * bet
    if decisao == "s" && isMoneyEnough totalMoney splitBet
      then do
        putStrLn "SPLIT!!\n"
        putStrLn "Mão 1:\n"
        let playerHand1 = [head playerHand]
        new_playerHand1 <- handCicle playerHand1 "0" deckShuffled
        let playerHand1Value = getHandValue new_playerHand1
        let playerHand2 = tail playerHand
        let _deckShuffled = drop 5 deckShuffled
        putStrLn "Mão 2:\n"
        new_playerHand2 <- handCicle playerHand2 "0" _deckShuffled
        let playerHand2Value = getHandValue new_playerHand2
        putStrLn $ "\nSua mão 1:\n" ++ printHand new_playerHand1
        putStrLn $ "\nSua mão 2:\n" ++ printHand new_playerHand2
        let __deckShuffled = drop 5 deckShuffled
        let dealerValue = getHandValue dealerHand
        let dealerHandAfter = buyDealerCards dealerHand __deckShuffled dealerValue
        let dealerHandValue = getHandValue dealerHandAfter
        putStrLn $ "\nMão do dealer:\n" ++ printHand dealerHandAfter
        money <- endsGame bet totalMoney new_playerHand1 __deckShuffled dealerHandAfter playerHand1Value dealerHandValue
        finalMoneySplit <- endsGame bet money new_playerHand2 __deckShuffled dealerHandAfter playerHand2Value dealerHandValue
        startGameMenu finalMoneySplit
      else do
        inGameMenu bet totalMoney playerHand dealerHand deckShuffled playerHandValue dealerHandValue False
  | otherwise = do
    putStrLn $ "\nSua mão:\n" ++ printHand playerHand
    putStrLn $ "\nMão do dealer:\n" ++ printHand dealerHand
    putStrLn
      ".------.\n\
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
            let new_playerHand = head deckShuffled : playerHand
            let new_playerHandValue = getHandValue new_playerHand
            let new_deckShuffled = drop 1 deckShuffled
            money <- endsGame new_bet totalMoney new_playerHand new_deckShuffled dealerHand new_playerHandValue dealerHandValue
            startGameMenu money
          else do
            putStrLn "\n\n\n\n\nDinheiro insuficiente. Você não pode dobrar sua aposta"
            inGameMenu bet totalMoney playerHand dealerHand deckShuffled playerHandValue dealerHandValue False
      "2" -> do
        let new_playerHand = head deckShuffled : playerHand
        let new_playerHandValue = getHandValue new_playerHand
        let new_deckShuffled = drop 1 deckShuffled
        inGameMenu bet totalMoney new_playerHand dealerHand new_deckShuffled new_playerHandValue dealerHandValue False
      "3" -> do
        putStrLn "Fechando mao...\n"
        money <- endsGame bet totalMoney playerHand deckShuffled dealerHand playerHandValue dealerHandValue
        startGameMenu money

endsGame :: Int -> Int -> [([Char], Char)] -> [([Char], Char)] -> [([Char], Char)] -> Int -> Int -> IO Int
endsGame bet totalMoney playerHand deckShuffled dealerHand playerHandValue dealerHandValue
  | playerHandValue > 21 = do
    printHands playerHand dealerHand playerHandValue dealerHandValue
    putStrLn "ESTOROU!!! \n"
    putStrLn "Dealer vence!\n"
    let new_money = totalMoney - bet
    return new_money
  | dealerHandValue > 21 = do
    printHands playerHand dealerHand playerHandValue dealerHandValue
    putStrLn "DEALER ESTOROU! \n"
    putStrLn "Você vence!\n"
    let new_money = totalMoney + bet
    return new_money
  | length dealerHand >= 2 && dealerHandValue > playerHandValue = do
    printHands playerHand dealerHand playerHandValue dealerHandValue
    putStrLn "Dealer vence!\n"
    let new_money = totalMoney - bet
    return new_money
  | length dealerHand >= 2 && dealerHandValue < playerHandValue = do
    printHands playerHand dealerHand playerHandValue dealerHandValue
    putStrLn "Você vence!\n"
    let new_money = totalMoney + bet
    return new_money
  | length dealerHand >= 2 && dealerHandValue == playerHandValue = do
    printHands playerHand dealerHand playerHandValue dealerHandValue
    putStrLn "Vocês empataram\n"
    putStrLn "Push!"
    let new_money = totalMoney
    return new_money
  | otherwise = do
    let dealerHandValueBeforeBuy = getHandValue dealerHand
    let new_dealerHand = buyDealerCards dealerHand deckShuffled dealerHandValueBeforeBuy
    let dealerHandValueAfterBuy = getHandValue new_dealerHand
    endsGame bet totalMoney playerHand deckShuffled new_dealerHand playerHandValue dealerHandValueAfterBuy

handCicle :: [([Char], Char)] -> [Char] -> [([Char], Char)] -> IO [([Char], Char)]
handCicle playerHand flag deckShuffled
  | flag == "2" = return playerHand
  | getHandValue playerHand > 21 = do
    putStrLn $ "\nSua mão:\n" ++ printHand playerHand
    putStrLn "\nSua mão ESTOROU!!\n"
    return playerHand
  | otherwise = do
    let palyerHandValue = getHandValue playerHand
    putStrLn $ "\nSua mão:\n" ++ printHand playerHand
    putStrLn $ "\nValor da sua mão:\n" ++ show palyerHandValue
    putStrLn $ "\n----------------------------------------\n" ++ "Escolha sua acao: "
    putStrLn "1 - Comprar carta"
    putStrLn "2 - Fechar Mão"
    option <- getLine
    case option of
      "1" -> do
        let new_playerHand = head deckShuffled : playerHand
        let new_deckShuffled = drop 1 deckShuffled
        handCicle new_playerHand option new_deckShuffled
      "2" -> do
        handCicle playerHand option deckShuffled
