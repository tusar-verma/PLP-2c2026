# Resumen: Unificación e Inferencia de Tipos

### Descripción y reglas introducidas

El objetivo de la inferencia de tipos es determinar si un término sin anotaciones $U$ es tipable en el cálculo lambda con tipos simples y hallar el juicio de tipado más general $\Gamma \vdash M : \tau$ tal que $\text{erase}(M) = U$.

#### 1. Algoritmo General de Inferencia ($\mathcal{I}$)

1. **Rectificación:** Renombrar variables ligadas mediante $\alpha$-conversión para evitar colisiones entre variables libres y ligadas, o entre distintos ligadores.


2. **Anotación con incógnitas frescas:** Asignar una variable de tipo fresca a cada variable libre en el contexto inicial $\Gamma_0$ y anotar cada $\lambda$ con una variable fresca para obtener $M_0$.


3. **Generación de restricciones:** Función recursiva $\mathcal{I}(\Gamma \mid M) = (\tau \mid E)$ que produce el tipo provisorio $\tau$ y el conjunto finito de ecuaciones $E$.


4. **Resolución:** Calcular $S = mgu(E)$ con el algoritmo de Martelli-Montanari. Si unifica, el término es tipable con juicio principal $S(\Gamma_0) \vdash S(M_0) : S(\tau)$; si falla, el término no es tipable.



#### 2. Reglas de Generación de Restricciones $\mathcal{I}(\Gamma \mid M) = (\tau \mid E)$

* **Constantes:**
  * $\mathcal{I}(\Gamma \mid \text{True}) = (\text{Bool} \mid \emptyset)$
    * $\mathcal{I}(\Gamma \mid \text{False}) = (\text{Bool} \mid \emptyset)$
    * $\mathcal{I}(\Gamma \mid \text{zero}) = (\text{Nat} \mid \emptyset)$




* **Variables:**
    * $\mathcal{I}(\Gamma \mid x) = (\tau \mid \emptyset) \quad \text{si } (x : \tau) \in \Gamma$




* **Abstracción:**
    * $\mathcal{I}(\Gamma \mid \lambda x : \tau . M) = (\tau \to \sigma \mid E) \quad \text{donde } \mathcal{I}(\Gamma, x : \tau \mid M) = (\sigma \mid E)$




* **Aplicación:**
    * $\mathcal{I}(\Gamma \mid M_1 \, M_2) = (X_k \mid \{\tau_1 \doteq \tau_2 \to X_k\} \cup E_1 \cup E_2)$ con $X_k$ fresca




* **Condicional:**
    * $\mathcal{I}(\Gamma \mid \text{if } M_1 \text{ then } M_2 \text{ else } M_3) = (\tau_2 \mid \{\tau_1 \doteq \text{Bool}, \tau_2 \doteq \tau_3\} \cup E_1 \cup E_2 \cup E_3)$




* **Aritmética básica:**
    * $\mathcal{I}(\Gamma \mid \text{succ}(M)) = (\text{Nat} \mid \{\tau \doteq \text{Nat}\} \cup E)$


    * $\mathcal{I}(\Gamma \mid \text{pred}(M)) = (\text{Nat} \mid \{\tau \doteq \text{Nat}\} \cup E)$


    * $\mathcal{I}(\Gamma \mid \text{isZero}(M)) = (\text{Bool} \mid \{\tau \doteq \text{Nat}\} \cup E)$




* **Extensiones habituales:**
* **Listas:**
    * $\mathcal{I}(\Gamma \mid []_\tau) = ([\tau] \mid \emptyset)$


    * $\mathcal{I}(\Gamma \mid M_1 :: M_2) = (\tau_2 \mid \{\tau_2 \doteq [\tau_1]\} \cup E_1 \cup E_2)$


    * $\mathcal{I}(\Gamma \mid \text{case } M_1 \text{ of } [] \mapsto M_2; \, h::t \mapsto M_3) = (\tau_2 \mid \{\tau_1 \doteq [X_h], \tau_2 \doteq \tau_3, X_t \doteq \tau_1\} \cup E_1 \cup E_2 \cup E_3)$ con $X_h, X_t$ frescas


    * $\mathcal{I}(\Gamma \mid [M_1 \mid x \leftarrow M_2, M_3]) = ([\tau_1] \mid \{\tau_2 \doteq [X_0], \tau_3 \doteq \text{Bool}\} \cup E_1 \cup E_2 \cup E_3)$ con $X_0$ fresca




* **Pares:**
    * $\mathcal{I}(\Gamma \mid \langle M_1, M_2 \rangle) = (\tau_1 \times \tau_2 \mid E_1 \cup E_2)$


    * $\mathcal{I}(\Gamma \mid \pi_1(M)) = (\sigma \mid \{\tau \doteq \sigma \times X\} \cup E)$ con $X$ fresca


    * $\mathcal{I}(\Gamma \mid \pi_2(M)) = (\rho \mid \{\tau \doteq X \times \rho\} \cup E)$ con $X$ fresca




* **Sumas / Coproductos:**
  * $\mathcal{I}(\Gamma \mid \text{case } M_1 \text{ of } \text{left}(x) \leadsto M_2 \mid \text{right}(y) \leadsto M_3) = (\tau_2 \mid \{\tau_1 \doteq X_x + X_y, \tau_2 \doteq \tau_3\} \cup E_1 \cup E_2 \cup E_3)$ con $X_x, X_y$ frescas







#### 3. Reglas de Martelli-Montanari (Unificación)

Dado un conjunto de ecuaciones $E$, se aplican sucesivamente hasta llegar a $\emptyset$ o a falla:

| Regla | Forma | Condición / Acción |
| --- | --- | --- |
| **Delete** | $\{X \doteq X\} \cup E \longrightarrow E$ | Elimina identidades triviales.
| **Decompose** | $\{C(\tau_1, \dots, \tau_n) \doteq C(\sigma_1, \dots, \sigma_n)\} \cup E \longrightarrow \{\tau_1 \doteq \sigma_1, \dots, \tau_n \doteq \sigma_n\} \cup E$ | Mismo constructor en ambos lados.
| **Swap** | $\{\tau \doteq X\} \cup E \longrightarrow \{X \doteq \tau\} \cup E$ | Cuando $\tau$ no es una incógnita.
| **Elim** | $\{X \doteq \tau\} \cup E \longrightarrow \{X := \tau\}(E)$ | Si $X \notin fv(\tau)$ (pasa Occurs-Check). Registra $\{X := \tau\}$.
| **Clash** | $\{C(\dots) \doteq C'(\dots)\} \cup E \longrightarrow \textbf{falla}$ | Constructores raíz incompatibles ($C \ne C'$). No tipable.
| **Occurs-Check** | $\{X \doteq \tau\} \cup E \longrightarrow \textbf{falla}$ | Si $X \ne \tau$ y $X \in fv(\tau)$. Evita tipos infinitos. No tipable.

### Ejemplo práctico

**Término:** $U = \lambda y . \, (x \; y) \; (\lambda z . \, z)$

1. **Rectificación y Anotación:**
* Variable libre: $x \implies \Gamma_0 = \{x : X_1\}$.


* Variables ligadas: $y : X_2$, $z : X_3$.


* Término anotado: $M_0 = \lambda y : X_2 . \, (x \; y) \; (\lambda z : X_3 . \, z)$.




2. **Generación de Restricciones ($\mathcal{I}$):**
* Contexto interno: $\Gamma = \{x : X_1, y : X_2\}$.


* Subtérmino $(\lambda z : X_3 . \, z)$: tipo $X_3 \to X_3$, restricciones $\emptyset$.


* Subtérmino $(x \; y)$: operador $x : X_1$, argumento $y : X_2$. Con variable fresca $X_4$:



$$\text{Tipo } = X_4, \quad E_1 = \{X_1 \doteq X_2 \to X_4\}$$





* Aplicación principal $((x \; y) \; (\lambda z . \, z))$: operador tiene tipo $X_4$, argumento tiene tipo $X_3 \to X_3$. Con variable fresca $X_5$:



$$\text{Tipo } = X_5, \quad E_2 = \{X_4 \doteq (X_3 \to X_3) \to X_5\}$$





* Tipo total de la abstracción: $X_2 \to X_5$.


* Restricciones acumuladas:

$$E = \{ X_1 \doteq X_2 \to X_4, \quad X_4 \doteq (X_3 \to X_3) \to X_5 \}$$







3. **Unificación (Martelli-Montanari):**
* Ecuación: $X_4 \doteq (X_3 \to X_3) \to X_5$. Como $X_4 \notin fv((X_3 \to X_3) \to X_5)$, aplicamos **Elim** con $S_1 = \{X_4 := (X_3 \to X_3) \to X_5\}$:



$$E' = \{ X_1 \doteq X_2 \to (X_3 \to X_3) \to X_5 \}$$





* Ecuación: $X_1 \doteq X_2 \to (X_3 \to X_3) \to X_5$. Como $X_1 \notin fv(\dots)$, aplicamos **Elim** con $S_2 = \{X_1 := X_2 \to (X_3 \to X_3) \to X_5\}$:



$$E'' = \emptyset$$





* $mgu = S_2 \circ S_1 = \{X_1 := X_2 \to (X_3 \to X_3) \to X_5, \; X_4 := (X_3 \to X_3) \to X_5\}$.




4. **Juicio Inferido Más General:**
* Contexto: $S(\Gamma_0) = \{ x : X_2 \to (X_3 \to X_3) \to X_5 \}$.


* Término: $S(M_0) = \lambda y : X_2 . \, (x \; y) \; (\lambda z : X_3 . \, z)$.


* Tipo inferido: $S(X_2 \to X_5) = X_2 \to X_5$.


### Notas importantes a tener en cuenta a la hora de hacer ejercicios

* **Rectificación temprana obligatoria:** Si una variable ligada tiene el mismo nombre que una variable libre (o dos abstracciones reutilizan el mismo identificador), hay que renombrar con $\alpha$-conversión antes de generar ecuaciones; de lo contrario, se asignarán tipos forzadamente iguales que falsean el resultado.


* **Frescura de variables:** Generar una incógnita nueva e independiente cada vez que:
  * Se procesa una variable libre en $\Gamma_0$.


  * Se entra a una abstracción $\lambda x$.


  * Se analiza una aplicación $M_1 \, M_2$ (el tipo de retorno $X_k$ es fresco).


  * Se abren constructores con tipos omitidos o variables internas (como $\pi_1$, $\pi_2$, listas o $\text{case}$).




* **Orden de aplicación en Martelli-Montanari:**
  * Al aplicar **Elim** con $\{X := \tau\}$, la sustitución debe propagarse a **todas** las ecuaciones restantes del sistema antes de seguir.


  * Si la incógnita está a la derecha ($\tau \doteq X$), aplicar **Swap** antes de intentar Elim.




* **Asociatividad de constructores:**
  * La flecha funcional $(\to)$ asocia a **derecha**: $A \to B \to C \equiv A \to (B \to C)$.


  * La aplicación de términos asocia a **izquierda**: $M_1 \, M_2 \, M_3 \equiv (M_1 \, M_2) \, M_3$.




* **Justificación de no tipabilidad:**
  * Si dos constructores raíz difieren ($\text{Bool} \doteq \text{Nat}$ o $\text{Nat} \doteq \tau_1 \to \tau_2$), justificar explícitamente: *"Falla por regla Clash de Martelli-Montanari"*.


  * Si una variable queda igualada a un término funcional o compuesto que la contiene ($X \doteq X \to Y$ o $X \doteq [X]$), justificar explícitamente: *"Falla por regla Occurs-Check de Martelli-Montanari"*.




* **Composición del mgu:** Recordar que si $S_1$ se aplicó primero y $S_2$ después sobre el sistema resultante, el unificador acumulado es $S_2 \circ S_1$. Para dar el tipo final o el contexto final, aplicar todas las sustituciones sobre las variables de partida.