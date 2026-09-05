module TP1 where

data Caja = Bombilla Bool | Nada
  deriving (Eq)

instance Show Caja where
  show = showDeCaja

showDeCaja :: Caja -> String
showDeCaja (Bombilla True) = "💡"
showDeCaja (Bombilla False) = "⚪️"
showDeCaja (Nada) = "🛑"

data Circuito
  = Caja Caja
  | Serie Circuito Circuito
  | Paralelo Caja Circuito Circuito Caja
  deriving (Eq)

instance Show Circuito where
  show = showDeCircuito

showDeCircuito :: Circuito -> String
showDeCircuito (Caja caja) = showDeCaja caja
showDeCircuito (Serie circuitoInicial circuitoFinal) =
  (showDeCircuito circuitoInicial) ++ "-" ++ (showDeCircuito circuitoFinal)
showDeCircuito (Paralelo cajaEntrada circuitoIzquierdo circuitoDerecho cajaSalida) =
  (showDeCaja cajaEntrada)
    ++ "{"
    ++ (showDeCircuito circuitoIzquierdo)
    ++ "}"
    ++ "{"
    ++ (showDeCircuito circuitoDerecho)
    ++ "}"
    ++ (showDeCaja cajaSalida)

showDeCircuitoConEstructura :: Circuito -> String
showDeCircuitoConEstructura (Caja caja) = showDeCaja caja
showDeCircuitoConEstructura (Serie circuitoInicial circuitoFinal) =
  "("
    ++ (showDeCircuitoConEstructura circuitoInicial)
    ++ "-"
    ++ (showDeCircuitoConEstructura circuitoFinal)
    ++ ")"
showDeCircuitoConEstructura (Paralelo cajaEntrada circuitoIzquierdo circuitoDerecho cajaSalida) =
  (showDeCaja cajaEntrada)
    ++ "{"
    ++ (showDeCircuitoConEstructura circuitoIzquierdo)
    ++ "}"
    ++ "{"
    ++ (showDeCircuitoConEstructura circuitoDerecho)
    ++ "}"
    ++ (showDeCaja cajaSalida)

on = Bombilla True

off = Bombilla False

cajaOn = Caja on

cajaOff = Caja off

cajaNada = Caja Nada

-- 1: recCircuito

-- c1, c2, ... cn: circuito1, circuito2, ...
-- cj1, cj2, ... cjn: caja1, caja2, ...

-- Arg1: cj1
-- Arg2: resultado
type FCaja b = Caja -> b

-- Arg1 y 2: c1 y c2
-- Arg2 y 3: resultados recursivos de c1 y c2
-- Arg2: resultado
type FSerie b = Circuito -> Circuito -> b -> b -> b

-- Arg1 y 4: cj1 y cj2
-- Arg2 y 3: c1 y c2
-- Arg5 y 6: resultados recursivos de c1 y c2
-- Arg: resultado
type FParalelo b = Caja -> Circuito -> Circuito -> Caja -> b -> b -> b

-- Arg1: función para recursión sobre constructor caja
-- Arg2: recursión para constructor serie
-- Arg3: recursión para constructor paralelo
-- Arg4: estructura en forma de constructor
-- Arg5: resultado de la función
recCircuito :: FCaja b -> FSerie b -> FParalelo b -> Circuito -> b
recCircuito fCaja fSerie fParalelo (Caja c) = fCaja c
recCircuito fCaja fSerie fParalelo (Serie c1 c2) = fSerie c1 c2 (recCircuito fCaja fSerie fParalelo c1) (recCircuito fCaja fSerie fParalelo c2)
recCircuito fCaja fSerie fParalelo (Paralelo cj1 c1 c2 cj2) = fParalelo cj1 c1 c2 cj2 (recCircuito fCaja fSerie fParalelo c1) (recCircuito fCaja fSerie fParalelo c2)

-- 2: foldCircuito

-- Arg1: cj1
-- Arg2: resultado
type FCajaEstructural b = Caja -> b

-- Arg1 y 2: resultados recursivos de c1 y c2
-- Arg2: resultado
type FSerieEstructural b = b -> b -> b

-- Arg1 y 2: cj1 y cj2
-- Arg3 y 4: resultados recursivos de c1 y c2
-- Arg5: resultado
type FParaleloEstructural b = Caja -> Caja -> b -> b -> b

foldCircuito :: FCajaEstructural b -> FSerieEstructural b -> FParaleloEstructural b -> Circuito -> b
foldCircuito fCaja fSerie fParalelo c = recCircuito fCaja (\c1 c2 r1 r2 -> fSerie r1 r2) (\cj1 c1 c2 cj2 r1 r2 -> fParalelo cj1 cj2 r1 r2) c

-- 3 invertido
invertido :: Circuito -> Circuito
invertido = foldCircuito fInvertirCaja fInvertirSerie fInvertirParalelo

fInvertirCaja :: Caja -> Circuito
fInvertirCaja Nada = cajaNada
fInvertirCaja (Bombilla True) = cajaOn
fInvertirCaja (Bombilla False) = cajaOff

fInvertirSerie :: Circuito -> Circuito -> Circuito
fInvertirSerie r1 r2 = (Serie r2 r1)

fInvertirParalelo :: Caja -> Caja -> Circuito -> Circuito -> Circuito
fInvertirParalelo cj1 cj2 r1 r2 = (Paralelo cj2 r2 r1 cj1)

-- 4: hayCaminoIluminado

hayCaminoIluminado :: Circuito -> Bool
hayCaminoIluminado = foldCircuito fhayCaminoIluminadoCaja fhayCaminoIluminadoSerie fhayCaminoIluminadoParalelo

fhayCaminoIluminadoCaja :: Caja -> Bool
fhayCaminoIluminadoCaja Nada = False
fhayCaminoIluminadoCaja (Bombilla True) = True
fhayCaminoIluminadoCaja (Bombilla False) = False

fhayCaminoIluminadoSerie :: Bool -> Bool -> Bool
fhayCaminoIluminadoSerie r1 r2 = r1 && r2

fhayCaminoIluminadoParalelo :: Caja -> Caja -> Bool -> Bool -> Bool
fhayCaminoIluminadoParalelo cj1 cj2 r1 r2 = fhayCaminoIluminadoCaja cj1 && fhayCaminoIluminadoCaja cj2 && (r1 || r2)

-- 5: cantidadPrendidas

cantidadPrendidas :: Circuito -> Int
cantidadPrendidas = foldCircuito fcantidadPrendidasCaja fcantidadPrendidasSerie fcantidadPrendidasParalelo

fcantidadPrendidasCaja :: Caja -> Int
fcantidadPrendidasCaja Nada = 0
fcantidadPrendidasCaja (Bombilla True) = 1
fcantidadPrendidasCaja (Bombilla False) = 0

fcantidadPrendidasSerie :: Int -> Int -> Int
fcantidadPrendidasSerie r1 r2 = r1 + r2

fcantidadPrendidasParalelo :: Caja -> Caja -> Int -> Int -> Int
fcantidadPrendidasParalelo cj1 cj2 r1 r2 = fcantidadPrendidasCaja cj1 + fcantidadPrendidasCaja cj2 + r1 + r2

-- 6: cajasDeCircuito

cajasDeCircuito :: Circuito -> [Caja]
cajasDeCircuito = foldCircuito fcajasDeCircuitoCaja fcajasDeCircuitoSerie fcajasDeCircuitoParalelo

fcajasDeCircuitoCaja :: Caja -> [Caja]
fcajasDeCircuitoCaja Nada = [Nada]
fcajasDeCircuitoCaja (Bombilla True) = [Bombilla True]
fcajasDeCircuitoCaja (Bombilla False) = [Bombilla False]

fcajasDeCircuitoSerie :: [Caja] -> [Caja] -> [Caja]
fcajasDeCircuitoSerie r1 r2 = r1 ++ r2

fcajasDeCircuitoParalelo :: Caja -> Caja -> [Caja] -> [Caja] -> [Caja]
fcajasDeCircuitoParalelo cj1 cj2 r1 r2 = [cj1] ++ r1 ++ r2 ++ [cj2]

-- 7: esCircuitoProlijo

esCircuitoProlijo = undefined -- TODO: COMPLETAR

-- 8: circuitoEmprolijado

circuitoEmprolijado = undefined -- TODO: COMPLETAR

-- 9: tienenLaMismaEstructura

tienenLaMismaEstructura = undefined -- TODO: COMPLETAR

-- 10: subCircuitoMásResistente

subCircuitoMásResistente = undefined -- TODO: COMPLETAR

{-- 11: Demostrar: alternado . alternado = id

alternado :: Circuito -> Circuito
{AC} alternado (Caja caja) = Caja (cajaAlternada caja)
{AS} alternado (Serie ci cf) = Serie (alternado ci) (alternado cf)
{AP} alternado (Paralelo ce ci cd cs) =
       Paralelo (cajaAlternada ce) (alternado ci) (alternado cd) (cajaAlternada cs)

cajaAlternada :: Caja -> Caja
{CAN} cajaAlternada Nada = Nada
{CAB} cajaAlternada Bombilla booleano = Bombilla not booleano

(.) :: (b -> c) -> (a -> b) -> a -> c
{C} (f . f) x = f (f x)

id :: a -> a
{I} id x = x

not :: Bool -> Bool
{NT} not True = False
{NF} not False = True

-- TODO: COMPLETAR

--}