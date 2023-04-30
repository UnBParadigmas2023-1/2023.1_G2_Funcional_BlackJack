module Menu (startGameMenu, inGameMenu) where

import Data.Array.IO
import Control.Monad

startGameMenu :: Int -> IO ()

inGameMenu :: Int -> Int -> [([Char], Char)] -> [([Char], Char)] -> [([Char], Char)] -> IO ()
