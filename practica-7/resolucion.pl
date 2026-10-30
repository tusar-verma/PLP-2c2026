/*===== Ejercicio 1 =====*/

padre(juan, carlos).
padre(juan, luis).
padre(carlos, daniel).
padre(carlos, diego).
padre(luis, pablo).
padre(luis, manuel).
padre(luis, ramiro).
padre(daniel, jose).
abuelo(X,Y) :- padre(X,Z), padre(Z,Y).  

% --- I ---
% X = juan ;
% false.


% --- II ---
hijo(X, Y) :- padre(Y, X).

hermano(X, Y) :- 
    padre(Z, X), 
    padre(Z, Y),
    X \= Y.

descendiente(X, Y) :- 
    padre(Y, X).
descendiente(X, Y) :- 
    padre(Z, X), 
    descendiente(Z, Y).

%  --- III ---

/*
descendiente(A, juan).
    Regla 1: padre(juan, A)
        A = carlos (solución 1)
        A = luis (solucion 2)
    Regla 2: padre(Z, A), descendiente(Z, juan)
        padre(Z, A),
            Z = juan
            A = carlos
                descendiente(juan, juan)
                    Regla 1: padre(juan, juan) (false)
                    Regla 2: padre (Z, juan), (false)
            Z = juan
            A = luis
                descendiente(juan, juan)
                    Regla 1: padre(juan, juan) (false)
                    Regla 2: padre (Z, juan), (false)

            Z = carlos
            A = daniel
                descendiente(carlos, juan)
                    Regla 1: padre(juan, carlos) (true)
                        A = daniel  (solucion 3)
                    Regla 2: padre(Z2, carlos), descendiente(Z2, juan)
                        Z2 = juan 
                        descendiente(juan, juan) (false)
            Z = carlos
            A = diego
                descendiente(carlos, juan)
                    Regla 1: padre(juan, carlos) (true) (A = diego  (solucion 4))
                    Regla 2: padre(Z2, carlos), descendiente(Z2, juan)
                        Z2 = juan 
                        descendiente(juan, juan) (false)

            Z = luis
            A = pablo
                descendiente(luis, juan)
                    Regla 1: padre(juan, luis) (true) (A = pablo  (solucion 5))
                    Regla 2: padre(Z2, luis), descendiente(Z2, juan)
                        Z2 = juan 
                        descendiente(juan, juan) (false)
            Z = luis
            A = manuel
                descendiente(luis, juan)
                    Regla 1: padre(juan, luis) (true) (A = manuel  (solucion 6))
                    Regla 2: padre(Z2, luis), descendiente(Z2, juan)
                        Z2 = juan 
                        descendiente(juan, juan) (false)
            Z = luis
            A = ramiro
                descendiente(luis, juan)
                    Regla 1: padre(juan, luis) (true) (A = ramiro (solucion 7))
                    Regla 2: padre(Z2, luis), descendiente(Z2, juan)
                        Z2 = juan 
                        descendiente(juan, juan) (false)


--- Escrito por gemini ---

?- descendiente(A, juan).
│
├── [Regla 1: padre(juan, A)]
│   ├── A = carlos  ──────────────────────────────────────────► ÉXITO (Solución 1)
│   └── A = luis    ──────────────────────────────────────────► ÉXITO (Solución 2)
│
└── [Regla 2: padre(Z, A), descendiente(Z, juan)]
    │
    ├── [padre(Z, A) unifica con padre(juan, carlos)] => Z = juan, A = carlos
    │   └── ?- descendiente(juan, juan).
    │       ├── [R1: padre(juan, juan)] ──────────────────────► FALLA
    │       └── [R2: padre(Z1, juan), ...] ───────────────────► FALLA (nadie es padre de juan)
    │
    ├── [padre(Z, A) unifica con padre(juan, luis)] => Z = juan, A = luis
    │   └── ?- descendiente(juan, juan).
    │       ├── [R1: padre(juan, juan)] ──────────────────────► FALLA
    │       └── [R2: padre(Z1, juan), ...] ───────────────────► FALLA
    │
    ├── [padre(Z, A) unifica con padre(carlos, daniel)] => Z = carlos, A = daniel
    │   └── ?- descendiente(carlos, juan).
    │       ├── [R1: padre(juan, carlos)] (Éxito) ────────────► ÉXITO (Solución 3: A = daniel)
    │       └── [R2: padre(Z1, carlos), ...]
    │           └── Z1 = juan => descendiente(juan, juan) ────► FALLA
    │
    ├── [padre(Z, A) unifica con padre(carlos, diego)] => Z = carlos, A = diego
    │   └── ?- descendiente(carlos, juan).
    │       ├── [R1: padre(juan, carlos)] (Éxito) ────────────► ÉXITO (Solución 4: A = diego)
    │       └── [R2: padre(Z1, carlos), ...] ─────────────────► FALLA
    │
    ├── [padre(Z, A) unifica con padre(luis, pablo)] => Z = luis, A = pablo
    │   └── ?- descendiente(luis, juan).
    │       ├── [R1: padre(juan, luis)] (Éxito) ──────────────► ÉXITO (Solución 5: A = pablo)
    │       └── [R2: padre(Z1, luis), ...] ───────────────────► FALLA
    │
    ├── [padre(Z, A) unifica con padre(luis, manuel)] => Z = luis, A = manuel
    │   └── ?- descendiente(luis, juan).
    │       ├── [R1: padre(juan, luis)] (Éxito) ──────────────► ÉXITO (Solución 6: A = manuel)
    │       └── [R2: padre(Z1, luis), ...] ───────────────────► FALLA
    │
    └── [padre(Z, A) unifica con padre(luis, ramiro)] => Z = luis, A = ramiro
        └── ?- descendiente(luis, juan).
            ├── [R1: padre(juan, luis)] (Éxito) ──────────────► ÉXITO (Solución 7: A = ramiro)
            └── [R2: padre(Z1, luis), ...] ───────────────────► FALLA
            
*/


%  --- IV ---
% abuelo(juan, A).


%  --- V ---
% hermano(pablo, A).

%  --- VI ---
%ancestro(X, X).
%ancestro(X, Y) :- ancestro(Z, Y), padre(X, Z).


%  --- VII ---
% eventualmente se resuelven todos los descendientes de juan, pero se llega a un bucle infinito y el programa se cuelga. Esto ocurre por la recursión, donde la segunda regla queda con 2 variables libres no instanciadas (y 1 fresca), por lo que en cada paso no se está reduciendo el problema.

/*
ancestro(juan, X) 
    regla 1   
        resuelve juan = X 
        si se pide otro valor falla y sigue a la siguiente regla.
    regla 2
        ancestro(Z, X), padre(juan, Z)
            ancestro(Z, X)
                regla 1 resuelve Z = X
                ancestro(X, X), padre(juan, X) 
                    resuelve X Carlos y Luis, y luego falla (backtracking a ancestro(Z, X))

                regla 2 implica resolver ancestro(Z2, X), padre(Z, Z2)
                ancestro(Z2, X), padre(Z, Z2), padre(juan, Z)
                    ancestro(Z2, X)
                        regla 1 resuelve Z2 = X
                            ancestro(X, X), padre(Z, X), padre(juan, Z)
                                resuelve Z = carlos y X los hijos de carlos: daniel, diego
                                resuelve Z = luis y X los hijos de luis: pablo, manuel, ramiro
                                luego falla (backtracking a ancestro(Z2, X)))

                        regla 2 implica resolver ancestro(Z3, X), padre(Z2, Z3)
                        ancestro(Z3, X), padre(Z2, Z3), padre(Z, Z2), padre(juan, Z)
                            ancestro(Z3, X)
                                regla 1 resuelve Z3 = X
                                ancestro(X, X), padre(Z2, X), padre(Z, Z2), padre(juan, Z)
                                    como la base de conocimiento no tiene valores para hacer verdadero esta formula, falla y hace backtracking.

                                regla 2 ...
                                    y asi se sigue infinitamente
*/

%  --- VIII ---
% el problema fue el llamado recursivo con 2 variables libres. Tratemos de evitar esto.

%ancestro(X, X).
%anestro(X, Y) :- descendiente(Y, X).

% 

ancestro(X, Y) :- padre(X, Y).
ancestro(X, Y) :- padre(X, Z), ancestro(Z, Y).

/*
padre(X, Z), ancestro(Z, Y). 
    padre(X, Z), padre(Z, Y).

    el segundo termino de padre(...) corta los posibles llamados recursivos a solo aquellos con Z2 que sean hijos de Z
    padre(X, Z), padre(Z, Z2), ancestro(Z2, Y) 
*/

/*===== Ejercicio 2=====*/

vecino(X, Y, [W|Ls]) :- vecino(X, Y, Ls).
vecino(X, Y, [X|[Y|Ls]]).
%  --- I ---
/*
?- vecino(5, Y, [5, 6, 5, 3]).
│
├── [R1: vecino(X1, Y1, [X1, Y1 | Ls1])]
│     Unificación: {X1 := 5, Y1 := Y, 5 := 5, 6 := Y, Ls1 := [5, 3]} => Y = 6
│     ÉXITO (Solución 1: Y = 6)
│
└── [R2: vecino(X2, Y2, [W2 | Ls2]) :- vecino(X2, Y2, Ls2)]
      Unificación: {X2 := 5, Y2 := Y, W2 := 5, Ls2 := [6, 5, 3]}
      Meta: ?- vecino(5, Y, [6, 5, 3]).
      │
      ├── [R1: vecino(X3, Y3, [X3, Y3 | Ls3])]
      │     Unificación: {X3 := 5, Y3 := Y, X3 := 6, ...}
      │     Intenta 5 = 6 (Clash de constantes)
      │     ──────────────────────────────────► FALLA
      │
      └── [R2: vecino(X4, Y4, [W4 | Ls4]) :- vecino(X4, Y4, Ls4)]
            Unificación: {X4 := 5, Y4 := Y, W4 := 6, Ls4 := [5, 3]}
            Meta: ?- vecino(5, Y, [5, 3]).
            │
            ├── [R1: vecino(X5, Y5, [X5, Y5 | Ls5])]
            │     Unificación: {X5 := 5, Y5 := Y, 5 := 5, 3 := Y, Ls5 := []}
            │     => Y = 3
            │     ────────────────────────────► ÉXITO (Solución 2: Y = 3)
            │
            └── [R2: vecino(X6, Y6, [W6 | Ls6]) :- vecino(X6, Y6, Ls6)]
                  Unificación: {X6 := 5, Y6 := Y, W6 := 5, Ls6 := [3]}
                  Meta: ?- vecino(5, Y, [3]).
                  │
                  ├── [R1: vecino(X7, Y7, [X7, Y7 | Ls7])]
                  │     Unificación de [3] con [X7, Y7 | Ls7]
                  │     Falla: una lista de 1 elemento no unifica con [_, _ | _]
                  │     ──────────────────────► FALLA
                  │
                  └── [R2: vecino(X8, Y8, [W8 | Ls8]) :- vecino(X8, Y8, Ls8)]
                        Unificación: {X8 := 5, Y8 := Y, W8 := 3, Ls8 := []}
                        Meta: ?- vecino(5, Y, []).
                        │
                        ├── [R1: [X9, Y9 | _] = []] ──► FALLA
                        └── [R2: [_ | _] = []]      ──► FALLA

*/

%  --- II ---
% son los mismos resultados pero con el orden invertido. Pero como prolog en este caso exploró todas las posibles caminos, no devuelve false. (En la anterior, como prolog es lazy, al hacer ; sobre la lista [5,3] para probar la segunda regla, trata de resolver con [3] y [] y como no encuentra solución devuelve false).


/*===== Ejercicio 3=====*/
/*===== Ejercicio =====*/
/*===== Ejercicio =====*/
/*===== Ejercicio =====*/
/*===== Ejercicio =====*/
/*===== Ejercicio =====*/
