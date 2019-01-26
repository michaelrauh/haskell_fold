import Control.Exception (evaluate)
import Test.Hspec
import Test.QuickCheck
import Fold2
import Fold3
import Fold4

main :: IO ()
main = hspec $ do
  describe "execute2" $ do
    it "folds a list of words into a formatted answer" $ do
      execute2 ["a", "b", "c", "d", "a", "c", "b", "d"] `shouldBe` [("a", "b", "d", "c")]

  describe "execute3" $ do
    it "folds 2x2 results into 3x2 results" $
      let wordList = ["a", "b", "c", "d", "e", "f", "a", "d", "b", "e", "c", "f"]
          results = [("a", "b", "e", "d"), ("b", "c", "f", "e")]
      in execute3 wordList results `shouldBe` [(("a", "b", "c"),("d", "e", "f"))]

  describe "execute4" $ do
    it "folds 3x2 results into 3x3 results" $
      let wordList = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "a", "d", "g", "b", "e", "h", "c", "f", "i"]
          results = [(("a", "b", "c"),("d", "e", "f")), (("d", "e", "f"),("g", "h", "i"))]
      in (execute4 wordList results) `shouldBe` [(("a", "b", "c"),("d", "e", "f"), ("g", "h", "i"))]
