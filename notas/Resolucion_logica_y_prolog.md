# Resumen: Resolución Lógica Proposicional y Programación en Prolog

---

## Parte 1: Resolución Lógica Proposicional (Teórica)

### 1. Interpretación Lógica de Programas Lógicos

Un programa lógico se fundamenta en formulas atómicas y reglas que expresan conocimiento declarativo sobre un dominio.

#### Términos y Fórmulas Atómicas

* **Término**: Variable, constante o función aplicada a términos.
* **Fórmula atómica**: Predicado $P(t_1, \dots, t_n)$ aplicado a $n$ términos.

#### Reglas y Hechos

Un programa lógico es un conjunto de reglas. La sintaxis de una regla es:

$$\sigma \text{ :- } \tau_1, \dots, \tau_n .$$

donde $\sigma, \tau_1, \dots, \tau_n$ son fórmulas atómicas.

* **Hecho**: Regla sin condiciones ($n = 0$), denotada simplemente como $\sigma.$
* **Interpretación Lógica de una Regla**: Representa una implicación donde todas las variables libres están cuantificadas universalmente:

$$\forall X_1 \dots \forall X_k . ((\tau_1 \land \dots \land \tau_n) \Rightarrow \sigma)$$

#### Consultas (Queries)

Una consulta tiene la forma:

$$\text{?- } \sigma_1, \dots, \sigma_n .$$

* **Interpretación Lógica de una Consulta**: Representa una fórmula cuantificada existencialmente sobre sus variables libres:

$$\exists X_1 \dots \exists X_k . (\sigma_1 \land \dots \land \sigma_n)$$

* **Mecanismo de Refutación**: El motor de ejecución intenta refutar la negación de la consulta ($\neg \tau \Rightarrow \bot$) utilizando el método de resolución.

---

### 2. Pasaje a Forma Clausal Proposicional

Para aplicar resolución en lógica proposicional, una fórmula arbitraria $\sigma$ debe transformarse a su **Forma Clausal** equivalente.

#### Definiciones Formales

* **Literal ($l$)**: Una variable proposicional o su negación.

$$l ::= P \mid \neg P$$


* **Cláusula ($\kappa$)**: Una disyunción de literales. Representada formalmente como un conjunto de literales:

$$\kappa = \{l_1, l_2, \dots, l_m\} \equiv (l_1 \lor l_2 \lor \dots \lor l_m)$$


* **Conjunto de Cláusulas ($\mathcal{C}$)**: Una conjunción de cláusulas (Forma Normal Conjuntiva o CNF). Representada formalmente como un conjunto de conjuntos:

$$\mathcal{C} = \{\kappa_1, \kappa_2, \dots, \kappa_n\} \equiv (\kappa_1 \land \kappa_2 \land \dots \land \kappa_n)$$



#### Algoritmo de Pasaje a Forma Clausal

Dado un teorema $\sigma$ que se desea demostrar válido ($\vdash \sigma$), el método niega la fórmula ($\neg \sigma$) y la transforma a forma clausal:

1. **Eliminar Implicaciones**:

$$\alpha \Rightarrow \beta \longrightarrow \neg \alpha \lor \beta$$


2. **Forma Normal Negada (NNF)**: Empujar las negaciones mediante las leyes de De Morgan y eliminación de doble negación:

$$\neg (\alpha \land \beta) \longrightarrow \neg \alpha \lor \neg \beta$$


$$\neg (\alpha \lor \beta) \longrightarrow \neg \alpha \land \neg \beta$$


$$\neg \neg \alpha \longrightarrow \alpha$$


3. **Forma Normal Conjuntiva (CNF)**: Distribuir la disyunción ($\lor$) sobre la conjunción ($\land$):

$$\alpha \lor (\beta \land \gamma) \longrightarrow (\alpha \lor \beta) \land (\alpha \lor \gamma)$$


$$(\alpha \land \beta) \lor \gamma \longrightarrow (\alpha \lor \gamma) \land (\beta \lor \gamma)$$


4. **Conversión a Conjuntos**: Aprovechando las propiedades de asociatividad, conmutatividad e idempotencia de $\lor$ y $\land$, cada disyunción se convierte en un conjunto de literales y la conjunción en un conjunto de cláusulas.

---

### 3. Algoritmo de Refutación por Resolución Proposicional

#### Regla de Resolución Proposicional

Dadas dos cláusulas que contienen literales complementarios $P$ y $\neg P$:

$$\frac{\{P, l_1, \dots, l_n\} \quad \{\neg P, l_1', \dots, l_m'\}}{\{l_1, \dots, l_n, l_1', \dots, l_m'\}}$$

La cláusula resultante se denomina **resolvente**.

#### Algoritmo de Refutación

Entrada: Conjunto inicial de cláusulas $\mathcal{C}_0$ derivado de $\neg \sigma$.

Salida: `INSAT` (insatisfactible, la fórmula original $\sigma$ es válida) o `SAT` (satisfactible, la fórmula no es válida).

1. Inicializar $\mathcal{C} := \mathcal{C}_0$.
2. Si la cláusula vacía $\{\} \in \mathcal{C}$, retornar `INSAT`.
3. Elegir dos cláusulas $\kappa, \kappa' \in \mathcal{C}$ que contengan literales opuestos $P$ y $\neg P$.
4. Calcular su resolvente $\rho$.
5. Si $\rho$ no está en $\mathcal{C}$:
* Actualizar $\mathcal{C} := \mathcal{C} \cup \{\rho\}$.
* Volver al paso 1.


6. Si no es posible generar nuevas resolventes y $\{\} \notin \mathcal{C}$, retornar `SAT`.

#### Propiedades del Método Proposicional

* **Corrección (Soundness)**: El pasaje a forma clausal preserva equivalencia lógica ($\vdash \sigma \iff \mathcal{C} \vdash \bot$).
* **Completitud y Terminación**: En lógica proposicional, si hay $n$ literales distintos, existen como máximo $2^n$ cláusulas posibles. Por lo tanto, el algoritmo siempre termina y devuelve `INSAT` si y solo si $\mathcal{C}_0 \vdash \bot$.

---

## Parte 2: Programación Lógica en Prolog (Práctica)

### 1. Elementos Básicos y Sintaxis

Prolog utiliza un subconjunto de la lógica de primer orden conocido como **Cláusulas de Horn**.

#### Términos

* **Átomos**: Comienzan con minúscula (ej. `juan`, `pizza`, `padre`).
* **Números**: Constantes numéricas (ej. `25`, `3.14`).
* **Variables**: Comienzan con Mayúscula o guion bajo `_` (ej. `X`, `Hijo`, `_resto`).

#### Hechos y Consultas

Un hecho declara una relación que se asume verdadera de forma incondicional.

```prolog
% Hechos en la Base de Conocimientos (KB)
gustar(juan, pizza).
padre(homero, bart).
padre(homero, lisa).

```

Consultas simples en la terminal:

```prolog
?- gustar(juan, pizza).
true.

?- gustar(juan, empanadas).
false.

```

> **Suposición de Mundo Cerrado (CWA)**: Todo lo que no se pueda demostrar como verdadero a partir de la Base de Conocimientos se asume falso.

---

### 2. Variables y Unificación

La unificación es el proceso mediante el cual Prolog iguala términos asignando valores a las variables (obteniendo el unificador más general o $MGU$).

#### Reglas de Unificación

1. **Constante con Constante**: Unifican solo si son idénticas (`juan = juan` resulta `true`).
2. **Variable con Término**: Una variable libre unifica con cualquier término y queda ligada a él (`X = pizza` resulta `X = pizza`).
3. **Estructura con Estructura**: Unifican si tienen el mismo nombre de predicado, la misma aridad (número de argumentos) y sus argumentos unifican uno a uno.

```prolog
?- punto(X, 10) = punto(5, Y).
X = 5,
Y = 10.

?- persona(juan, Edad) = persona(Nombre, 25).
Nombre = juan,
Edad = 25.

```

#### Variables Anónimas

Cualquier variable que comience con `_` indica que el valor instanciado no necesita mostrarse al usuario.

```prolog
?- padre(homero, _).
true.

```

---

### 3. Reglas y Estrategia de Búsqueda

Una regla establece una relación condicional.

* `:-` representa la implicación lógica invertida ("si").
* `,` representa la conjunción lógica ("y").

```prolog
% X es tío de Y si Z es padre de Y y X es hermano de Z
tio(X, Y) :-
    padre(Z, Y),
    hermano(X, Z).

```

#### Estrategia de Búsqueda de Prolog

Cuando el motor evalúa una consulta, sigue tres principios:

1. **De arriba hacia abajo**: Recorre las cláusulas en el orden exacto en que están escritas en el archivo.
2. **De izquierda a derecha**: En una regla, evalúa los objetivos del cuerpo ordenadamente de izquierda a derecha.
3. **Búsqueda en Profundidad (DFS) y Backtracking**: Si alcanza un punto donde una condición falla (`false`), el motor retrocede (*backtrack*) al último punto de decisión con alternativas y prueba la siguiente cláusula. En la terminal se solicita la siguiente alternativa con el carácter `;`.

---

### 4. Aritmética en Prolog

Prolog distingue entre la unificación simbólica (`=`) y la evaluación matemática (`is`).

* `=` **Unificación simbólica**: No evalúa expresiones.
* `is` **Evaluación aritmética**: Evalúa la expresión del lado derecho y unifica el resultado con el lado izquierdo. Requiere que todos los valores del lado derecho estén instanciados.

```prolog
?- X = 2 + 3.
X = 2 + 3.

?- X is 2 + 3.
X = 5.

```

---

### 5. Recursividad

Debido a la ausencia de estructuras de control iterativas (`for`, `while`), las repeticiones en Prolog se expresan recursivamente con un **Caso Base** y un **Caso Recursivo**.

```prolog
% Caso Base: Un padre es ancestro directo
ancestro(X, Y) :-
    padre(X, Y).

% Caso Recursivo: X es ancestro de Y si es padre de un Z y Z es ancestro de Y
ancestro(X, Y) :-
    padre(X, Z),
    ancestro(Z, Y).

```

---

### 6. Procesamiento de Listas

Una lista en Prolog se denota entre corchetes `[...]`. La estructura interna divide la lista en **Cabeza** (`Head`, primer elemento) y **Cola** (`Tail`, lista con el resto de elementos): `[Cabeza | Cola]`.

#### Unificación sobre Listas

```prolog
?- [X | Y] = [a, b, c].
X = a,
Y = [b, c].

?- [1, 2 | Resto] = [1, 2, 3, 4].
Resto = [3, 4].

```

#### Predicados Fundamentales sobre Listas

##### Pertenencia (`pertenece/2`)

Comprueba o genera elementos pertenecientes a una lista.

```prolog
% Caso base: El elemento es la cabeza
pertenece(X, [X | _]).

% Caso recursivo: El elemento está en la cola
pertenece(X, [_ | Cola]) :-
    pertenece(X, Cola).

```

##### Longitud de una lista (`longitud/2`)

Cuenta la cantidad de elementos utilizando `is` en el retorno de la recursión.

```prolog
% Caso base: La lista vacía tiene longitud 0
longitud([], 0).

% Caso recursivo: 1 + la longitud de la cola
longitud([_ | Cola], N) :-
    longitud(Cola, NCola),
    N is NCola + 1.

```

##### Concatenación y Reversibilidad (`concatenar/3`)

`concatenar(L1, L2, L3)` indica que `L3` es el resultado de unir `L1` y `L2`.

```prolog
% Caso base: Concatenar la lista vacía con L resulta en L
concatenar([], L, L).

% Caso recursivo: Mantener el elemento de la cabeza en el resultado
concatenar([X | L1], L2, [X | L3]) :-
    concatenar(L1, L2, L3).

```

Ejemplos de uso multidireccional de `concatenar/3`:

```prolog
% 1. Unir dos listas
?- concatenar([1, 2], [3, 4], R).
R = [1, 2, 3, 4].

% 2. Generar todas las particiones posibles de una lista
?- concatenar(X, Y, [a, b]).
X = [], Y = [a, b] ;
X = [a], Y = [b] ;
X = [a, b], Y = [] .

```

##### Prefijo, Sufijo y Sublista con `concatenar/3`

```prolog
prefijo(L, P) :-
    concatenar(P, _, L).

sufijo(L, S) :-
    concatenar(_, S, L).

sublista(L, SL) :-
    sufijo(L, S),
    prefijo(S, SL).

```

##### Inserción en cualquier posición (`insertar/3`)

Inserta un elemento `X` en cualquier posición de la lista `L`.

```prolog
insertar(X, L, LX) :-
    concatenar(P, D, L),
    concatenar(P, [X | D], LX).

```

```prolog
?- insertar(x, [1, 2], Res).
Res = [x, 1, 2] ;
Res = [1, x, 2] ;
Res = [1, 2, x].

```

##### Permutaciones (`permutacion/2`)

Genera o verifica los reordenamientos posibles de una lista.

```prolog
% Caso base: La permutación de [] es []
permutacion([], []).

% Caso recursivo: Permutar la cola e insertar el elemento en cualquier posición
permutacion([X | Cola], Perm) :-
    permutacion(Cola, PCola),
    insertar(X, PCola, Perm).

```

```prolog
?- permutacion([1, 2], P).
P = [1, 2] ;
P = [2, 1].

```