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

-- # Ejercicio 2

-- ## i

curry :: ((a, b) -> c) -> a -> b -> c
curry f x y = f (x, y)

-- ii

uncurry :: (a -> b -> c) -> (a, b) -> c
uncurry f (x, y) = f x y

-- iii

-- creo que haria falta usar recursion para que funcione con cualquier n.

-- # Ejercicio 3

{-
Basicamente lazy evaluation para listaDesde

takeHastaMultiploDe10 (listaDesde 29)
takeHastaMultiploDe10 (29 : listaDesde (29+1))          -- Ahora se hace pattern matching con (x:xs) de takeHastaMultiploDe10
if esMultiploDe10 29 then [] else 29 : (takeHastaMultiploDe10 (listaDesde (29+1)))   -- Se evalua el if (condicion es falsa)
29 : (takeHastaMultiploDe10 (listaDesde (29+1)))        -- nuevamente se evalua el listar desde
29 : (takeHastaMultiploDe10 (30 : listaDesde (30+1)))   -- y nuevamente se hace pattern matching con el caso (x:xs)
29 : (if esMultiploDe10 30 then [] else 30 : (takeHastaMultiploDe10 (listaDesde (30+1))))     -- Ahora se toma la rama true
29 : []
[29]
-}

-- # Ejercicio 4

paresDeNat :: [(Int, Int)]
paresDeNat = [(x, y) | x <- [0 ..], y <- [0 .. x]]

-- # Ejercicio 5

{-
pitagóricas :: [(Integer, Integer, Integer)]
pitagóricas = [(a, b, c) | a <- [1..], b <-[1..], c <- [1..], a^2 + b^2 == c^2]
Esta definicion no es util ya que solo se recorrera un valor de a y b (el 1) e infinitos para el c. Por lo que el recorrido
no encontrará las triplas pitagoricas.
[(1,1,1),(1,1,2),(1,1,3),(1,1,4),(1,1,5)...]

Se esta rompiendo la primer regla de usar un solo generador infinito.
-}

pitagóricas :: [(Integer, Integer, Integer)]
pitagóricas = [(a, b, c) | c <- [1 ..], b <- [1 .. c], a <- [1 .. b], a ^ (2 :: Int) + b ^ (2 :: Int) == c ^ (2 :: Int)]

{-
Notar que hay un solo generador infinito y corresponde a c. Luego a y b toman valores menores que c, ya que se tiene
la restriccion de que a^+ b^2 = c^2 que implica que c >= b >= a
-}

-- # Ejercicio 6

-- Idea: recorremos los numeros de 1 a n (sea x el indice del recorrido). Por cada valor de x armo listas que sumen (n-x),
-- luego agrego x y dicho conjunto de listas pasan a sumar n. Asi para cada valor de x.

listasQueSuman :: Int -> [[Int]]
listasQueSuman 0 = [[]]
listasQueSuman n = agregarListasSuman n n

agregarListasSuman :: Int -> Int -> [[Int]]
agregarListasSuman _ 0 = []
agregarListasSuman n x = map (\y -> x : y) (listasQueSuman (n - x)) ++ agregarListasSuman n (x - 1)

listasQueSuman' :: Int -> [[Int]]
listasQueSuman' 0 = [[]]
listasQueSuman' n = [x : xs | x <- [1 .. n], xs <- listasQueSuman' (n - x)]

-- Por ultimo no es recursion estructural al no estar haciendo recursión sobre la estructura de la lista. Se hace sobre los enteros n y x.

-- # Ejercicio 7

listaInfinitaDeListas :: [[Int]]
listaInfinitaDeListas = juntarTodasLasListas 0

juntarTodasLasListas :: Int -> [[Int]]
juntarTodasLasListas n = listasQueSuman n ++ juntarTodasLasListas (n + 1)

{-
concatMap :: Foldable t => (a -> [b]) -> t a -> [b]

Aplica cierta funcion a cada elemento de la lista y concatena los resultados (dicha función devuelve una lista.
Por lo que se concatena cada lista generada por la función evaluada en cada elemento).
-}
listaInfinitaDeListas' :: [[Int]]
listaInfinitaDeListas' = concatMap listasQueSuman [1 ..]