module FoldSquareSpec (spec) where

import Control.Exception (evaluate)
import Test.Hspec
import Test.QuickCheck

import Data.List
import qualified Data.Matrix as M
import qualified Data.Set as S
import qualified Data.Map.Strict as Map
import FoldSquare

{-# ANN module "HLint: ignore Redundant do" #-}

spec :: Spec
spec = do
  describe "fold square" $ do
    it "folds a list of words into a square dropping transpose and obvious squares" $ do
      let wordList = ["a", "b", "c", "d", "a", "c", "b", "d"]
          uniqueWords = ["a", "b", "c", "d"]
          firstResult = M.fromList 2 2 ["a","b","c","d"]
          expected = [firstResult]
      foldSquare wordList uniqueWords `shouldBe` expected