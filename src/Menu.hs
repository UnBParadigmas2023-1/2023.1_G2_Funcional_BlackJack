module Menu (startGameMenu, inGameMenu, mainMenu) where

import Data.Array.IO
import Control.Monad

mainMenu :: Int -> IO ()
mainMenu money = do
  if money <= 0
    then putStrLn "Você faliu...\n"
    else do
      putStrLn "Menu Principal do Jogo: "
      putStrLn "1 - Iniciar partida"
      putStrLn "2 - Fechar\n"
      option <- getLine
      case option of
        "1" -> startGameMenu money
        "2" -> putStrLn "O jogo serah finalizado...\n"

startGameMenu :: Int -> IO ()

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