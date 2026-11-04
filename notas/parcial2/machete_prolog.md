# Machete Prolog

## 1. Fundamentos

* **Sintaxis Base:**
  * **Átomos/Constantes:** Empiezan con minúscula (`juan`, `nil`, `a`, `cero`).


  * **Variables:** Empiezan con mayúscula (`X`, `Resto`, `Lista`).


  * **Variable Anónima (`_`):** Cuando no interesa el valor ni reportar la unificación.


  * **Cláusulas:** Terminan obligatoriamente con punto (`.`).




* **Mundo Cerrado y Negación (`not/1`):**
  * `not(P)` tiene éxito si $P$ falla; falla si $P$ tiene éxito.


  * **No liga variables:** Cualquier variable que esté libre dentro de `not(P)` se cuantifica existencialmente ($\neg \exists X . P(X)$) y queda libre al salir.


  * **Patrón obligatorio de filtrado:** Primero instanciar, luego negar: `member(X, L), not(condicion(X))`. (Hacer `not(condicion(X)), member(X, L)` falla si existe *algún* elemento que cumpla la condición).




* **Esquema Generate & Test:**
  * `pred(X) :- generar_candidato(X), test(X)`.


  * El generador va a la izquierda y acota el dominio; el test va a la derecha.




* **Recursión y No Terminación (DFS):**
  * Colocar siempre los **casos base antes de los casos recursivos**.


  * Evitar recursión a izquierda directa (`p(X) :- p(Y), ...`) para no colgar el motor en bucle infinito.




* **Restricción de Examen:** Salvo `not/1`, **no están permitidos otros metapredicados** (`findall`, `setof`, `bagof`, `maplist`, etc.) ni el operador de corte `!` para resolver ejercicios de parcial.



## 2. Operaciones Extra-lógicas y Aritmética

| Operador / Predicado | Descripción | Ejemplo |
| --- | --- | --- |
| `X = Y` | **Unificación puramente simbólica** (no calcula).| `X = 2 + 3` $\implies X = 2 + 3$. |
| `X \= Y` | Falla si $X$ unifica con $Y$; éxito si no unifican.| `a \= b` $\to$ `true`; `2 \= 2` $\to$ `false`. |
| `X is Exp` | **Evalúa aritméticamente** `Exp` y unifica con `X`.| `X is 2 + 3` $\implies X = 5$. *(Lado derecho debe estar instanciado)*. |
| `=:=` , `=\=` | Igualdad y desigualdad aritmética (evalúa ambos lados). | `1 + 1 =:= 2` $\to$ `true`; `3 =\= 2` $\to$ `true`. |
| `<`, `>`, `=<`, `>=` | Comparación aritmética (`=<` y `>=` no forman flechas). | `2 =< 3` $\to$ `true`. |
| `==` , `\==` | Igualdad/desigualdad sintáctica estricta (sin unificar variables). | `X == Y` $\to$ `false` si son variables distintas no ligadas. |
| `mod(A, B)` | Resto de división entera (usar dentro de `is` o `=:=`). | `R is mod(7, 3)` $\implies R = 1$. |
| `gcd(A, B)` | Máximo común divisor aritmético. | `M is gcd(12, 8)` $\implies M = 4$. |
| `abs(X)`, `max(A, B)`, `min(A, B)` | Funciones matemáticas dentro de `is`. | `D is abs(5 - 9)` $\implies D = 4$. |
| `var(X)` / `nonvar(X)` | Éxito si $X$ es variable libre / si $X$ está instanciada. | `var(X)` $\to$ `true`; `nonvar(3)` $\to$ `true`. |
| `ground(X)` | Éxito si $X$ no contiene ninguna variable libre en su estructura. | `ground([1, a])` $\to$ `true`; `ground([X, 1])` $\to$ `false`. |


## 3. Diccionario de Predicados Permitidos (con Ejemplos)

### Generación y Números

* **`between(+Low, +High, ?Value)`**


    * Genera o verifica enteros en el rango inclusivo $[Low, High]$.


    * *Ejemplo:* `between(1, 3, X).` $\implies X=1; \, X=2; \, X=3.$


* **`numlist(+Low, +High, -List)`**
  * Genera la lista de enteros consecutivos desde `Low` hasta `High`.
  * *Ejemplo:* `numlist(2, 5, L).` $\implies L = [2, 3, 4, 5].$


* **`sum_list(+List, -Sum)`**
  * Suma todos los elementos numéricos de una lista.


  * *Ejemplo:* `sum_list([1, 2, 3], S).` $\implies S = 6.$


* **`number(?X)` / `atom(?X)`**
  * Verifican si el término es un número o un átomo constante.
  * *Ejemplo:* `number(4).` $\to$ `true`; `atom(hola).` $\to$ `true`; `atom(4).` $\to$ `false`.



### Listas Básicas y Posicionales

* **`member(?Elem, ?List)`**


  * Verifica pertenencia o genera uno a uno los elementos de `List`.


  * *Ejemplo:* `member(X, [1, 2]).` $\implies X=1; \, X=2$.




* **`append(?L1, ?L2, ?L3)`**


  * Concatena `L1` y `L2` en `L3`, o parte `L3` en todas sus combinaciones.


  * *Ejemplo:* `append([1], [2], L).` $\implies L = [1, 2]$. `append(A, B, [1, 2]).` $\implies A=[], B=[1, 2]; \dots$




* **`length(?List, ?N)`**


  * Calcula la longitud o genera listas de $N$ variables libres.


  * *Ejemplo:* `length([a, b], N).` $\implies N = 2$. `length(L, 2).` $\implies L = [\_, \_]$.




* **`last(?List, ?Elem)`**


    * Verdadero si `Elem` es el último elemento de `List`.


    * *Ejemplo:* `last([a, b, c], X).` $\implies X = c.$


* **`nth0(?Index, ?List, ?Elem)` / `nth1(?Index, ?List, ?Elem)`**
  * Relaciona el elemento en la posición `Index` (0-indexada o 1-indexada).
  * *Ejemplo:* `nth0(1, [a, b, c], X).` $\implies X = b.$ `nth1(1, [a, b, c], X).` $\implies X = a.$


* **`reverse(+List, ?Reversed)`**


  * Invierte el orden de los elementos.


  * *Ejemplo:* `reverse([1, 2, 3], R).` $\implies R = [3, 2, 1]$.




* **`flatten(+NestedList, -FlatList)`**


  * Aplana listas con anidamientos arbitrarios a una lista lineal.


  * *Ejemplo:* `flatten([1, [2, [3]], 4], L).` $\implies L = [1, 2, 3, 4]$.




* **`is_list(?Term)`**
  * Verifica si el término es una lista bien formada.
  * *Ejemplo:* `is_list([1, 2]).` $\to$ `true`; `is_list(a).` $\to$ `false`.



### Modificación y Reordenamiento

* **`select(?Elem, ?List, ?Rest)`**
  * Extrae `Elem` de `List`, dejando `Rest` (o inserta si se usa inversamente).
  * *Ejemplo:* `select(b, [a, b, c], R).` $\implies R = [a, c].$


* **`delete(+List, +Elem, -Rest)`**
  * Elimina **todas** las ocurrencias de `Elem` en `List`.
  * *Ejemplo:* `delete([1, 2, 1, 3], 1, R).` $\implies R = [2, 3].$


* **`sort(+List, -Sorted)`**
  * Ordena los elementos y **elimina duplicados** (crea un conjunto ordenado).
  * *Ejemplo:* `sort([3, 1, 2, 1], L).` $\implies L = [1, 2, 3].$


* **`msort(+List, -Sorted)`**
  * Ordena los elementos **manteniendo duplicados**.
  * *Ejemplo:* `msort([3, 1, 2, 1], L).` $\implies L = [1, 1, 2, 3].$



### Conjuntos (Listas tratadas como conjuntos)

* **`is_set(+List)`**
  * Verdadero si `List` no contiene elementos duplicados.
  * *Ejemplo:* `is_set([1, 2, 3]).` $\to$ `true`; `is_set([1, 2, 1]).` $\to$ `false`.


* **`list_to_set(+List, -Set)`**
  * Convierte una lista en un conjunto conservando el orden de primera aparición.
  * *Ejemplo:* `list_to_set([a, b, a, c], S).` $\implies S = [a, b, c].$


* **`subset(+SubSet, +Set)`**
  * Verifica si todos los elementos de `SubSet` pertenecen a `Set`.
  * *Ejemplo:* `subset([1, 2], [2, 3, 1]).` $\to$ `true`.


* **`union(+Set1, +Set2, -Union)`**
  * Unión de dos conjuntos (sin duplicar elementos compartidos).
  * *Ejemplo:* `union([1, 2], [2, 3], U).` $\implies U = [1, 2, 3].$


* **`intersection(+Set1, +Set2, -Intersect)`**


    * Elementos comunes entre ambos conjuntos.


    * *Ejemplo:* `intersection([1, 2, 3], [2, 4], I).` $\implies I = [2]$.




* **`subtract(+Set, +Delete, -Result)`**
  * Diferencia de conjuntos: retira de `Set` los elementos presentes en `Delete`.
  * *Ejemplo:* `subtract([1, 2, 3, 4], [2, 4], R).` $\implies R = [1, 3].$



## 4. Plantillas Clásicas para Escribir en el Examen

### Generador Infinito de Enteros (`desde/2` reversible)

```prolog
desde(X, X).
desde(X, Y) :- N is X + 1, desde(N, Y).

desdeReversible(X, Y) :- nonvar(Y), Y >= X.
desdeReversible(X, Y) :- var(Y), desde(X, Y).

```

*(Esencial para generar tamaños crecientes de estructuras sin colgarse)*.

### Sublistas, Prefijos y Sufijos (con `append/3`)

```prolog
prefijo(L, P)  :- append(P, _, L).
sufijo(L, S)   :- append(_, S, L).
sublista(L, SL) :- sufijo(L, S), prefijo(S, SL).

```



### Generador de Subconjuntos / Partes

```prolog
subconjunto([], []).
subconjunto([X|Xs], [X|Ys]) :- subconjunto(Xs, Ys).
subconjunto([_|Xs], Ys)     :- subconjunto(Xs, Ys).

```



### Minimizador / Búsqueda del Óptimo con `not`

Para encontrar el elemento que minimiza un valor $V$ sin usar cortes ni metapredicados:

```prolog
esMinimo(X) :-
    candidato(X, V),
    not((candidato(_, OtroV), OtroV < V)).

```



### Para Todo ($\forall$) mediante Doble Negación con `not`

Para verificar que "todo $X$ cumple la propiedad $P$" cuando solo se dispone de `not`:


$$\forall X . P(X) \iff \neg \exists X . \neg P(X)$$

```prolog
todosCumplen(Dominio) :-
    not((elemento(X, Dominio), not(cumpleP(X)))).

```



### Manejo de Árboles Binarios (`nil` y `bin(Izq, V, Der)`)

```prolog
inorder(nil, []).
inorder(bin(I, V, D), L) :-
    inorder(I, LI),
    inorder(D, LD),
    append(LI, [V|LD], L).

```



## 5. Cuadro Comparativo Rápido (Respuestas Sí/No vs. Valores)

* **Para chequear/verificar (`true`/`false`):** Enviar todos los argumentos instanciados con constantes/átomos.


  * `?- member(2, [1, 2, 3]).` $\to$ `true.`




* **Para generar/buscar soluciones:** Enviar variables libres (con Mayúscula) en los parámetros deseados.


    * `?- member(X, [1, 2, 3]).` $\implies X = 1; \, X = 2; \, X = 3.$