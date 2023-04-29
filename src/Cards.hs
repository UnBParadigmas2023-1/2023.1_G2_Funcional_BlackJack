module Cards (deck, shuffle, printHand) where
import System.Random
import Data.Array.IO
import Control.Monad

suits :: [[Char]]
suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
values :: [Char]
values = ['2'..'9'] ++ ['A', 'J', 'Q', 'K', 'X']

deck :: [([Char], Char)]
deck = [(x, y) | x <- suits, y <- values]


-- Fonte: Haskell. Random shuffle. Disponível em: 
-- <https://wiki.haskell.org/Random_shuffle>. Acessado em 29 de abril de 2023.
shuffle :: [a] -> IO [a]
shuffle xs = do
        ar <- newArray n xs
        forM [1..n] $ \i -> do
            j <- randomRIO (i,n)
            vi <- readArray ar i
            vj <- readArray ar j
            writeArray ar j vi
            return vj
  where
    n = length xs
    newArray :: Int -> [a] -> IO (IOArray Int a)
    newArray n xs =  newListArray (1,n) xs

-- Arte baseada no site
-- Fonte: Ascii. CARDS - ASCII ART. Disponível em:
-- <https://ascii.co.uk/art/cards>. Acessado em 29 de abril de 2023
-- Exemplo de uso da função: putStrLn $ (printHand[("Hearts", '2'), ("Diamonds", '7')])

printHand :: [([Char], Char)] -> String
printHand [] = ""
printHand (h:t)
    | suit == "Hearts" =  ".------.\n\
                          \|" ++ [(snd h)] ++ "_  _ |\n\
                          \|( \\/ )|\n\
                          \| \\  / |\n\
                          \|  \\/ " ++ [(snd h)] ++"|\n\
                          \`------´\n" ++ (printHand t)
    | suit == "Diamonds" =  ".------.\n\
                            \|" ++ [(snd h)] ++ " /\\  |\n\
                            \| /  \\ |\n\
                            \| \\  / |\n\
                            \|  \\/ " ++ [(snd h)] ++"|\n\
                            \`------´\n" ++ (printHand t)
    | suit == "Clubs" =  ".------.\n\
                        \|" ++ [(snd h)] ++ " _   |\n\
                        \| ( )  |\n\
                        \|(_x_) |\n\
                        \|  Y  " ++ [(snd h)] ++"|\n\
                        \`------´\n" ++ (printHand t)
    | suit == "Spades" =  ".------.\n\
                          \|" ++ [(snd h)] ++ " .   |\n\
                          \| / \\  |\n\
                          \|(_,_) |\n\
                          \|  I  " ++ [(snd h)] ++ "|\n\
                          \`------'\n" ++ (printHand t)
    where suit = fst h