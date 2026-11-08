:- use_module(popong).

% ----------------
% Ejercicio 1
% ----------------

% esMatriz(+ListaDeListas)

/*esMatriz([]).
esMatriz([Lista | RestoListas]) :-
  length(Lista, TamLista),
  todasLasListasTienenTam(TamLista, RestoListas).
  
todasLasListasTienenTam(_, []).
todasLasListasTienenTam(TamLista, [Lista | RestoListas ]) :-
  length(Lista, TamLista),
  todasLasListasTienenTam(TamLista, RestoListas).*/

esMatriz([]).
esMatriz([Lista | RestoListas ]) :-
  length(Lista, TamLista),
  maplist(longitudLista(TamLista), RestoListas).
  
longitudLista(N, Lista) :- length(Lista, N).

% ----------------
% Ejercicio 2
% ----------------

% tamaño(+Matriz, -Filas, -Columnas)
% Precondición: esMatriz(Matriz)
tamaño([], 0, 0).
tamaño([Lista | RestoListas], Filas, Columnas) :-
  length([Lista | RestoListas], Filas),
  length(Lista, Columnas).

% ----------------
% Ejercicio 3
% ----------------

% coordenadaEnRango(+Matriz, +Coordenada)
% Precondición: esMatriz(Matriz)


/*
coordenadaEnRango(Matriz, (X, Y)) :- 
  tamaño(Matriz, Filas, Columnas),
  X > 0,
  Y > 0,
  Filas >= X,
  Columnas >= Y.
Sobre la reversibilidad: 
los operadores aritmeticso > y >= requieren que ambos lados esten instanciados. Por lo tanto, el segundo argumento no es reversible.
Matriz no es reversible: 
Al tratar de unificar Matriz, entra al subojectivo tamaño
Usando la primer regla, unifica Matriz con [], si fila: 0 y columna 0. Al volver, no satisface la regla 2 de coordenadaEnRango y hace backtracking.
Ahora usa la regla 2 de tamaño.
El primer length unifica con M: [Lista] y Filas: 1, con Lista libre.
Al ir al segundo length(Lista, Columnas), unifica Lista: [] y columna 0. Al volver a coordenadaEnRango falla y hace backtracking 
unifica Lista: [_] y Columnas 1. Vuelve a coordenadaEnRango, si la coordenada (X, Y) tiene X=1 e Y >= 1 entonces tiene exito, sino falla. 
Al pedir sucesivamente más resultados se generan matrices de 1 sola fila y N columnas, con N > Y, siendo N la cantidad de veces que se pidió una respuesta.   
*/

coordenadaEnRango(Matriz, (X, Y)) :- 
  tamaño(Matriz, Filas, Columnas),
  between(1, Filas, X),
  between(1, Columnas, Y),
  Filas >= X,
  Columnas >= Y.

% Con esta implementación ahora (X, Y) son reversibles.

% ----------------
% Observadores de tablero.
% ----------------

% valorEnCoordenada(+Tablero, ?Coordenada, ?Valor)
% Posibles usos:
% - (+T, +Coordenada, -V): Instancia en V el valor en las coordenadas Coordenada del tablero T.
% - (+T, -Coordenada, +V): Instancia en Coordenada todas las coordenadas del tablero T que tienen el valor V.
% - (+T, -Coordenada, -V): Instancia en Coordenada todas las coordenadas del tablero T y en V sus correspondientes valores.
% Precondición: esMatriz(Tablero), coordenadaEnRango(Tablero, Coordenada).
valorEnCoordenada(T, (I,J), V) :-
  nth1(I, T, Fila),
  nth1(J, Fila, V).

% coordenada(+Tablero, -Coordenada)
% Instancia en Coordenada todas las coordenadas del tablero Tablero.
% Precondición: esMatriz(Tablero).
coordenada(T, Coordenada) :-
  valorEnCoordenada(T, Coordenada, _).

% libre(+Tablero, ?Coordenada)
% Instancia en Coordenada todas las coordenadas libres del tablero Tablero (o verifica si la coordenada Coordenada está libre en Tablero).
% Precondición: esMatriz(Tablero), coordenadaEnRango(Tablero, Coordenada).
libre(T, Coordenada) :-
  valorEnCoordenada(T, Coordenada, libre).

% color(+Tablero, +Color, ?Coordenada)
% Instancia en Coordenada todas las coordenadas del tablero Tablero que tienen el color Color (o verifica si la coordenada Coordenada tiene color Color en Tablero).
% Precondición: esMatriz(Tablero), coordenadaEnRango(Tablero, Coordenada).
color(T, Color, Coordenada) :-
  color(Color),
  valorEnCoordenada(T, Coordenada, Color).

% ----------------
% Ejercicio 4.a)
% ----------------

% tableroConPosiciónLiberada(+Tablero, +Coordenada, -TableroLiberado)
% Precondición: esMatriz(Tablero), coordenadaEnRango(Tablero, Coordenada), not(libre(Tablero, Coordenada)).

tableroConPosiciónLiberada([Fila | RestoFilas], (X, Y), [Fila | RestoFilasLiberado]) :-
  X > 1,
  X1 is X - 1,
  tableroConPosiciónLiberada(RestoFilas, (X1, Y), RestoFilasLiberado).
tableroConPosiciónLiberada([Fila | RestoFilas], (X, Y), [FilaResultante | RestoFilas]) :-
  X == 1,
  liberarPosicionDeFila(Y, Fila, FilaResultante).

liberarPosicionDeFila(1, [_ | Cola], [libre | Cola]).
liberarPosicionDeFila(Y, [Cabeza | Cola], [Cabeza | ColaConPosLiberada]) :-
  Y > 1,
  Y1 is Y - 1,
  liberarPosicionDeFila(Y1, Cola, ColaConPosLiberada).


% ----------------
% Ejercicio 4.b)
% ----------------

% tableroConPosicionesLiberadas(+Tablero, +Posiciones, -TableroLiberado)
% Precondición: esMatriz(Tablero).
% Precondición: para cada Coordenada en Posiciones: coordenadaEnRango(Tablero, Coordenada), not(libre(Tablero, Coordenada)).

tableroConPosicionesLiberadas(Tablero, [], Tablero).
tableroConPosicionesLiberadas(Tablero, [Posicion | RestoPosiciones], TableroConElRestoPosicionesLiberadas) :- 
  tableroConPosiciónLiberada(Tablero, Posicion, TableroConPosLiberada),
  tableroConPosicionesLiberadas(TableroConPosLiberada, RestoPosiciones, TableroConElRestoPosicionesLiberadas).

% ----------------
% Operaciones sobre coordenadas.
% ----------------

% dirección(?Dirección)
% Instacia en Dirección todas las posibles direcciones (o verifica que Dirección sea una dirección).
dirección(norte).
dirección(este).
dirección(sur).
dirección(oeste).

% direcciones(-Direcciones)
% Instancia en Direcciones una lista con todas las direcciones.
direcciones([norte, este, sur, oeste]).

% vecinaEnDir(+Coordenada, ?Dirección, -Vecina)
% Instancia en Vecina la coordenada vecina a Coordenada en la dirección Dirección (o instancia cada par dirección-vecina en Dirección y Vecina, respectivamente).
vecinaEnDir((I,J), norte, (I2, J)) :- I2 is I-1.
vecinaEnDir((I,J), este, (I, J2)) :- J2 is J+1.
vecinaEnDir((I,J), sur, (I2, J)) :- I2 is I+1.
vecinaEnDir((I,J), oeste, (I, J2)) :- J2 is J-1.

% hayOcupadaAl(+Tablero, +(I, J), +Dirección)
% Precondición: esMatriz(Tablero), coordenadaEnRango(Tablero, (I,J)).
hayOcupadaAl(T, (I, J), D) :-
  vecinaEnDir((I, J), D, V),
  coordenadaEnRango(T, V),
  color(T, _, V).
hayOcupadaAl(T, (I, J), D) :-
  vecinaEnDir((I, J), D, V),
  coordenadaEnRango(T, V),
  libre(T, V),
  hayOcupadaAl(T, V, D).

% ocupadaEnLíneaRectaAl(+Tablero, +(I, J), +Dirección, -Ocupada)
% Precondición: esMatriz(Tablero), coordenadaEnRango(Tablero, (I,J)), hayOcupadaAl(Tablero, (I, J), Dirección).
ocupadaEnLíneaRectaAl(T, (I, J), D, O) :-
  vecinaEnDir((I, J), D, O),
  color(T, _, O).
ocupadaEnLíneaRectaAl(T, (I, J), D, O) :-
  vecinaEnDir((I, J), D, V),
  libre(T, V),
  ocupadaEnLíneaRectaAl(T, V, D, O).

% ocupadasEnLíneaRecta(+Tablero, +(I, J), -PosicionesOcupadas)
% Precondición: esMatriz(Tablero), coordenadaEnRango(Tablero, (I,J)).
ocupadasEnLíneaRecta(T, (I, J), Ocupadas) :-
  direcciones(Direcciones),
  ocupadasPorDirecciones(T, (I, J), Direcciones, Ocupadas).

% ocupadasPorDirecciones(+Tablero, +(I, J), +Direcciones, -PosicionesOcupadas)
% Precondición: esMatriz(Tablero), coordenadaEnRango(Tablero, (I,J)).
ocupadasPorDirecciones(_, _, [], []).
ocupadasPorDirecciones(T, (I, J), [D|Ds], [O|Os]) :-
  hayOcupadaAl(T, (I, J), D),
  ocupadaEnLíneaRectaAl(T, (I, J), D, O),
  ocupadasPorDirecciones(T, (I, J), Ds, Os).
ocupadasPorDirecciones(T, (I, J), [D|Ds], Os) :-
  not(hayOcupadaAl(T, (I, J), D)),
  ocupadasPorDirecciones(T, (I, J), Ds, Os).

% ----------------
% Obtención de los colores predominantes desde una coordenada.
% ----------------

% coloresPredominantes(+Tablero, +(I, J), -Colores, -Coordenadas)
% Instancia en Colores la lista con los colores que son predominantes en el tablero Tablero desde la coordenada (I,J), y en Coordenadas las coordenadas correspondientes a dichos colores..
% Precondición: esMatriz(Tablero), coordenadaEnRango(Tablero, (I,J)), libre(Tablero, (I, J)).
coloresPredominantes(T, (I, J), ColoresPredominantes, Coordenadas) :-
  ocupadasEnLíneaRecta(T, (I, J), Os),
  posicionesAColores(T, Os, ColoresOcupadas),
  soloPredominantesEn(ColoresOcupadas, ColoresOcupadas, Os, ColoresPredominantes, Coordenadas).

% posicionesAColores(+Tablero, +Posiciones, -Colores)
% Instancia en Colores los colores de las coordenadas Posiciones en el tablero Tablero.
% Precondición: esMatriz(Tablero).
% Precondición: para cada Coordenada en Posiciones: coordenadaEnRango(Tablero, Coordenada), not(libre(Tablero, Coordenada)).
posicionesAColores(_, [], []).
posicionesAColores(T, [P | Ps], [C | Cs]) :-
  color(T, C, P),
  posicionesAColores(T, Ps, Cs).

% soloPredominantesEn(+ColoresOcupadasCompleta, +ColoresOcupadasRestantes, +CoordenadasOcupadas, -ColoresPredominantes, -CoordenadasPredominantes).
% Instancia en ColoresPredominantes los colores de la lista ColoresOcupadasRestantes que son predominantes en ColoresOcupadasCompleta.
soloPredominantesEn(_, [], [], [], []).
soloPredominantesEn(COC, [CO | COs], [Cr | Crs], CPs, [Cr | Coord]) :-
  soloPredominantesEn(COC, COs, Crs, CPs, Coord),
  member(CO, CPs).
soloPredominantesEn(COC, [CO | COs], [Cr | Crs], [CO | CPs], [Cr | Coord]) :-
  soloPredominantesEn(COC, COs, Crs, CPs, Coord),
  not(member(CO, CPs)),
  esPredominante(CO, COC).
soloPredominantesEn(COC, [CO | COs], [_ | Crs], CPs, Coord) :-
  soloPredominantesEn(COC, COs, Crs, CPs, Coord),
  not(member(CO, CPs)),
  not(esPredominante(CO, COC)).

% esPredominante(+Color, +Colores)
% Indica si el color Color es predominante en Colores.
esPredominante(C, Cs) :-
  cantApariciones(C, Cs, K),
  not(hayColorConMásPresencia(Cs, K, Cs)), !.

% cantApariciones(+Elemento, +Lista, -Cantidad)
% Instancia en Cantidad la cantidad de veces que aparece el elemento Elemento en la lista Lista.
cantApariciones(_, [], 0).
cantApariciones(X, [X|Xs], N) :-
  cantApariciones(X, Xs, N2),
  N is N2 + 1.
cantApariciones(X, [Y|Xs], N) :-
  X \= Y,
  cantApariciones(X, Xs, N).

% hayColorConMásPresencia(+ListaCompleta, +Cantidad, +ListaRestante)
% Indica si hay algún color de la lista ListaRestante que aparezca en ListaCompleta más de Cantidad veces.
hayColorConMásPresencia([C|_], K, CC) :-
  cantApariciones(C, CC, K2), K2 > K.
hayColorConMásPresencia([_|Cs], K, CC) :-
  hayColorConMásPresencia(Cs, K, CC).

% jugadaPosible(+Tablero, ?Jugada)
% Precondición: esMatriz(Tablero).
% Tiene éxito si la posición Jugada tiene colores vecinos repetidos
jugadaPosible(T, (I, J)) :-
  libre(T, (I, J)),
  ocupadasEnLíneaRecta(T, (I, J), Os),
  posicionesAColores(T, Os, Cs),
  not(is_set(Cs)).

% ----------------
% Ejercicio 5.a)
% ----------------

% jugarPosición(+TableroInicial, +Coordenada, -TableroResultante)
% Precondición: esMatriz(TableroInicial), coordenadaEnRango(TableroInicial, Coordenada), libre(TableroInicial, Coordenada).
jugarPosición(T, (I,J), TR) :- 
  jugadaPosible(T, (I,J)),
  coloresPredominantes(T, (I,J), _, Coordenadas),
  tableroConPosicionesLiberadas(T,Coordenadas,TR).


% ----------------
% Ejercicio 5.b)
% ----------------

% jugarPosiciones(+TableroInicial, +Jugadas, -TableroResultante)
% Precondición: esMatriz(TableroInicial).
% Precondición: para cada Coordenada en Jugadas: coordenadaEnRango(TableroInicial, Coordenada).
jugarPosiciones(T, [], T).
jugarPosiciones(T, JD, TR) :- 
  [J | Js] = JD,
  jugarPosición(T, J, TI),
  jugarPosiciones(TI, Js, TR).

% jugarNaive(+TableroInicial, -TableroFinal)
% Precondición: esMatriz(TableroInicial).
jugarNaive(T, T) :-
  not(jugadaPosible(T, _)).
jugarNaive(T, TF) :-
  jugadaPosible(T, J),
  jugarPosición(T, J, TI),
  jugarNaive(TI, TF).

% ----------------
% Ejercicio 6.b)
% ----------------

% jugadasNaive(+Tablero, -Jugadas)
% Precondición: esMatriz(Tablero).
jugadasNaive(T, []) :-
  not(jugadaPosible(T, _)).
jugadasNaive(T, [J | Js]) :-
  jugadaPosible(T, J),
  jugarPosición(T, J, TI),
  jugadasNaive(TI, Js).

% ----------------
% Ejercicio 7.a)
% ----------------

% victoriaConJugadas(+Tablero, +Jugadas).
% Precondición: esMatriz(Tablero).
% Precondición: para cada Coordenada en Jugadas: coordenadaEnRango(Tablero, Coordenada).
victoriaConJugadas(T, J) :-
  jugarPosiciones(T, J, TF),
  tableroVacio(TF).

% tableroVacio(+Tablero)
tableroVacio(T) :-
  forall(coordenada(T, C), libre(T, C)).

% ----------------
% Ejercicio 7.b)
% ----------------

% juegoNaiveVictorioso(+Tablero, -Jugadas)
% Precondición: esMatriz(Tablero).
juegoNaiveVictorioso(T, J) :-
  jugadasNaive(T, J),
  victoriaConJugadas(T, J).
% ----------------
% Ejercicio 7.c)
% ----------------

% mejorJuegoNaive(+Tablero, -Jugadas)
% Precondición: esMatriz(Tablero).
mejorJuegoNaive(_, _) :- completar("Ejercicio 7.c").

% ----------------
% Ejercicio 8 - OPCIONAL
% ----------------

% tableroEnElQueNaiveGanaEmpezandoPor(-Tablero, +Coordenada)
tableroEnElQueNaiveGanaEmpezandoPor(_, _) :- completar("Ejercicio 8").

% ----------------
% Interfaz gráfica
% ----------------

% guiTablero(+Tablero)
%% NOTA: Si no funciona, usar en su lugar mostrarMatrizAlt.
guiTablero(T) :- mostrarMatriz(T), !.

% guiJugada(+Tablero1, +Coordenada, +Tablero2)
guiJugada(T1, J, T2) :- guiTablero(T1), write(J), write('\n'), guiTablero(T2).

% guiJugadas(+Tablero, +Jugadas)
guiJuego(T, Js) :- guiTablero(T), guiParesJugadasTableros(T, Js).

% guiParesJugadasTableros(+Tablero, +Jugadas)
guiParesJugadasTableros(_, []).
guiParesJugadasTableros(T, [J | Js]) :-
  write(J), write('\n'),
  jugarPosición(T, J, T2),
  guiTablero(T2),
  guiParesJugadasTableros(T2, Js).

% ----------------
% Tableros de ejemplo
% ----------------

% tablero(+N, -T)
tablero(1, [
  [rojo,  libre, azul,  rojo],
  [azul,  libre, azul,  rojo],
  [verde, rojo,  azul,  verde],
  [libre, libre, libre, rojo]
]).
tablero(2, [
  [libre, libre, libre, libre],
  [libre, libre, libre, libre],
  [verde, libre, libre, verde],
  [libre, libre, libre, libre]
]).
tablero(3, [
  [libre, libre, libre, libre],
  [libre, libre, libre, libre],
  [libre, libre, libre, libre],
  [libre, libre, libre, libre]
]).

% Indica que se debe completar el predicado. Siempre falla.
completar(S) :- write("COMPLETAR: "), write(S), nl, fail.
