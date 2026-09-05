import TP1
import Test.HUnit

-- TESTS

testsInvertido :: Test
testsInvertido =
  TestList -- TODO: AGREGAR
    [ "Caja invertida (1)"
        ~: invertido cajaOn
        ~?= cajaOn,
      "Caja invertida (2)"
        ~: invertido cajaOff
        ~?= cajaOff,
      "Caja invertida (3)"
        ~: invertido cajaNada
        ~?= cajaNada,
      "Circuito ejemplo enunciado"
        ~: invertido (Serie (Paralelo on (Paralelo off cajaNada cajaOn on) (Paralelo Nada cajaOn cajaOff Nada) on) cajaOn)
        ~?= Serie cajaOn (Paralelo on (Paralelo Nada cajaOff cajaOn Nada) (Paralelo on cajaOn cajaNada off) on)
    ]

testsHayCaminoIluminado :: Test
testsHayCaminoIluminado =
  TestList -- TODO: AGREGAR
    [ "En una caja con bombilla encendida hay camino iluminado"
        ~: hayCaminoIluminado cajaOn
        ~?= True,
      "Caja sin bombilla no hay camino iluminado"
        ~: hayCaminoIluminado cajaNada
        ~?= False,
      "En ejemplo enunciado no hay cambino iluminado"
        ~: hayCaminoIluminado (Serie (Paralelo on (Paralelo off cajaNada cajaOn on) (Paralelo Nada cajaOn cajaOff Nada) on) cajaOn)
        ~?= False,
      "Modificacion de ejemplo de enunciado para agregar camino iluminado"
        ~: hayCaminoIluminado (Serie (Paralelo on (Paralelo off cajaNada cajaOn on) (Paralelo on cajaOn cajaOff on) on) cajaOn)
        ~?= True,
      "Invertir ejemplo modificado todavia tiene camino iluminado"
        ~: hayCaminoIluminado (invertido (Serie (Paralelo on (Paralelo off cajaNada cajaOn on) (Paralelo on cajaOn cajaOff on) on) cajaOn))
        ~?= True
    ]

testsCantidadPrendidas :: Test
testsCantidadPrendidas =
  TestList -- TODO: AGREGAR
    [ "Cantidad prendidas en caja prendida es 1"
        ~: cantidadPrendidas cajaOn
        ~?= 1,
      "Cantidad prendidas en ejemplo enunciado"
        ~: cantidadPrendidas (Serie (Paralelo on (Paralelo off cajaNada cajaOn on) (Paralelo Nada cajaOn cajaOff Nada) on) cajaOn)
        ~?= 6
    ]

testsCajasDeCircuito :: Test
testsCajasDeCircuito =
  TestList -- TODO: AGREGAR
    [ "La lista de cajas de un circuito con una única caja es la lista con esa caja"
        ~: cajasDeCircuito cajaOn
        ~?= [on],
      "Lista de cajas de ejemplo enunciado"
        ~: cajasDeCircuito (Serie (Paralelo on (Paralelo off cajaNada cajaOn on) (Paralelo Nada cajaOn cajaOff Nada) on) cajaOn)
        ~?= [on, off, Nada, on, on, Nada, on, off, Nada, on, on],
      "Lista de cajas de ejemplo enunciado pero inertido"
        ~: cajasDeCircuito (invertido (Serie (Paralelo on (Paralelo off cajaNada cajaOn on) (Paralelo Nada cajaOn cajaOff Nada) on) cajaOn))
        ~?= [on, on, Nada, off, on, Nada, on, on, Nada, off, on]
    ]

testsEsCircuitoProlijo :: Test
testsEsCircuitoProlijo =
  TestList -- TODO: AGREGAR
    [ "Una caja es prolija"
        ~: esCircuitoProlijo cajaOn
        ~?= True,
      "Circuito de ejemplo de enunciado prolijo"
        ~: esCircuitoProlijo (Serie (Serie cajaOn cajaOn) cajaOff)
        ~?= True,
      "Circuito de ejemplo de enunciado no prolijo"
        ~: esCircuitoProlijo (Serie cajaOn (Serie cajaOn cajaOff))
        ~?= False
    ]

-- NOTA: para correr este test, cambiar la línea 18 del archivo tp1.hs de "show = showDeCircuito" a
-- "show = showDeCircuitoConEstructura".
-- De esa forma, podrán distinguir la estructura de los circuitos en serie.
testsCircuitoEmprolijado :: Test
testsCircuitoEmprolijado =
  TestList -- TODO: AGREGAR
    []

--  "La versión emprolijada de una caja es la misma caja"
--     ~: circuitoEmprolijado cajaOn
--     ~?= cajaOn,
--   "Version emprolijada del ejemplo del enunciado"
--     ~: circuitoEmprolijado (Serie cajaOn (Serie cajaOff cajaOn))
--     ~?= (Serie (Serie cajaOn cajaOff) cajaOn),
--   "Un ejemplo mas dificil"
--     ~: circuitoEmprolijado (Serie cajaOn (Serie cajaOff (Paralelo Nada cajaOn (Serie cajaOn (Serie cajaOff cajaOn)) off)))
--     ~?= Serie (Serie cajaOn cajaOff) (Paralelo Nada cajaOn (Serie (Serie cajaOn cajaOff) cajaOn) off),
--   "Series anidadas"
--     ~: circuitoEmprolijado (Serie cajaOn (Serie cajaOff (Serie cajaOn (Serie cajaOff cajaOn))))
--     ~?= Serie (Serie (Serie (Serie cajaOn cajaOff) cajaOn) cajaOff) cajaOn,
--   "Muchas series anidadas, un paralelo y varias series anidadas"
--     ~: circuitoEmprolijado (Serie cajaOn (Serie cajaOff (Serie cajaOn (Paralelo on (Serie cajaOn (Serie cajaOff (Serie cajaOn cajaOff))) cajaNada off))))
--     ~?= Serie (Serie (Serie cajaOn cajaOff) cajaOn) (Paralelo on (Serie (Serie (Serie cajaOn cajaOff) cajaOn) cajaOff) cajaNada off)

testsTienenLaMismaEstructura :: Test
testsTienenLaMismaEstructura =
  TestList -- TODO: AGREGAR
    [ "Circuito de una sola caja es igual estructuralmente a circuito de una caja"
        ~: tienenLaMismaEstructura cajaOn cajaOff
        ~?= True,
      "Circuito en serie es igual a circuito en serie"
        ~: tienenLaMismaEstructura (Serie (Serie (Serie cajaOn cajaOn) cajaOn) cajaOn) (Serie (Serie (Serie cajaOff cajaOff) cajaOff) cajaOff)
        ~?= True,
      "Circuito en serie no es igual a circuito en serie distinto"
        ~: tienenLaMismaEstructura (Serie (Serie (Serie cajaOn cajaOn) cajaOn) cajaOn) (Serie cajaNada cajaOff)
        ~?= False,
      "Circuitos paralelos estructuralmente iguales"
        ~: tienenLaMismaEstructura
          (Paralelo on (Serie (Serie cajaOn cajaOn) cajaOn) (Paralelo on cajaNada cajaNada on) off)
          (Paralelo on (Serie (Serie cajaOff cajaOff) cajaOff) (Paralelo on cajaNada cajaOn on) Nada)
        ~?= True,
      "Circuitos paralelos estructuralmente no iguales"
        ~: tienenLaMismaEstructura
          (Paralelo on (Serie (Serie cajaOn cajaOn) cajaOn) (Serie cajaNada cajaNada) off)
          (Paralelo on (Serie (Serie cajaOff cajaOff) cajaOff) (Paralelo on cajaNada cajaOn on) Nada)
        ~?= False
    ]

testsSubCircuitoMásResistente :: Test
testsSubCircuitoMásResistente =
  TestList -- TODO: AGREGAR
    []

tests :: Test
tests =
  TestList
    [ TestLabel "invertido" testsInvertido,
      TestLabel "hayCaminoIluminado" testsHayCaminoIluminado,
      TestLabel "cantidadPrendidas" testsCantidadPrendidas,
      TestLabel "cajasDeCircuito" testsCajasDeCircuito,
      TestLabel "esCircuitoProlijo" testsEsCircuitoProlijo,
      -- TestLabel "circuitoEmprolijado" testsCircuitoEmprolijado
      TestLabel "tienenLaMismaEstructura" testsTienenLaMismaEstructura,
      TestLabel "subCircuitoMásResistente" testsSubCircuitoMásResistente
    ]

main :: IO ()
main = runTestTT tests >>= print