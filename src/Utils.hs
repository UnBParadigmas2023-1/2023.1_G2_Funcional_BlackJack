module Utils where

import Cards
import Data.Char
import Data.Char (digitToInt)
import Data.List

--- Soma valor das cartas do deck
--- hand -> Cartas sem contar a primeira
--- firstCard -> Primeira carta da mao
sumCards :: [([Char], Char)] -> Int
sumCards (firstCard : hand)
  | handLength == 0 = getCardValue firstCard
  | otherwise = getCardValue firstCard + sumCards hand
  where
    handLength = length hand

--- Retorna valor da carta
getCardValue :: ([Char], Char) -> Int
getCardValue card
  | cardValue == 'J' || cardValue == 'Q' || cardValue == 'K' || cardValue == 'X' = 10
  | cardValue == 'A' = 1
  | otherwise = digitToInt cardValue
  where
    cardValue = snd card

--- Verifica se valor eh maior ou igual a 17
isOverOrEqual17 :: Int -> Bool
isOverOrEqual17 value
  | value >= 17 = True
  | otherwise = False

--- Verifica se valor eh maior que 21
isOver21 :: Int -> Bool
isOver21 value
  | value > 21 = True
  | otherwise = False

--- Verifica se valor eh igual a 21
isEqual21 :: Int -> Bool
isEqual21 value
  | value == 21 = True
  | otherwise = False

--- Verifica qual dos conjuntos de cartas possui maior valor
compareHandValues :: [([Char], Char)] -> [([Char], Char)] -> [Char]
compareHandValues handOne handTwo
  | handOneValue > handTwoValue = "handOne"
  | handOneValue < handTwoValue = "handTwo"
  | otherwise = "equal"
  where
    handOneValue = sumCards handOne
    handTwoValue = sumCards handTwo

isMoneyEnough :: Int -> Int -> Bool
isMoneyEnough money minValue
  | money < minValue = False
  | otherwise = True

buyDealerCards :: [([Char], Char)] -> [([Char], Char)] -> Int -> [([Char], Char)]
buyDealerCards dealerHand deckShuffled dealerhandValue
  | isOverOrEqual17 dealerhandValue = dealerHand
  | otherwise = do
    let new_dealerHand = head deckShuffled : dealerHand
    let new_dealerHandValue = getHandValue new_dealerHand 0
    let new_deckShuffled = drop 1 deckShuffled
    buyDealerCards new_dealerHand new_deckShuffled new_dealerHandValue

getHandValue :: [([Char], Char)] -> Int -> Int
getHandValue [] a = 0
getHandValue (h : t) currentSum
  | cardValue == 'J' || cardValue == 'Q' || cardValue == 'K' || cardValue == 'X' = 10 + getHandValue t (currentSum + 10)
  | cardValue == 'A' && 11 + currentSum + getHandValue t currentSum > 21 = 1 + getHandValue t (currentSum + 1)
  | cardValue == 'A' && 11 + currentSum + getHandValue t currentSum <= 21 = 11 + getHandValue t (currentSum + 11)
  | otherwise = digitToInt cardValue + getHandValue t (currentSum + digitToInt cardValue)
  where
    cardValue = snd h

verifySplitPossibility :: [([Char], Char)] -> Bool
verifySplitPossibility playerHand = length (nub values) < length playerHand
  where
    values = map snd playerHand

areCardsEqual :: ([Char], Char) -> ([Char], Char) -> Bool
areCardsEqual firstCard secondCard
  | firstCardValue == secondCardValue = True
  | otherwise = False
  where
    firstCardValue = snd firstCard
    secondCardValue = snd secondCard

checkEqualCards :: [([Char], Char)] -> Bool
checkEqualCards (lastCard : hand)
  | comparison = True
  | otherwise = False
  where
    penultCard = last hand
    comparison = areCardsEqual lastCard penultCard

printHands :: [([Char], Char)] -> [([Char], Char)] -> Int -> Int -> IO ()
printHands playerHand dealerHand playerHandValue dealerHandValue = do
  putStrLn $ "\nSua mão:\n" ++ printHand playerHand
  putStrLn $ "Mão do dealer:\n" ++ printHand dealerHand
  putStrLn $ "Valor da sua mão: " ++ show playerHandValue
  putStrLn $ "Valor da mão do dealer: " ++ show dealerHandValue
