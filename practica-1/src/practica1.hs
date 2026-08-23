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

-- # Ejercicio 8

-- ## I

-- ### a

filtroPalabrasTamañoMenor5 :: [String] -> [String]
filtroPalabrasTamañoMenor5 xs = filter (\x -> length x < 5) xs

-- ### b

notasAprobadas :: [Int] -> [Bool]
notasAprobadas xs = map (\x -> x >= 6) xs

-- ### c

elementosParesAlCuadrado :: [Int] -> [Int]
elementosParesAlCuadrado xs = map (\x -> x ^ (2 :: Integer)) (filter (\x -> mod x 2 == 0) xs)

-- ## II
{-
foldr :: (a -> b -> b) -> b -> [a] -> b
foldr f z []     = z
foldr f z (x:xs) = f x (foldr f z xs)

foldl :: (b -> a -> b) -> b -> [a] -> b
foldl f v []     = v
foldl f v (x:xs) = foldl f (f v x) xs
-}

sum' :: (Num a) => [a] -> a
sum' xs = foldr (\x acc -> (x + acc)) 0 xs

elem' :: (Eq a) => [a] -> a -> Bool
elem' xs e = foldr (\x acc -> x == e || acc) False xs

plusplus :: [a] -> [a] -> [a]
plusplus xs ys = foldr (\x acc -> x : acc) ys xs

filter' :: (a -> Bool) -> [a] -> [a]
filter' f xs = foldr (\x acc -> if f x then x : acc else acc) [] xs

map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr (\x acc -> f x : acc) [] xs

-- ## III
mejorSegun :: (a -> a -> Bool) -> [a] -> a
mejorSegun _ [] = (error "Lista debe ser no vacia")
mejorSegun f (x : xs) = foldr (\a acc -> if (f a acc) then a else acc) x xs

-- ## IV

-- Solución sin foldl para ayudarme a pensar
sumasParciales' :: (Num a) => [a] -> [a]
sumasParciales' xs = sumaParcialesAux xs 0

sumaParcialesAux :: (Num a) => [a] -> a -> [a]
sumaParcialesAux [] n = [n]
sumaParcialesAux (x : xs) n = (n + x) : sumaParcialesAux xs (n + x)

sumasParciales :: (Num a) => [a] -> [a]
sumasParciales [] = [0]
sumasParciales (x : xs) = foldl (\acc y -> (acc ++ [last (acc) + y])) [x] xs

-- ## V
{-
La recursión de foldr permite hacer la suma alternada por como agrupa las operaciones

foldr f z []     = z
foldr f z (x:xs) = f x (foldr f z xs)

suponiendo A = [a,b,c,d] una lista de 4 elementos

foldr f z A = f a (foldr f z [b, c, d]) = f a (f b (foldr z [c, d])) = f a (f b (f c (foldr f z [d]))) = f a (f b (f c (f d (foldr f z []))))
            = f a (f b (f c (f d (z))))

si f :: (a -> b -> b) le pasamos la función resta y z = 0, queda

(-) a ((-) b ((-) c ((-) d (0)))) = a - (b - (c - (d - (0)))))

Desarollando esta agrupación de operaciones:

a - (b - (c - (d - (0))))) = a - (b - (c - (d)))) = a - (b - (c - d))) = a - (b - c + d)) = a - b + c - d

Este argumento se puede explicar como que: elem - (recursion), el "-" hace que se intercambien todos los signos en la (recursion)

-}

sumaAlt :: (Num a) => [a] -> a
sumaAlt = foldr (-) 0

-- o tambien:  sumaAlt xs = foldr (-) 0 xs

-- ## VI
{-

foldl f z []     = z
foldl f z (x:xs) = foldl f (f z x) xs

A = [a, b, c, d]

foldl f z [a, b, c, d] = foldl f (f z a) [b, c, d] = foldl f (f z a) [b, c, d] = foldl f (f (f z a) b) [c d] = foldl f (f (f (f z a) b) c) [d] = foldl f (f (f (f (f z a) b) c) d) []
                       = f (f (f (f z a) b) c) d

el argumento es similar pero recorremos de izq a derecha. En el ultimo paso de la recursión tenemos el ultimo elemento y la suma acumulada de la recursión.
Hacemos la operación -(recursion) + elem para invertir la suma acumulada hasta ahora y sumar el elemento actual.

Notar que cada paso recursivo hace lo mismo, por lo que efectivamente se hace una suma alternada, y como el ultimo paso suma el ultimo elemento de la lista y con signo positivo
entonces logramos hacer el ultima - anteultima + antepenultimo ...

-}

sumaAltInverso :: (Num a) => [a] -> a
sumaAltInverso xs = foldl (\acc x -> -(acc) + x) 0 xs

-- ## VII

{-
Supongo que se deben aplicar desde el ultimo elemento al primero f(g(h(x))) = [f, g, h]
-}

componerTodas :: [a -> a] -> a -> a
componerTodas xs = foldr (\x acc -> x . acc) id xs

-- # Ejercicio 9

-- ## I
{-
Permutacion se hace recursivamente: dado una lista [a,b,c...], si se tiene las permutaciones de los elementos [b,c,...]
se puede calcular las permutaciones de [a,b,c...] como agregar "a" en las permutaciones de [b,c,...]. Por cada permutación p_i de [b,c,...]
se debe insertar "a" una vez alguna posición posible para formar una de las permutaciones de [a,b,c,...]

Por ejemplo [a,b,c]

Suponiendo que se tiene las permutaciones de [b,c] = [[b,c], [c,b]]

Tomamos una de ella e insertamos "a" en cada posición posible:

- [b,c] --> [a,b,c], [b,a,c], [b,c,a]

Y asi con todas las demás permutaciones de [b,c]:

- [c,b] --> [a,c,b], [c,a,b], [c,b,a]

Y juntamos todo.

La función permutaciones se encarga de la recursion para la permutación de la lista mas pequeña (recorrido hacia derecha)
La función insertarEnPermutaciones se encarga de iniciar la recursión que inserta el elemento nuevo en las permutaciones del paso recursivo.
La función insertarEnPermutacionesAux se encarga de hacer la recursión para generar las listas de permutaciones con el elemento en cada posición posible

-}
permutaciones :: [a] -> [[a]]
permutaciones [] = [[]]
permutaciones (x : xs) = insertarEnPermutaciones x (permutaciones xs)

insertarEnPermutaciones :: a -> [[a]] -> [[a]]
insertarEnPermutaciones elemento listaPermutaciones = concatMap (\permutacion -> insertarEnPermutacionesAux elemento (length (permutacion)) permutacion) listaPermutaciones

insertarEnPermutacionesAux :: a -> Int -> [a] -> [[a]]
insertarEnPermutacionesAux elemento 0 xs = [elemento : xs]
insertarEnPermutacionesAux elemento n xs = ((take n xs) ++ (elemento : (drop n xs))) : (insertarEnPermutacionesAux elemento (n - 1) xs)

permutaciones' :: [a] -> [[a]]
permutaciones' xs = foldr (\x acc -> insertarEnPermutaciones x acc) [[]] xs

-- ## II

partes :: [a] -> [[a]]
partes xs = foldr (\x acc -> concatMap (\ys -> [ys, x : ys]) acc) [[]] xs

-- ## III

prefijos :: [a] -> [[a]]
prefijos xs = foldl (\acc x -> acc ++ [last (acc) ++ [x]]) [[]] xs

-- # Ejercicio 10

recr :: (a -> [a] -> b -> b) -> b -> [a] -> b
recr _ z [] = z
recr f z (x : xs) = f x xs (recr f z xs)

-- ## a

sacarUna :: (Eq a) => a -> [a] -> [a]
sacarUna _ [] = []
sacarUna e xs = recr (\y ys acc -> if (y == e) then ys else y : acc) [] xs

-- ## b

{-
Por que al no tener disponible ys (la lista total en el paso recursivo actual) no podemos cortar la recursión
al encontrar la primer aparición del elemento.
-}

-- ## c

-- precondición: la lista de entrada ya esta ordenada de manera creciente
insertarOrdenado :: (Ord a) => a -> [a] -> [a]
insertarOrdenado e xs = recr (\y ys acc -> if (e < y) then e : [y] ++ ys else y : acc) [e] xs

-- # Ejercicio 11

{-
Para que sea recursion estructural debe cumplir:

1. Se define por 2 ecuaciones (caso base y caso recursivo)
2. El caso base: no depende de nada (es un valor fijo)
3. El caso recursivo usa x y el resultado de la llamada recursiva y nada mas (no puede usar g ni xs sueltas).

g [] = ...
g (x:xs) = ... x ... (g xs) ...

Y recursion primitiva agrega poder usar la estructura en cada paso de la recursion.
-}

elementosEnPosicionesPares :: [a] -> [a]
elementosEnPosicionesPares [] = []
elementosEnPosicionesPares (x : xs) = if null xs then [x] else x : elementosEnPosicionesPares (tail xs)

-- En este caso no es estructural ya que el caso recursivo usa xs y no el resultado de aplicar la función en xs
-- (toma xs y se fija si no es null, ademas de usar la cola de xs)

entrelazar :: [a] -> [a] -> [a]
entrelazar [] = id
entrelazar (x : xs) = \ys ->
  if null ys
    then x : entrelazar xs []
    else x : head ys : entrelazar xs (tail ys)

{-
Es estructural (y por lo tanto tambien primitivo).
El caso base es un solo elemento. El caso recursivo se resuelve con recursion aplicada a xs (el resultado de entrelazar xs)
que en este caso es una función.
El caso recursivo entonces, usa la función recursiva devuelta por el caso recursivo en xs
-}

entrelazar' :: [a] -> [a] -> [a]
entrelazar' = foldr (\x acc -> g x acc) id
  where
    g x acc = \ys ->
      if null ys
        then x : acc []
        else x : head ys : acc (tail ys)

entrelazar'' :: [a] -> [a] -> [a]
entrelazar'' = recr f id
  where
    f x xs recursion = \ys ->
      if null ys
        then x : recursion []
        else x : head ys : recursion (tail ys)

slowSort :: (Ord a) => [a] -> [a]
slowSort [] = []
slowSort (p : xs) = slowSort menores ++ [p] ++ slowSort mayores
  where
    menores = [x | x <- xs, x <= p]
    mayores = [x | x <- xs, x > p]

{-
No es estructural ni primitivo. En el caso recursivo no se usa slowSort xs directamente, sino que se usa xs para computar otras listas
menores y mayores recursivamente. Es decir, hay 2 llamadas recursivas.

Esto no se puede representar con recursion estructural ni primivita, que hacen una sola llamada recursiva
y recorren la estructura siempre en el mismo orden.
-}

{-
La siguiente funcion es parecida pero si es estructural ya que solo hace una llamada recursiva en el caso recursivo
-}

slowSortParecido :: (Ord a) => [a] -> [a]
slowSortParecido = foldr (\e acc -> [x | x <- acc, x <= e] ++ [e] ++ [x | x <- acc, x > e]) []

sufijos :: [a] -> [[a]]
sufijos [] = [[]]
sufijos (x : xs) = (x : xs) : sufijos xs

{-
No es estructural al usar xs en el paso recursivo.
Es primitiva
-}

sufijos' :: [a] -> [[a]]
sufijos' = recr (\x xs acc -> (x : xs) : acc) [[]]

miScanr :: (a -> b -> b) -> b -> [a] -> [b]
miScanr f n [] = [n]
miScanr f n (x : xs) =
  let (y : ys) = miScanr f n xs
   in (f x y) : (y : ys)

{-
No se que hace la función pero es estructural: el caso base es un valor particular y el caso recursivo solo usa la llamada a la función recursiva en xs
-}

miScanr' :: (a -> b -> b) -> b -> [a] -> [b]
miScanr' f n =
  foldr
    ( \x acc ->
        let (y : ys) = acc
         in (f x y) : (y : ys)
    )
    [n]

-- # Ejercicio 12

-- ## I

mapPares :: (a -> b -> c) -> [(a, b)] -> [c]
mapPares f = map (\(x1, x2) -> f x1 x2)

mapPares' :: (a -> b -> c) -> [(a, b)] -> [c]
-- mapPares' f = map (\x -> Practica1.uncurry f x)
mapPares' f = map (Practica1.uncurry f)

-- ## II

armarPares :: [a] -> [b] -> [(a, b)]
armarPares _ [] = []
armarPares [] _ = []
armarPares (x : xs) (y : ys) = (x, y) : armarPares xs ys

-- ## III

mapDoble :: (a -> b -> c) -> [a] -> [b] -> [c]
mapDoble f xs ys = mapPares f (armarPares xs ys)

-- # Ejercicio 14

-- ## I

foldNat :: (Int -> b -> b) -> b -> Int -> b
foldNat _ n 0 = n
foldNat f n x = f x (foldNat f n (x - 1))

-- ## II

potencia :: Int -> Int -> Int
potencia a = foldNat (\_ acc -> a * acc) 1

-- # Ejercicio 17

data AB a = Nil | Bin (AB a) a (AB a)

-- ## I

-- ## II

-- ## III

-- ## VI

-- ## V
