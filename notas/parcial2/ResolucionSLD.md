# Resumen: Ejercicios de Resolución en LPO y SLD



## 1. Deducción Lógica y Justificación por Refutación

* **Demostrar que una fórmula $\tau$ se deduce de las premisas $\sigma_1, \dots, \sigma_n$** ($\sigma_1 \land \dots \land \sigma_n \models \tau$):


    * Equivale a probar que la implicación $(\sigma_1 \land \dots \land \sigma_n) \Rightarrow \tau$ es **válida**.


    * Por refutación, se demuestra que la negación es **insatisfactible**:


    $$\neg ((\sigma_1 \land \dots \land \sigma_n) \Rightarrow \tau) \equiv \sigma_1 \land \dots \land \sigma_n \land \neg \tau \vdash \bot$$





    * En forma clausal: se juntan las cláusulas de las premisas con las cláusulas provenientes de la **negación de la conclusión ($\neg \tau$)** y se busca la cláusula vacía $\square$.





## 2. Checklist Estricto para Justificar si una Derivación es SLD

En los exámenes suelen dar una derivación por resolución y preguntar: *“¿Esta demostración es SLD? Justificar”*. Para responder afirmativamente, se deben cumplir **todas** estas condiciones:

1. **Cláusulas de Horn:** Todas las cláusulas del conjunto inicial (salvo la meta) deben tener exactamente 1 literal positivo (cláusulas de definición).


2. **Meta inicial:** Debe comenzar obligatoriamente con una cláusula objetivo (0 literales positivos), proveniente de la negación de lo que se desea probar.


3. **Linealidad estricta:** En cada paso $i$, se debe resolver el objetivo intermedio $G_i$ con alguna cláusula de definición del programa $D \in P$ para obtener el nuevo objetivo $G_{i+1}$.


   * *Motivo de fallo típico:* Si en algún paso se resuelven dos reglas del programa entre sí, o dos cláusulas que contienen literales positivos, **la derivación deja de ser SLD** (pasa a ser resolución general).




4. **Resolución binaria:** Cada paso cancela exactamente un literal del objetivo contra el único literal positivo de la cláusula de definición.



## 3. Traducción de Programas Prolog a Forma Clausal

* **Hecho:** `p(X).` $\longrightarrow \{p(X)\}$


* **Regla:** `p(X) :- q(X), r(X).` $\longrightarrow \{p(X), \neg q(X), \neg r(X)\}$


* **Consulta (Goal):** `?- p(X).` $\longrightarrow \{\neg p(X)\}$ (cláusula objetivo con $X$ abierta)





## Ejemplo práctico

**Ejercicio:** Dadas las propiedades de una relación binaria $R$:

1. Irreflexiva: $\forall X . \neg R(X, X)$


2. Simétrica: $\forall X . \forall Y . (R(X, Y) \Rightarrow R(Y, X))$


3. Transitiva: $\forall X . \forall Y . \forall Z . ((R(X, Y) \land R(Y, Z)) \Rightarrow R(X, Z))$



Demostrar por resolución que si cumple 1, 2 y 3, entonces $R$ es vacía ($\forall X . \neg \exists Y . R(X, Y)$).

### 1. Pasaje a Forma Clausal:

* Premisa 1: $\kappa_1 = \{\neg R(X_1, X_1)\}$


* Premisa 2: $\kappa_2 = \{\neg R(X_2, Y_2), R(Y_2, X_2)\}$


* Premisa 3: $\kappa_3 = \{\neg R(X_3, Y_3), \neg R(Y_3, Z_3), R(X_3, Z_3)\}$


* Negación de la conclusión:


$$\neg (\forall X . \neg \exists Y . R(X, Y)) \equiv \exists X . \exists Y . R(X, Y)$$



Skolemizamos con constantes frescas $a, b$ (no hay $\forall$ precedentes):


$$\kappa_4 = \{R(a, b)\}$$






### 2. Derivación y Análisis de SLD:

* **Opción A (Resolución Lineal NO-SLD):**


    * (4 y 2) con $S = \{X_2 := a, Y_2 := b\} \implies \kappa_5 = \{R(b, a)\}$


    * (5 y 3) con $S = \{Y_3 := b, Z_3 := a\} \implies \kappa_6 = \{\neg R(X_6, b), R(X_6, a)\}$


    * (6 y 4) con $S = \{X_6 := a\} \implies \kappa_7 = \{R(a, a)\}$


    * (7 y 1) con $S = \{X_1 := a\} \implies \kappa_8 = \square$


    * *Justificación de examen:* **NO es SLD.** La cláusula $\kappa_1$ es la única cláusula objetivo del conjunto ($\{\neg R(X_1, X_1)\}$), pero la derivación comenzó resolviendo $\kappa_4$ (hecho positivo) con $\kappa_2$ (regla), produciendo resolventes con literales positivos ($\kappa_5, \kappa_6, \kappa_7$) en lugar de derivar secuencialmente cláusulas objetivo.




* **Opción B (Derivación SLD válida):**


  * Objetivo inicial: $G_0 = \kappa_1 = \{\neg R(X_1, X_1)\}$


  * ($G_0$ y $\kappa_3$) unificando $R(X_1, X_1)$ con $R(X_3, Z_3)$ con $S_1 = \{X_3 := X_1, Z_3 := X_1\}$:


  $$G_1 = \{\neg R(X_1, Y_3), \neg R(Y_3, X_1)\}$$





  * ($G_1$ y $\kappa_2$) unificando $\neg R(Y_3, X_1)$ con la cabeza de $\kappa_2$ ($R(Y_2, X_2)$) con $S_2 = \{X_1 := X_2, Y_3 := Y_2\}$:


  $$G_2 = \{\neg R(X_2, Y_2)\}$$





  * ($G_2$ y $\kappa_4$) con $S_3 = \{X_2 := a, Y_2 := b\}$:


  $$G_3 = \square$$





* *Justificación de examen:* **SÍ es SLD.** Inicia en la cláusula objetivo $G_0$, todas las demás son cláusulas de definición (1 positivo), y cada paso resuelve linealmente el objetivo contra una cláusula del programa produciendo un nuevo objetivo.







## Notas importantes a tener en cuenta a la hora de hacer ejercicios

* **Trazar un plan informal antes de unificar:** Los ejercicios de resolución en LPO tienen un espacio de combinaciones exponencial. En el examen, escribir primero el argumento en castellano (ej: *"Si $a R b$, por simetría $b R a$; por transitividad $a R a$; pero por irreflexividad no puede ser $a R a$, absurdo"*), y luego buscar exactamente las cláusulas que reflejen esa cadena deductiva.


* **Renombrado de variables en cada paso:** En la teórica y práctica restan puntos si se reutiliza la misma letra de variable entre dos cláusulas que unifican. Siempre escribir subíndices según el número de paso o cláusula ($X_1, X_2, X_3$).


* **Reutilización de cláusulas:** Las cláusulas no se "consumen" ni se descartan. Una misma regla o hecho (como `append` o una propiedad transitiva) puede y suele utilizarse múltiples veces en la misma refutación.


* **Diferencia crucial entre Resolución SLD abstracta y Prolog:**
  * La **resolución SLD abstracta** es completa e independiente de la regla de selección de literales: cualquier orden de literales que lleve a $\square$ es una prueba SLD válida.


  * **Prolog** impone una regla fija (primer literal de izquierda a derecha + búsqueda DFS de arriba a abajo).


  * *Pregunta típica de parcial:* Si en Prolog una consulta diverge en bucle infinito (por ejemplo, al poner un predicado recursivo antes de un caso base o por recursión izquierda), **por resolución SLD abstracta sí se puede resolver** eligiendo resolver primero las ramas finitas o reordenando la selección del literal. Justificar: *"Es SLD porque cumple las restricciones estructurales lineales sobre cláusulas de Horn, pero no respeta la regla de computación operacional de Prolog"*.




* **Cuidado al Skolemizar en las premisas:** Si una premisa ya viene con existenciales ($\forall X . \exists Y . P(X, Y)$), la función de Skolem se aplica sobre esa premisa de forma independiente a la consulta. La negación solo se aplica a la **conclusión final que se quiere probar**.