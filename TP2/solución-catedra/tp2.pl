:- use_module(popong).

% ----------------
% Ejercicio 1
% Implementar el predicado esMatriz(+ListaDeListas) que es verdadero cuando ListaDeListas es una matriz. Esto es, todas las listas tienen la misma longitud.
% ----------------

% esMatriz(+ListaDeListas)
esMatriz([]).
esMatriz([Fila|SubM]) :-
  length(Fila, C),
  todasDeLongitud(SubM, C).

% todasDeLongitud(+ListaDeListas, +Longitud)
todasDeLongitud([], _).
todasDeLongitud([L|Ls], Long) :-
  length(L, Long),
  todasDeLongitud(Ls, Long).

% ----------------
% Ejercicio 2
% Implementar el predicado tamaño(+Matriz, -Filas, -Columnas) que instancia en Filas la cantidad de filas de Matriz y en Columnas su cantidad de columnas. Se presupone que Matriz es una matriz.
% ----------------

% tamaño(+Matriz, -Filas, -Columnas)
% Precondición: esMatriz(Matriz)
tamaño([], 0, 0).
tamaño([Fila | SubM], F, C) :-
  length(Fila, C),
  length(SubM, PF),
  F is PF+1.

% ----------------
% Ejercicio 3
% Implementar el predicado coordenadaEnRango(+Matriz, +(I, J)) que es verdadero cuando la coordena (I,J) pertenece a Matriz. Como cualquier persona racional, empezamos a contar desde 1 así que la primera fila es la número 1. Se presupone que Matriz es una matriz.
% ----------------

% coordenadaEnRango(+Matriz, +(I, J))
% Precondición: esMatriz(Matriz)
coordenadaEnRango(M, (I,J)) :-
  I > 0, J > 0,
  tamaño(M, F, C),
  I =< F, J =< C.

% ----------------
% Observadores de tablero.
% ----------------

% valorEnCoordenada(+Tablero, ?(I, J), ?Valor)
% Posibles usos:
% - (+T, +(I, J), -V): Instancia en V el valor en las coordenadas (I,J) del tablero T.
% - (+T, -(I, J), +V): Instancia en (I,J) todas las coordenadas del tablero T que tienen el valor V.
% - (+T, -(I, J), -V): Instancia en (I,J) todas las coordenadas del tablero T y en V sus correspondientes valores.
% Precondición: esMatriz(Tablero), coordenadaEnRango(Tablero, (I,J)).
valorEnCoordenada(T, (I, J), V) :-
  nth1(I, T, Fila),
  nth1(J, Fila, V).

% coordenada(+Tablero, -(I, J))
% Instancia en (I,J) todas las coordenadas del tablero Tablero.
% Precondición: esMatriz(Tablero).
coordenada(T, (I,J)) :-
  valorEnCoordenada(T, (I, J), _).

% libre(+Tablero, ?(I, J))
% Instancia en (I,J) todas las coordenadas libres del tablero Tablero (o verifica si la coordenada (I,J) está libre en Tablero).
% Precondición: esMatriz(Tablero), coordenadaEnRango(Tablero, (I,J)).
libre(T, Coord) :-
  valorEnCoordenada(T, Coord, libre).

% color(+Tablero, +Color, ?(I, J))
% Instancia en (I,J) todas las coordenadas del tablero Tablero que tienen el color Color (o verifica si la coordenada (I,J) tiene color Color en Tablero).
% Precondición: esMatriz(Tablero), coordenadaEnRango(Tablero, (I,J)).
color(T, Color, Coord) :-
  color(Color),
  valorEnCoordenada(T, Coord, Color).

% ----------------
% Ejercicio 4.a)
% Implementar el predicado tableroConPosiciónLiberada(+Tablero, +(I,J), -TableroLiberado) que instancia en TableroLiberado el tablero resultante de liberar la posición (I,J) del tablero Tablero. Esto es, TableroLiberado debería ser exactamente igual a Tablero excepto en la posición (I,J) que debe estar libre. Se presupone que Tablero es una matriz, que la coordenada (I,J) está en el rango de Tablero y que la posición (I,J) de Tablero no está libre.
% ----------------

% tableroConPosiciónLiberada(+Tablero, +(I,J), -TableroLiberado)
% Precondición: esMatriz(Tablero), coordenadaEnRango(Tablero, (I,J)), not(libre(Tablero, (I,J))).
tableroConPosiciónLiberada([Fila | SubM], (1, J), [FilaLiberada | SubM]) :-
  filaConPosiciónLiberada(Fila, J, FilaLiberada).
tableroConPosiciónLiberada([Fila | SubM], (I, J), [Fila | RecSubM]) :-
  I > 1, I2 is I - 1, tableroConPosiciónLiberada(SubM, (I2, J), RecSubM).

% filaConPosiciónLiberada(+Fila, +J, -FilaLiberada).
% Precondición: J está entre 1 y la longitud de Fila.
% Precondición: El elemento en la posición J de Fila no está libre.
filaConPosiciónLiberada([_ | SubF], 1, [libre | SubF]).
filaConPosiciónLiberada([X | SubF], J, [X | RecSubF]) :-
  J > 1, J2 is J - 1, filaConPosiciónLiberada(SubF, J2, RecSubF).

% ----------------
% Ejercicio 4.b)
% Implementar el predicado tableroConPosicionesLiberadas(+Tablero, +Posiciones, -TableroLiberado) que instancia en TableroLiberado el tablero resultante de liberar las posiciones Posiciones del tablero Tablero. Esto es, TableroLiberado debería ser exactamente igual a Tablero excepto en las posiciones Posiciones que deben estar libres. Se presupone que Tablero es una matriz y que todas las coordenadas de Posiciones están en el rango de Tablero y que esas posiciones de Tablero no están libres.
% ----------------

% tableroConPosicionesLiberadas(+Tablero, +Posiciones, -TableroLiberado)
% Precondición: esMatriz(Tablero).
% Precondición: para cada (I, J) en Posiciones: coordenadaEnRango(Tablero, (I,J)), not(libre(Tablero, (I,J))).
tableroConPosicionesLiberadas(T, [], T).
tableroConPosicionesLiberadas(T, [P | Ps], TL) :-
  tableroConPosiciónLiberada(T, P, TI),
  tableroConPosicionesLiberadas(TI, Ps, TL).

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

% vecinaEnDir(+(I, J), ?Dirección, -Vecina)
% Instancia en Vecina la coordenada vecina a (I,J) en la dirección Dirección (o instancia cada par dirección-vecina en Dirección y Vecina, respectivamente).
vecinaEnDir((I, J), norte, (I2, J)) :- I2 is I-1.
vecinaEnDir((I, J), este, (I, J2)) :- J2 is J+1.
vecinaEnDir((I, J), sur, (I2, J)) :- I2 is I+1.
vecinaEnDir((I, J), oeste, (I, J2)) :- J2 is J-1.

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
% Precondición: para cada (I, J) en Posiciones: coordenadaEnRango(Tablero, (I,J)), not(libre(Tablero, (I,J))).
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
% Implementar el predicado jugarPosición(+TableroInicial, +(I, J), -TableroResultante) que instancia en TableroResultante el tablero resultante de hacer una jugada en la posición (I,J) del tablero TableroInicial. Se presupone que TableroInicial es una matriz, que la coordenada (I,J) está en el rango de TableroInicial y que la posición en dicha coordenada está libre en TableroInicial.
% ----------------

% jugarPosición(+TableroInicial, +(I, J), -TableroResultante)
% Precondición: esMatriz(TableroInicial), coordenadaEnRango(TableroInicial, (I,J)), libre(TableroInicial, (I, J)).
jugarPosición(T, P, TR) :-
  jugadaPosible(T, P),
  coloresPredominantes(T, P, _, Ps),
  tableroConPosicionesLiberadas(T, Ps, TR).

% ----------------
% Ejercicio 5.b)
% Implementar el predicado jugarPosiciones(+TableroInicial, +Jugadas, -TableroResultante) que instancia en TableroResultante el tablero resultante de hacer jugadas en cada una de las posiciones de Jugadas sobre el tablero TableroInicial, en ese orden. Se presupone que TableroInicial es una matriz y que todas las coordenadas en Jugadas están en el rango de TableroInicial y que sus respectivas posiciones en TableroInicial están libres al momento de jugar sobre ellas.
% ----------------

% jugarPosiciones(+TableroInicial, +Jugadas, -TableroResultante)
% Precondición: esMatriz(TableroInicial).
% Precondición: para cada (I, J) en Jugadas: coordenadaEnRango(TableroInicial, (I,J)).
jugarPosiciones(T, [], T).
jugarPosiciones(T, [(I, J) | Ps], TR) :-
  jugarPosición(T, (I, J), TI),
  jugarPosiciones(TI, Ps, TR).

% jugarNaive(+TableroInicial, -TableroFinal)
% Precondición: esMatriz(TableroInicial).
jugarNaive(T, T) :-
  not(jugadaPosible(T, _)).
jugarNaive(T, TF) :-
  jugadaPosible(T, J),
  jugarPosición(T, J, TI),
  jugarNaive(TI, TF).


% ----------------
% Ejercicio 6.a)
% Implementar el predicado jugadasNaive(+Tablero, -Jugadas) que instancia en Jugadas la lista de jugadas que realizaría un jugador naive. Nuevamente, notar que si se le piden más resultados a este predicado termina instanciando todas las posibles secuencias de jugadas sobre el tablero (en este caso no deberían instanciarse resultados repetidos). Se presupone que Tablero es una matriz.
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
% Implementar el predicado victoriaConJugadas(+Tablero, +Jugadas) que es verdadero cuando la lista de jugadas en Jugadas logra la victoria en el tablero Tablero. Esto es, el tablero resultante de jugar las jugadas de Jugadas sobre el tablero Tablero, en ese orden, está vacío. Se presupone que Tablero es una matriz y que cada coordenada de Jugadas está en el rango de Tablero.
% ----------------

% victoriaConJugadas(+Tablero, +Jugadas).
% Precondición: esMatriz(Tablero).
% Precondición: para cada (I, J) en Jugadas: coordenadaEnRango(Tablero, (I,J)).
victoriaConJugadas(T, []) :-
  not(color(T, _, _)).
victoriaConJugadas(T, [J | Js]) :-
  jugarPosición(T, J, TI),
  victoriaConJugadas(TI, Js).

% ----------------
% Ejercicio 7.b)
% Implementar el predicado juegoNaiveVictorioso(+Tablero, -Jugadas) que instancia en Jugadas la lista de jugadas que realizaría un jugador naive y tras la cual alcanzaría la victoria. Nuevamente, notar que si se le piden más resultados a este predicado termina instanciando todas las posibles secuencias de jugadas victoriosas sobre el tablero (en este caso no deberían instanciarse resultados repetidos). Se presupone que Tablero es una matriz.
% ----------------

% juegoNaiveVictorioso(+Tablero, -Jugadas)
% Precondición: esMatriz(Tablero).
juegoNaiveVictorioso(T, J) :-
  jugadasNaive(T, J),
  victoriaConJugadas(T, J).

% ----------------
% Ejercicio 7.c)
% Implementar el predicado mejorJuegoNaive(+Tablero, -Jugadas) que instancia en Jugadas la lista de jugadas correspondiente a alguno de los mejores juegos victoriosos que realizaría un jugador naive (si hay más de uno, debería instanciarlos todos) sobre el tablero Tablero. Un juego es mejor que otro si requiere menos jugadas para terminar. Se presupone que Tablero es una matriz.
% ----------------

% mejorJuegoNaive(+Tablero, -Jugadas)
% Precondición: esMatriz(Tablero).
mejorJuegoNaive(T, J) :-
  juegoNaiveVictorioso(T, J),
  length(J, K),
  not(hayJuegoNaiveVictoriosoMásCorto(T, K)).

% hayJuegoNaiveVictoriosoMásCorto(+Tablero, +K)
hayJuegoNaiveVictoriosoMásCorto(T, K) :-
  juegoNaiveVictorioso(T, J),
  length(J, K2),
  K2 < K.

% ----------------
% Ejercicio 8 - OPCIONAL
% Implementar el predicado tableroEnElQueNaiveGanaEmpezandoPor(-Tablero, +(I, J)) que instancia en Tablero cada tablero en el que un jugador naive podría llegar a salir victorioso si su primera jugada es en la posición de la coordenada (I,J).
% ----------------

% tableroEnElQueNaiveGanaEmpezandoPor(-Tablero, +(I, J))
tableroEnElQueNaiveGanaEmpezandoPor(T, (I, J)) :-
  desde(1,X),
  between(1,X,Filas),
  divideA(X,Filas),
  Columnas is X/Filas,
  tableroDe(Filas, Columnas, T),
  ganaNaiveEmpezandoPor(T, (I, J)),
  guiTablero(T).

% tableroDe(+Filas, +Columnas, -Tablero)
tableroDe(0, _, []).
tableroDe(F, C, [Fila|Filas]) :-
  F > 0,
  filaDe(C, Fila),
  F2 is F-1,
  tableroDe(F2, C, Filas).

% filaDe(+Columnas, -Fila)
filaDe(0, []).
filaDe(C, [X|Xs]) :-
  C > 0,
  posibleValorTablero(X),
  C2 is C-1,
  filaDe(C2, Xs).

% posibleValorTablero(-X)
posibleValorTablero(libre).
posibleValorTablero(Color) :- color(Color).

% ganaNaiveEmpezandoPor(+Tablero, +(I, J))
ganaNaiveEmpezandoPor(T, (I, J)) :-
  juegoNaiveVictorioso(T, [(I, J)|_]),
  !.

% divideA(+Dividendo, +Divisor)
divideA(X,Y) :-
  división(X,Y,_,0).

% división(+Dividendo, +Divisor, -Cociente, -Resto)
división(X,Y,C,R) :-
  C is (X // Y),
  R is (X mod Y).

% desde(+X, -Y)
desde(X,X).
desde(X,Y) :-
  desde(X,Y2),
  Y is Y2+1.

% ----------------
% Interfaz gráfica
% ----------------

% guiTablero(+Tablero)
%% NOTA: Si no funciona, usar en su lugar mostrarMatrizAlt.
guiTablero(T) :- mostrarMatriz(T), !.

% guiJugada(+Tablero1, +(I, J), +Tablero2)
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
tablero(4, [
  [rojo,  libre, libre, azul,  libre],
  [azul,  libre, azul,  libre, libre],
  [azul,  rojo,  libre, libre, azul],
  [rojo,  azul,  libre, rojo,  azul],
  [libre, azul,  libre, azul,  rojo]
]).
tablero(5, [
  [libre, azul,  libre],
  [rojo,  libre, rojo],
  [libre, azul,  libre]
]).
tablero(6, [
  [libre, azul,  libre],
  [azul,  libre, azul],
  [libre, azul,  libre]
]).
