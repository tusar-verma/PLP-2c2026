# Ejercicio 1: Sintaxis y Gramáticas

### Intuición

En el encabezado de la práctica se definen tres lenguajes formales disjuntos mediante sus gramáticas BNF:

1. **Tipos ($\tau$):** $\text{Bool} \mid \text{Nat} \mid \tau \to \tau \mid X_n$ (donde $X_n \in \mathfrak{T}$ son variables de tipo o incógnitas).


2. **Términos anotados ($M$):** Expresiones del cálculo lambda donde cada ligador lambda tiene explícitamente anotado su tipo: $\lambda x : \tau.\, M$, además de variables, aplicaciones, booleanos, condicionales y operaciones aritméticas.


3. **Términos sin anotaciones ($U$):** Expresiones crudas donde las abstracciones no llevan tipo: $\lambda x.\, U$.



Cualquier símbolo que no pertenezca a los alfabetos de estas gramáticas (como metavariables no instanciadas $\sigma$, o funciones del metalenguaje como $\text{erase}$) hace que la cadena **no pertenezca** a ninguna de las tres gramáticas en sentido sintáctico estricto.

---

### Resolución Formal

* **I. $\lambda x : \text{Bool}.\, \text{succ}(x)$**
* **Válida.** Pertenece a la gramática de **Términos anotados ($M$)**.


* *Justificación:* Es una abstracción $\lambda x : \tau.\, M$ con $\tau = \text{Bool}$ y cuerpo $\text{succ}(x)$, donde $x$ es una variable de término.




* **II. $\lambda x.\, \text{isZero}(x)$**
* **Válida.** Pertenece a la gramática de **Términos sin anotaciones ($U$)**.


* *Justificación:* La abstracción tiene la forma $\lambda x.\, U$ sin anotación de tipo en el parámetro $x$.




* **III. $X_1 \to \sigma$**
* **Inválida.**
* *Justificación:* La letra $\sigma$ es una metavariable que utilizamos en el discurso teórico para referirnos a un tipo cualquiera, pero el conjunto inductivo de tipos solo admite constructores base ($\text{Bool}, \text{Nat}$), flechas y variables de tipo concretas $X_n \in \mathfrak{T}$. Al no ser $\sigma$ una variable de tipo de la forma $X_n$, la cadena no se puede derivar de la gramática de tipos.




* **IV. $\text{erase}(f \; y)$**
* **Inválida.**
* *Justificación:* $\text{erase}$ es una función metalingüística (una operación semántica externa que borra tipos de un término anotado), no es un constructor sintáctico de términos ni de tipos.




* **V. $X_1$**
* **Válida.** Pertenece a la gramática de **Tipos ($\tau$)**.


* *Justificación:* Coincide directamente con la producción de variable de tipo $X_n$ con $n=1$ ($X_1 \in \mathfrak{T}$).




* **VI. $X_1 \to (\text{Bool} \to X_2)$**
* **Válida.** Pertenece a la gramática de **Tipos ($\tau$)**.


* *Justificación:* Se genera mediante dos aplicaciones de la regla inductiva $\tau \to \tau$, usando las variables $X_1, X_2$ y la constante base $\text{Bool}$.




* **VII. $\lambda x : X_1 \to X_2.\, \text{if zero then True else zero succ(True)}$**
* **Válida.** Pertenece a la gramática de **Términos anotados ($M$)**.


* *Justificación:* Es una abstracción $\lambda x : \tau.\, M$ donde $\tau = X_1 \to X_2$ es un tipo bien formado. El cuerpo es un condicional `if ... then ... else ...` y la rama `else` es la aplicación sintáctica de `zero` a `succ(True)`. *(Nota: la gramática define la validez sintáctica de las expresiones; no exige que tengan tipos coherentes para ser sintácticamente válidas)*.




* **VIII. $\text{erase}(\lambda f : \text{Bool} \to \text{Bool}.\, \lambda y : \text{Bool}.\, f \; y)$**
* **Inválida.**
* *Justificación:* Al igual que en el ítem IV, $\text{erase}$ no es un constructor sintáctico del cálculo lambda, sino una función auxiliar externa que opera sobre términos.





---

# Ejercicio 2: Aplicación de Sustituciones

### Intuición

Una **sustitución** $S$ es una función que asigna tipos a las incógnitas de tipo $X_k$. Cuando aplicamos $S$ a:

* Un **tipo** $\tau$, busca cada variable $X_k$ en $\tau$ y la reemplaza por $S(X_k)$.


* Un **contexto de tipado** $\Gamma = \{x_1 : \tau_1, \dots\}$, actualiza los tipos asignados a las variables: $S(\Gamma) = \{x_1 : S(\tau_1), \dots\}$.


* Un **término anotado** $M$, solo reemplaza las incógnitas que aparecen **dentro de las anotaciones de tipo de los $\lambda$**; la estructura del código y los nombres de las variables no se modifican.



---

### Resolución Formal

#### Ítem I

Dada la sustitución:


$$S = \{X_1 := \text{Nat}\}$$


Calcular $S(\{x : X_1 \to \text{Bool}\})$:

* La expresión es un contexto de tipado con una sola asignación. Aplicamos $S$ sobre el tipo de la variable $x$:



$$S(X_1 \to \text{Bool}) = S(X_1) \to \text{Bool} = \text{Nat} \to \text{Bool}$$


* **Resultado:**

$$\{x : \text{Nat} \to \text{Bool}\}$$



---

#### Ítem II

Dada la sustitución:


$$S = \{X_1 := X_2 \to X_3, \quad X_4 := \text{Bool}\}$$


Se pide calcular tres aplicaciones:

1. **$S(\{z : X_4 \to \text{Bool}\})$:**
* Aplicamos $S$ al tipo asociado a $z$:

$$S(X_4 \to \text{Bool}) = S(X_4) \to \text{Bool} = \text{Bool} \to \text{Bool}$$


* **Resultado:** $\{z : \text{Bool} \to \text{Bool}\}$


2. **$S(\lambda z : X_1 \to \text{Bool}.\, z)$:**
* La sustitución solo actúa sobre la anotación de tipo del parámetro $z$:

$$S(X_1 \to \text{Bool}) = S(X_1) \to \text{Bool} = (X_2 \to X_3) \to \text{Bool}$$


* El cuerpo $z$ no sufre alteraciones sintácticas.
* **Resultado:** $\lambda z : (X_2 \to X_3) \to \text{Bool}.\, z$


3. **$S(\text{Nat} \to X_2)$:**
* Como $X_2 \notin \text{dom}(S)$, por definición $S(X_2) = X_2$.


* **Resultado:** $\text{Nat} \to X_2$



---

# Ejercicio 3: Unificación de Tipos y Cálculo de MGU

### Intuición

Dadas dos expresiones de tipos $\tau$ y $\sigma$, buscamos si existe una sustitución $S$ tal que $S(\tau) = S(\sigma)$.

* Para que unifiquen, sus constructores raíz deben coincidir (o al menos uno debe ser una incógnita que no aparezca en el otro término).


* Un tipo flecha $\tau_1 \to \tau_2$ jamás puede unificar con una constante atómica como $\text{Nat}$ o $\text{Bool}$ (regla **Clash**).


* Si una variable aparece dentro del término con el que se la quiere igualar (ejemplo: $X \doteq X \to \text{Bool}$), la unificación falla por **Occurs-Check**.



---

### Análisis de pares unificables entre Fila 1 y Fila 2

**Fila 1:**

1. $X_1 \to X_2$
2. $\text{Nat}$
3. $X_2 \to \text{Bool}$
4. $X_3 \to X_4 \to X_5 \equiv X_3 \to (X_4 \to X_5)$ (por asociatividad a derecha de la flecha)


5. $X_1$

**Fila 2:**
A. $\text{Nat} \to \text{Bool}$
B. $(\text{Nat} \to X_2) \to \text{Bool}$
C. $\text{Nat}$
D. $X_2 \to \text{Bool}$

---

### Emparejamientos y deducción de MGUs con Martelli-Montanari

#### Pareja 1: $\text{Nat}$ (Fila 1) con $\text{Nat}$ (Fila 2)

* **Ecuación:** $\{\text{Nat} \doteq \text{Nat}\}$
* **Regla Decompose / Delete:** Constructores 0-arios idénticos $\longrightarrow \emptyset$.


* **mgu:** $\text{Id}$ (Sustitución identidad / vacía).



#### Pareja 2: $X_1 \to X_2$ (Fila 1) con $\text{Nat} \to \text{Bool}$ (Fila 2)

* **Ecuación:** $\{X_1 \to X_2 \doteq \text{Nat} \to \text{Bool}\}$
* **Decompose:** $\{X_1 \doteq \text{Nat}, \; X_2 \doteq \text{Bool}\}$

* **Elim ($X_1$):** $S_1 = \{X_1 := \text{Nat}\}$, queda $\{X_2 \doteq \text{Bool}\}$.


* **Elim ($X_2$):** $S_2 = \{X_2 := \text{Bool}\}$, queda $\emptyset$.


* **mgu:** $S_2 \circ S_1 = \{X_1 := \text{Nat}, \; X_2 := \text{Bool}\}$.



#### Pareja 3: $X_2 \to \text{Bool}$ (Fila 1) con $X_2 \to \text{Bool}$ (Fila 2)

* **Ecuación:** $\{X_2 \to \text{Bool} \doteq X_2 \to \text{Bool}\}$
* **Decompose:** $\{X_2 \doteq X_2, \; \text{Bool} \doteq \text{Bool}\}$

* **Delete:** Ambos pares son idénticos $\longrightarrow \emptyset$.


* **mgu:** $\text{Id}$


#### Pareja 4: $X_3 \to (X_4 \to X_5)$ (Fila 1) con $(\text{Nat} \to X_2) \to \text{Bool}$ (Fila 2)

* **Ecuación:** $\{X_3 \to (X_4 \to X_5) \doteq (\text{Nat} \to X_2) \to \text{Bool}\}$
* *Nota sobre el lado derecho:* En la imagen de la guía se lee $(\text{Nat} \to X_2) \to \text{Bool}$ (o análogamente si se unifica con $X_1 \to X_2$).
* **Decompose:**

$$\{X_3 \doteq \text{Nat} \to X_2, \quad X_4 \to X_5 \doteq \text{Bool}\}$$


* **Clash:** En la segunda ecuación tenemos el constructor $(\to)$ igualado al constructor constante $\text{Bool}$. Como $(\to) \ne \text{Bool}$, se produce **falla** inmediata.


* *Conclusión:* No unifican con esa constante.

Veamos cómo empareja $X_1 \to X_2$ con $(\text{Nat} \to X_2) \to \text{Bool}$:

* **Ecuación:** $\{X_1 \to X_2 \doteq (\text{Nat} \to X_2) \to \text{Bool}\}$
* **Decompose:** $\{X_1 \doteq \text{Nat} \to X_2, \; X_2 \doteq \text{Bool}\}$

* **Elim ($X_2$):** $S_1 = \{X_2 := \text{Bool}\}$. Al aplicarlo sobre la primera ecuación:

$$X_1 \doteq \text{Nat} \to \text{Bool}$$


* **Elim ($X_1$):** $S_2 = \{X_1 := \text{Nat} \to \text{Bool}\}$.
* **mgu:** $S = \{X_1 := \text{Nat} \to \text{Bool}, \; X_2 := \text{Bool}\}$.



#### Pareja 5: La variable libre $X_1$ (Fila 1)

Como $X_1$ es una incógnita pura, unifica con **cualquiera** de los tipos de la Fila 2 siempre que $X_1$ no ocurra en ellos (por **Elim**):

* Con $\text{Nat}$: $\mathbf{mgu} = \{X_1 := \text{Nat}\}$

* Con $\text{Nat} \to \text{Bool}$: $\mathbf{mgu} = \{X_1 := \text{Nat} \to \text{Bool}\}$

* Con $X_2 \to \text{Bool}$: $\mathbf{mgu} = \{X_1 := X_2 \to \text{Bool}\}$

* Con $(\text{Nat} \to X_2) \to \text{Bool}$: $\mathbf{mgu} = \{X_1 := (\text{Nat} \to X_2) \to \text{Bool}\}$


---

# Ejercicio 5: Inferencia de Tipo o Demostración de No Tipabilidad

Desarrollaremos cada uno de los términos mostrando explícitamente el par $(\tau \mid E)$ generado por $\mathcal{I}$ y la traza de reglas de Martelli-Montanari.

---

### Término 1: $\lambda x.\, \lambda y.\, \lambda z.\, z \; x \; y \; z$

* **Paso 1 y 2 (Anotación):**

$$M_0 = \lambda x : X_1.\, \lambda y : X_2.\, \lambda z : X_3.\, (((z \; x) \; y) \; z)$$


* **Paso 3 (Generación de restricciones sobre el cuerpo):**
* Contexto: $\Gamma = \{x : X_1, \; y : X_2, \; z : X_3\}$.


* 1ra aplicación $(z \; x)$:
* Tipo de $z$: $X_3$. Tipo de $x$: $X_1$.


* Variable fresca de resultado: $X_4$.


* Restricción: $X_3 \doteq (X_1 \to X_4)$.


* Tipo de $(z \; x)$: $X_4$.




* 2da aplicación $((z \; x) \; y)$:
* Tipo de $(z \; x)$: $X_4$. Tipo de $y$: $X_2$.


* Variable fresca de resultado: $X_5$.


* Restricción: $X_4 \doteq (X_2 \to X_5)$.


* Tipo de $((z \; x) \; y)$: $X_5$.




* 3ra aplicación $(((z \; x) \; y) \; z)$:
* Tipo de la función: $X_5$. Tipo del argumento $z$: $X_3$.


* Variable fresca de resultado: $X_6$.


* Restricción: $X_5 \doteq (X_3 \to X_6)$.


* Tipo final del cuerpo: $X_6$.




* **Conjunto de ecuaciones $E$:**

$$E = \{ X_3 \doteq X_1 \to X_4, \quad X_4 \doteq X_2 \to X_5, \quad X_5 \doteq X_3 \to X_6 \}$$




* **Paso 4 (Unificación de Martelli-Montanari):**
1. **Elim ($X_4 := X_2 \to X_5$):** Sustituimos $X_4$ en la primera ecuación:



$$\{ X_3 \doteq X_1 \to X_2 \to X_5, \quad X_5 \doteq X_3 \to X_6 \}$$


2. **Elim ($X_3 := X_1 \to X_2 \to X_5$):** Sustituimos $X_3$ en la segunda ecuación:



$$\{ X_5 \doteq (X_1 \to X_2 \to X_5) \to X_6 \}$$


3. Examinamos la ecuación resultante:
La incógnita $X_5$ **aparece en el lado derecho** (está anidada en el dominio del tipo funcional).


4. Por lo tanto, se dispara la regla **Occurs-Check** ($X_5 \in \text{vars}(\tau)$ con $X_5 \ne \tau$), provocando una **falla** inmediata.




* **Conclusión:** El término **NO es tipable** por violación de occurs-check (implicaría que la variable $z$ tenga un tipo infinito autoreferencial).



---

### Término 2: $\lambda x.\, w \; (x \; (\lambda y.\, w \; y))$

* **Paso 1 y 2 (Anotación):**
* Variable libre: $w \implies \Gamma_0 = \{w : X_1\}$.


* Anotamos ligadores:

$$M_0 = \lambda x : X_2.\, w \; (x \; (\lambda y : X_3.\, w \; y))$$




* **Paso 3 (Generación de restricciones):**
* Contexto interno: $\Gamma = \{w : X_1, \; x : X_2, \; y : X_3\}$.


* Subtérmino $(\lambda y : X_3.\, w \; y)$:


* Aplicación $(w \; y)$: $X_1 \doteq (X_3 \to X_4)$, con $X_4$ fresco. Tipo: $X_4$.


* Tipo de $(\lambda y : X_3.\, w \; y)$: $X_3 \to X_4$.




* Subtérmino $(x \; (\lambda y.\, w \; y))$:


* El operador $x$ tiene tipo $X_2$.


* Generamos variable fresca de resultado: $X_5$.


* Restricción de aplicación: $X_2 \doteq ((X_3 \to X_4) \to X_5)$.


* Tipo: $X_5$.




* Aplicación principal $w \; (\dots)$:


* El operador es $w$ (tipo $X_1$).


* El argumento tiene tipo $X_5$.


* Variable fresca de resultado: $X_6$.


* Restricción: $X_1 \doteq (X_5 \to X_6)$.


* Tipo del cuerpo: $X_6$.




* **Conjunto $E$:**

$$E = \{ X_1 \doteq X_3 \to X_4, \quad X_2 \doteq (X_3 \to X_4) \to X_5, \quad X_1 \doteq X_5 \to X_6 \}$$




* **Paso 4 (Unificación de Martelli-Montanari):**
1. **Elim ($X_1 := X_3 \to X_4$):** Reemplazamos $X_1$ en la tercera ecuación:



$$\{ X_2 \doteq (X_3 \to X_4) \to X_5, \quad (X_3 \to X_4) \doteq (X_5 \to X_6) \}$$


2. **Decompose** sobre la segunda ecuación:



$$\{ X_2 \doteq (X_3 \to X_4) \to X_5, \quad X_3 \doteq X_5, \quad X_4 \doteq X_6 \}$$


3. **Swap** sobre $X_3 \doteq X_5 \longrightarrow X_5 \doteq X_3$.


4. **Elim ($X_5 := X_3$):** Reemplazamos $X_5$ en la ecuación de $X_2$:



$$X_2 \doteq (X_3 \to X_4) \to X_3$$


5. **Elim ($X_4 := X_6$):**

$$X_2 \doteq (X_3 \to X_6) \to X_3$$


6. El sistema concluye exitosamente en $\emptyset$.


7. **Sustitución $mgu$:**

$$S = \{ X_1 := X_3 \to X_6, \quad X_2 := (X_3 \to X_6) \to X_3, \quad X_4 := X_6, \quad X_5 := X_3 \}$$




* **Conclusión:** **Es tipable.**
* Tipo del término: $S(X_2 \to X_6) = \mathbf{((X_3 \to X_6) \to X_3) \to X_6}$.


* Contexto inferido: $S(\Gamma_0) = \mathbf{\{ w : X_3 \to X_6 \}}$.


* *(Curiosidad lógica: ¡El tipo inferido es la famosa Ley de Peirce!)*




---

### Término 3: $\lambda x.\, \lambda y.\, x \; y$

* **Paso 1 y 2 (Anotación):** $\Gamma_0 = \emptyset$, $M_0 = \lambda x : X_1.\, \lambda y : X_2.\, x \; y$.


* **Paso 3 (Generación de restricciones):**
* Bajo $\Gamma = \{x : X_1, \; y : X_2\}$, en la aplicación $x \; y$ creamos $X_3$ fresco:



$$E = \{ X_1 \doteq (X_2 \to X_3) \}$$


* Tipo del cuerpo $= X_3$.


* Tipo total $= X_1 \to (X_2 \to X_3)$.




* **Paso 4 (Unificación):**
* Aplicamos **Elim** en $X_1$: $S = \{X_1 := X_2 \to X_3\}$. Queda $\emptyset$.




* **Conclusión:** **Es tipable.**
* Tipo inferido: $S(X_1 \to X_2 \to X_3) = \mathbf{(X_2 \to X_3) \to X_2 \to X_3}$.





---

### Término 4: $\lambda x.\, (\lambda x.\, x) \; x$

* **Paso 1 (Rectificación obligatoria):**
* Hay dos abstracciones con la variable $x$. Renombramos la variable ligada interna por $y$:



$$U_{\text{rect}} = \lambda x.\, (\lambda y.\, y) \; x$$




* **Paso 2 (Anotación):** $\Gamma_0 = \emptyset$.



$$M_0 = \lambda x : X_1.\, (\lambda y : X_2.\, y) \; x$$


* **Paso 3 (Generación de restricciones):**
* Contexto: $\Gamma = \{x : X_1\}$.


* $\lambda y : X_2.\, y$ tiene tipo $X_2 \to X_2$, restricciones $\emptyset$.


* $x$ tiene tipo $X_1$, restricciones $\emptyset$.


* Aplicación $((\lambda y.\, y) \; x)$: inventamos $X_3$ fresco.



$$E = \{ (X_2 \to X_2) \doteq (X_1 \to X_3) \}$$


* Tipo del cuerpo $= X_3$.


* Tipo total $= X_1 \to X_3$.




* **Paso 4 (Unificación):**
* **Decompose:** $\{X_2 \doteq X_1, \; X_2 \doteq X_3\}$.


* **Elim ($X_2 := X_1$):** $\{X_1 \doteq X_3\}$.


* **Elim ($X_1 := X_3$):** conjunto vacío $\emptyset$.


* $S = \{X_1 := X_3, \; X_2 := X_3\}$.




* **Conclusión:** **Es tipable.**
* Tipo inferido: $S(X_1 \to X_3) = \mathbf{X_3 \to X_3}$ (la función identidad).





---

### Término 5: $\lambda x.\, (\lambda y.\, y) \; x$

* **Paso 1 y 2 (Anotación):** Ya está rectificado (las variables tienen nombres distintos).



$$M_0 = \lambda x : X_1.\, (\lambda y : X_2.\, y) \; x$$


* **Resolución:**
* La estructura sintáctica es **idéntica** al término anterior luego de la rectificación.
* Genera la misma restricción: $E = \{(X_2 \to X_2) \doteq (X_1 \to X_3)\}$.


* La unificación devuelve $S = \{X_1 := X_3, \; X_2 := X_3\}$.




* **Conclusión:** **Es tipable.**
* Tipo inferido: $\mathbf{X_3 \to X_3}$.





---

### Término 6: $(\lambda z.\, \lambda x.\, x \; (z \; (\lambda y.\, z))) \; \text{True}$

* **Paso 1 y 2 (Anotación):** $\Gamma_0 = \emptyset$.



$$M_0 = (\lambda z : X_1.\, \lambda x : X_2.\, x \; (z \; (\lambda y : X_3.\, z))) \; \text{True}$$


* **Paso 3 (Generación de restricciones):**
* Analizamos la abstracción interna con $\Gamma = \{z : X_1, \; x : X_2, \; y : X_3\}$:


* Abstracción $\lambda y : X_3.\, z$: el cuerpo es $z$ (tipo $X_1$). El tipo de esta función es $X_3 \to X_1$.


* Aplicación $(z \; (\lambda y.\, z))$: el operador es $z$ (tipo $X_1$) y su argumento tiene tipo $X_3 \to X_1$.


* Por la regla de aplicación (con variable fresca $X_4$ para el resultado):



$$E_1 = \{ X_1 \doteq ((X_3 \to X_1) \to X_4) \}$$



Tipo de $(z \; (\lambda y.\, z)) = X_4$.


* Aplicación $x \; (\dots)$: el operador $x$ tiene tipo $X_2$ y se aplica al resultado $X_4$. Con variable fresca $X_5$:



$$E_2 = \{ X_2 \doteq (X_4 \to X_5) \}$$



Tipo de $(x \; (\dots)) = X_5$.




* Tipo de $\lambda x : X_2.\, \dots = X_2 \to X_5$.


* Tipo de $\lambda z : X_1.\, \dots = X_1 \to (X_2 \to X_5)$.


* Aplicación al término $\text{True}$:
* $\text{True}$ tiene tipo $\text{Bool}$.


* Inventamos variable fresca $X_6$ para el resultado total de la aplicación externa:



$$E_3 = \{ (X_1 \to (X_2 \to X_5)) \doteq (\text{Bool} \to X_6) \}$$




* **Conjunto $E$ total:**

$$E = \{ X_1 \doteq (X_3 \to X_1) \to X_4, \quad X_2 \doteq X_4 \to X_5, \quad (X_1 \to (X_2 \to X_5)) \doteq (\text{Bool} \to X_6) \}$$




* **Paso 4 (Unificación):**
1. Miramos la primera ecuación del conjunto:



$$X_1 \doteq (X_3 \to X_1) \to X_4$$


2. Observamos que la variable $X_1$ aparece en el miembro izquierdo y **también aparece en el miembro derecho** (como tipo de retorno de la subexpresión $X_3 \to X_1$).


3. Como $X_1 \in \text{vars}((X_3 \to X_1) \to X_4)$ y no son idénticos, se dispara la regla **Occurs-Check**.


4. El algoritmo se detiene inmediatamente en **falla**.




* **Conclusión:** El término **NO es tipable**.



---

### Término 7: $y \; x$

* **Paso 1 y 2 (Anotación):**
* Tanto $y$ como $x$ son variables libres.


* Contexto inicial: $\Gamma_0 = \{y : X_1, \; x : X_2\}$.


* Término anotado: $M_0 = y \; x$.




* **Paso 3 (Generación de restricciones):**
* Tipo de $y$: $X_1$, $E = \emptyset$.


* Tipo de $x$: $X_2$, $E = \emptyset$.


* Por la regla de aplicación, creamos la variable fresca $X_3$ para el resultado:



$$E = \{ X_1 \doteq (X_2 \to X_3) \}$$



Tipo total $= X_3$.




* **Paso 4 (Unificación):**
* Ecuación única: $\{X_1 \doteq X_2 \to X_3\}$.


* $X_1$ no ocurre en $X_2 \to X_3$.


* Aplicamos **Elim** en $X_1$: la sustitución es $S = \{X_1 := X_2 \to X_3\}$ y el conjunto queda $\emptyset$.




* **Conclusión:** **Es tipable.**
* Tipo del resultado: $S(X_3) = \mathbf{X_3}$.


* Contexto de tipado inferido:



$$S(\Gamma_0) = \{ y : S(X_1), \; x : S(X_2) \} = \mathbf{\{ y : X_2 \to X_3, \; x : X_2 \}}$$


* Juicio de tipado derivado: $\mathbf{\{y : X_2 \to X_3, \; x : X_2\} \vdash y \; x : X_3}$.

# Ejercicio 6: Numerales de Church

## Enunciado e Intuición

Se pide hallar tipos $\sigma$ y $\tau$ apropiados para que los términos de la forma:


$$c_n = \lambda y : \sigma.\, \lambda x : \tau.\, y^n(x)$$


resulten tipables para todo $n \in \mathbb{N}$, donde $y^0(x) = x$ e $y^{n+1}(x) = y(y^n(x))$. El par $(\sigma, \tau)$ debe ser el mismo para todos los números $n$.

* **Intuición:** Un numeral de Church representa la operación de aplicar una función $y$ exactamente $n$ veces partiendo de un valor base $x$. Para que podamos componer $y$ consigo misma tantas veces como queramos ($y(y(\dots(y(x))\dots))$), el dominio y el codominio de $y$ deben coincidir obligatoriamente; es decir, $y$ debe ser un endomorfismo ($\alpha \to \alpha$). Si $y$ transforma cosas de tipo $\alpha$ en cosas de tipo $\alpha$, entonces el elemento base $x$ debe tener ese mismo tipo $\alpha$, permitiendo que la cadena de aplicaciones funcione para cualquier $n$.



---

#### Resolución Formal con el Algoritmo $\mathcal{I}$

Siguiendo la sugerencia del enunciado, analizamos el caso $n = 2$ sobre el término sin tipos:


$$U = \lambda y.\, \lambda x.\, y \; (y \; x)$$

1. **Anotación con incógnitas frescas:** Término cerrado ($\Gamma_0 = \emptyset$).



$$M_0 = \lambda y : X_1.\, \lambda x : X_2.\, y \; (y \; x)$$



2. **Generación de restricciones $\mathcal{I}(\{y : X_1, x : X_2\} \mid y \; (y \; x))$:**
* Subexpresión $(y \; x)$: $y$ tiene tipo $X_1$ y $x$ tiene tipo $X_2$. Con variable fresca $X_3$ para el resultado, se genera la restricción de aplicación:



$$E_1 = \{ X_1 \doteq X_2 \to X_3 \}$$



Tipo de $(y \; x) = X_3$.


* Subexpresión exterior $y \; (y \; x)$: el operador $y$ tiene tipo $X_1$ y el argumento tiene tipo $X_3$. Con variable fresca $X_4$ para el resultado:



$$E_2 = \{ X_1 \doteq X_3 \to X_4 \}$$



Tipo del cuerpo $= X_4$.


* Conjunto de restricciones:

$$E = \{ X_1 \doteq X_2 \to X_3, \quad X_1 \doteq X_3 \to X_4 \}$$



* Tipo preliminar del término: $X_1 \to X_2 \to X_4$.




3. **Unificación de Martelli-Montanari:**
* **Elim ($X_1 := X_2 \to X_3$):** Reemplazamos $X_1$ en la segunda ecuación:



$$\{ X_2 \to X_3 \doteq X_3 \to X_4 \}$$


* **Decompose:**

$$\{ X_2 \doteq X_3, \quad X_3 \doteq X_4 \}$$



* Por transitividad mediante **Elim**, obtenemos la sustitución más general:



$$S = \{ X_1 := X_4 \to X_4, \quad X_2 := X_4, \quad X_3 := X_4 \}$$





4. **Tipo resultante para $n = 2$:**

$$S(X_1 \to X_2 \to X_4) = (X_4 \to X_4) \to X_4 \to X_4$$




Renombrando la variable libre $X_4$ por una variable genérica $\alpha$, los tipos son:



$$\sigma = \alpha \to \alpha \quad \text{y} \quad \tau = \alpha$$



#### Demostración por Inducción para todo $n \in \mathbb{N}$

Probemos por inducción en $n$ que con $\Gamma = \{y : \alpha \to \alpha, x : \alpha\}$ se deriva $\Gamma \vdash y^n(x) : \alpha$:

* **Caso base ($n = 0$):** $y^0(x) = x$. Por la regla **T-Var**, $\{y : \alpha \to \alpha, x : \alpha\} \vdash x : \alpha$.


* **Paso inductivo ($n + 1$):** Por definición, $y^{n+1}(x) = y(y^n(x))$. Por hipótesis inductiva, $\Gamma \vdash y^n(x) : \alpha$. Como además $\Gamma \vdash y : \alpha \to \alpha$, aplicando la regla **T-App** concluimos $\Gamma \vdash y(y^n(x)) : \alpha$.



Aplicando **T-Abs** dos veces:


$$\vdash \lambda y : (\alpha \to \alpha).\, \lambda x : \alpha.\, y^n(x) : (\alpha \to \alpha) \to \alpha \to \alpha$$

* **Conclusión:** Los tipos requeridos son **$\sigma = \alpha \to \alpha$** y **$\tau = \alpha$**. Todos los numerales de Church tienen exactamente el **mismo tipo principal**: $(\alpha \to \alpha) \to \alpha \to \alpha$.



---

# Ejercicio 7: Inferencia y Chequeo de Tipos

#### Enunciado

Dada la expresión $U = \lambda y.\, (x \; y) \; (\lambda z.\, z)$:

1. Utilizar el algoritmo de inferencia.


2. Demostrar mediante chequeo de tipos (árbol de derivación) que el juicio encontrado es correcto.


3. Determinar qué ocurriría si la variable ligada $z$ fuera $x$.



---

#### Resolución de la Parte I (Inferencia)

1. **Rectificación y Anotación:**
* Variable libre: $x \implies \Gamma_0 = \{x : X_1\}$.


* Variables ligadas: $y : X_2$ y $z : X_3$.


* Término anotado: $M_0 = \lambda y : X_2.\, (x \; y) \; (\lambda z : X_3.\, z)$.




2. **Generación de restricciones $\mathcal{I}(\{x : X_1, y : X_2\} \mid (x \; y) \; (\lambda z : X_3.\, z))$:**
* Para la función identidad $(\lambda z : X_3.\, z)$: Tipo $= X_3 \to X_3$, restricciones $\emptyset$.


* Para $(x \; y)$: $x$ tiene tipo $X_1$ e $y$ tiene tipo $X_2$. Con variable fresca $X_4$ para el resultado:



$$E_1 = \{ X_1 \doteq X_2 \to X_4 \}$$



Tipo de $(x \; y) = X_4$.


* Para la aplicación principal $((x \; y) \; (\lambda z.\, z))$: el operador tiene tipo $X_4$ y el argumento tiene tipo $X_3 \to X_3$. Con variable fresca $X_5$:



$$E_2 = \{ X_4 \doteq (X_3 \to X_3) \to X_5 \}$$



Tipo del cuerpo $= X_5$.


* Tipo total de la abstracción: $X_2 \to X_5$.


* Conjunto de restricciones:

$$E = \{ X_1 \doteq X_2 \to X_4, \quad X_4 \doteq (X_3 \to X_3) \to X_5 \}$$





3. **Unificación de Martelli-Montanari:**
* **Elim ($X_4 := (X_3 \to X_3) \to X_5$):** Sustituimos $X_4$ en la primera ecuación:



$$X_1 \doteq X_2 \to ((X_3 \to X_3) \to X_5)$$


* Conjunto reducido a $\emptyset$. La sustitución unificadora más general es:



$$S = \{ X_1 := X_2 \to (X_3 \to X_3) \to X_5, \quad X_4 := (X_3 \to X_3) \to X_5 \}$$




4. **Juicio inferido:**
* Contexto: $S(\Gamma_0) = \mathbf{\{ x : X_2 \to (X_3 \to X_3) \to X_5 \}}$.


* Término: $S(M_0) = \lambda y : X_2.\, (x \; y) \; (\lambda z : X_3.\, z)$.


* Tipo: $S(X_2 \to X_5) = \mathbf{X_2 \to X_5}$.





---

#### Resolución de la Parte II (Chequeo de Tipos)

Verificamos que el juicio derivado sea válido construyendo su árbol de tipado deductivo en el cálculo lambda simplemente tipado:
Sean $\Gamma = \{x : X_2 \to (X_3 \to X_3) \to X_5\}$ y $\Gamma' = \Gamma \cup \{y : X_2\}$.

$$\frac{\dfrac{\dfrac{x : X_2 \to (X_3 \to X_3) \to X_5 \in \Gamma'}{\Gamma' \vdash x : X_2 \to (X_3 \to X_3) \to X_5} \text{T-Var} \quad \dfrac{y : X_2 \in \Gamma'}{\Gamma' \vdash y : X_2} \text{T-Var}}{\Gamma' \vdash x \; y : (X_3 \to X_3) \to X_5} \text{T-App} \quad \dfrac{\dfrac{z : X_3 \in \Gamma', z : X_3}{\Gamma', z : X_3 \vdash z : X_3} \text{T-Var}}{\Gamma' \vdash \lambda z : X_3.\, z : X_3 \to X_3} \text{T-Abs}}{\dfrac{\Gamma' \vdash (x \; y) \; (\lambda z : X_3.\, z) : X_5}{\Gamma \vdash \lambda y : X_2.\, (x \; y) \; (\lambda z : X_3.\, z) : X_2 \to X_5} \text{T-Abs}} \text{T-App}$$

El árbol cierra completamente en todos sus axiomas, demostrando que el juicio es formalmente correcto.

---

#### Resolución de la Parte III (Si $z$ fuera $x$)

Si la expresión original fuera $\lambda y.\, (x \; y) \; (\lambda x.\, x)$, tendríamos que la variable $x$ aparece simultáneamente como **variable libre** en $(x \; y)$ y como **variable ligada** en $(\lambda x.\, x)$.

* El **Paso 1 del algoritmo $\mathcal{I}$ exige rectificar el término** mediante $\alpha$-renombre de modo que ninguna variable ligada tenga el mismo nombre que una variable libre:



$$\text{erase}(\lambda y.\, (x \; y) \; (\lambda x.\, x)) \quad \xrightarrow{\alpha} \quad \lambda y.\, (x \; y) \; (\lambda z.\, z)$$



* **Conclusión:** Como el cálculo lambda opera módulo $\alpha$-equivalencia ($\Lambda_\alpha$), el algoritmo rectifica el término renombrando la variable ligada a una variable fresca $z$, por lo que **el resultado del tipado y la inferencia es exactamente el mismo**.



---

# Ejercicio 8: Extensión con Pares (Productos Cartesianos)

#### Reglas del enunciado

* Tipos: $\tau ::= \dots \mid \tau \times \tau$

* Términos: $M ::= \dots \mid \langle M, M \rangle \mid \pi_1(M) \mid \pi_2(M)$

* Reglas para $\mathcal{I}$:


* $\mathcal{I}(\Gamma \mid \langle M_1, M_2 \rangle) = (\tau \times \sigma \mid E_1 \cup E_2)$ donde $\mathcal{I}(\Gamma \mid M_1) = (\tau \mid E_1)$ e $\mathcal{I}(\Gamma \mid M_2) = (\sigma \mid E_2)$.


* $\mathcal{I}(\Gamma \mid \pi_1(M)) = (\sigma \mid \{\tau \doteq \sigma \times X\} \cup E)$ con $X$ fresca y $(\tau \mid E) = \mathcal{I}(\Gamma \mid M)$.


* $\mathcal{I}(\Gamma \mid \pi_2(M)) = (\rho \mid \{\tau \doteq X \times \rho\} \cup E)$ con $X$ fresca y $(\tau \mid E) = \mathcal{I}(\Gamma \mid M)$.





---

#### Ítem I: Tipar $(\lambda f.\, \langle f \; \text{zero}, \; f \; \text{succ(zero)} \rangle) \; (\lambda x.\, \text{isZero}(x))$

*(Nota sintáctica del PDF: la guía escribe $(\lambda f.\, \langle f \; 2 \rangle \dots)$ usando números y proyecciones; resolvemos la aplicación estándar dada en el texto)*:


$$U = (\lambda f.\, \langle f \; \text{zero}, \; f \; \text{succ(zero)} \rangle) \; (\lambda x.\, \text{isZero}(x))$$

1. **Anotación con frescas:** $\Gamma_0 = \emptyset$.



$$M_0 = (\lambda f : X_1.\, \langle f \; \text{zero}, \; f \; \text{succ(zero)} \rangle) \; (\lambda x : X_2.\, \text{isZero}(x))$$



2. **Generación de restricciones con $\mathcal{I}$:**
* Operador izquierdo $\lambda f : X_1.\, \langle f \; \text{zero}, \; f \; \text{succ(zero)} \rangle$:


* Bajo $\{f : X_1\}$, evaluamos $f \; \text{zero}$: requiere $X_1 \doteq \text{Nat} \to X_3$, con $X_3$ fresco. Tipo: $X_3$.


* Evaluamos $f \; \text{succ(zero)}$: requiere $X_1 \doteq \text{Nat} \to X_4$, con $X_4$ fresco. Tipo: $X_4$.


* Por la regla del par: tipo $= X_3 \times X_4$.


* Tipo de la abstracción $= X_1 \to (X_3 \times X_4)$.




* Argumento derecho $\lambda x : X_2.\, \text{isZero}(x)$:


* $\text{isZero}(x)$ requiere $X_2 \doteq \text{Nat}$ y da $\text{Bool}$.


* Tipo de la abstracción $= X_2 \to \text{Bool}$.




* Aplicación global (con resultado fresco $X_5$):



$$E = \{ X_1 \doteq \text{Nat} \to X_3, \quad X_1 \doteq \text{Nat} \to X_4, \quad X_2 \doteq \text{Nat}, \quad (X_1 \to (X_3 \times X_4)) \doteq ((X_2 \to \text{Bool}) \to X_5) \}$$




3. **Unificación de Martelli-Montanari:**
* **Decompose** en la última ecuación:

$$X_1 \doteq X_2 \to \text{Bool} \quad \text{y} \quad X_5 \doteq X_3 \times X_4$$



* Como $X_2 \doteq \text{Nat}$, entonces $X_1 \doteq \text{Nat} \to \text{Bool}$.


* Unificando con las ecuaciones de $X_1$:

$$\text{Nat} \to \text{Bool} \doteq \text{Nat} \to X_3 \implies X_3 \doteq \text{Bool}$$



$$\text{Nat} \to \text{Bool} \doteq \text{Nat} \to X_4 \implies X_4 \doteq \text{Bool}$$



* Por lo tanto, $X_5 \doteq \text{Bool} \times \text{Bool}$.




4. **Conclusión:** **Es tipable.**
* Tipo inferido: $\mathbf{\text{Bool} \times \text{Bool}}$.





---

#### Ítem II: Intentar tipar $(\lambda f.\, \langle f \; \text{zero}, \; f \; \text{True} \rangle) \; (\lambda x.\, x)$

*(En la guía: $(\lambda f.\, \langle f \; 2, \; f \; \text{True} \rangle) \; (\lambda x.\, x)$)*

1. **Anotación con frescas:**

$$M_0 = (\lambda f : X_1.\, \langle f \; \text{zero}, \; f \; \text{True} \rangle) \; (\lambda x : X_2.\, x)$$



2. **Generación de restricciones en el cuerpo de $\lambda f$:**
* Para $f \; \text{zero}$: como $\text{zero} : \text{Nat}$, se genera la ecuación:



$$X_1 \doteq \text{Nat} \to X_3 \quad \text{(con } X_3 \text{ fresca)}$$


* Para $f \; \text{True}$: como $\text{True} : \text{Bool}$, se genera la ecuación:



$$X_1 \doteq \text{Bool} \to X_4 \quad \text{(con } X_4 \text{ fresca)}$$


* El conjunto $E$ contiene necesariamente:

$$E = \{ X_1 \doteq \text{Nat} \to X_3, \quad X_1 \doteq \text{Bool} \to X_4, \dots \}$$





3. **Unificación de Martelli-Montanari:**
* Aplicamos **Elim** en $X_1$ reemplazando en la segunda ecuación:



$$\text{Nat} \to X_3 \doteq \text{Bool} \to X_4$$


* Aplicamos **Decompose** por la flecha:



$$\text{Nat} \doteq \text{Bool} \quad \text{y} \quad X_3 \doteq X_4$$


* En la ecuación $\text{Nat} \doteq \text{Bool}$, los constructores base son distintos ($\text{Nat} \ne \text{Bool}$). Se activa la regla **Clash** y el algoritmo se detiene inmediatamente en **falla**.





* **Conclusión:** **NO es tipable.**
* *Justificación del fallo:* La inferencia falla por la regla **Clash** en Martelli-Montanari al exigir que el argumento formal $f$ tenga simultáneamente dominio $\text{Nat}$ y dominio $\text{Bool}$ dentro de la tupla. En cálculo lambda monomórfico, una misma variable ligada no puede recibir argumentos de tipos heterogéneos.





---

# Ejercicio 9: Extensión con Uniones Disjuntas (Sumas / Coproductos)

#### Reglas provistas por la práctica



* Tipos: $\tau ::= \dots \mid \tau + \tau$

* Términos: $M ::= \dots \mid \text{left}_\sigma(M) \mid \text{right}_\sigma(M) \mid \text{case } M \text{ of } \text{left}(x) \leadsto M \mid \text{right}(y) \leadsto M$

* Regla de $\mathcal{I}$ para el condicional de suma:



$$\mathcal{I}(\Gamma \mid \text{case } M_1 \text{ of } \text{left}(x) \leadsto M_2 \mid \text{right}(y) \leadsto M_3) = (\tau_2 \mid \{ \tau_1 \doteq X_x + X_y, \; \tau_2 \doteq \tau_3 \} \cup E_1 \cup E_2 \cup E_3)$$



donde $\mathcal{I}(\Gamma \mid M_1) = (\tau_1 \mid E_1)$, $\mathcal{I}(\Gamma, x : X_x \mid M_2) = (\tau_2 \mid E_2)$, $\mathcal{I}(\Gamma, y : X_y \mid M_3) = (\tau_3 \mid E_3)$, con $X_x, X_y$ frescas.



---

#### I. $\text{case } \text{left}_\sigma(\text{zero}) \text{ of } \text{left}(x) \leadsto \text{isZero}(x) \mid \text{right}(y) \leadsto \text{True}$

*(Nota: el enunciado escribe $\text{left}(1)$ en notación informal para denotar $\text{succ(zero)}$)*.

1. **Anotación y llamada recursiva:** $\Gamma_0 = \emptyset$.


* $M_1 = \text{left}_{X_1}(\text{zero})$: $\text{zero} : \text{Nat}$, por lo que $\tau_1 = \text{Nat} + X_1$ con $E_1 = \emptyset$.


* Rama left: con $x : X_x$, el cuerpo es $\text{isZero}(x) \implies X_x \doteq \text{Nat}$, tipo $\tau_2 = \text{Bool}$.


* Rama right: con $y : X_y$, el cuerpo es $\text{True} \implies \tau_3 = \text{Bool}$, $E_3 = \emptyset$.




2. **Restricciones generadas:**

$$E = \{ \text{Nat} + X_1 \doteq X_x + X_y, \quad \text{Bool} \doteq \text{Bool}, \quad X_x \doteq \text{Nat} \}$$



3. **Unificación:**
* **Decompose** en la primera ecuación: $X_x \doteq \text{Nat}$ y $X_1 \doteq X_y$.


* **Delete** en $\text{Bool} \doteq \text{Bool}$ y en $X_x \doteq \text{Nat}$ tras sustituir.


* Sustitución $mgu$: $\{X_x := \text{Nat}, \; X_1 := X_y\}$.





* **Conclusión:** **Es tipable.**
* Tipo del término: $\mathbf{\text{Bool}}$.


* Juicio de tipado: $\mathbf{\vdash \text{case } \text{left}_{X_y}(\text{zero}) \text{ of } \text{left}(x) \leadsto \text{isZero}(x) \mid \text{right}(y) \leadsto \text{True} : \text{Bool}}$.





---

#### II. $\text{case } \text{right}_\sigma(z) \text{ of } \text{left}(x) \leadsto \text{isZero}(x) \mid \text{right}(y) \leadsto y$

1. **Anotación:** Variable libre $z \implies \Gamma_0 = \{z : X_z\}$. Anotamos $\text{right}_{X_1}(z)$.


* $M_1 = \text{right}_{X_1}(z)$: tipo $\tau_1 = X_1 + X_z$.


* Rama left ($x : X_x$): $\text{isZero}(x) \implies X_x \doteq \text{Nat}$, $\tau_2 = \text{Bool}$.


* Rama right ($y : X_y$): cuerpo $y \implies \tau_3 = X_y$.




2. **Restricciones:**

$$E = \{ X_1 + X_z \doteq X_x + X_y, \quad \text{Bool} \doteq X_y, \quad X_x \doteq \text{Nat} \}$$



3. **Unificación:**
* Por **Decompose** de la suma: $X_1 \doteq X_x$ y $X_z \doteq X_y$.


* Con $X_x := \text{Nat}$ y $X_y := \text{Bool}$, obtenemos:


$$S = \{ X_x := \text{Nat}, \quad X_y := \text{Bool}, \quad X_1 := \text{Nat}, \quad X_z := \text{Bool} \}$$






* **Conclusión:** **Es tipable.**
* Tipo del término: $S(\tau_2) = \mathbf{\text{Bool}}$.


* Contexto inferido: $S(\Gamma_0) = \mathbf{\{ z : \text{Bool} \}}$.





---

#### III. $\text{case } \text{right}_\sigma(\text{zero}) \text{ of } \text{left}(x) \leadsto \text{isZero}(x) \mid \text{right}(y) \leadsto y$

1. **Anotación:** Término cerrado ($\Gamma_0 = \emptyset$).


* $M_1 = \text{right}_{X_1}(\text{zero})$: como $\text{zero} : \text{Nat}$, tipo $\tau_1 = X_1 + \text{Nat}$.


* Rama left: $\tau_2 = \text{Bool}$ con $X_x \doteq \text{Nat}$.


* Rama right: $\tau_3 = X_y$.




2. **Restricciones:**

$$E = \{ X_1 + \text{Nat} \doteq X_x + X_y, \quad \text{Bool} \doteq X_y, \quad X_x \doteq \text{Nat} \}$$



3. **Unificación:**
* **Decompose** en la suma: $X_1 \doteq X_x$ y $\text{Nat} \doteq X_y$.


* De la igualdad de ramas se exige $\text{Bool} \doteq X_y$.


* Al aplicar **Elim** con $X_y := \text{Bool}$, la ecuación $\text{Nat} \doteq X_y$ deviene en:



$$\text{Nat} \doteq \text{Bool}$$


* Regla **Clash**: conflicto entre constructores constantes $\text{Nat} \ne \text{Bool} \implies \textbf{falla}$.





* **Conclusión:** **NO es tipable.**
* *Justificación:* El discriminador inyecta un natural por la derecha ($\text{right}(\text{zero})$), por lo que la variable de la rama derecha $y$ debe ser $\text{Nat}$, pero esa misma rama devuelve $y$ como resultado del case, cuyo tipo debe ser $\text{Bool}$ para coincidir con la rama izquierda ($\text{isZero}(x)$).





---

#### IV. $\text{case } x \text{ of } \text{left}(x) \leadsto \text{isZero}(x) \mid \text{right}(y) \leadsto y$

1. **Paso 1 (Rectificación):** La variable libre $x$ se llama igual que la variable ligada en el patrón `left(x)`. Rectificamos renombrando la ligada por $w$:



$$\text{case } x \text{ of } \text{left}(w) \leadsto \text{isZero}(w) \mid \text{right}(y) \leadsto y$$


2. **Anotación:** $\Gamma_0 = \{x : X_x\}$.


* $M_1 = x$: tipo $\tau_1 = X_x$.


* Rama left: $w : X_w \implies X_w \doteq \text{Nat}$ y $\tau_2 = \text{Bool}$.


* Rama right: $y : X_y \implies \tau_3 = X_y$.




3. **Restricciones:**

$$E = \{ X_x \doteq X_w + X_y, \quad \text{Bool} \doteq X_y, \quad X_w \doteq \text{Nat} \}$$



4. **Unificación:**
* Por **Elim**, $X_w := \text{Nat}$ y $X_y := \text{Bool}$.


* Sustituyendo en la primera: $X_x \doteq \text{Nat} + \text{Bool}$.


* $S = \{ X_x := \text{Nat} + \text{Bool}, \; X_w := \text{Nat}, \; X_y := \text{Bool} \}$.





* **Conclusión:** **Es tipable.**
* Tipo del término: $\mathbf{\text{Bool}}$.


* Contexto inferido: $S(\Gamma_0) = \mathbf{\{ x : \text{Nat} + \text{Bool} \}}$.





---

#### V. $\text{case } \text{left}_\sigma(z) \text{ of } \text{left}(x) \leadsto z \mid \text{right}(y) \leadsto y$

1. **Anotación:** Variable libre $z \implies \Gamma_0 = \{z : X_z\}$. Anotamos $\text{left}_{X_1}(z)$.


* $\tau_1 = X_z + X_1$.


* Rama left: con $x : X_x$, el cuerpo devuelve la variable libre $z$ (tipo $X_z$). Por lo tanto $\tau_2 = X_z$.


* Rama right: con $y : X_y$, el cuerpo devuelve $y$ (tipo $X_y$). Por lo tanto $\tau_3 = X_y$.




2. **Restricciones:**

$$E = \{ X_z + X_1 \doteq X_x + X_y, \quad X_z \doteq X_y \}$$



3. **Unificación:**
* **Decompose** en la suma: $X_z \doteq X_x$ y $X_1 \doteq X_y$.


* Con $X_z \doteq X_y$, igualamos $X_1 \doteq X_z$ y $X_x \doteq X_z$.


* Sustitución $mgu$: $\{X_x := X_z, \; X_y := X_z, \; X_1 := X_z\}$.





* **Conclusión:** **Es tipable.**
* Tipo del término: $S(\tau_2) = \mathbf{X_z}$.


* Contexto inferido: $\mathbf{\{ z : X_z \}}$.





---

#### VI. $\text{case } z \text{ of } \text{left}(x) \leadsto z \mid \text{right}(y) \leadsto y$

1. **Anotación:** Variable libre $z \implies \Gamma_0 = \{z : X_z\}$.


* Discriminador $M_1 = z$: tipo $\tau_1 = X_z$.


* Rama left ($x : X_x$): cuerpo $z$ (tipo $X_z$).


* Rama right ($y : X_y$): cuerpo $y$ (tipo $X_y$).




2. **Restricciones:**

$$E = \{ X_z \doteq X_x + X_y, \quad X_z \doteq X_y \}$$



3. **Unificación:**
* Aplicamos **Elim** con $X_z := X_y$ sobre la primera ecuación:



$$X_y \doteq X_x + X_y$$


* Examinamos la ecuación $X_y \doteq X_x + X_y$: la variable $X_y$ aparece dentro del constructor $(+)$ del lado derecho ($X_y \in \text{vars}(X_x + X_y)$).


* Se dispara la regla **Occurs-Check** $\implies \textbf{falla}$.





* **Conclusión:** **NO es tipable.**
* *Justificación:* El término exigiría que el tipo de $z$ sea igual a la suma disjunta de otro tipo consigo mismo infinitamente ($X_y \doteq X_x + X_y$), violando la condición de finitud de tipos detectada por Occurs-Check.





---

# Ejercicio 10: Extensión con Listas

#### Reglas provistas por la práctica



* Tipos: $\tau ::= \dots \mid [\tau]$

* $\mathcal{I}(\Gamma \mid []_\tau) = ([\tau] \mid \emptyset)$

* $\mathcal{I}(\Gamma \mid M_1 :: M_2) = (\tau_2 \mid \{ \tau_2 \doteq [\tau_1] \} \cup E_1 \cup E_2)$

* $\mathcal{I}(\Gamma \mid \text{foldr } M_1 \text{ base } \leadsto M_2; \; \text{rec}(h, r) \leadsto M_3) = (\tau_2 \mid \{ \tau_1 \doteq [X_h], \; \tau_2 \doteq \tau_3, \; \tau_3 \doteq X_r \} \cup E_1 \cup E_2 \cup E_3)$ con $X_h, X_r$ frescas.



---

#### I. $\text{foldr } (x :: []) \text{ base } \leadsto []; \; \text{rec}(h, r) \leadsto \text{isZero}(h) :: r$

1. **Anotación:**
* Variable libre $x \implies \Gamma_0 = \{x : X_x\}$.


* Lista de entrada $M_1 = x :: []_{X_1}$: como $x : X_x$ y $[] : [X_1]$, la regla del cons exige $[X_1] \doteq [X_x]$, devolviendo tipo $\tau_1 = [X_1]$.


* Caso base $M_2 = []_{X_2}$: tipo $\tau_2 = [X_2]$ con $E_2 = \emptyset$.


* Paso recursivo $M_3 = \text{isZero}(h) :: r$ bajo $\{h : X_h, r : X_r\}$:
* $\text{isZero}(h)$ exige $X_h \doteq \text{Nat}$ y da $\text{Bool}$.


* El cons exige $\tau_r \doteq [\text{Bool}]$, es decir, $X_r \doteq [\text{Bool}]$.


* Tipo $\tau_3 = X_r$.






2. **Restricciones acumuladas:**

$$E = \{ [X_1] \doteq [X_x], \quad [X_1] \doteq [X_h], \quad [X_2] \doteq X_r, \quad X_r \doteq X_r, \quad X_h \doteq \text{Nat}, \quad X_r \doteq [\text{Bool}] \}$$



3. **Unificación:**
* De $[X_1] \doteq [X_x]$ y $[X_1] \doteq [X_h]$ obtenemos por **Decompose** que $X_1 \doteq X_x \doteq X_h$.


* Como $X_h \doteq \text{Nat}$, entonces $X_x := \text{Nat}$ y $X_1 := \text{Nat}$.


* De $[X_2] \doteq X_r$ y $X_r \doteq [\text{Bool}]$, por transitividad $[X_2] \doteq [\text{Bool}] \implies X_2 := \text{Bool}$.


* Todas las ecuaciones unifican en $\emptyset$.





* **Conclusión:** **Es tipable.**
* Tipo del término: $S(\tau_2) = S([X_2]) = \mathbf{[\text{Bool}]}$.


* Contexto inferido: $S(\Gamma_0) = \mathbf{\{ x : \text{Nat} \}}$.





---

#### II. $\text{foldr } ((\lambda x.\, \text{succ}(x)) :: []) \text{ base } \leadsto []; \; \text{rec}(x, r) \leadsto \text{if } p \; x \text{ then } 2 :: r \text{ else } r$

*(Notación de la guía: $p$ variable booleana predicado, $2 \equiv \text{succ(succ(zero))}$)*.

1. **Rectificación y Anotación:**
* Renombramos la variable ligada en el paso recursivo por $h$ para evitar colisiones con $x$.


* Variable libre $p \implies \Gamma_0 = \{p : X_p\}$.


* Lista de entrada: $(\lambda x : X_x.\, \text{succ}(x)) :: []_{X_1}$. Como el sucesor exige $X_x \doteq \text{Nat}$ y da $\text{Nat}$, la función tiene tipo $\text{Nat} \to \text{Nat}$. La regla del cons exige $[X_1] \doteq [\text{Nat} \to \text{Nat}]$.


* Caso base: $[]_{X_2}$ de tipo $[X_2]$.


* Paso recursivo con $\{h : X_h, r : X_r\}$:
* Condición $p \; h$: exige $X_p \doteq X_h \to \text{Bool}$.


* Rama then: $\text{succ(succ(zero))} :: r$ exige $X_r \doteq [\text{Nat}]$ y da tipo $X_r$.


* Rama else: $r$ de tipo $X_r$.


* Tipo $\tau_3 = X_r$.






2. **Restricciones del foldr:**

$$\tau_1 \doteq [X_h] \implies [\text{Nat} \to \text{Nat}] \doteq [X_h] \implies X_h \doteq \text{Nat} \to \text{Nat}$$



$$\tau_2 \doteq X_r \implies [X_2] \doteq X_r$$




Como $X_r \doteq [\text{Nat}]$, entonces $[X_2] \doteq [\text{Nat}] \implies X_2 := \text{Nat}$.


3. **Unificación del predicado:**
* $X_p \doteq X_h \to \text{Bool} \implies X_p \doteq (\text{Nat} \to \text{Nat}) \to \text{Bool}$.





* **Conclusión:** **Es tipable.**
* Tipo del término: $\mathbf{[\text{Nat}]}$.


* Contexto inferido: $\mathbf{\{ p : (\text{Nat} \to \text{Nat}) \to \text{Bool} \}}$.





---

#### III. $\text{foldr } \text{base } \dots$ (Término mal formado)

En la diapositiva el inciso aparece como `foldr base rec(h,r) -> isZero(h)::r` omitiendo la lista de entrada $M_1$ y el caso base $M_2$.

* **Conclusión:** **Inválido sintácticamente.** La regla de tipado del foldr exige obligatoriamente los tres subtérminos ($M_1$ lista, $M_2$ base y $M_3$ paso).



---

#### IV. $\text{foldr } xs \text{ base } \leadsto \text{True}; \; \text{rec}(h, x) \leadsto x$

1. **Rectificación y Anotación:**
* Renombramos el acumulador por $r$ para no colisionar: $\text{rec}(h, r) \leadsto r$.


* Variable libre $xs \implies \Gamma_0 = \{xs : X_{xs}\}$.


* $M_1 = xs$ de tipo $X_{xs}$.


* $M_2 = \text{True}$ de tipo $\tau_2 = \text{Bool}$.


* Paso recursivo con $\{h : X_h, r : X_r\}$: cuerpo $r$, de tipo $\tau_3 = X_r$.




2. **Restricciones de $\mathcal{I}$ para foldr:**

$$E = \{ X_{xs} \doteq [X_h], \quad \text{Bool} \doteq X_r, \quad X_r \doteq X_r \}$$



3. **Unificación:**
* $X_r := \text{Bool}$.


* $X_{xs} := [X_h]$.


* La variable de los elementos de la lista $X_h$ queda completamente libre y sin ligar a un tipo base.





* **Conclusión:** **Es tipable.**
* Tipo resultante: $\mathbf{\text{Bool}}$.


* Contexto inferido: $\mathbf{\{ xs : [X_h] \}}$ (acepta una lista de cualquier tipo homogéneo $X_h$).