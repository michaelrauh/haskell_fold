module MapBuilder
    ( buildNextWordMap,
    buildPreviousWordMap
    ) where

import Data.List
import qualified Data.Matrix as M
import qualified Data.Set as S
import qualified Data.Map.Strict as Map

buildNextWordMap :: Ord a => [a] -> Map.Map a (S.Set a)
buildNextWordMap wordList = Map.fromListWith S.union $ buildSlidingTuple wordList

buildPreviousWordMap :: Ord a => [a] -> Map.Map a (S.Set a)
buildPreviousWordMap wordList = Map.fromListWith S.union $ map reverseSingletonTuple $ buildSlidingTuple wordList

buildSlidingTuple :: [a] -> [(a, S.Set a)]
buildSlidingTuple [] = []
buildSlidingTuple [first] = []
buildSlidingTuple [first, second] = [(first, S.singleton second)]
buildSlidingTuple (first:second:rest) = (first, S.singleton second) : buildSlidingTuple (second : rest)

reverseSingletonTuple :: (a1, S.Set a2) -> (a2, S.Set a1)
reverseSingletonTuple (first, second) = (head $ S.elems second, S.singleton first)