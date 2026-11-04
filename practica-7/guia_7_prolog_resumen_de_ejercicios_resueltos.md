## Guía Práctica 7: Programación Lógica (Prolog)

#### Ejercicio 1: Motor de Búsqueda, Reglas y Recursión
```prolog
padre(juan, carlos).   padre(juan, luis).
padre(carlos, daniel). padre(carlos, diego).
padre(luis, pablo).    padre(luis, manuel).    padre(luis, ramiro).
abuelo(X, Y) :- padre(X, Z), padre(Z, Y).
```
* **I.** `?- abuelo(X, manuel).` $\implies$ `X = juan ; false.`
* **II.** Definiciones:
  ```prolog
  hijo(X, Y) :- padre(Y, X).
  hermano(X, Y) :- padre(Z, X), padre(Z, Y), X \= Y.
  descendiente(X, Y) :- padre(Y, X).
  descendiente(X, Y) :- padre(Z, X), descendiente(Z, Y).
  ```
* **III.** Seguimiento `?- descendiente(Alguien, juan).`:
  * Regla 1 (`padre(juan, A)`): Devuelve `A = carlos` (sol 1) y `A = luis` (sol 2).
  * Regla 2 (`padre(Z, A), descendiente(Z, juan)`):
    * Con $Z = juan$, `descendiente(juan, juan)` falla (nadie es padre de Juan).
    * Con $Z = carlos$, `descendiente(carlos, juan)` es true $\implies A$ toma los hijos de Carlos: `daniel` (sol 3) y `diego` (sol 4).
    * Con $Z = luis$, `descendiente(luis, juan)` es true $\implies A$ toma los hijos de Luis: `pablo` (sol 5), `manuel` (sol 6) y `ramiro` (sol 7).
* **IV. Nietos de Juan:** `?- abuelo(juan, Nieto).`
* **V. Hermanos de Pablo:** `?- hermano(Hermano, pablo).`
* **VI - VII. Problema de `ancestro`:**
  * Reglas dadas: `ancestro(X, X).` y `ancestro(X, Y) :- ancestro(Z, Y), padre(X, Z).`
  * `ancestro(juan, X)` responde `X = juan`, pero al pedir más entra en recursión por izquierda con dos variables libres (`ancestro(Z, Y)`), generando una cadena infinita de metas `ancestro(Z2, Y)` sin consumir la base. Cuelga el intérprete (*stack overflow*).
* **VIII. Versión corregida:**
  ```prolog
  ancestro(X, Y) :- padre(X, Y).
  ancestro(X, Y) :- padre(X, Z), ancestro(Z, Y).
  ```



#### Ejercicio 2: Orden de Cláusulas y Árbol de Ejecución
```prolog
vecino(X, Y, [X, Y | Ls]).        % R1
vecino(X, Y, [_ | Ls]) :- vecino(X, Y, Ls). % R2
```
* **I.** Árbol de búsqueda para `?- vecino(5, Y, [5, 6, 5, 3]).`:
  * Rama R1 sobre `[5, 6, 5, 3]`: Unifica con `[5, Y | Ls1]` $\implies Y = 6$ (**Solución 1**).
  * Rama R2 sobre `[5, 6, 5, 3]`: Pasa a `vecino(5, Y, [6, 5, 3])`.
    * R1 sobre `[6, 5, 3]`: Falla por clash ($5 \neq 6$).
    * R2 sobre `[6, 5, 3]`: Pasa a `vecino(5, Y, [5, 3])`.
      * R1 sobre `[5, 3]`: Unifica con `[5, Y | []]` $\implies Y = 3$ (**Solución 2**).
      * R2 sobre `[5, 3]`: Pasa a `vecino(5, Y, [3])`.
        * R1 sobre `[3]`: Falla (lista de longitud 1 no unifica con `[_, _ | _]`).
        * R2 sobre `[3]`: Pasa a `vecino(5, Y, [])`, que falla por ambas reglas.
* **II. Inversión del orden de reglas:** Mismas soluciones lógicas, pero en orden inverso (`Y = 3`, luego `Y = 6`).



#### Ejercicio 3: Bucles Infinitos y Terminación
* **I.** En `menorOIgual(X, suc(Y)) :- menorOIgual(X, Y).`, la consulta `?- menorOIgual(0, X).` unifica $X$ con $suc(Y_1)$, generando la meta recursiva `menorOIgual(0, Y_1)`. Como la regla recursiva está antes que el caso base, repite indefinidamente asignando $Y_1 = suc(Y_2)$ sin llegar jamás a la base. Cuelga en bucle infinito.
* **II. Causas de cuelgue en Prolog:**
  1. Recursión a izquierda directa o indirecta.
  2. Casos recursivos ubicados antes que los casos base.
  3. Metas recursivas que unifican contra variables libres frescas generando términos de tamaño no acotado sin condiciones de guarda.
* **III. Versión corregida:**
  ```prolog
  menorOIgual(0, X) :- natural(X).
  menorOIgual(suc(X), suc(Y)) :- menorOIgual(X, Y).
  ```



#### Ejercicios 4 y 5: Listas con `append/3`
```prolog
% Ej 4
juntar([], L, L).
juntar([X | L1], L2, [X | L3]) :- juntar(L1, L2, L3).

% Ej 5
last(L, U)       :- juntar(_, [U], L).
reverse([], []).
reverse([X|Xs], R):- reverse(Xs, R1), juntar(R1, [X], R).
prefijo(P, L)    :- juntar(P, _, L).
sufijo(S, L)     :- juntar(_, S, L).
sublista(S, L)   :- juntar(P, _, L), juntar(_, S, P).
pertenece(X, L)  :- juntar(_, [X | _], L).
```



#### Ejercicio 6: Aplanar Listas (`flatten`)
```prolog
aplanar(X, [X]) :- X \= [], X \= [_ | _].
aplanar([], []).
aplanar([X | L1], Y) :- 
    aplanar(X, Y1), 
    aplanar(L1, Y2), 
    append(Y1, Y2, Y).
```



#### Ejercicio 7: Operaciones de Conjuntos y Particiones
* **I. Intersección y Partir:**
  ```prolog
  interseccion([], _, []).
  interseccion([X | L1], L2, [X | L3]) :- member(X, L2), not(member(X, L1)), interseccion(L1, L2, L3).
  interseccion([X | L1], L2, L3)       :- member(X, L2), member(X, L1), interseccion(L1, L2, L3).
  interseccion([X | L1], L2, L3)       :- not(member(X, L2)), interseccion(L1, L2, L3).

  % partir(+N, +L, -L1, -L2) corregido para evitar cuelgues si N viene libre:
  partir(0, L, [], L).
  partir(N, [X|XS], [X|L1], L2) :-
      N > 0,
      N1 is N - 1,
      partir(N1, XS, L1, L2).
  ```
  *(Nota: La versión con `N is N1 + 1` al final cuelga si $N$ no está acotado; evaluar `N > 0` antes consume el contador).*
* **II. Borrar:**
  ```prolog
  borrar([], _, []).
  borrar([X|XS], X, YS)     :- borrar(XS, X, YS).
  borrar([Z|XS], X, [Z|YS]) :- X \= Z, borrar(XS, X, YS).
  ```
* **III. Sacar Duplicados:**
  ```prolog
  sacarDuplicados([], []).
  sacarDuplicados([X|XS], [X|L2]) :- not(member(X, XS)), sacarDuplicados(XS, L2).
  sacarDuplicados([X|XS], L2)     :- member(X, XS), sacarDuplicados(XS, L2).
  ```
* **IV. Permutación:**
  ```prolog
  permutacion([], []).
  permutacion(L, [X | P]) :-
      append(Pref, [X | Suf], L),
      append(Pref, Suf, Resto),
      permutacion(Resto, P).
  ```
* **V - VI. Repartos:**
  ```prolog
  reparto(L, 1, [L]).
  reparto(L, N, [Pref | RestoListas]) :-
      N > 1,
      N1 is N - 1,
      append(Pref, Resto, L),
      reparto(Resto, N1, RestoListas).

  repartoSinVacias([], []).
  repartoSinVacias(L, [Pref | RestoListas]) :-
      append(Pref, Resto, L),
      Pref \= [],
      repartoSinVacias(Resto, RestoListas).
  ```
  *(Nota de corrección en `repartoSinVacias`: caso base `repartoSinVacias([], []).` para evitar anidar `[[]]`).*



#### Ejercicio 8: Subconjunto que Suma $S$
```prolog
subconjunto([], []).
subconjunto([X | Xs], [X | Ys]) :- subconjunto(Xs, Ys).
subconjunto([_ | Xs], Ys)       :- subconjunto(Xs, Ys).

sumatoria([], 0).
sumatoria([X | Xs], S) :- sumatoria(Xs, S1), S is S1 + X.

parteQueSuma(L, S, P) :-
    subconjunto(L, P),
    P \= [],
    sumatoria(P, S).
```



#### Ejercicio 9: Reversibilidad y `is`
* `desde(X, X).` / `desde(X, Y) :- N is X + 1, desde(N, Y).`
* **I.** Exige $X$ instanciado numéricamente (`+X, ?Y`) porque `is/2` requiere todas las variables de su término derecho ligadas.
* **II. `desdeReversible(+X, ?Y)`:**
  ```prolog
  desdeReversible(X, Y) :- nonvar(Y), Y >= X.
  desdeReversible(X, Y) :- var(Y), desde(X, Y).
  ```



#### Ejercicio 10: Intercalar
```prolog
intercalar([], L2, L2).
intercalar(L1, [], L1) :- L1 \= [].
intercalar([X | L1], [Y | L2], [X, Y | L3]) :- intercalar(L1, L2, L3).
```
* **Reversibilidad:** Totalmente reversible para `(+L1, +L2, -L3)` y `(-L1, -L2, +L3)`.



#### Ejercicio 11: Árboles Binarios Básicos
```prolog
vacio(nil).
raiz(bin(_, V, _), V).

altura(nil, 0).
altura(bin(Izq, _, Der), N) :-
    altura(Izq, HI), altura(Der, HD),
    N is max(HI, HD) + 1.

cantidadDeNodos(nil, 0).
cantidadDeNodos(bin(Izq, _, Der), N) :-
    cantidadDeNodos(Izq, N1), cantidadDeNodos(Der, N2),
    N is N1 + N2 + 1.
```



#### Ejercicio 12: Inorder y ABB
```prolog
% I. inorder(+AB, -L)
inorder(nil, []).
inorder(bin(Izq, V, Der), L) :-
    inorder(Izq, LI), inorder(Der, LD),
    append(LI, [V | LD], L).

% II. arbolConInorder(+L, -AB)
arbolConInorder([], nil).
arbolConInorder(L, bin(Izq, X, Der)) :-
    append(L1, [X | L2], L),
    arbolConInorder(L1, Izq),
    arbolConInorder(L2, Der).

% III. aBB(+T)
aBB(nil).
aBB(Ab) :- inorder(Ab, L), listaOrdenada(L).

listaOrdenada([]).
listaOrdenada([_]).
listaOrdenada([X1, X2 | XS]) :- X1 =< X2, listaOrdenada([X2 | XS]).

% IV. aBBInsertar(+X, +T1, ?T2)
aBBInsertar(X, nil, bin(nil, X, nil)).
aBBInsertar(X, bin(Izq, V, Der), bin(NuevoIzq, V, Der)) :-
    X < V, aBBInsertar(X, Izq, NuevoIzq).
aBBInsertar(X, bin(Izq, V, Der), bin(Izq, V, NuevoDer)) :-
    X > V, aBBInsertar(X, Der, NuevoDer).
aBBInsertar(X, bin(Izq, X, Der), bin(Izq, X, Der)).
```



#### Ejercicio 13: Generación de Pares Coprimos (G&T)
```prolog
coprimos(X, Y) :-
    desde(2, S),
    between(1, S, X),
    Y is S - X, Y >= 1,
    1 =:= gcd(X, Y).
```
*(Se usa `desde/2` sobre la suma $S = X + Y$ para explorar un espacio infinito de manera diagonal y exhaustiva).*



#### Ejercicio 14: Cuadrados Semi-Mágicos y Mágicos (G&T)
```prolog
cuadradoSemiMagico(0, []).
cuadradoSemiMagico(N, XS) :-
    N > 0, desde(0, S),
    generarMatriz(N, N, S, XS).

generarMatriz(0, _, _, []).
generarMatriz(Filas, Cols, S, [Fila | Resto]) :-
    Filas > 0, F1 is Filas - 1,
    generarFila(Cols, S, Fila),
    generarMatriz(F1, Cols, S, Resto).

generarFila(0, 0, []).
generarFila(K, S, [X | Xs]) :-
    K > 0, K1 is K - 1,
    between(0, S, X),
    SResto is S - X,
    generarFila(K1, SResto, Xs).

% Cuadrado Mágico completo (Generate & Test):
cuadradoMagico(N, M) :-
    cuadradoSemiMagico(N, M),
    M = [Fila1 | _],
    sum_list(Fila1, S),
    testColumnas(N, S, M).

testColumnas(0, _, _).
testColumnas(Col, S, M) :-
    Col > 0,
    columnaSuma(Col, M, S),
    C1 is Col - 1,
    testColumnas(C1, S, M).

columnaSuma(_, [], 0).
columnaSuma(Col, [Fila | Filas], S) :-
    nth1(Col, Fila, Elem),
    columnaSuma(Col, Filas, S1),
    S is S1 + Elem.
```



#### Ejercicio 15: Triángulos y Generación Infinita (Agregado clave)
*(Aporta el manejo de estructuras geométricas y generación finita/infinita según instanciación).*
```prolog
% I. esTriangulo(+T)
esTriangulo(tri(A, B, C)) :-
    A > 0, B > 0, C > 0,
    A < B + C, A > abs(B - C),
    B < A + C, B > abs(A - C),
    C < A + B, C > abs(A - B).

% II. perimetro(?T, ?P)
perimetro(tri(A, B, C), P) :-
    nonvar(P),
    between(1, P, A),
    LimB is P - A,
    between(1, LimB, B),
    C is P - (A + B),
    C > 0,
    esTriangulo(tri(A, B, C)).
perimetro(T, P) :-
    var(P),
    desde(3, P),
    perimetro(T, P).

% III. triangulo(-T)
triangulo(T) :- perimetro(T, _).
```



#### Ejercicio 16: Poda del Árbol con Corte (`!`)
```prolog
frutal(frutilla). frutal(banana). frutal(manzana).
cremoso(banana).  cremoso(americana). cremoso(frutilla). cremoso(dulceDeLeche).
leGusta(X) :- frutal(X), cremoso(X).
cucurucho(X, Y) :- leGusta(X), leGusta(Y).
```
* **Efectos de ubicación de `!`:**
  * `leGusta(X) :- frutal(X), !, cremoso(X).`: Toma solo la primera fruta (`frutilla`); si es cremosa devuelve únicamente esa; si no fuera cremosa, falla sin probar `banana`.
  * `cucurucho(X, Y) :- leGusta(X), !, leGusta(Y).`: Fija el primer sabor en `X = frutilla` y poda todas las demás opciones de $X$. Devuelve solo los cucuruchos con frutilla de primer sabor.
  * `cucurucho(X, Y) :- leGusta(X), leGusta(Y), !.`: Devuelve exclusivamente la primera solución completa (`X = frutilla, Y = frutilla`).



#### Ejercicio 17: Semántica y Peligros de `not/1`
* **I.** `?- P(Y), not(Q(Y)).` $\implies$ Genera las instancias de $Y$ que satisfacen $P$ y que **no** hacen demostrable $Q(Y)$.
* **II.** `?- not(Q(Y)), P(Y).` $\implies$ Si existe *algún* elemento en la base que satisfaga $Q$, `not(Q(Y))` falla de inmediato y la consulta no produce ninguna solución.
* **III. Existencia de un único testigo:**
  ```prolog
  unicoP(Y) :- P(Y), not((P(Z), Z \= Y)).
  ```



#### Ejercicio 18: Corte Más Parejo
```prolog
corte(L, L1, L2, Diff) :-
    append(L1, L2, L),
    sum_list(L1, S1),
    sum_list(L2, S2),
    Diff is abs(S1 - S2).

corteMasParejo(L, L1, L2) :-
    corte(L, L1, L2, Diff),
    not((corte(L, _, _, DiffMenor), DiffMenor < Diff)).
```



#### Ejercicio 20: Próximo Número Poderoso
```prolog
proximoNumPoderoso(X, Y) :-
    Inicio is X + 1,
    desde(Inicio, Y),
    esPoderoso(Y),
    !. % Frena en el primer candidato válido

esPoderoso(Y) :-
    not((divisorPrimo(Y, P), Cuad is P * P, 0 =\= Y mod Cuad)).

divisorPrimo(Y, P) :-
    between(2, Y, P),
    0 =:= Y mod P,
    esPrimo(P).

esPrimo(P) :-
    P > 1,
    P1 is P - 1,
    not((between(2, P1, D), 0 =:= P mod D)).
```



#### Ejercicio 21: Para Todo ($\forall$) y Conjuntos (Agregado conceptual)
* **Definición correcta con doble negación:**
  ```prolog
  conjuntoDeNaturales(X) :-
      not((pertenece(E, X), not(natural(E)))).
  ```
* **Error en la versión alternativa:**
  `not((not(natural(E)), pertenece(E, X)))` evalúa `not(natural(E))` con $E$ libre. Como `natural(E)` unifica con `0` (éxito), `not(natural(E))` falla de inmediato. La conjunción interior falla siempre, y el `not(...)` exterior devuelve erróneamente `true` para cualquier $X$.



#### Ejercicio 22: Grafos No Orientados
```prolog
conectados(G, X, Y) :- esArista(G, X, Y).
conectados(G, X, Y) :- esArista(G, Y, X).

% I. Camino Simple
caminoSimple(G, D, H, L) :-
    esNodo(G, D), esNodo(G, H),
    pasoCamino(G, D, H, [D], L).

pasoCamino(_, H, H, _, [H]).
pasoCamino(G, Actual, H, Visitados, [Actual | LResto]) :-
    Actual \= H,
    conectados(G, Actual, Sig),
    not(member(Sig, Visitados)),
    pasoCamino(G, Sig, H, [Sig | Visitados], LResto).

% II. Camino Hamiltoniano
caminoHamiltoniano(G, L) :-
    caminoSimple(G, _, _, L),
    not((esNodo(G, N), not(member(N, L)))).

% III. Es Conexo
esConexo(G) :-
    not((esNodo(G, A), esNodo(G, B), not(caminoSimple(G, A, B, _)))).

% IV. Es Estrella
esEstrella(G) :-
    esConexo(G),
    esNodo(G, Centro),
    not((esArista(G, A, B), A \= Centro, B \= Centro)).
```



#### Ejercicio 23: Generación Exhaustiva de Árboles
```prolog
% I. Generador de estructuras sin instanciar valores:
arbol(A) :- desde(0, N), generarArbolN(N, A).

generarArbolN(0, nil).
generarArbolN(N, bin(Izq, _, Der)) :-
    N > 0,
    NSub is N - 1,
    between(0, NSub, NIzq),
    NDer is NSub - NIzq,
    generarArbolN(NIzq, Izq),
    generarArbolN(NDer, Der).

% II. Nodos pertenecientes a un conjunto L:
nodosEn(nil, _).
nodosEn(bin(Izq, V, Der), L) :-
    member(V, L),
    nodosEn(Izq, L),
    nodosEn(Der, L).

% III. Árboles sin repetir etiquetas del alfabeto L:
sinRepEn(nil, _).
sinRepEn(bin(Izq, V, Der), L) :-
    select(V, L, Resto),
    particion(Resto, LIzq, LDer),
    sinRepEn(Izq, LIzq),
    sinRepEn(Der, LDer).

particion([], [], []).
particion([X | Xs], [X | L1], L2) :- particion(Xs, L1, L2).
particion([X | Xs], L1, [X | L2]) :- particion(Xs, L1, L2).
```