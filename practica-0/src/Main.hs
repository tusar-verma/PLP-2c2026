module Main (main) where

import Practica0
import Test.HUnit

main :: IO ()
main = runTestTTAndExit allTests

allTests :: Test
allTests =
  test
    [ valorAbsoluto 5 ~?= 5,
      valorAbsoluto (-3) ~?= 3,
      cantDivisoresPrimos 6 ~?= 2,
      vacioAB (Bin (Bin (Nil) False (Nil)) True (Bin (Bin (Nil) False (Nil)) True (Nil))) ~?= True,
      productoAB (Bin (Bin (Nil) 3 (Nil)) 2 (Bin (Bin (Nil) 1 (Nil)) 5 (Nil))) ~?= 30
    ]