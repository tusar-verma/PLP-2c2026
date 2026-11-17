# Ej 1

Tenemos la misma solución que la catedra (comentada). La solución alternativa entregada usa maplist, que evita crear la regla recursiva (solo el predicado a chequear por cada elemento de la lista).

# Ej 2

Identica

# Ej 3

Solución de la cátedra no es reversible en el segundo argumento (coordenadas (I, J)). Los operadores extra-lógicos > y =< requieren ambos operandos instanciados

Nuestra solución es reversible en el segundo argumento

# Ej 4

## a

La función aux liberarPosicionDeFila es identica salvo orden de los argumentos.

La regla 1 de tableroConPosiciónLiberada de la cátedra unifica la coordenada (1, J). Es más limpio.
Ambas solucioens son identicas en "comportamiento" y reversibilidad.

## b

Identica

# Ej 5

## a

Identica

## b

Identica

# Ej 6

Identica

# Ej 7

## a

La solución de la cátedra usa el 5a y llama recursivamente a victoriaConJugadas con la cola de la lista de jugadas. Luego tiene que manejar el caso base de la lista de jugadas vacía [].
Nuestra implementación usa el ej 5b para jugar todas las posiciones, por lo que no necesitamos hacer una regla recursiva.

Chequeamos la condición de victoria con el predicado forall viendo que cada coordenada este libre.
La cátedra, en el caso base de victoriaConJugadas, chequea que ninguna coordenada del tablero tenga un color válido.

Los chequeos de victoria son similares en que tienen que recorrer todas las pocisiones del tablero. La nuestra por cada una fija si está libre (tenga el valor atómico libre) y la cátedra que no tenga un color.

En general, la idea de ambas son similares: jugar cada jugada de la lista de jugadas, obtener el tablero final y chequear condición de victoria sobre el tablero final.

## b

Identica

## c

Identica

