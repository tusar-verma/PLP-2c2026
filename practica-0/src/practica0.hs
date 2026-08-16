module Practica0 where

-- ######### ejercicio 1 #########

-- :t null
-- null :: Foldable t => t a -> Bool
--  Devuelve True si la estructura no tiene elementos.

-- :t head
-- <interactive>:1:1: warning: [GHC-63394] [-Wx-partial]
--     In the use of `head'
--     (imported from Prelude, but defined in GHC.Internal.List):
--     "This is a partial function, it throws an error on empty lists. Use pattern matching, 'Data.List.uncons' or 'Data.Maybe.listToMaybe' instead. Consider refactoring to use "Data.List.NonEmpty"."
-- devuelve el primer elemento de una lista, si la lista es vacía devuelve un error

-- :t tail
-- <interactive>:1:1: warning: [GHC-63394] [-Wx-partial]
--     In the use of `tail'
--     (imported from Prelude, but defined in GHC.Internal.List):
--     "This is a partial function, it throws an error on empty lists. Replace it with 'drop' 1, or use pattern matching or 'GHC.Internal.Data.List.uncons' instead. Consider refactoring to use "Data.List.NonEmpty"."
-- devuelve la lista sin el primer elemento, si la lista es vacía devuelve un error

-- :t init
-- init :: GHC.Internal.Stack.Types.HasCallStack => [a] -> [a]
-- devuelve la lista sin el último elemento, si la lista es vacía devuelve un error

-- :t last
-- last :: GHC.Internal.Stack.Types.HasCallStack => [a] -> a
-- devuelve el último elemento de una lista, si la lista es vacía devuelve un error

-- :t take
-- take :: Int -> [a] -> [a]
-- devuelve los primeros n elementos de una lista, si n es mayor que la longitud de la lista devuelve la lista completa

-- :t drop
-- drop :: Int -> [a] -> [a]
-- devuelve la lista sin los primeros n elementos, si n es mayor que la longitud de la lista devuelve una lista vacía

-- :t (++)
-- (++) :: [a] -> [a] -> [a]
-- concatena dos listas

-- :t concat
-- concat :: Foldable t => t [a] -> [a]
-- concatena una lista de listas en una sola lista

-- :t reverse
-- reverse :: [a] -> [a]
-- devuelve la lista en orden inverso

-- :t elem
-- elem :: (Foldable t, Eq a) => a -> t a -> Bool
-- verifica si un elemento está en una estructura foldable

-- ######### ejercicio 2 #########

-- ### Ejercicio a
valorAbsoluto :: Float -> Float
valorAbsoluto x
  | x >= 0 = x
  | otherwise = -x

-- ### Ejercicio cfactorial :: Int -> Int
factorial :: (Eq t, Num t) => t -> t
factorial 0 = 1
factorial n = n * factorial (n - 1)

-- ### Ejercicio d
cantDivisoresPrimos :: Int -> Int
cantDivisoresPrimos n = contarDivisoresPrimos n n

contarDivisoresPrimos :: Int -> Int -> Int
contarDivisoresPrimos _ 1 = 0
contarDivisoresPrimos n k =
  if (mod n k == 0 && esPrimo k)
    then
      1 + contarDivisoresPrimos n (k - 1)
    else
      contarDivisoresPrimos n (k - 1)

esPrimo :: Int -> Bool
esPrimo n = esPrimoAux n (n - 1)

esPrimoAux :: Int -> Int -> Bool
esPrimoAux 1 _ = False
esPrimoAux 2 _ = True
esPrimoAux _ 1 = True
esPrimoAux n k = (mod n k /= 0) && esPrimoAux n (k - 1)

-- ######### ejercicio 3 #########

-- ### Ejercicio a
inverso :: Float -> Maybe Float
inverso 0 = Nothing
inverso n = Just (1.0 / n)

-- ### Ejercicio b
aEntero :: Either Int Bool -> Int
aEntero (Right v) = if (v) then 1 else 0
aEntero (Left v) = v

-- ######### ejercicio 4 #########

-- ### Ejercicio a

limpiar :: String -> String -> String
limpiar [] y = y
limpiar (x : xs) y = limpiar xs (limpiarCaracter x y)

limpiarCaracter :: Char -> String -> String
limpiarCaracter _ [] = []
limpiarCaracter c (x : xs)
  | c == x = limpiarCaracter c xs
  | otherwise = x : (limpiarCaracter c xs)

-- ### Ejercicio b
difPromedio :: [Float] -> [Float]
difPromedio lf = map (\x -> x - promedio (lf)) lf

promedio :: [Float] -> Float
promedio lf = (sum lf) / fromIntegral (length lf)

-- ### Ejercicio c
todosIguales :: [Int] -> Bool
todosIguales [] = True
todosIguales [_] = True
todosIguales (x1 : x2 : xs) = x1 == x2 && todosIguales (xs)

-- ######### ejercicio 5 #########
data AB a = Nil | Bin (AB a) a (AB a)
  deriving (Show, Eq)

-- ### Ejercicio a
vacioAB :: AB a -> Bool
vacioAB Nil = True
vacioAB (Bin _ _ _) = False

-- ### Ejercicio b
negacionAB :: AB Bool -> AB Bool
negacionAB Nil = Nil
negacionAB (Bin a b c) = Bin (negacionAB a) (not b) (negacionAB c)

-- ### Ejercicio c
productoAB :: AB Int -> Int
productoAB Nil = 0
productoAB (Bin a b c)
  | a /= Nil && c /= Nil = productoAB a * b * productoAB c
  | c == Nil && a /= Nil = productoAB a * b
  | c /= Nil && a == Nil = productoAB c * b
  | otherwise = b