module FoldHorizontal
    ( executeHorizontal
    ) where

import Common
import Data.List
import qualified Data.Matrix as M
import MatrixTools
import Control.Monad

type MatrixPair = (Matrix, Matrix)
type Matrix = M.Matrix String

executeHorizontal :: [String] -> [Matrix] -> [Matrix]
executeHorizontal wordList inputMatrices =
  let width = M.ncols $ head inputMatrices
      phraseMap = buildPhraseMap wordList width
      possiblePairs = liftM2 (,) inputMatrices inputMatrices
      answers = filterPairs possiblePairs phraseMap
      final = map combineMatrixPair answers
  in nub final

filterPairs matrixPairs phraseMap =
  let candidates = filter filterCandidates matrixPairs
  in  filter (filterFoldable phraseMap) candidates

filterCandidates :: MatrixPair -> Bool
filterCandidates (left, right) =
  let overlapLeft = removeLeftColumn left
      overlapRight = removeRightColumn right
      topRight = getTopRight right
      bottomLeft = getBottomLeft left
  in topRight /= bottomLeft && overlapLeft == overlapRight

filterFoldable phraseMap (left, right) =
  let nextWords' = nextWords phraseMap
      froms = getRows left
      possibilities = mapM nextWords' froms
      targetWords = getRightColumnList right
      correspondences = zip targetWords possibilities
      answers = map wordInList correspondences
  in (length answers == M.ncols left) && and answers

wordInList :: (String, [String]) -> Bool
wordInList (target, possibilities) = target `elem` possibilities

combineMatrixPair :: MatrixPair -> Matrix
combineMatrixPair (left, right) = left M.<|> getRightColumn right
