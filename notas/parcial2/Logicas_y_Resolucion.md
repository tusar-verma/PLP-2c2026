# Resumen: Lógica de Primer Orden, Resolución y Programación Lógica (Prolog)


## 1. Lógica Proposicional y LPO: Pasaje a Forma Clausal

Para demostrar la validez de una fórmula $\sigma$ ($\models \sigma$), se niega ($\neg \sigma$) y se transforma a un conjunto finito de cláusulas $\mathcal{C}$ para derivar una contradicción ($\mathcal{C} \vdash \bot$ o cláusula vacía $\{\}$).

### Algoritmo de Pasaje a Forma Clausal (6 pasos formales):

1. **Eliminar implicaciones y equivalencias:**


    * $\alpha \Rightarrow \beta \longrightarrow \neg \alpha \lor \beta$


    * $\alpha \Leftrightarrow \beta \longrightarrow (\neg \alpha \lor \beta) \land (\neg \beta \lor \alpha)$




2. **Forma Normal Negada (NNF):** Empujar negaciones hacia los átomos mediante De Morgan y dualidad de cuantificadores:


    * $\neg (\alpha \land \beta) \longrightarrow \neg \alpha \lor \neg \beta$, $\neg (\alpha \lor \beta) \longrightarrow \neg \alpha \land \neg \beta$, $\neg \neg \alpha \longrightarrow \alpha$


    * $\neg (\forall X . \alpha) \longrightarrow \exists X . \neg \alpha$, $\neg (\exists X . \alpha) \longrightarrow \forall X . \neg \alpha$




3. **Forma Normal Prenexa (FNP):** Extraer cuantificadores al frente tras renombrar variables para evitar colisiones: $\mathcal{Q}_1 X_1 \dots \mathcal{Q}_n X_n . \tau$.


4. **Skolemización (FNS):** Eliminar existenciales ($\exists$):


   * Si $\exists Y$ está dominado por los cuantificadores universales $\forall X_1 \dots \forall X_k$, se reemplaza $Y$ por una función fresca de Skolem: $f(X_1, \dots, X_k)$.


   * Si no está bajo ningún universal ($k=0$), se reemplaza por una constante fresca $c$.


   * **Propiedad clave:** La Skolemización **no preserva validez/equivalencia**, pero sí preserva **satisfactibilidad** (las fórmulas resultantes son *equisatisfactibles*).




5. **Forma Normal Conjuntiva (CNF):** Distribuir disyunciones sobre conjunciones en la matriz libre de cuantificadores:


* $\alpha \lor (\beta \land \gamma) \longrightarrow (\alpha \lor \beta) \land (\alpha \lor \gamma)$




6. **Conjunto de Cláusulas:** Se omiten los cuantificadores universales explícitos (se asumen implícitos) y se descompone la conjunción en un conjunto de cláusulas, donde cada cláusula es un conjunto de literales. Renombrar variables para que distintas cláusulas no compartan nombres.



## 2. Reglas de Resolución

* **Resolución Proposicional:**


$$\frac{\{P, l_1, \dots, l_n\} \quad \{\neg P, l_1', \dots, l_m'\}}{\{l_1, \dots, l_n, l_1', \dots, l_m'\}}$$


* **Resolución General de Primer Orden:** Requiere unificación con el $mgu$ de conjuntos de literales (factorización para garantizar completitud):



$$\frac{\{\sigma_1, \dots, \sigma_p, l_1, \dots, l_n\} \quad \{\neg \tau_1, \dots, \neg \tau_q, l_1', \dots, l_m'\}}{S(\{l_1, \dots, l_n, l_1', \dots, l_m'\})} \quad \text{donde } S = mgu(\{\sigma_1 \doteq \dots \doteq \sigma_p \doteq \tau_1 \doteq \dots \doteq \tau_q\})$$


* **Resolución SLD (*Selected literal, Linear resolution for Definite clauses*):**


* **Cláusulas de Horn:** Cláusulas con a lo sumo un literal positivo.


    * *De definición (reglas/hechos):* Exactamente 1 positivo ($\{A, \neg B_1, \dots, \neg B_n\}$ equivale a $A \leftarrow B_1 \land \dots \land B_n$).


    * *Objetivo (meta/goal):* 0 literales positivos ($\{\neg G_1, \dots, \neg G_m\}$).


    * *Vacía ($\square$ o $\{\}$):* Contradicción ($\bot$).




* **Regla de deducción SLD:** En cada paso resuelve el objetivo actual con una cláusula del programa:



$$\frac{\{\neg G_1, \neg G_2, \dots, \neg G_m\} \quad \{H, \neg A_1, \dots, \neg A_k\}}{S(\{\neg A_1, \dots, \neg A_k, \neg G_2, \dots, \neg G_m\})} \quad \text{donde } S = mgu(G_1 \doteq H)$$


* **Sustitución Respuesta:** Composición de los unificadores $S = S_n \circ \dots \circ S_1$ evaluada sobre las variables de la consulta inicial.







## 3. Semántica Operacional de Prolog

* **Estrategia de Búsqueda:** Búsqueda en profundidad (DFS) de arriba hacia abajo sobre las cláusulas del programa.


* **Regla de Selección:** De izquierda a derecha sobre los literales del objetivo actual.


* **Mundo Cerrado (CWA):** Lo que no se puede deducir del programa se considera falso.


* **Compromisos de eficiencia:** Omite el *occurs-check* (riesgo de incorrección / bucles con ciclos) y usa DFS (incompleto: recursión a izquierda puede colgar la ejecución).


* **Aspectos Extra-lógicos y Metapredicados:**
  * **Corte (`!`):** Siempre tiene éxito al ejecutarse. Poda las alternativas de las reglas escritas debajo para el mismo predicado y congela las elecciones tomadas a la izquierda del corte dentro de la regla actual.


    * *Corte Verde:* Mejora eficiencia, no altera el significado declarativo.


    * *Corte Rojo:* Modifica el conjunto de respuestas; si se remueve, cambia la semántica del programa.




  * **Negación por Falla (`not/1`):** `not(P) :- P, !, fail.` y `not(_).` Tiene éxito si $P$ falla; falla si $P$ tiene éxito. **No liga variables**.


  * **Aritmética:** Extra-lógica. `X is Exp` evalúa matemáticamente `Exp` y unifica con `X` (las variables de `Exp` deben estar instanciadas). Operadores de comparación: `=:=`, `=\=`, `>`, `<`, `>=`, `=<`. Comparación sintáctica/unificación: `=` y `\=`.


  * **Colección:** `findall(Var, Goal, L)` (todas las soluciones, no falla, da `[]` si no hay), `bagof` (preserva orden con duplicados), `setof` (ordenado y sin duplicados).


  * **Orden superior:** `maplist(Pred, L1, L2)`, `forall(Gen, Cond)`.







### Ejemplo práctico

#### 1. Pasaje a Forma Clausal y Resolución General en LPO

**Fórmula:** Demostrar que $\sigma \equiv \forall X . (P(X) \Rightarrow Q(X)) \land P(a) \Rightarrow Q(a)$ es válida.

1. **Negar $\sigma$:** $\neg (\forall X . (\neg P(X) \lor Q(X)) \land P(a) \Rightarrow Q(a)) \equiv \forall X . (\neg P(X) \lor Q(X)) \land P(a) \land \neg Q(a)$.


2. **Forma Clausal $\mathcal{C}_0$:**
   * $\kappa_1 = \{\neg P(X), Q(X)\}$


   * $\kappa_2 = \{P(a)\}$


   * $\kappa_3 = \{\neg Q(a)\}$




3. **Derivación:**
    * De $\kappa_1$ y $\kappa_2$ con $S_1 = mgu(P(X) \doteq P(a)) = \{X := a\}$ obtenemos $\kappa_4 = \{Q(a)\}$.


    * De $\kappa_4$ y $\kappa_3$ con $S_2 = mgu(Q(a) \doteq Q(a)) = \emptyset$ obtenemos $\kappa_5 = \{\}$ ($\square$).


    * Conclusión: Como $\mathcal{C}_0 \vdash \bot$, $\neg \sigma$ es insatisfactible y por lo tanto $\sigma$ es válida.





#### 2. Traza de Ejecución y Resolución SLD en Prolog

**Programa:**

```prolog
natural(cero).                          % (C1)
natural(suc(X)) :- natural(X).          % (C2)
suma(cero, Y, Y).                       % (C3)
suma(suc(X), Y, suc(Z)) :- suma(X, Y, Z). % (C4)

```

**Consulta:** `?- suma(suc(cero), cero, R).`

* Forma clausal del objetivo: $G_0 = \{\neg suma(suc(cero), cero, R)\}$.


* Paso 1: Unifica con cabeza de (C4) $suma(suc(X_1), Y_1, suc(Z_1))$.


  * $S_1 = \{X_1 := cero, Y_1 := cero, R := suc(Z_1)\}$.


  * Nuevo objetivo: $G_1 = \{\neg suma(cero, cero, Z_1)\}$.




* Paso 2: Unifica con cabeza de (C3) $suma(cero, Y_2, Y_2)$.


    * $S_2 = \{Y_2 := cero, Z_1 := cero\}$.


    * Nuevo objetivo: $G_2 = \{\}$ ($\square$, éxito).




* Sustitución respuesta: $S_2(S_1(R)) = S_2(suc(Z_1)) = suc(cero)$.


## 4. Operador de Corte (`!`)

El operador de corte (`!`) es un mecanismo de control **extra-lógico** cuya función es **podar el árbol de búsqueda** (*backtracking*) de Prolog.

* **Comportamiento operacional:**
  * Al evaluarse, tiene **éxito inmediato**.


  * **No bloquea lo que está a su derecha:** la ejecución continúa evaluando normalmente los literales que le siguen dentro de la misma regla.


  * **Congela las decisiones pasadas (poda):** en el momento exacto en que la ejecución cruza el `!`, se eliminan los puntos de elección (*choice points*) generados desde que se invocó esa regla. Esto descarta:


    1. Cualquier regla alternativa escrita más abajo para el mismo predicado.


    2. Cualquier solución alternativa para los literales ubicados a la izquierda del `!` dentro de esa regla.







```prolog
regla(X) :- sub_a(X), !, sub_b(X).  % Cláusula 1
regla(X) :- otra_regla(X).           % Cláusula 2

```

Si `sub_a(X)` tiene éxito y pasa por el `!`, Prolog **ya no probará** otras formas de resolver `sub_a(X)` ni intentará la `Cláusula 2`. Si más adelante `sub_b(X)` falla, la consulta entera `regla(X)` falla de inmediato sin retroceder a `sub_a` ni a la segunda cláusula.
 

* **Corte Verde (Green Cut):** Optimiza la ejecución evitando búsquedas redundantes; no altera las soluciones lógicas del programa (si se retira el `!`, el conjunto de respuestas sigue siendo el mismo).


```prolog
add(N, zero, N) :- !.
add(zero, N, N).
add(suc(N), M, suc(P)) :- add(N, M, P).

```


*(Si el segundo argumento es `zero`, evita explorar innecesariamente las demás reglas)*.


* **Corte Rojo (Red Cut):** Altera la semántica declarativa; si se retira el corte, el programa devuelve resultados distintos o incorrectos.


```prolog
maximo(A, B, A) :- A >= B, !.
maximo(A, B, B).

```


*(Si se consulta `?- maximo(5, 2, 2).`, unifica directo con la segunda regla y devuelve `true` erróneamente porque el corte solo protege si se entró por la primera cláusula)*.



## 5. Predicado `fail`

* **Definición:** Es un predicado predefinido que **falla siempre de manera incondicional** (nunca unifica ni tiene éxito).


* **Utilidad:** Se utiliza para obligar a Prolog a iniciar un proceso de retroceso (*backtracking*).



#### La Combinación `!, fail` (Negación por Falla)

Al combinar el corte con `fail` en una regla seguida de un hecho general, se implementa la **negación por falla** (`not/1`):

```prolog
not(P) :- P, !, fail.
not(_).

```

* **Mecánica de ejecución:**
1. **Si `P` tiene éxito:** La ejecución avanza al `!`, el cual **poda y destruye** la posibilidad de retroceder hacia la segunda regla (`not(_).`). Luego choca contra `fail`, que fuerza a fallar. Como no hay alternativas a las cuales retroceder, `not(P)` termina dando **`false`**.


2. **Si `P` falla:** La ejecución **nunca llega al corte `!**`. Prolog hace *backtracking* normal hacia la siguiente cláusula disponible (`not(_).`), la cual es un hecho y tiene **éxito inmediato** devolviendo **`true`**.



## 6. Notas importantes a tener en cuenta a la hora de hacer ejercicios

* **Skolemización y Variables Universales Anteriores:** Al reemplazar $\exists Y$, la función de Skolem debe llevar como argumentos **únicamente las variables universales que anteceden** al existencial en la forma prenexa. Si no hay universales antes, es una constante $c$. ¡Ojo! No skolemizar antes de llevar la fórmula a NNF.


* **Renombrado de Variables entre Cláusulas:** En resolución y resolución SLD, antes de unificar se deben renombrar las variables para que las dos cláusulas no compartan identificadores (ej: $X$ pasa a $X_1$, $X_2$), evitando ligaduras accidentales.


* **Diferencia entre Invalidez e Insatisfactibilidad:**
    * Si $\neg \sigma \vdash \bot \implies \neg \sigma$ es **insatisfactible** $\implies \sigma$ es **válida**.


    * Si $\neg \sigma$ es satisfactible $\implies \sigma$ **no es válida** (pero $\sigma$ podría seguir siendo satisfactible).




* **Semi-decidibilidad en LPO:** En lógica proposicional la resolución siempre termina ($2^n$ estados). En LPO, si la fórmula es válida el método termina; si no es válida, puede iterar indefinidamente generando infinitos términos funcionales.


* **Cuándo se puede usar SLD vs. Resolución General:**
  * Para aplicar SLD el programa **debe constar únicamente de cláusulas de Horn** (a lo sumo 1 literal positivo) y comenzar desde la cláusula objetivo (meta negada).


  * Si en el conjunto hay alguna cláusula con 2 o más literales positivos (ej: $\{P(X), Q(X)\}$), **no se puede usar SLD**; se debe aplicar resolución general con factorización.




* **Efectos del orden en Prolog (No terminación):**
  * La recursión por izquierda (`p(X) :- p(Y), ...`) combinada con DFS cuelga el intérprete en un bucle infinito.


  * Colocar predicados generadores después de los tests provoca fallas o loops: en el esquema *Generate & Test*, el generador va a la izquierda y el test a la derecha (`candidato(X), test(X)`).




* **Peligros con `not/1`:**
  * Si se invoca `not(Q(X))` con la variable libre $X$, Prolog evalúa $\exists X . Q(X)$. Si existe *algún* elemento que cumpla $Q$, el `not` falla entero y no genera nada.


  * Para filtrar elementos de un conjunto $P \setminus Q$, siempre escribir `P(X), not(Q(X))` (con $X$ instanciada por $P$), nunca `not(Q(X)), P(X)`.




* **Aritmética en Prolog:**
  * Nunca usar `X = 1 + 2` para calcular; esto unifica $X$ con el término compuesto `+(1, 2)`.


  * Para evaluar se usa `X is 1 + 2`. Si el lado derecho contiene variables sin instanciar, lanza un error de instanciación (`Instantiation error`).