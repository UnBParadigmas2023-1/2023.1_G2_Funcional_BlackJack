-- Modulos do G2
import Cards
-- Modulos do Haskell
import Control.Monad
import Data.Char
import Data.Typeable
import Menu
import System.Exit
import System.IO
import System.Random

main :: IO ()
main = do
  putStrLn "Bem-vindo ao BlackJack\n"
  mainMenu 2000
