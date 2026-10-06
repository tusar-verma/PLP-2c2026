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