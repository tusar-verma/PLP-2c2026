# 1. Sintaxis de la Lógica de Primer Orden

La lógica de primer orden extiende a la lógica proposicional permitiendo expresar propiedades sobre elementos de un universo.

### Alfabeto de un Lenguaje $\mathcal{L}$

Un lenguaje de primer orden $\mathcal{L}$ está constituido por:

* **Símbolos de función ($\mathcal{F}$):** Cada símbolo $f$ tiene asociada una aridad $n \ge 0$. Si la aridad es $0$, el símbolo se denomina **constante**.


* **Símbolos de predicado ($\mathcal{P}$):** Cada símbolo $P$ tiene asociada una aridad $n \ge 0$.


* **Variables ($\mathcal{X}$):** Conjunto infinito numerable de variables $\{X, Y, Z, \dots\}$.



### Gramática de Términos y Fórmulas

| Tipo | Gramática | Descripción / Ejemplos |
| --- | --- | --- |
| **Término ($t$)** | $t ::= X \mid f(t_1, \dots, t_n)$<br> | Representa objetos del dominio. Ej: $0$, $\text{succ}(X)$, $+(X, Y)$.

 |
| **Fórmula ($\sigma$)** | $\sigma ::= P(t_1, \dots, t_n) \mid \bot \mid \sigma \Rightarrow \sigma \mid \sigma \wedge \sigma \mid \sigma \vee \sigma \mid \neg \sigma \mid \forall X. \sigma \mid \exists X. \sigma$<br> | Representa afirmaciones lógicas. Ej: $\forall X. \exists Y. =(+(X, Y), 0)$.

 |

### Variables Libres, Ligadas y Sustitución

* **Ocurrencia Ligada:** Ocurre dentro del alcance de un cuantificador ($\forall X$ o $\exists X$).


* **Ocurrencia Libre:** Ocurre fuera del alcance de los cuantificadores.


* **Sustitución ($\sigma\{X := t\}$):** Reemplaza todas las ocurrencias libres de $X$ en $\sigma$ por el término $t$, renombrando variables ligadas si es necesario para **evitar la captura de variables**.



---

# 2. Deducción Natural para Primer Orden

A las reglas proposicionales se suman las reglas de introducción ($I$) y eliminación ($E$) para cuantificadores.

### Cuantificador Universal ($\forall$)

* **Eliminación ($\forall_E$):**

$$\frac{\Gamma \vdash \forall X. \sigma}{\Gamma \vdash \sigma\{X:=t\}} \forall_E$$



* **Introducción ($\forall_I$):**

$$\frac{\Gamma \vdash \sigma}{\Gamma \vdash \forall X. \sigma} \forall_I \quad \text{con } X \notin fv(\Gamma)$$




> **Restricción:** Se exige $X \notin fv(\Gamma)$ para asegurar que $X$ sea un elemento genérico/arbitrario y no un valor particular fijado en las hipótesis.
> 
> 

### Cuantificador Existencial ($\exists$)

* **Introducción ($\exists_I$):**

$$\frac{\Gamma \vdash \sigma\{X:=t\}}{\Gamma \vdash \exists X. \sigma} \exists_I$$



* **Eliminación ($\exists_E$):**

$$\frac{\Gamma \vdash \exists X. \sigma \quad \Gamma, \sigma \vdash \tau}{\Gamma \vdash \tau} \exists_E \quad \text{con } X \notin fv(\Gamma, \tau)$$




---

# 3. Semántica y Modelos

### Estructuras y Asignaciones

Dado un lenguaje $\mathcal{L}$, una **Estructura de primer orden** es un par $\mathcal{M} = (M, I)$ donde:

1. **$M$ (Universo):** Conjunto no vacío de elementos.


2. **$I$ (Interpretación):** Mapea cada función $f^n$ a una función real $I(f): M^n \rightarrow M$, y cada predicado $P^n$ a una relación $I(P) \subseteq M^n$.



Una **Asignación** $a: \mathcal{X} \rightarrow M$ le otorga a cada variable libre un elemento del universo $M$.

### Clasificación Semántica de Fórmulas

* **Válida:** Verdadera para **toda** estructura $\mathcal{M}$ y **toda** asignación $a$ ($\models \sigma$).


* **Satisfactible:** Verdadera para **al menos una** estructura $\mathcal{M}$ y asignación $a$.


* **Insatisfactible:** Falsa para **toda** estructura $\mathcal{M}$ y asignación $a$.


* **Inválida:** Falsa para **al menos una** estructura $\mathcal{M}$ y asignación $a$.



### Resultados Teoricos Principales

* **Teorema de Corrección y Completitud (Gödel, 1929):** Dada una teoría $T$, la derivabilidad formal equivale a la validez semántica ($\vdash \sigma \iff \models \sigma$).


* **El Problema de la Decisión:** No existe un algoritmo general capaz de determinar si una fórmula cualquiera de primer orden es válida (es indecidible).



---

# 4. Unificación de Términos

Dado un conjunto de ecuaciones entre términos $E$, el objetivo es encontrar el **m.g.u.** (*most general unifier*), que es la sustitución más general que iguala ambos lados de cada ecuación.

### 🛠️ Reglas del Algoritmo de Unificación

1. **Delete:** $\{X \triangleq X\} \cup E \longrightarrow E$

2. **Decompose:** $\{f(t_1, \dots, t_n) = f(s_1, \dots, s_n)\} \cup E \longrightarrow \{t_1=s_1, \dots, t_n=s_n\} \cup E$

3. **Swap:** $\{t = X\} \cup E \longrightarrow \{X = t\} \cup E$ (si $t$ no es una variable)


4. **Elim:** $\{X = t\} \cup E \longrightarrow \{X = t\} \cup E\{X := t\}$ (si $X \notin fv(t)$)


5. **Clash (Falla):** $\{f(t_1, \dots) = g(s_1, \dots)\} \longrightarrow \text{falla}$ (si $f \neq g$)


6. **Occurs-Check (Falla):** $\{X = t\} \longrightarrow \text{falla}$ (si $X \neq t$ y $X \in fv(t)$)



### Terminación

La terminación del algoritmo se demuestra asociando a $E$ la tripla lexicográfica $(n_1, n_2, n_3)$, donde:

* $n_1$: Cantidad de variables distintas en $E$.


* $n_2$: Tamaño total de las expresiones de $E$.


* $n_3$: Cantidad de ecuaciones de la forma $t = X$ en $E$.



Cada regla que no falla reduce estrictamente la tripla $(n_1, n_2, n_3)$ según el orden lexicográfico.
