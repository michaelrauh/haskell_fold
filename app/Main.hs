module Main where

import Common

import Data.List
import Control.Monad
import Fold2
import Fold3

main :: IO ()
main = do
  contents <- getContents
  let wordList = words contents
  let answer2 = execute2 wordList
  let answer3 = execute3 wordList answer2
  putStrLn "2x2 results:"
  putStr $ produceResult answer2
  putStrLn "3x2 results:"
  putStr $ produceResult3 answer3
