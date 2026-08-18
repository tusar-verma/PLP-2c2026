module Main (main) where

import Practica1
import Test.HUnit

main :: IO ()
main = runTestTTAndExit allTests

allTests :: Test
allTests =
  test
    [max2 (1 :: Integer, 2 :: Integer) ~?= (2 :: Integer)]