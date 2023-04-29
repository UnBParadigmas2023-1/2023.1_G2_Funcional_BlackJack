import Cards
import Control.Monad
import Data.Char
import Data.Typeable
import System.Exit
import System.IO
import System.Random

main :: IO ()
main = do
  putStrLn "Bem-vindo ao BlackJack\n"
  mainMenu 2000

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