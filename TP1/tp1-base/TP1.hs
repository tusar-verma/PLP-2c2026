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
  show = showDeCircuitoConEstructura

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
esCircuitoProlijo :: Circuito -> Bool
esCircuitoProlijo = recCircuito fesCircuitoProlijoCaja fesCircuitoProlijoSerie fesCircuitoProlijoParalelo

fesCircuitoProlijoCaja :: Caja -> Bool
fesCircuitoProlijoCaja c = True

fesCircuitoProlijoSerie :: Circuito -> Circuito -> Bool -> Bool -> Bool
fesCircuitoProlijoSerie c1 c2 r1 r2 = r1 && r2 && noEsSerie c2

fesCircuitoProlijoParalelo :: Caja -> Circuito -> Circuito -> Caja -> Bool -> Bool -> Bool
fesCircuitoProlijoParalelo cj1 c1 c2 cj2 r1 r2 = r1 && r2

noEsSerie :: Circuito -> Bool
noEsSerie (Caja c) = True
noEsSerie (Serie c1 c2) = False
noEsSerie (Paralelo cj1 c1 c2 cj2) = True

-- 8: circuitoEmprolijado

-- circuitoEmprolijado :: Circuito -> Circuito
-- circuitoEmprolijado = recCircuito fcircuitoEmprolijadoCaja fcircuitoEmprolijadoSerie fcircuitoEmprolijadoParalelo

-- fcircuitoEmprolijadoCaja :: Caja -> Circuito
-- fcircuitoEmprolijadoCaja Nada = Caja Nada
-- fcircuitoEmprolijadoCaja (Bombilla True) = cajaOn
-- fcircuitoEmprolijadoCaja (Bombilla False) = cajaOff

-- fcircuitoEmprolijadoSerie :: Circuito -> Circuito -> Circuito -> Circuito -> Circuito
-- fcircuitoEmprolijadoSerie c1 c2 r1 r2 = if (noEsSerie r2) then (Serie r1 r2) else (asociarIzquierda r1 r2)

-- fcircuitoEmprolijadoParalelo :: Caja -> Circuito -> Circuito -> Caja -> Circuito -> Circuito -> Circuito
-- fcircuitoEmprolijadoParalelo cj1 c1 c2 cj2 r1 r2 = (Paralelo cj1 r1 r2 cj2)

-- asociarIzquierda :: Circuito -> Circuito -> Circuito
-- asociarIzquierda cSerie = recCircuito fasociarIzquierdaCaja fasociarIzquierdaSerie fasociarIzquierdaParalelo cSerie

-- fasociarIzquierdaCaja :: Caja -> Circuito -> Circuito
-- fasociarIzquierdaCaja c cSerie = (\(p1, p2) -> Serie (Serie (Caja c) p1) p2) (desarmarSerie cSerie)

-- fasociarIzquierdaSerie :: Circuito -> Circuito -> Circuito -> Circuito -> Circuito
-- fasociarIzquierdaSerie (Serie c1 c2) cSerie = (\(p1, p2) -> Serie (Serie c1 p1) p2) (desarmarSerie cSerie)

-- fasociarIzquierdaParalelo :: Caja -> Circuito -> Circuito -> Caja -> Circuito -> Circuito -> Circuito
-- fasociarIzquierdaParalelo (Paralelo cj1 c1 c2 cj2) cSerie = (\(p1, p2) -> Serie (Serie (Paralelo cj1 c1 c2 cj2) p1) p2) (desarmarSerie cSerie)

-- asociarIzquierda :: Circuito -> Circuito -> Circuito
-- asociarIzquierda (Caja c) cSerie = (\(p1, p2) -> Serie (Serie (Caja c) p1) p2) (desarmarSerie cSerie)
-- asociarIzquierda (Serie c1 c2) cSerie = (\(p1, p2) -> Serie (Serie c1 p1) p2) (desarmarSerie cSerie)
-- asociarIzquierda (Paralelo cj1 c1 c2 cj2) cSerie = (\(p1, p2) -> Serie (Serie (Paralelo cj1 c1 c2 cj2) p1) p2) (desarmarSerie cSerie)

-- desarmarSerie :: Circuito -> (Circuito, Circuito)
-- desarmarSerie (Serie c1 c2) = (c1, c2)
-- desarmarSerie _ = error ("No tiene sentido llamar a desarmarSerie con un circuito no serie")

-- 9: tienenLaMismaEstructura
tienenLaMismaEstructura :: Circuito -> Circuito -> Bool
tienenLaMismaEstructura c1 c2 = foldCircuito ftienenLaMismaEstructuraCaja ftienenLaMismaEstructuraSerie ftienenLaMismaEstructuraParalelo c1 c2

-- Las funciones de cada caso recursivo devuelven una función que devuelve True si el circuito pasado es igual a dicho circuito
-- Para cada constructor de circuito construimos una función que toma un circuito c y devuelve un booleano si c es igual al circuito
ftienenLaMismaEstructuraCaja :: Caja -> Circuito -> Bool
ftienenLaMismaEstructuraCaja cj = \c -> case c of
  -- No compramos lo que hay en las cajas por que piden igualdad de estructura más allá del contenido de las cajas
  Caja cj' -> True
  Serie c1 c2 -> False
  Paralelo cj1 c1 c2 cj2 -> False

ftienenLaMismaEstructuraSerie :: (Circuito -> Bool) -> (Circuito -> Bool) -> (Circuito -> Bool)
ftienenLaMismaEstructuraSerie r1 r2 = \c -> case c of
  Caja cj' -> False
  Serie c1 c2 -> (r1 c1) && (r2 c2)
  Paralelo cj1 c1 c2 cj2 -> False

ftienenLaMismaEstructuraParalelo :: Caja -> Caja -> (Circuito -> Bool) -> (Circuito -> Bool) -> (Circuito -> Bool)
ftienenLaMismaEstructuraParalelo cj1 cj2 r1 r2 = \c -> case c of
  Caja cj' -> False
  Serie c1 c2 -> False
  -- No compramos lo que hay en las cajas por que piden igualdad de estructura más allá del contenido de las cajas
  Paralelo cj1' c1 c2 cj2' -> (r1 c1) && (r2 c2)

-- 10: subCircuitoMásResistente

resistenciaCircuito :: Circuito -> Float
resistenciaCircuito c = error ("Sin implementar. Asumir implementado")

subCircuitoMásResistente :: Circuito -> Circuito
subCircuitoMásResistente c = recCircuito fsubCircuitoMásResistenteCaja fsubCircuitoMásResistenteSerie fsubCircuitoMasResistenteParalelo c

fsubCircuitoMásResistenteCaja :: Caja -> Circuito
fsubCircuitoMásResistenteCaja Nada = Caja Nada
fsubCircuitoMásResistenteCaja (Bombilla True) = cajaOn
fsubCircuitoMásResistenteCaja (Bombilla False) = cajaOff

fsubCircuitoMásResistenteSerie :: Circuito -> Circuito -> Circuito -> Circuito -> Circuito
fsubCircuitoMásResistenteSerie c1 c2 r1 r2 = elMayorSubCircuitoConResistencia r1 r2 (Serie c1 c2)

fsubCircuitoMasResistenteParalelo :: Caja -> Circuito -> Circuito -> Caja -> Circuito -> Circuito -> Circuito
fsubCircuitoMasResistenteParalelo cj1 c1 c2 cj2 r1 r2 = elMayorSubCircuitoConResistencia r1 r2 (Paralelo cj1 c1 c2 cj2)

elMayorSubCircuitoConResistencia :: Circuito -> Circuito -> Circuito -> Circuito
elMayorSubCircuitoConResistencia c1 c2 c3
  | resistenciaCircuito c1 >= resistenciaCircuito c2 && resistenciaCircuito c1 >= resistenciaCircuito c3 = c1
  | resistenciaCircuito c2 >= resistenciaCircuito c1 && resistenciaCircuito c2 >= resistenciaCircuito c3 = c2
  | otherwise = c3

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

Usando la igualdad extensional basta con ver que para todo circuito c vale: alternado . alternado c = id c
Lo vamos a demostrar usando el lema de generación sobre circuitos e inducción estructural sobre c.

El lema de generación sobre circuitos nos dice que un circuito puede tener la forma:

data Circuito = Caja Caja
    | Serie Circuito Circuito
    | Paralelo Caja Circuito Circuito Caja

Tambien usaremos lema de generación sobre caja:  Caja = Bombilla Bool | Nada

Tenemos entonces 1 caso base y 2 casos recursivo para c

#### Caso base c = Caja cj

qvq:
alternado . alternado (Caja cj) = id (Caja cj)

desarrollando ambas partes de la ecuación:

  id (Caja cj)                                                                            {I}
= Caja cj

  alternado . alternado (Caja cj)                                                         {C}
= alternado (alternado (Caja cj))                                                         {AC}
= alternado (Caja (cajaAlternada cj))                                                     {AC}
= Caja (cajaAlternada (cajaAlternada cj))                                                 {Lema1}
= Caja cj

Ahora probaremos el Lema1: cj = cajaAlternada (cajaAlternada cj)

Usando lema de generación sorbe cj:

-- qvq:
cajaAlternada (cajaAlternada cj) = cj

  cajaAlternada (cajaAlternada Nada)              {CAN}
= cajaAlternada Nada                              {CAN}
= Nada

  cajaAlternada (cajaAlternada Bombilla b)        {CAB}
= cajaAlternada (Bombilla (not b))                {CAB}
= Bombilla (not (not b))                          {Negación con negación se cancelan}
= Bombilla b

Para ambos constructores de Caja se obtiene la igualdad. Por lo tanto hemos demostrado el Lema1.

Y la propiedad original vale para el caso base de Circuito.

############ Caso inductivo c = Serie c1 c2  ###############

HI: ∀ c1, c2:: Circuito
  alternado . alternado c1 = id c1 AND alternado . alternado c2 = id c2

QVQ: alternado . alternado (Serie c1 c2) = id (Serie c1 c2)

  alternado . alternado (Serie c1 c2)                               {C}
= alternado (alternado (Serie c1 c2))                               {AS}
= alternado (Serie (alternado c1) (alternado c2))                   {AS}
= Serie (alternado (alternado c1)) (alternado (alternado c2))       {C}
= Serie (alternado . alternado c1) (alternado . alternado c2)       {HI}
= Serie (id c1) (id c2)                                             {I}
= Serie c1 c2                                                       {I}
= id (Serie c1 c2)

Desarrollando el lado izquierdo llegamos al lado derecho de la ecuación. Vale la igualdad para circuitos serie.

############ Caso inductivo c = Paralelo cj1 c1 c2 cj2  ###############

HI: ∀ c1, c2 :: Circuito, ∀cj1 cj1 :: Caja
  alternado . alternado c1 = id c1 AND alternado . alternado c2 = id c2

QVQ: alternado . alternado (Paralelo cj1 c1 c2 cj2) = id (Paralelo cj1 c1 c2 cj2)

alternado . alternado (Paralelo cj1 c1 c2 cj2)                                                      {C}
= alternado (alternado (Paralelo cj1 c1 c2 cj2))                                                    {AP}
= alternado (Paralelo (cajaAlternada cj1) (alternado c1) (alternado c2) (cajaAlternada cj2))        {AP}
= Paralelo
    cajaAlternada (cajaAlternada cj1)
    alternado (alternado c1)
    alternado (alternado c2)
    cajaAlternada (cajaAlternada cj2)                                                               {C}
= Paralelo
    cajaAlternada (cajaAlternada cj1)
    (alternado . alternado c1)
    (alternado . alternado c2)
    cajaAlternada (cajaAlternada cj2)                                                               {HI}
= Paralelo
    cajaAlternada (cajaAlternada cj1)
    (id c1)
    (id c2)
    cajaAlternada (cajaAlternada cj2)                                                               {Lema 1}
= Paralelo
    cj1
    (id c1)
    (id c2)
    cj2                                                                                             {I}
= Paralelo cj1 c1 c2 cj2                                                                            {I}
= id (Paralelo cj1 c1 c2 cj2)

Desarrollando el lado izquierdo llegamos al lado derecho de la ecuación. Vale la igualdad para circuitos paralelos.

Como probamos caso base y ambos casos recursivos, entonces demostramos que para todo c::Circuito vale: alternado . alternado c = id c

Y por principio extensional vale: alternado . alternado = id

--}