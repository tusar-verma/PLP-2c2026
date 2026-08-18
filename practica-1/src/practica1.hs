module Practica1 where

import Prelude hiding (subtract)

-- # Ejercicio1

-- ## a
max2 :: (Float, Float) -> Float
max2 (x, y)
  | x >= y = x
  | otherwise = y

-- No esta curryficada

max2curry :: Float -> Float -> Float
max2curry x y = max2 (x, y)

-- ## b

normaVectorial :: (Float, Float) -> Float
normaVectorial (x, y) = sqrt (x ** 2 + y ** 2)

--  No esta curryficado

normaVectorialCurry :: Float -> Float -> Float
normaVectorialCurry x y = normaVectorial (x, y)

-- ## c
subtract :: Float -> Float -> Float
subtract = flip (-)

-- flip invierte el orden de los operadores: flip f x y = f y x
-- flip (-) es la resta con el minuendo y substraendo invertidos: flip (-) x y = (-) y x
-- por lo tanto el tipo de subtract es el mismo tipo que (-) (y se asume que los numeros son float)

-- y ya esta curryficado al no recibir los argumentos de forma secuencial y no como tuplas.

-- ## d

predecesor :: Float -> Float
predecesor = subtract 1

-- ya esta currificado

-- ## e
evaluarEnCero :: (Float -> t) -> t
evaluarEnCero = \f -> f 0

-- Ya esta currificada
-- El tipo se infiere de la función lambda, que recibe una función y devuelve el resultado
-- de evaluar dicha función en 0. Como no conocemos la función f, podemos decir que devuelve un tipo generico.

-- ## f

dosVeces :: (a -> a) -> a -> a -- que es lo mismo que (a -> a) -> (a -> a)
dosVeces = \f -> f . f

-- esto ya esta curryficado al recibir un solo argumento y no una tupla.

-- ## g

flipAll :: [a -> b -> c] -> [b -> a -> c]
flipAll = map flip

{-
ghci> :t flip
flip :: (a1 -> b1 -> c1) -> b1 -> a1 -> c1
ghci> :t map
map :: (a2 -> b2) -> [a2] -> [b2]

flip entonces recibe una funcion (a1 -> b1 -> c1) y devuelve otra (b1 -> a1 -> c1)
Ambos se reemplazan en a2 y b2 respectivamente para obtener el tipado de flipAll

Ya se encuentra curryficada y la funcion recibe una lista de funciones binarias (2 argumentos entrada)
y devueve la lista de funciones con sus argumentos invertidos.
-}
-- ## h

flipRaro :: b -> (a -> b -> c) -> (a -> c)
flipRaro = flip flip

{-
flip :: (a -> b -> c) -> b -> a -> c
flip :: (a -> b -> c) -> b -> (a -> c)
flip f x y = f y x

flip1 flip2 x y z = flip2 y x z = y z x
-}


