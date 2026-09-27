# Ejercicio 1: Sintaxis

**Consigna:** Determinar qué expresiones son sintácticamente válidas (generadas por las gramáticas) y a qué categoría pertenecen (términos o tipos).

Para resolver esto, debemos observar estrictamente las gramáticas definidas en la guía:

* **Términos ($M$):** $x \mid \lambda x:\tau. M \mid M\ M \mid \text{true} \mid \text{false} \mid \text{if } M \text{ then } M \text{ else } M \mid \text{zero} \mid \text{succ}(M) \mid \text{pred}(M) \mid \text{isZero}(M)$.


* **Tipos ($\tau$):** $\text{Bool} \mid \text{Nat} \mid \tau \to \tau$.


* Las letras $x, y, z$ (con o sin subíndices) representan nombres de variables arbitrarias tomadas de un conjunto infinito $\mathfrak{X}$. Las letras $M, N, O, P$ y $\sigma, \tau, \rho$ son metavariables que denotan términos y tipos, respectivamente, pero no son parte del lenguaje en sí.



**Resolución:**

* **a) $x$**: Es un término sintácticamente válido. Corresponde a la regla de generación de una variable.


* **b) $x~x$**: Es un término válido. Corresponde a la regla de aplicación de un término a otro ($M\ M$).


* **c) $M$**: Es inválido como expresión pura del lenguaje. La letra $M$ es una metavariable utilizada para describir la sintaxis, no una variable del conjunto $\mathfrak{X}$.


* **d) $M~M$**: Inválido por la misma razón que el caso anterior; utiliza metavariables.


* **e) $\text{true false}$**: Es un término válido. Se trata de la aplicación ($M\ M$) del término $\text{true}$ al término $\text{false}$.


* **f) $\text{true succ(false true)}$**: Es un término válido. Es una aplicación donde el término izquierdo es $\text{true}$ y el derecho es $\text{succ}(M)$, siendo $M$ la aplicación $\text{false true}$.


* **g) $\lambda x.\text{isZero}(x)$**: Es inválido. Según la gramática, la abstracción requiere explícitamente la anotación del tipo de la variable con la forma $\lambda x:\tau.M$.


* **h) $\lambda x:\sigma. \text{succ}(x)$**: Es inválido en el lenguaje estricto, ya que $\sigma$ es una metavariable que denota un tipo, no un tipo concreto derivado de la gramática.


* **j) $\lambda z: \text{if true then Bool else Nat}.~x$**: Es inválido. Las estructuras de control condicional (`if then else`) son exclusivas de la gramática de los términos ($M$), y no pueden utilizarse para definir expresiones de tipos ($\tau$).


* **k) $\sigma$**: Es inválido, pues es una metavariable.


* **l) $\text{Bool}$**: Es un tipo válido.


* **m) $\text{Bool} \to \text{Bool}$**: Es un tipo válido. Corresponde a la regla $\tau \to \tau$.


* **o) $\text{succ true}$**: Es inválido. La gramática define al sucesor estrictamente con paréntesis: $\text{succ}(M)$.


* **p) $\lambda x:\text{Bool}. \text{if zero then true else zero succ(true)}$**: Es un término válido. Es una abstracción bien formada cuyo cuerpo es una expresión `if`.



---

# Ejercicio 2: Árbol sintáctico de un término completo

**Consigna:** Mostrar un término que utilice al menos una vez todas las reglas de generación de la gramática de los términos y exhibir su árbol sintáctico.

Debemos incluir: variable ($x$), abstracción ($\lambda$), aplicación ($M\ M$), constantes booleanas ($\text{true}, \text{false}$), condicional ($\text{if}$), constante numérica ($\text{zero}$), y los operadores numéricos ($\text{succ}, \text{pred}, \text{isZero}$).

**Término propuesto:**
$(\lambda x:\text{Nat}. \text{if isZero}(x) \text{ then succ(zero) else pred}(y)) \text{ true false}$
(Nota: El término es sintácticamente válido aunque no tenga sentido semántico o no tipifique, ya que el ejercicio 1 y 2 se enfocan puramente en la gramática).

**Árbol sintáctico (Descripción):**

* **Raíz:** Aplicación (`@`).


* **Hijo izquierdo:** Aplicación (`@`).


* **Hijo izquierdo:** Abstracción (`λx:Nat`).


* **Cuerpo (Hijo único):** Condicional (`if`).


* **Condición:** `isZero`.


* **Hijo:** Variable (`x`).




* **Rama Then:** `succ`.


* **Hijo:** Constante (`zero`).




* **Rama Else:** `pred`.


* **Hijo:** Variable (`y`).








* **Hijo derecho:** Constante (`true`).




* **Hijo derecho:** Constante (`false`).





---

# Ejercicio 3: Subtérminos ⋆

**Consigna:** Analizar ocurrencias y subtérminos en distintas expresiones.

La teoría establece que un ligador (la variable junto al símbolo $\lambda$) identifica y define una entidad que funcionará como parámetro. Por lo tanto, el ligador en sí no es una expresión a evaluar y no se considera un subtérmino.

* **a) Marcar las ocurrencias del término $x$ como subtérmino en $\lambda x:\text{Nat}. \text{succ}((\lambda x:\text{Nat}. x) x)$:**
* La primera $x$ en $\lambda x:\text{Nat}$ es un ligador, no un subtérmino.


* La segunda $x$ en el ligador interno $(\lambda x:\text{Nat}$ tampoco es un subtérmino.


* La tercera $x$ (el cuerpo de la abstracción interna) sí es un subtérmino y es una **ocurrencia ligada**.


* La cuarta $x$ (el argumento de la aplicación) también es un subtérmino y es una **ocurrencia ligada** por el $\lambda$ más externo.




* **b) ¿Ocurre $x_1$ como subtérmino en $\lambda x_1 : \text{Nat}. \text{succ}(x_2)$?**
* No. Como se explicó, $x_1$ actúa exclusivamente como el ligador que define el parámetro de la función. No es un subtérmino.




* **c) ¿Ocurre $x (y z)$ como subtérmino en $u~x (y z)$?**
* No. Para resolver la omisión de paréntesis, la convención usual del cálculo lambda dicta que la aplicación es asociativa a izquierda. Esto significa que $u~x (y z)$ se agrupa sintácticamente como $((u~x) (y~z))$. Los subtérminos inmediatos son la aplicación $(u~x)$ y la aplicación $(y~z)$, impidiendo que exista la agrupación aislada $x (y z)$ dentro del árbol.





---

# Ejercicio 4: Paréntesis y Ligaduras ⋆

**Consigna:** Insertar paréntesis según la convención usual, imaginar el árbol e indicar variables libres y ligadas.

Según la teoría, las variables libres son aquellas que no están definidas por ningún ligador en su contexto, mientras que las ligadas remiten a un parámetro definido por una abstracción.

**a) $u~x (y~z) (\lambda v: \text{Bool}. v~y)$**

* **I. Paréntesis:** $(((u~x) (y~z)) (\lambda v: \text{Bool}. (v~y)))$.


* **II/III. Variables:** Las variables $u, x, y, z$ no tienen ningún ligador $\lambda$ que las defina en el término, por lo que son **ocurrencias libres**. La variable $v$ es definida por el ligador $\lambda v$, por lo que su ocurrencia en $(v~y)$ es una **ocurrencia ligada**. (Notar que la $y$ dentro de la abstracción sigue estando libre).



**b) $(\lambda x: \text{Bool} \to \text{Nat} \to \text{Bool}. \lambda y: \text{Bool} \to \text{Nat}. \lambda z: \text{Bool}. x~z (y~z)) u~v~w$**

* **I. Paréntesis:** $(((( \lambda x \dots ( \lambda y \dots ( \lambda z: \text{Bool}. ((x~z) (y~z)) ) ) ) u) v) w)$.


* **II/III. Variables:** Las variables $x, y, z$ son parámetros de las funciones anidadas, por ende sus ocurrencias en el cuerpo $((x~z) (y~z))$ son **ligadas**. Las variables $u, v, w$ que se pasan como argumentos al final no están bajo el alcance de ningún $\lambda$, por lo que ocurren de forma **libre**.



**c) $w (\lambda x: \text{Bool} \to \text{Nat} \to \text{Bool}. \lambda y: \text{Bool} \to \text{Nat}. \lambda z: \text{Bool}. x~z (y~z)) u~v$**

* **I. Paréntesis:** $(((w ( \lambda x \dots ( \lambda y \dots ( \lambda z: \text{Bool}. ((x~z) (y~z)) ) ) )) u) v)$.


* **II/III. Variables:** Al igual que en el caso anterior, $x, y, z$ son **ligadas**. Las variables $w, u, v$ son **libres**.



**IV. ¿En cuál término ocurre el subtérmino $(\lambda x \dots x~z(y~z))~u$?**


Ocurre únicamente en el término **b**. Debido a la asociatividad a izquierda de la aplicación, en el término (b) primero se aplica todo el bloque de lambdas a la variable $u$, conformando exactamente ese subtérmino. En cambio, en el término (c), la variable $w$ es aplicada al bloque de lambdas, modificando la estructura del árbol.

---

# Ejercicio 5: Término no tipable

**Consigna:** Mostrar un término que no sea tipable y que no tenga variables libres ni abstracciones.

Para que un término no tenga variables libres ni abstracciones, debemos construirlo puramente con las constantes y constructores de la gramática (como `true`, `false`, `zero`, `succ`, etc.).

* **Término propuesto:** $\text{succ(true)}$
* **Justificación:** La gramática define el constructor $\text{succ}(M)$. Sin embargo, para que un término sea bien tipado, las reglas de inferencia exigen coherencia de tipos. La función `succ` espera computacionalmente un término de tipo $\text{Nat}$, pero se le está pasando la constante `true`, cuyo tipo base es $\text{Bool}$. Al producirse este choque de tipos sin variables abiertas ni abstracciones, el término resultante es sintácticamente válido pero **no es tipable**.

Resolución detallada y justificada de los **Ejercicios 6 al 10** de la **Práctica N° 4 (Cálculo-$\lambda$: Tipado y Semántica Operacional)**.

---

## Marco de Referencia: Reglas de Tipado del Sistema Base

Para construir o refutar derivaciones de forma rigurosa, recordemos las reglas de inferencia que definen el sistema de tipos para el cálculo-$\lambda$ con `Bool` y `Nat`:

* **Variable (`T-Var` / `var`):** $\dfrac{x : \tau \in \Gamma}{\Gamma \vdash x : \tau}$ (donde el contexto $\Gamma$ es un conjunto finito de pares $x_i : \tau_i$ sin variables repetidas).


* **Abstracción (`T-Abs` / $\to_i$):** $\dfrac{\Gamma, x : \sigma \vdash M : \tau}{\Gamma \vdash \lambda x : \sigma . M : \sigma \to \tau}$
* **Aplicación (`T-App` / $\to_e$):** $\dfrac{\Gamma \vdash M : \sigma \to \tau \quad \Gamma \vdash N : \sigma}{\Gamma \vdash M \, N : \tau}$
* **Booleanos (`T-True`, `T-False`):** $\dfrac{}{\Gamma \vdash \text{true} : \text{Bool}}$ y $\dfrac{}{\Gamma \vdash \text{false} : \text{Bool}}$
* **Condicional (`T-If`):** $\dfrac{\Gamma \vdash M : \text{Bool} \quad \Gamma \vdash N : \tau \quad \Gamma \vdash O : \tau}{\Gamma \vdash \text{if } M \text{ then } N \text{ else } O : \tau}$
* **Naturales (`T-Zero`, `T-Succ`, `T-Pred`, `T-IsZero`):**
* $\dfrac{}{\Gamma \vdash \text{zero} : \text{Nat}}$
* $\dfrac{\Gamma \vdash M : \text{Nat}}{\Gamma \vdash \text{succ}(M) : \text{Nat}}$ y $\dfrac{\Gamma \vdash M : \text{Nat}}{\Gamma \vdash \text{pred}(M) : \text{Nat}}$


* $\dfrac{\Gamma \vdash M : \text{Nat}}{\Gamma \vdash \text{isZero}(M) : \text{Bool}}$



---

# Ejercicio 6 (Derivaciones ⋆)

**Consigna:** Dar una derivación —o explicar por qué no es posible dar una derivación— para cada uno de los siguientes juicios de tipado.

### a) $\vdash \text{if true then zero else succ(zero)} : \text{Nat}$

**Es derivable.** La condición `true` tiene tipo `Bool` y ambas ramas (`zero` y `succ(zero)`) tienen el mismo tipo `Nat`, cumpliendo todas las premisas de la regla `T-If` en el contexto vacío ($\Gamma = \emptyset$).

$$\dfrac{   \dfrac{}{\vdash \text{true} : \text{Bool}} \text{ T-True}   \quad   \dfrac{}{\vdash \text{zero} : \text{Nat}} \text{ T-Zero}   \quad   \dfrac{     \dfrac{}{\vdash \text{zero} : \text{Nat}} \text{ T-Zero}   }{\vdash \text{succ(zero)} : \text{Nat}} \text{ T-Succ} }{\vdash \text{if true then zero else succ(zero)} : \text{Nat}} \text{ T-If}$$

---

### b) $x : \text{Nat}, y : \text{Bool} \vdash \text{if true then false else } (\lambda z : \text{Bool}. z) \text{ true} : \text{Bool}$

**Es derivable.** Llamemos $\Gamma = \{x : \text{Nat}, y : \text{Bool}\}$ al contexto inicial (notar que las variables del contexto no se usan, lo cual es perfectamente válido por debilitamiento).

* La guarda `true` tiene tipo `Bool`.
* La rama *then* (`false`) tiene tipo `Bool`.
* La rama *else* es una aplicación $(\lambda z : \text{Bool}. z) \text{ true}$ donde la función tiene tipo $\text{Bool} \to \text{Bool}$ y el argumento tiene tipo $\text{Bool}$, resultando en tipo $\text{Bool}$.

$$\dfrac{   \dfrac{}{\Gamma \vdash \text{true} : \text{Bool}} \text{ T-True}   \quad   \dfrac{}{\Gamma \vdash \text{false} : \text{Bool}} \text{ T-False}   \quad   \dfrac{     \dfrac{       \dfrac{z : \text{Bool} \in \Gamma, z : \text{Bool}}{\Gamma, z : \text{Bool} \vdash z : \text{Bool}} \text{ T-Var}     }{\Gamma \vdash \lambda z : \text{Bool}. z : \text{Bool} \to \text{Bool}} \text{ T-Abs}     \quad     \dfrac{}{\Gamma \vdash \text{true} : \text{Bool}} \text{ T-True}   }{\Gamma \vdash (\lambda z : \text{Bool}. z) \text{ true} : \text{Bool}} \text{ T-App} }{x : \text{Nat}, y : \text{Bool} \vdash \text{if true then false else } (\lambda z : \text{Bool}. z) \text{ true} : \text{Bool}} \text{ T-If}$$

---

### c) $\vdash \text{if } \lambda x : \text{Bool}. x \text{ then zero else succ(zero)} : \text{Nat}$

**No es posible dar una derivación.**

* **Justificación:** La única regla aplicable a un término condicional es `T-If`, cuya primera premisa exige que la condición tenga tipo $\text{Bool}$ ($\vdash \lambda x : \text{Bool}. x : \text{Bool}$). Sin embargo, la única regla que permite tipar una abstracción es `T-Abs`, la cual concluye obligatoriamente un tipo funcional de la forma $\sigma \to \tau$ (en este caso, $\vdash \lambda x : \text{Bool}. x : \text{Bool} \to \text{Bool}$). Como $\text{Bool} \to \text{Bool} \neq \text{Bool}$, la búsqueda de la derivación se traba en la premisa de la condición.

---

### d) $x : \text{Bool} \to \text{Nat}, y : \text{Bool} \vdash x~y : \text{Nat}$

**Es derivable.** Sea $\Gamma = \{x : \text{Bool} \to \text{Nat}, y : \text{Bool}\}$. Aplicamos la regla de aplicación (`T-App`) y cerramos ambas ramas con la regla de variable (`T-Var`):

$$\dfrac{   \dfrac{x : \text{Bool} \to \text{Nat} \in \Gamma}{\Gamma \vdash x : \text{Bool} \to \text{Nat}} \text{ T-Var}   \quad   \dfrac{y : \text{Bool} \in \Gamma}{\Gamma \vdash y : \text{Bool}} \text{ T-Var} }{x : \text{Bool} \to \text{Nat}, y : \text{Bool} \vdash x~y : \text{Nat}} \text{ T-App}$$

---

# Ejercicio 7

**Consigna:** Se modifica la regla de tipado de la abstracción y se la cambia por la siguiente regla:


$$\frac{\Gamma \vdash M : \tau}{\Gamma \vdash \lambda x : \sigma. M : \sigma \to \tau} \to_{i2}$$


Exhibir un juicio de tipado que sea derivable en el sistema original pero que no lo sea en el sistema actual.

* **Juicio propuesto:**

$$\vdash \lambda x : \text{Bool}. x : \text{Bool} \to \text{Bool}$$


* **Justificación detallada:**
1. **En el sistema original:** La regla `T-Abs` ($\to_i$) agrega el par $x : \text{Bool}$ al contexto $\Gamma$ al subir a la premisa. Esto permite derivar $x : \text{Bool} \vdash x : \text{Bool}$ mediante la regla `T-Var`, cerrando el árbol exitosamente.
2. **En el sistema modificado ($\to_{i2}$):** La nueva regla **no agrega** la declaración $x : \sigma$ al contexto de la premisa ($\Gamma$ permanece intacto). Al intentar derivar $\vdash \lambda x : \text{Bool}. x : \text{Bool} \to \text{Bool}$ con $\Gamma = \emptyset$, la premisa exige demostrar $\emptyset \vdash x : \text{Bool}$. Como $x$ no pertenece al contexto vacío $\emptyset$, no es posible aplicar `T-Var` y el juicio no se puede derivar. *(En este sistema defectuoso solo se podrían tipar funciones constantes que no utilicen su parámetro ligado $x$, salvo que $x$ ya estuviera declarada previamente en el contexto externo).*





---

# Ejercicio 8

**Consigna:** Determinar qué tipo representa $\sigma$ en cada uno de los siguientes juicios de tipado.

### a) $\vdash \text{succ(zero)} : \sigma$

* **Respuesta:** $\sigma = \text{Nat}$.
* **Justificación:** Por `T-Zero`, sabemos que $\vdash \text{zero} : \text{Nat}$. La única regla para tipar el constructor `succ` es `T-Succ`, la cual establece que si su subtérmino tiene tipo $\text{Nat}$, la expresión $\text{succ(zero)}$ tiene tipo $\text{Nat}$.



### b) $\vdash \text{isZero(succ(zero))} : \sigma$

* **Respuesta:** $\sigma = \text{Bool}$.
* **Justificación:** Por el inciso (a), $\vdash \text{succ(zero)} : \text{Nat}$. La regla `T-IsZero` exige que su subtérmino sea de tipo $\text{Nat}$ y concluye que la expresión completa `isZero(...)` tiene tipo $\text{Bool}$.

### c) $\vdash \text{if (if true then false else false) then zero else succ(zero)} : \sigma$

* **Respuesta:** $\sigma = \text{Nat}$.
* **Justificación:**
1. En el condicional interno, `true`, `false` y `false` tienen tipo `Bool`, por lo que `if true then false else false` tiene tipo `Bool` según `T-If`.
2. En el condicional principal, la condición es válida (tiene tipo `Bool`), la rama *then* (`zero`) tiene tipo `Nat` y la rama *else* (`succ(zero)`) tiene tipo `Nat`. Por la regla `T-If`, el tipo resultante de toda la expresión coincide con el tipo de sus ramas: $\sigma = \text{Nat}$.



---

# Ejercicio 9 (Tipos habitados) 

**Consigna:** Demostrar que los siguientes tipos están habitados para cualquier $\sigma, \tau$ y $\rho$ (es decir, exhibir un término cerrado $M$ tal que $\vdash M : \text{Tipo}$ sea derivable).

> **Estrategia:** Como $\sigma, \tau, \rho$ son tipos arbitrarios, no podemos usar constantes particulares (`zero`, `true`), sino únicamente variables y abstracciones/aplicaciones. Recordemos que $\to$ asocia a derecha.

### a) $\sigma \to \tau \to \sigma$

* **Habitante:** $M = \lambda x : \sigma . \lambda y : \tau . x$
* **Derivación:** Llamando $\Gamma = \{x : \sigma, y : \tau\}$,

$$\dfrac{   \dfrac{     \dfrac{x : \sigma \in \Gamma}{x : \sigma, y : \tau \vdash x : \sigma} \text{ T-Var}   }{x : \sigma \vdash \lambda y : \tau . x : \tau \to \sigma} \text{ T-Abs} }{\vdash \lambda x : \sigma . \lambda y : \tau . x : \sigma \to \tau \to \sigma} \text{ T-Abs}$$



---

### b) $(\sigma \to \tau \to \rho) \to (\sigma \to \tau) \to \sigma \to \rho$

* **Habitante:** $M = \lambda f : \sigma \to \tau \to \rho . \lambda g : \sigma \to \tau . \lambda x : \sigma . (f~x)~(g~x)$
* **Justificación / Derivación:** Sea el contexto completo $\Gamma = \{f : \sigma \to \tau \to \rho, \; g : \sigma \to \tau, \; x : \sigma\}$.
1. Por `T-Var` y `T-App`, aplicamos $f$ a $x$ obteniendo $\Gamma \vdash f~x : \tau \to \rho$.
2. Por `T-Var` y `T-App`, aplicamos $g$ a $x$ obteniendo $\Gamma \vdash g~x : \tau$.
3. Por `T-App`, aplicamos $(f~x)$ al argumento $(g~x)$ obteniendo $\Gamma \vdash (f~x)~(g~x) : \rho$.
4. Finalmente, aplicamos tres veces seguidas la regla `T-Abs` abstrayendo $x : \sigma$, luego $g : \sigma \to \tau$ y por último $f : \sigma \to \tau \to \rho$, obteniendo el juicio en el contexto vacío $\vdash M : (\sigma \to \tau \to \rho) \to (\sigma \to \tau) \to \sigma \to \rho$.



---

### c) $(\sigma \to \tau \to \rho) \to \tau \to \sigma \to \rho$

* **Habitante:** $M = \lambda f : \sigma \to \tau \to \rho . \lambda y : \tau . \lambda x : \sigma . (f~x)~y$
* **Justificación / Derivación:** Sea $\Gamma = \{f : \sigma \to \tau \to \rho, \; y : \tau, \; x : \sigma\}$.
1. Por `T-App` entre $f$ y $x$, tenemos $\Gamma \vdash f~x : \tau \to \rho$.
2. Por `T-App` entre $(f~x)$ e $y$, tenemos $\Gamma \vdash (f~x)~y : \rho$.
3. Aplicando tres veces `T-Abs` (para $x$, luego $y$, luego $f$), se deriva $\vdash \lambda f : \sigma \to \tau \to \rho . \lambda y : \tau . \lambda x : \sigma . (f~x)~y : (\sigma \to \tau \to \rho) \to \tau \to \sigma \to \rho$.



---

### d) $(\tau \to \rho) \to (\sigma \to \tau) \to \sigma \to \rho$

* **Habitante:** $M = \lambda f : \tau \to \rho . \lambda g : \sigma \to \tau . \lambda x : \sigma . f~(g~x)$
* **Justificación / Derivación:** Sea $\Gamma = \{f : \tau \to \rho, \; g : \sigma \to \tau, \; x : \sigma\}$.
1. Por `T-App` entre $g$ y $x$, tenemos $\Gamma \vdash g~x : \tau$.
2. Por `T-App` entre $f$ y $(g~x)$, tenemos $\Gamma \vdash f~(g~x) : \rho$.
3. Aplicando tres veces `T-Abs` (para $x$, luego $g$, luego $f$), se deriva $\vdash \lambda f : \tau \to \rho . \lambda g : \sigma \to \tau . \lambda x : \sigma . f~(g~x) : (\tau \to \rho) \to (\sigma \to \tau) \to \sigma \to \rho$.



---

### Respuestas a la sección "Para pensar"



1. **¿Con qué función ya conocida de Haskell se corresponden los habitantes de los otros tipos?**

* **a)** $\sigma \to \tau \to \sigma$ se corresponde con **`const`** (toma dos argumentos y devuelve siempre el primero, ignorando el segundo).
* **c)** $(\sigma \to \tau \to \rho) \to \tau \to \sigma \to \rho$ se corresponde con **`flip`** (toma una función currificada de dos argumentos y devuelve una función equivalente que recibe los argumentos en orden inverso).
* **d)** $(\tau \to \rho) \to (\sigma \to \tau) \to \sigma \to \rho$ se corresponde con la composición de funciones **`(.)`** (aplica primero $g$ a $x$ y al resultado le aplica $f$).


2. **¿Hay tipos que no estén habitados?**

* En el cálculo con los tipos concretos `Bool` y `Nat`, cualquier tipo construido a partir de `Bool`, `Nat` y $\to$ está habitado (porque siempre podemos devolver `true` o `zero` al final de las abstracciones).
* Sin embargo, como esquemas de tipos genéricos (para *cualquier* $\sigma$ y $\tau$ arbitrarios sin usar constantes de tipos base), existen esquemas **no habitados**, como $\sigma \to \tau$ (si $\sigma \neq \tau$) o $((\sigma \to \tau) \to \sigma) \to \sigma$.


3. **¿Si se reemplaza $\to$ por $\Rightarrow$, las fórmulas habitadas son siempre tautologías?**

* **Sí.** Por el Isomorfismo de Curry-Howard, toda derivación de tipado en el cálculo-$\lambda$ simplemente tipado (con variables, $\lambda$ y aplicación) se corresponde exactamente con una demostración en el fragmento implicacional de la **Lógica Proposicional Intuicionista (NJ)**. Por el teorema de corrección (soundness) de la deducción natural, toda fórmula demostrable en NJ es también válida en la semántica clásica bivaluada (es una tautología).




4. **¿Las tautologías son siempre fórmulas habitadas?**

* **No.** Existen tautologías de la lógica clásica que **no son demostrables en lógica intuicionista (NJ)** y, por lo tanto, no tienen habitantes en el cálculo-$\lambda$ simplemente tipado puro. El ejemplo canónico que utiliza únicamente el conectivo $\Rightarrow$ es la **Ley de Peirce**: $((\tau \Rightarrow \rho) \Rightarrow \tau) \Rightarrow \tau$. Es una tautología clásica, pero el tipo $((\tau \to \rho) \to \tau) \to \tau$ no está habitado para $\tau, \rho$ arbitrarios.





---

# Ejercicio 10 

**Consigna:** Determinar qué tipos representan $\sigma$ y $\tau$ en cada uno de los siguientes juicios de tipado. Si hay más de una solución, o si no hay ninguna, indicarlo.

### a) $x : \sigma \vdash \text{isZero(succ}(x)) : \tau$

* **Solución única:** $\sigma = \text{Nat}$ y $\tau = \text{Bool}$.
* **Justificación:**
1. El constructor más externo es `isZero(...)`. Por la regla `T-IsZero`, el tipo del término completo debe ser $\tau = \text{Bool}$, y su subtérmino `succ(x)` debe tener tipo $\text{Nat}$.
2. Para que $x : \sigma \vdash \text{succ}(x) : \text{Nat}$ sea derivable mediante `T-Succ`, su premisa exige $x : \sigma \vdash x : \text{Nat}$.


3. Por `T-Var`, esto fuerza a que $\sigma = \text{Nat}$.



---

### b) $\vdash (\lambda x : \sigma. x)(\lambda y : \text{Bool}. \text{zero}) : \sigma$

* **Solución única:** $\sigma = \text{Bool} \to \text{Nat}$ (y no aparece $\tau$ en este ítem).
* **Justificación:**
1. El subtérmino derecho $\lambda y : \text{Bool}. \text{zero}$ tiene tipo $\text{Bool} \to \text{Nat}$ (por `T-Abs` y `T-Zero`).
2. El subtérmino izquierdo $\lambda x : \sigma. x$ tiene tipo $\sigma \to \sigma$ (por `T-Abs` y `T-Var`).
3. Por la regla `T-App`, para aplicar una función de tipo $\sigma \to \sigma$ a un argumento de tipo $\text{Bool} \to \text{Nat}$, el dominio de la función debe coincidir exactamente con el tipo del argumento: $\sigma = \text{Bool} \to \text{Nat}$. El resultado de la aplicación también tiene tipo $\sigma = \text{Bool} \to \text{Nat}$, verificando el juicio.



---

### c) $y : \tau \vdash \text{if } (\lambda x : \sigma. x) \text{ then } y \text{ else succ(zero)} : \sigma$

* **Solución:** **No hay ninguna solución.**
* **Justificación:** Por la regla `T-If`, la guarda del condicional debe tener tipo $\text{Bool}$, es decir, necesitaríamos derivar $y : \tau \vdash \lambda x : \sigma. x : \text{Bool}$. Pero por `T-Abs`, cualquier abstracción $\lambda x : \sigma. x$ tiene tipo funcional $\sigma \to \sigma$. No existe ningún tipo $\sigma$ tal que $\sigma \to \sigma = \text{Bool}$, por lo que el juicio nunca es derivable.

---

### d) $x : \sigma \vdash x~y : \tau$

* **Solución:** **No hay ninguna solución** (asumiendo $x \neq y$, como indican los nombres distintos de variables).
* **Justificación:** Para tipar la aplicación $x~y$ mediante `T-App`, necesitamos derivar en la premisa derecha el juicio $x : \sigma \vdash y : \rho$ para algún tipo $\rho$. Sin embargo, $y$ es una variable y la única regla aplicable es `T-Var`, que requiere que $y$ esté declarada en el contexto. Como el contexto solo contiene a $x : \sigma$, la variable libre $y$ no puede tiparse.



---

### e) $x : \sigma, y : \tau \vdash x~y : \tau$

* **Infinitas soluciones:** $\tau$ puede ser **cualquier tipo** válido (por ejemplo, $\text{Bool}$, $\text{Nat}$, $\text{Bool} \to \text{Nat}$, etc.) y $\sigma$ debe ser de la forma **$\tau \to \tau$**.
* **Justificación:**
1. Por `T-Var`, el argumento $y$ tiene tipo $\tau$, y queremos que el resultado de la aplicación $x~y$ también tenga tipo $\tau$.
2. Por la regla `T-App`, la variable $x$ que actúa como función debe recibir un argumento de tipo $\tau$ y devolver un resultado de tipo $\tau$.
3. Por lo tanto, $\sigma = \tau \to \tau$ para cualquier elección del tipo $\tau$.



---

### f) $x : \sigma \vdash x~\text{true} : \tau$

* **Infinitas soluciones:** $\tau$ puede ser **cualquier tipo** válido, y $\sigma = \text{Bool} \to \tau$.
* **Justificación:**
1. El argumento `true` tiene tipo `Bool` (por `T-True`).
2. Para que la aplicación $x~\text{true}$ tenga tipo $\tau$ mediante `T-App`, $x$ debe ser una función cuyo dominio sea `Bool` y cuyo codominio sea $\tau$.
3. Así, para cualquier tipo $\tau$, basta tomar $\sigma = \text{Bool} \to \tau$.



---

### g) $x : \sigma \vdash x~\text{true} : \sigma$

* **Solución:** **No hay ninguna solución.**
* **Justificación:**
1. Por el análisis del ítem anterior (`T-App` y `T-True`), para que $x~\text{true}$ tenga tipo $\sigma$, el tipo de $x$ (que es $\sigma$) debería ser una función que toma un `Bool` y devuelve algo de tipo $\sigma$.
2. Esto exige satisfacer la ecuación de tipos:

$$\sigma = \text{Bool} \to \sigma$$


3. En la gramática de tipos finitos del cálculo-$\lambda$ simplemente tipado, ningún tipo puede ser igual a una expresión que lo contenga a sí mismo como subtérmino propio (una expresión de tipo tiene longitud/altura finita, y la longitud de $\text{Bool} \to \sigma$ es estrictamente mayor que la de $\sigma$). Por lo tanto, no existe solución.



---

### h) $x : \sigma \vdash x~x : \tau$

* **Solución:** **No hay ninguna solución**.


* **Justificación:**
1. Como se destaca en las clases teóricas, el término de auto-aplicación $x~x$ no es tipable en el cálculo simplemente tipado sin importar qué anotación de tipo se le asigne.


2. Por la regla `T-App`, para que $x~x$ tenga tipo $\tau$, la ocurrencia izquierda de $x$ debe tener un tipo funcional $\rho \to \tau$ mientras que la ocurrencia derecha de $x$ debe tener el tipo del argumento $\rho$.
3. Como ambas son la misma variable $x$ cuyo único tipo en el contexto es $\sigma$, debe cumplirse simultáneamente que $\sigma = \rho \to \tau$ y $\sigma = \rho$.


4. Sustituyendo una en otra, obtenemos la ecuación $\sigma = \sigma \to \tau$, la cual es imposible de satisfacer con tipos finitos porque el lado derecho tiene mayor tamaño sintáctico que el izquierdo.

A continuación se presenta la resolución detallada y justificada de los **Ejercicios 11 al 15** de la Práctica N° 4, desarrollada paso a paso para servir como guía de estudio.

---

# Ejercicio 11 (Debilitamiento y fortalecimiento)

**Consigna:** Demostrar las siguientes propiedades, procediendo por inducción en la derivación del juicio correspondiente, y dar un contraejemplo cuando se indique.

### 1. Debilitamiento (*Weakening*)

> **Propiedad a demostrar:** Si $\Gamma \vdash M : \sigma$ es un juicio de tipado derivable y $x$ es una variable que no aparece en $\Gamma$ ($x \notin \text{dom}(\Gamma)$), entonces $\Gamma, x : \tau \vdash M : \sigma$ es derivable para todo tipo $\tau$.
> 
> 

Demostración por inducción en la estructura de la derivación de $\Gamma \vdash M : \sigma$:
Analizamos los casos según la última regla de inferencia aplicada en la derivación de $\Gamma \vdash M : \sigma$:

* **Casos base (Axiomas):**
* **`T-True`, `T-False`, `T-Zero`:** El juicio es de la forma $\Gamma \vdash c : \sigma$ (donde $c \in \{\text{true}, \text{false}, \text{zero}\}$). Como estos axiomas son válidos en cualquier contexto bien formado y $x \notin \text{dom}(\Gamma)$, aplicando el mismo axioma sobre el contexto extendido obtenemos directamente $\Gamma, x : \tau \vdash c : \sigma$.
* **`T-Var`:** El término es una variable $y$, es decir, $\Gamma \vdash y : \sigma$ con $(y : \sigma) \in \Gamma$. Como por hipótesis $x \notin \text{dom}(\Gamma)$, el contexto $\Gamma, x : \tau$ es válido (no repite variables) y sigue cumpliéndose que $(y : \sigma) \in (\Gamma, x : \tau)$. Aplicando `T-Var`, derivamos $\Gamma, x : \tau \vdash y : \sigma$.


* **Casos inductivos:**
* **`T-Succ`, `T-Pred`, `T-IsZero`:** Supongamos que la última regla es `T-Succ`, con premisa $\Gamma \vdash M_1 : \text{Nat}$ y conclusión $\Gamma \vdash \text{succ}(M_1) : \text{Nat}$. Por Hipótesis Inductiva (HI) aplicada a la derivación de la premisa (ya que $x \notin \text{dom}(\Gamma)$), es derivable $\Gamma, x : \tau \vdash M_1 : \text{Nat}$. Aplicando `T-Succ` a este juicio, obtenemos $\Gamma, x : \tau \vdash \text{succ}(M_1) : \text{Nat}$. *(Los casos `T-Pred` y `T-IsZero` son completamente análogos).*


* **`T-If`:** La última regla tiene como premisas $\Gamma \vdash M_1 : \text{Bool}$, $\Gamma \vdash M_2 : \sigma$ y $\Gamma \vdash M_3 : \sigma$. Aplicando la HI a cada una de las tres subderivaciones, obtenemos que $\Gamma, x : \tau \vdash M_1 : \text{Bool}$, $\Gamma, x : \tau \vdash M_2 : \sigma$ y $\Gamma, x : \tau \vdash M_3 : \sigma$ son derivables. Aplicando `T-If`, concluimos $\Gamma, x : \tau \vdash \text{if } M_1 \text{ then } M_2 \text{ else } M_3 : \sigma$.
* **`T-App`:** Las premisas son $\Gamma \vdash M_1 : \rho \to \sigma$ y $\Gamma \vdash M_2 : \rho$. Por HI en ambas premisas, son derivables $\Gamma, x : \tau \vdash M_1 : \rho \to \sigma$ y $\Gamma, x : \tau \vdash M_2 : \rho$. Aplicando `T-App`, concluimos $\Gamma, x : \tau \vdash M_1~M_2 : \sigma$.
* **`T-Abs`:** El término es $\lambda y : \rho_1 . M_1$ con tipo $\sigma = \rho_1 \to \rho_2$, y la premisa de la derivación es $\Gamma, y : \rho_1 \vdash M_1 : \rho_2$.
* Trabajando en $\Lambda_\alpha$ y por la **Hipótesis de Barendregt**, podemos asumir sin pérdida de generalidad que la variable ligada $y$ es distinta de $x$ ($y \neq x$) y $y \notin \text{dom}(\Gamma)$.


* Como $x \notin \text{dom}(\Gamma)$ y $x \neq y$, entonces $x \notin \text{dom}(\Gamma, y : \rho_1)$.
* Podemos aplicar la HI a la premisa para obtener que $\Gamma, y : \rho_1, x : \tau \vdash M_1 : \rho_2$ es derivable (como el contexto es un conjunto de pares, equivale a $\Gamma, x : \tau, y : \rho_1 \vdash M_1 : \rho_2$).
* Aplicando `T-Abs`, concluimos $\Gamma, x : \tau \vdash \lambda y : \rho_1 . M_1 : \rho_1 \to \rho_2$. $\blacksquare$





---

### 2. Fortalecimiento (*Strengthening*)

> **Propiedad a demostrar:** Si $\Gamma, x : \tau \vdash M : \sigma$ es un juicio de tipado derivable tal que $x$ no aparece libre en $M$ ($x \notin \text{fv}(M)$), entonces $\Gamma \vdash M : \sigma$ es derivable para todo tipo $\tau$.
> 
> 

Demostración por inducción en la derivación de $\Gamma, x : \tau \vdash M : \sigma$:

* **Casos base (Axiomas):**
* **`T-True`, `T-False`, `T-Zero`:** No dependen de las variables del contexto, por lo que $\Gamma \vdash c : \sigma$ es derivable directamente por el mismo axioma.
* **`T-Var`:** El término es $M = y$, por lo que $\Gamma, x : \tau \vdash y : \sigma$. El conjunto de variables libres es $\text{fv}(y) = \{y\}$. Como por hipótesis $x \notin \text{fv}(y)$, sabemos con certeza que $y \neq x$. Dado que $(y : \sigma) \in (\Gamma, x : \tau)$ y $y \neq x$, obligatoriamente $(y : \sigma) \in \Gamma$. Aplicando `T-Var`, derivamos $\Gamma \vdash y : \sigma$.


* **Casos inductivos:**
* **`T-Succ`, `T-Pred`, `T-IsZero`:** Sea $M = \text{succ}(M_1)$. Sabemos que $\text{fv}(\text{succ}(M_1)) = \text{fv}(M_1)$. Como $x \notin \text{fv}(M)$, entonces $x \notin \text{fv}(M_1)$. Aplicando la HI a la premisa $\Gamma, x : \tau \vdash M_1 : \text{Nat}$, obtenemos $\Gamma \vdash M_1 : \text{Nat}$ y por `T-Succ` concluimos $\Gamma \vdash \text{succ}(M_1) : \text{Nat}$. *(Análogo para `pred` e `isZero`).*


* **`T-If`:** Sea $M = \text{if } M_1 \text{ then } M_2 \text{ else } M_3$. Como $\text{fv}(M) = \text{fv}(M_1) \cup \text{fv}(M_2) \cup \text{fv}(M_3)$ y $x \notin \text{fv}(M)$, entonces $x$ no aparece libre en ninguno de los tres subtérminos. Por HI en las tres premisas y aplicando `T-If`, se deriva $\Gamma \vdash \text{if } M_1 \text{ then } M_2 \text{ else } M_3 : \sigma$.


* **`T-App`:** Sea $M = M_1~M_2$. Como $\text{fv}(M_1~M_2) = \text{fv}(M_1) \cup \text{fv}(M_2)$ y $x \notin \text{fv}(M_1~M_2)$, tenemos que $x \notin \text{fv}(M_1)$ y $x \notin \text{fv}(M_2)$. Aplicando la HI a ambas premisas de `T-App` y volviendo a aplicar `T-App`, obtenemos $\Gamma \vdash M_1~M_2 : \sigma$.


* **`T-Abs`:** Sea $M = \lambda y : \rho_1 . M_1$ con $\sigma = \rho_1 \to \rho_2$. Por la Hipótesis de Barendregt, tomamos un representante donde la variable ligada $y$ cumpla $y \neq x$.


* Recordemos que $\text{fv}(\lambda y : \rho_1 . M_1) = \text{fv}(M_1) \setminus \{y\}$.
* Como $x \notin \text{fv}(\lambda y : \rho_1 . M_1)$ y además $x \neq y$, se deduce que $x \notin \text{fv}(M_1)$.
* La premisa de la derivación es $\Gamma, x : \tau, y : \rho_1 \vdash M_1 : \rho_2$. Aplicando la HI sobre esta premisa (pues $x \notin \text{fv}(M_1)$), obtenemos que $\Gamma, y : \rho_1 \vdash M_1 : \rho_2$ es derivable.
* Aplicando `T-Abs`, concluimos $\Gamma \vdash \lambda y : \rho_1 . M_1 : \rho_1 \to \rho_2$. $\blacksquare$





---

### 3. Contraejemplo para fortalecimiento cuando $x \in \text{fv}(M)$

* **Contraejemplo:** Tomemos $\Gamma = \emptyset$, el término $M = x$ (donde claramente $x \in \text{fv}(x)$) y $\tau = \sigma = \text{Bool}$.
* **Justificación:**
* El juicio $x : \text{Bool} \vdash x : \text{Bool}$ **es derivable** en un paso mediante la regla `T-Var`.
* Sin embargo, al quitar $x : \text{Bool}$ del contexto, el juicio resultante $\emptyset \vdash x : \text{Bool}$ **no es derivable**, ya que la variable $x$ queda libre sin estar declarada en el contexto vacío, haciendo imposible aplicar `T-Var`.



---

# Ejercicio 12 (Lema de sustitución)

**Consigna:** Demostrar que si valen $\Gamma, x : \sigma \vdash M : \tau$ y $\Gamma \vdash N : \sigma$ entonces vale $\Gamma \vdash M\{x := N\} : \tau$. Sugerencia: proceder por inducción en la estructura del término $M$.

Demostración por inducción estructural en $M$:

1. **Caso $M = \text{true}$, $M = \text{false}$ o $M = \text{zero}$:**
* Por definición de sustitución, $c\{x := N\} = c$ (para $c \in \{\text{true}, \text{false}, \text{zero}\}$).
* Como $\Gamma, x : \sigma \vdash c : \tau$ solo puede haberse derivado por el axioma correspondiente (`T-True`, `T-False` o `T-Zero`), aplicando el mismo axioma sobre $\Gamma$ obtenemos $\Gamma \vdash c : \tau$.


2. Caso $M = y$ (una variable):
Subdividimos en dos casos según si $y$ es o no la variable $x$:


* **Subcaso $y = x$:**
* Por definición de sustitución, $x\{x := N\} = N$.
* Como $\Gamma, x : \sigma \vdash x : \tau$ proviene únicamente de la regla `T-Var`, y en un contexto cada variable tiene un único tipo asignado, debe cumplirse que $\tau = \sigma$.
* Queremos ver que $\Gamma \vdash N : \tau$, es decir, $\Gamma \vdash N : \sigma$, lo cual vale exactamente por nuestra segunda hipótesis del enunciado.




* **Subcaso $y \neq x$:**
* Por definición de sustitución, $y\{x := N\} = y$.
* Como $x \notin \text{fv}(y)$ y tenemos $\Gamma, x : \sigma \vdash y : \tau$, por la propiedad de **Fortalecimiento** (demostrada en el Ejercicio 11.2) obtenemos directamente $\Gamma \vdash y : \tau$.






3. Caso $M = \text{succ}(M_1)$ (análogo para $\text{pred}(M_1)$ e $\text{isZero}(M_1)$):


* Por definición de sustitución, $(\text{succ}(M_1))\{x := N\} = \text{succ}(M_1\{x := N\})$.
* La única regla para tipar $\text{succ}(M_1)$ es `T-Succ`, por lo que $\tau = \text{Nat}$ y su premisa es $\Gamma, x : \sigma \vdash M_1 : \text{Nat}$.


* Por Hipótesis Inductiva sobre $M_1$, vale $\Gamma \vdash M_1\{x := N\} : \text{Nat}$.
* Aplicando `T-Succ`, concluimos $\Gamma \vdash \text{succ}(M_1\{x := N\}) : \text{Nat}$.




4. Caso $M = \text{if } M_1 \text{ then } M_2 \text{ else } M_3$:


* Por definición de sustitución, $(\text{if } M_1 \text{ then } M_2 \text{ else } M_3)\{x := N\} = \text{if } M_1\{x := N\} \text{ then } M_2\{x := N\} \text{ else } M_3\{x := N\}$.
* La derivación de $\Gamma, x : \sigma \vdash M : \tau$ debe terminar con `T-If`, cuyas premisas son $\Gamma, x : \sigma \vdash M_1 : \text{Bool}$, $\Gamma, x : \sigma \vdash M_2 : \tau$ y $\Gamma, x : \sigma \vdash M_3 : \tau$.
* Aplicando la HI a $M_1, M_2$ y $M_3$, obtenemos $\Gamma \vdash M_1\{x := N\} : \text{Bool}$, $\Gamma \vdash M_2\{x := N\} : \tau$ y $\Gamma \vdash M_3\{x := N\} : \tau$.
* Aplicando `T-If`, concluimos $\Gamma \vdash (\text{if } M_1 \text{ then } M_2 \text{ else } M_3)\{x := N\} : \tau$.


5. Caso $M = M_1~M_2$ (Aplicación):


* Por definición de sustitución, $(M_1~M_2)\{x := N\} = (M_1\{x := N\})~(M_2\{x := N\})$.
* La derivación de $\Gamma, x : \sigma \vdash M_1~M_2 : \tau$ debe provenir de `T-App`, por lo que existe un tipo $\rho$ tal que valen las premisas $\Gamma, x : \sigma \vdash M_1 : \rho \to \tau$ y $\Gamma, x : \sigma \vdash M_2 : \rho$.
* Por HI en $M_1$ y en $M_2$, valen $\Gamma \vdash M_1\{x := N\} : \rho \to \tau$ y $\Gamma \vdash M_2\{x := N\} : \rho$.
* Aplicando `T-App`, obtenemos $\Gamma \vdash (M_1~M_2)\{x := N\} : \tau$.


6. Caso $M = \lambda y : \rho_1 . M_1$ (Abstracción):


* Por la **Hipótesis de Barendregt** (trabajando en $\Lambda_\alpha$), elegimos un representante de la clase de equivalencia donde la variable ligada $y$ sea distinta de $x$ ($y \neq x$), no pertenezca a $\text{fv}(N)$ y no aparezca en $\Gamma$ ($y \notin \text{dom}(\Gamma)$).


* Con esto, la sustitución entra sin captura: $(\lambda y : \rho_1 . M_1)\{x := N\} = \lambda y : \rho_1 . (M_1\{x := N\})$.


* Como $\Gamma, x : \sigma \vdash \lambda y : \rho_1 . M_1 : \tau$ proviene de `T-Abs`, tenemos que $\tau = \rho_1 \to \rho_2$ y la premisa es $\Gamma, y : \rho_1, x : \sigma \vdash M_1 : \rho_2$.
* Por otro lado, como tenemos $\Gamma \vdash N : \sigma$ y $y \notin \text{dom}(\Gamma)$, por la propiedad de **Debilitamiento** (demostrada en el Ejercicio 11.1) sabemos que es derivable $\Gamma, y : \rho_1 \vdash N : \sigma$.


* Ahora podemos aplicar la Hipótesis Inductiva sobre $M_1$ (tomando como contexto base $\Gamma' = \Gamma, y : \rho_1$), de donde deducimos que $\Gamma, y : \rho_1 \vdash M_1\{x := N\} : \rho_2$ es derivable.
* Finalmente, aplicando `T-Abs`, obtenemos $\Gamma \vdash \lambda y : \rho_1 . (M_1\{x := N\}) : \rho_1 \to \rho_2$. $\blacksquare$



---

# Ejercicio 13 ⋆ (Semántica: Sustitución y $\alpha$-renombre)

**Consigna:** Sean $\sigma, \tau, \rho$ tipos. Según la definición de sustitución, calcular las expresiones renombrando variables en ambos términos para que las sustituciones no cambien su significado (evitar captura de variables libres).

> **Recordatorio teórico:** Al sustituir $\{x := N\}$ dentro de una abstracción $\lambda z . M$, si $z = x$ la sustitución se detiene porque $x$ está ligada localmente; si $z \neq x$ pero $z \in \text{fv}(N)$, debemos renombrar la variable ligada $z$ por una variable fresca mediante $\alpha$-equivalencia ($\lambda z.M =_\alpha \lambda w.M\{z := w\}$) antes de meter la sustitución adentro, para no capturar la ocurrencia libre de $z$ en $N$.
> 
> 

---

### a) $(\lambda y : \sigma. x (\lambda x : \tau. x))\{x := (\lambda y : \rho. x~y)\}$

1. **Análisis de variables libres del término a sustituir:**
Sea $N = \lambda y : \rho. x~y$. Su conjunto de variables libres es $\text{fv}(N) = \{x\}$ (pues $y$ está ligada por $\lambda y : \rho$).
2. **Revisión de captura y $\alpha$-renombre:**
* En el término principal $\lambda y : \sigma. x (\lambda x : \tau. x)$, el ligador externo es $\lambda y : \sigma$. Como $y \notin \text{fv}(N)$ (pues $\text{fv}(N) = \{x\}$), el ligador $\lambda y : \sigma$ **no captura** ninguna variable libre de $N$.
* Sin embargo, para cumplir con la **Hipótesis de Barendregt** (que todas las variables ligadas sean distintas entre sí y de las libres) y evitar cualquier confusión visual entre los distintos ligadores, renombramos las variables ligadas en ambos términos:


* En el término izquierdo, renombramos la $x$ ligada interna por $z$: $\lambda y : \sigma. x (\lambda z : \tau. z)$.


* En el término derecho $N$, renombramos la $y$ ligada por $w$: $\lambda w : \rho. x~w$.






3. **Cálculo paso a paso de la sustitución:**

$$(\lambda y : \sigma. x (\lambda z : \tau. z))\{x := (\lambda w : \rho. x~w)\}$$


* Bajamos dentro de $\lambda y : \sigma$ (pues $y \neq x$ e $y \notin \text{fv}(\lambda w : \rho. x~w)$):

$$= \lambda y : \sigma. (x (\lambda z : \tau. z))\{x := (\lambda w : \rho. x~w)\}$$


* Distribuimos en la aplicación:

$$= \lambda y : \sigma. (x\{x := (\lambda w : \rho. x~w)\}) ((\lambda z : \tau. z)\{x := (\lambda w : \rho. x~w)\})$$


* En el hijo izquierdo, $x\{x := N\} = N$. En el hijo derecho, como $x$ no aparece libre en $\lambda z : \tau. z$ (en la versión original era $\lambda x : \tau. x$ donde $x$ estaba ligada, por lo que la sustitución tampoco hacía nada), queda intacto:

$$= \lambda y : \sigma. (\lambda w : \rho. x~w) (\lambda z : \tau. z)$$



(Que es $\alpha$-equivalente a $\lambda y : \sigma. (\lambda y : \rho. x~y) (\lambda x : \tau. x)$).





---

### b) $(y (\lambda v : \sigma. x~v))\{x := (\lambda y : \tau. v~y)\}$

1. **Análisis de variables libres y peligro de captura:**
* Sea $N = \lambda y : \tau. v~y$. Sus variables libres son $\text{fv}(N) = \{v\}$ (ya que $y$ está ligada).
* En el término principal $y (\lambda v : \sigma. x~v)$, aparece la abstracción $\lambda v : \sigma. x~v$, la cual liga la variable **$v$** y adentro tiene una ocurrencia libre de $x$.
* ¡Atención! Si hiciéramos un reemplazo ingenuo sin renombrar, al meter $N$ en lugar de $x$ dentro de $\lambda v : \sigma$, la variable libre $v$ de $N$ quedaría **capturada** por el ligador $\lambda v : \sigma$, cambiando el significado del término.




2. **$\alpha$-renombre previo:**
* Aplicamos $\alpha$-equivalencia sobre $\lambda v : \sigma. x~v$ renombrando la variable ligada $v$ por una variable fresca $z$ ($z \notin \{x, y, v\}$):



$$\lambda v : \sigma. x~v =_\alpha \lambda z : \sigma. x~z$$


* También podemos renombrar la variable ligada $y$ en $N$ por $w$ para cumplir Barendregt respecto de la $y$ libre externa:



$$\lambda y : \tau. v~y =_\alpha \lambda w : \tau. v~w$$




3. **Cálculo paso a paso de la sustitución:**

$$(y (\lambda z : \sigma. x~z))\{x := (\lambda w : \tau. v~w)\}$$


* Distribuimos en la aplicación principal:

$$= (y\{x := (\lambda w : \tau. v~w)\}) ((\lambda z : \sigma. x~z)\{x := (\lambda w : \tau. v~w)\})$$


* A la izquierda, $y\{x := N\} = y$ (pues $y \neq x$). A la derecha, como $z \neq x$ y $z \notin \text{fv}(\lambda w : \tau. v~w) = \{v\}$, la sustitución ingresa al cuerpo de la abstracción:

$$= y (\lambda z : \sigma. (x~z)\{x := (\lambda w : \tau. v~w)\})$$


* Distribuimos en la aplicación $(x~z)$:

$$= y (\lambda z : \sigma. (x\{x := (\lambda w : \tau. v~w)\}) (z\{x := (\lambda w : \tau. v~w)\}))$$


* Evaluamos las hojas ($x\{x := N\} = N$ y $z\{x := N\} = z$):

$$= y (\lambda z : \sigma. (\lambda w : \tau. v~w)~z)$$





---

# Ejercicio 14 (Conmutación de sustituciones)

**Consigna:** Sean $M, N$ y $P$ términos del cálculo-$\lambda$.

* **a)** Por inducción en la estructura del término $M$, demostrar que si $x \notin \text{fv}(P)$ y $x \neq y$, entonces:



$$M\{x := N\}\{y := P\} = M\{y := P\}\{x := N\{y := P\}\}$$


* **b)** Dar un contraejemplo cuando $x$ aparece libre en $P$.



---

### a) Demostración por inducción en la estructura de $M$

* **Caso 1: $M$ es una constante ($c \in \{\text{true}, \text{false}, \text{zero}\}$):**
* Lado izquierdo: $c\{x := N\}\{y := P\} = c\{y := P\} = c$.
* Lado derecho: $c\{y := P\}\{x := N\{y := P\}\} = c\{x := N\{y := P\}\} = c$. Coinciden.


* Caso 2: $M$ es una variable $z$:
Analizamos los tres subcasos posibles para la variable $z$:


* **Subcaso 2.1 ($z = x$):** (Recordemos que como $x \neq y$, entonces $z \neq y$).


* Lado izquierdo: $x\{x := N\}\{y := P\} = N\{y := P\}$.
* Lado derecho: $x\{y := P\}\{x := N\{y := P\}\} = x\{x := N\{y := P\}\} = N\{y := P\}$. Coinciden.


* **Subcaso 2.2 ($z = y$):** (Como $x \neq y$, entonces $z \neq x$).


* Lado izquierdo: $y\{x := N\}\{y := P\} = y\{y := P\} = P$.
* Lado derecho: $y\{y := P\}\{x := N\{y := P\}\} = P\{x := N\{y := P\}\}$.
* ¡Acá usamos la hipótesis clave del enunciado! Como **$x \notin \text{fv}(P)$**, sustituir $x$ en $P$ no altera a $P$, es decir: $P\{x := N\{y := P\}\} = P$. Por lo tanto, ambos lados dan $P$ y coinciden.




* **Subcaso 2.3 ($z \neq x$ y $z \neq y$):**
* Lado izquierdo: $z\{x := N\}\{y := P\} = z\{y := P\} = z$.
* Lado derecho: $z\{y := P\}\{x := N\{y := P\}\} = z\{x := N\{y := P\}\} = z$. Coinciden.




* Caso 3: $M = M_1~M_2$ (Aplicación):


* Como la sustitución distribuye sobre la aplicación:

$$(M_1~M_2)\{x := N\}\{y := P\} = (M_1\{x := N\}\{y := P\})~(M_2\{x := N\}\{y := P\})$$


* Aplicando la Hipótesis Inductiva a $M_1$ y a $M_2$:

$$= (M_1\{y := P\}\{x := N\{y := P\}\})~(M_2\{y := P\}\{x := N\{y := P\}\})$$


$$= (M_1~M_2)\{y := P\}\{x := N\{y := P\}\}$$



*(Los casos de constructores `succ`, `pred`, `isZero` e `if` son idénticos porque la sustitución simplemente se distribuye a sus subtérminos y se aplica la HI).*


* Caso 4: $M = \lambda z : \tau . M_1$ (Abstracción):


* Por la **Hipótesis de Barendregt** (trabajando en $\Lambda_\alpha$), elegimos un representante de $\lambda z : \tau . M_1$ tal que la variable ligada $z$ sea fresca: $z \neq x$, $z \neq y$, $z \notin \text{fv}(N)$ y $z \notin \text{fv}(P)$. (Notar que esto también implica que $z \notin \text{fv}(N\{y := P\})$).


* Gracias a esto, todas las sustituciones ingresan limpiamente dentro de la abstracción $\lambda z : \tau$:



$$(\lambda z : \tau . M_1)\{x := N\}\{y := P\} = \lambda z : \tau . (M_1\{x := N\}\{y := P\})$$


* Aplicando la Hipótesis Inductiva sobre el subtérmino $M_1$:

$$= \lambda z : \tau . (M_1\{y := P\}\{x := N\{y := P\}\})$$


$$= (\lambda z : \tau . M_1)\{y := P\}\{x := N\{y := P\}\} \quad \blacksquare$$





---

### b) Contraejemplo cuando $x \in \text{fv}(P)$

Para romper la igualdad en el Subcaso 2.2, basta elegir $M = y$ y hacer que $P$ contenga a $x$ libre:

* **Elección de términos:** Sean $M = y$, $N = \text{zero}$ y $P = x$ (con $x \neq y$). Aquí claramente $x \in \text{fv}(P) = \{x\}$.
* **Evaluación del lado izquierdo:**

$$M\{x := N\}\{y := P\} = y\{x := \text{zero}\}\{y := x\} = y\{y := x\} = x$$


* **Evaluación del lado derecho:**

$$M\{y := P\}\{x := N\{y := P\}\} = y\{y := x\}\{x := \text{zero}\{y := x\}\} = x\{x := \text{zero}\} = \text{zero}$$


* Como $x \neq \text{zero}$, ambos lados dan resultados distintos y la propiedad no se cumple.

---

# Ejercicio 15 (Valores) ⋆

**Consigna:** Dado el conjunto de valores visto en clase:


$$V ::= \lambda x : \tau. M \mid \text{true} \mid \text{false} \mid \text{zero} \mid \text{succ}(V)$$


Determinar si cada una de las siguientes expresiones es o no un valor.

> **Criterio clave:** La gramática de valores indica que toda abstracción $\lambda x : \tau. M$ **es un valor sin importar qué término $M$ tenga en su cuerpo** (porque en nuestra estrategia de reducción *call-by-value* no se evalúa debajo del $\lambda$). En cambio, $\text{succ}(M)$ solo es un valor si lo que tiene adentro es a su vez un valor numérico $V$.
> 
> 

* **a) $(\lambda x : \text{Bool}. x) \text{ true}$**

* **NO es un valor.** Es una **aplicación** ($M_1~M_2$), y las aplicaciones no forman parte de la gramática de valores $V$ (de hecho, es un *redex* que puede reducirse a `true`).




* **b) $\lambda x : \text{Bool}. \underline{2}$** *(donde $\underline{2}$ abrevia $\text{succ(succ(zero))}$)*

* **SÍ es un valor.** Tiene la forma sintáctica de una abstracción $\lambda x : \tau. M$, la cual pertenece directamente a la producción $V ::= \lambda x : \tau. M$.




* **c) $\lambda x : \text{Bool}. \text{pred}(\underline{2})$**

* **SÍ es un valor.** Aunque su cuerpo $\text{pred}(\underline{2})$ contiene una operación que aún no fue reducida, la expresión completa en su raíz es una **abstracción** ($\lambda x : \tau. M$). Según la gramática $V ::= \lambda x : \tau. M$, el cuerpo $M$ puede ser cualquier término arbitrario sin necesidad de ser un valor.




* **d) $\lambda y : \text{Nat}. (\lambda x : \text{Bool}. \text{pred}(\underline{2})) \text{ true}$**

* **SÍ es un valor.** Por la misma razón que el inciso anterior: el constructor más externo de la expresión es una **abstracción** $\lambda y : \text{Nat}. M$ (con $M = (\lambda x : \text{Bool}. \text{pred}(\underline{2})) \text{ true}$).




* **e) $x$**

* **NO es un valor.** Las variables no están incluidas en la gramática de los valores $V$.




* **f) $\text{succ(succ(zero))}$**

* **SÍ es un valor.** Lo verificamos recursivamente con la gramática de $V$:


1. $\text{zero}$ es un valor ($V$) por caso base.


2. Como $\text{zero}$ es un valor, $\text{succ(zero)}$ es un valor por la regla $\text{succ}(V)$.


3. Como $\text{succ(zero)}$ es un valor, $\text{succ(succ(zero))}$ también es un valor por la regla $\text{succ}(V)$.


Resolución detallada y justificada de los **Ejercicios 16 al 20** de la guía de Cálculo-$\lambda$ Tipado.

---

# Ejercicio 16 (Programa, Forma Normal) ⋆

**Marco teórico para este ejercicio:**

* **Programa:** Es un término cerrado ($\text{fv}(M) = \emptyset$) que es tipable en el contexto vacío ($\vdash M : \tau$).


* **Forma Normal (FN):** Es un término $M$ que no puede reducirse más (no existe $N$ tal que $M \to N$).
* **Valor vs. Error:** En esta variante **sin la regla $\text{pred(zero)} \to \text{zero}$**, un programa bien tipado que alcanza una forma normal puede terminar en un **valor** ($V ::= \lambda x : \tau. M \mid \text{true} \mid \text{false} \mid \text{zero} \mid \text{succ}(V)$) o trabarse en una forma normal que no es un valor, lo cual constituye un **error en tiempo de ejecución** (como $\text{pred(zero)}$).



---

### i. $(\lambda x : \text{Bool}. x) \text{ true}$

* **a) ¿Es un programa?** **Sí.** No tiene variables libres y tipa en el contexto vacío: $\vdash (\lambda x : \text{Bool}. x) \text{ true} : \text{Bool}$ (por `T-App`, `T-Abs`, `T-Var` y `T-True`).


* **b) Evaluación y resultado:**

$$(\lambda x : \text{Bool}. x) \text{ true} \to x\{x := \text{true}\} = \text{true}$$



El resultado de la evaluación es **`true`**, el cual es una **forma normal** y es un **valor**.



---

### ii. $\lambda x : \text{Nat}. \text{pred(succ}(x))$

* **a) ¿Es un programa?** **Sí.** La única variable ($x$) está ligada por $\lambda x : \text{Nat}$ y tipa en el contexto vacío: $\vdash \lambda x : \text{Nat}. \text{pred(succ}(x)) : \text{Nat} \to \text{Nat}$.


* **b) Evaluación y resultado:**
Como en la semántica operacional estándar no se reduce debajo de las abstracciones ($\lambda$), el término no realiza ningún paso de reducción (0 pasos). Ya se encuentra en **forma normal** y es un **valor** (por tener la forma $\lambda x : \tau. M$).



---

### iii. $\lambda x : \text{Nat}. \text{pred(succ}(y))$

* **a) ¿Es un programa?** **No.** Contiene a la variable $y$ libre ($y \in \text{fv}(M)$). En consecuencia, es imposible tiparlo en el contexto vacío $\emptyset$ porque la regla `T-Var` falla al buscar a $y$.



---

### iv. $(\lambda x : \text{Bool}. \text{pred(isZero}(x))) \text{ true}$

* **a) ¿Es un programa?** **No.** Aunque es cerrado, **no es tipable**. En el cuerpo de la abstracción, la variable $x$ está declarada con tipo `Bool`, pero el constructor `isZero(x)` exige en la premisa de `T-IsZero` que su subtérmino $x$ tenga tipo `Nat`.



---

### v. $(\lambda f : \text{Nat} \to \text{Bool}. f \text{ zero}) (\lambda x : \text{Nat}. \text{isZero}(x))$

* **a) ¿Es un programa?** **Sí.** Es cerrado y tipa en el contexto vacío con tipo `Bool`: el argumento $\lambda x : \text{Nat}. \text{isZero}(x)$ tiene tipo $\text{Nat} \to \text{Bool}$, coincidiendo con el dominio de la función izquierda.


* **b) Evaluación y resultado:**
Como el argumento $\lambda x : \text{Nat}. \text{isZero}(x)$ ya es un valor, aplicamos $\beta$-reducción (`E-AppAbs`):



$$(\lambda f : \text{Nat} \to \text{Bool}. f \text{ zero}) (\lambda x : \text{Nat}. \text{isZero}(x)) \to (\lambda x : \text{Nat}. \text{isZero}(x)) \text{ zero}$$



Como `zero` es un valor, volvemos a aplicar `E-AppAbs`:



$$\to \text{isZero(zero)}$$



Finalmente, por la regla `E-IsZeroZero`:

$$\to \text{true}$$



El resultado **`true`** es una **forma normal** y es un **valor**.



---

### vi. $(\lambda f : \text{Nat} \to \text{Bool}. x) (\lambda x : \text{Nat}. \text{isZero}(x))$

* **a) ¿Es un programa?** **No.** La ocurrencia de la variable $x$ en el cuerpo de la primera abstracción ($\lambda f : \text{Nat} \to \text{Bool}. x$) está **libre** (el ligador $\lambda x$ de la derecha solo tiene alcance sobre $\text{isZero}(x)$). Por tener variables libres, no tipa en el contexto vacío.



---

### vii. $(\lambda x : \text{Nat}. \text{isZero}(x)) \text{ pred(zero)}$

* **a) ¿Es un programa?** **Sí.** Es cerrado y bien tipado en el contexto vacío: $\vdash (\lambda x : \text{Nat}. \text{isZero}(x)) \text{ pred(zero)} : \text{Bool}$ (ya que $\vdash \text{pred(zero)} : \text{Nat}$).


* **b) Evaluación y resultado:**
En estrategia *call-by-value* (llamada por valor), para aplicar la regla $\beta$ (`E-AppAbs`) necesitamos que el argumento sea un valor.


* El lado izquierdo $\lambda x : \text{Nat}. \text{isZero}(x)$ ya es un valor.


* Intentamos reducir el argumento derecho $\text{pred(zero)}$ mediante la regla de congruencia `E-App2`.
* Sin embargo, como en este ejercicio **no existe la regla $\text{pred(zero)} \to \text{zero}$**, el subtérmino $\text{pred(zero)}$ no puede reducirse, pero tampoco es un valor (la gramática de valores numéricos solo incluye a `zero` y `succ(V)`).


* Por lo tanto, la expresión completa $(\lambda x : \text{Nat}. \text{isZero}(x)) \text{ pred(zero)}$ no puede dar ningún paso de reducción: **ya está en forma normal**, pero **no es un valor**, sino que representa un **error** (término *stuck* o trabado).





---

### viii. $\text{fix } \lambda y : \text{Nat}. \text{succ}(y)$

* **a) ¿Es un programa?** **Sí.** Es cerrado y, dado que $\vdash \lambda y : \text{Nat}. \text{succ}(y) : \text{Nat} \to \text{Nat}$, por la regla `T-Fix` se deriva $\vdash \text{fix } \lambda y : \text{Nat}. \text{succ}(y) : \text{Nat}$.


* **b) Evaluación y resultado:**
Aplicando la regla de reducción de `fix` ($\text{fix } (\lambda y : \tau. M) \to M\{y := \text{fix } (\lambda y : \tau. M)\}$) y la regla de congruencia de `succ` (`E-Succ`):

$$\text{fix } \lambda y : \text{Nat}. \text{succ}(y) \to \text{succ}(\text{fix } \lambda y : \text{Nat}. \text{succ}(y)) \to \text{succ(succ}(\text{fix } \lambda y : \text{Nat}. \text{succ}(y))) \to \dots$$



La evaluación **no termina** (diverge infinitamente), por lo que **no tiene forma normal** (ni llega nunca a un valor ni a un error).

---

# Ejercicio 17 (Determinismo)

En el texto de la guía, los símbolos de los incisos (b) y (c) corresponden a las combinaciones entre reducción en un paso ($\to$) y reducción en muchos pasos ($\twoheadrightarrow$, clausura reflexiva y transitiva de $\to$).

### a) ¿Si $M \to N$ y $M \to N'$ entonces $N = N'$?



* **Respuesta:** **Sí, es verdadero (la relación $\to$ de evaluación en un paso es determinista / es una función parcial).**
* **Justificación:** Como las reglas de reducción especifican un orden fijo de evaluación (por ejemplo, en una aplicación $M_1~M_2$, `E-App1` evalúa $M_1$ primero; recién cuando $M_1$ es un valor $V_1$, `E-App2` evalúa $M_2$; y recién cuando ambos son valores $(\lambda x:\tau.M_1')~V_2$, se aplica `E-AppAbs`) y ningún valor $V$ puede reducirse, para cualquier término $M$ existe a lo sumo una única regla aplicable y un único *redex* habilitado en cada paso.

---

### b) ¿Vale lo mismo con muchos pasos? Es decir, ¿si $M \twoheadrightarrow M'$ y $M \twoheadrightarrow M''$ entonces $M' = M''$?



* **Respuesta:** **No, es falso** en general (a menos que se exija adicionalmente que $M'$ y $M''$ sean formas normales).


* **Justificación y contraejemplo:** La relación $\twoheadrightarrow$ permite dar **cero, uno o más pasos** de reducción. Por lo tanto, un mismo término $M$ puede reducir en 0 pasos a $M' = M$ y en 1 paso a $M'' = N$ con $M \neq N$.
* *Contraejemplo:* Sea $M = (\lambda x : \text{Bool}. x) \text{ true}$.
* En 0 pasos: $M \twoheadrightarrow (\lambda x : \text{Bool}. x) \text{ true} = M'$.
* En 1 paso: $M \twoheadrightarrow \text{true} = M''$.
Claramente $M' \neq M''$.


* *(Nota importante: Si $M'$ y $M''$ son ambas **formas normales**, entonces sí vale que $M' = M''$ como consecuencia directa del determinismo de un paso).*



---

### c) ¿Es cierto que si $M \to M'$ y $M \twoheadrightarrow M''$ entonces $M' = M''$?



* **Respuesta:** **No, es falso**.


* **Justificación y contraejemplo:** Por la misma razón anterior, $M \twoheadrightarrow M''$ puede tomar una cantidad de pasos distinta de 1 (por ejemplo, 0 pasos o 2 pasos).
* *Contraejemplo (con 2 pasos):* Sea $M = \text{isZero(pred(succ(zero)))}$.
* En 1 paso ($M \to M'$): $M' = \text{isZero(zero)}$.
* En 2 pasos ($M \twoheadrightarrow M''$): $M'' = \text{true}$.
Se cumple que $M \to M'$ y $M \twoheadrightarrow M''$, pero $M' \neq M''$.





---

# Ejercicio 18

### a) ¿Da lo mismo evaluar $\text{succ(pred}(M))$ que $\text{pred(succ}(M))$? ¿Por qué?



* **Respuesta:** **No da lo mismo**, específicamente cuando $M$ evalúa a `zero` ($M \twoheadrightarrow \text{zero}$).


* **Justificación (analizando ambas variantes de las reglas para `pred`):**
1. **En el cálculo CON la regla $\text{pred(zero)} \to \text{zero}$:**
* Si $M = \text{zero}$, entonces:

$$\text{succ(pred(zero))} \to \text{succ(zero)} \quad (\text{que representa el valor } 1)$$



Mientras que:

$$\text{pred(succ(zero))} \to \text{zero} \quad (\text{que representa el valor } 0)$$


* Llegan a valores distintos ($\text{succ(zero)} \neq \text{zero}$).


2. **En el cálculo SIN la regla $\text{pred(zero)} \to \text{zero}$:**
* Si $M = \text{zero}$, $\text{succ(pred(zero))}$ se traba (es un error en forma normal, no es valor), mientras que $\text{pred(succ(zero))} \to \text{zero}$ evalúa normalmente al valor `zero`.





---

### b) ¿Es verdad que para todo término $M$ vale $\text{isZero(succ}(M)) \twoheadrightarrow \text{false}$? Si no lo es, ¿para qué términos vale?



* **Respuesta:** **No es verdad para todo término $M$**.


* **Justificación:** La regla `E-IsZeroSucc` está restringida por llamada por valor únicamente a **valores** ($\text{isZero(succ}(V)) \to \text{false}$). Antes de poder cancelar `isZero` con `succ`, la regla de congruencia `E-Succ` obliga a evaluar completamente a $M$ hasta que se convierta en un valor $V$.
* Si $M$ no termina (por ejemplo, $M = \text{fix } \lambda y:\text{Nat}. \text{succ}(y)$) o si $M$ se traba en algo que no es valor (como una variable libre $x$), entonces $\text{isZero(succ}(M))$ nunca reduce a `false`.


* **¿Para qué términos $M$ vale?**
* Si la pregunta se refiere a reducción en **muchos pasos** ($\twoheadrightarrow$): Vale exactamente para todos los términos $M$ que **reducen en cero o más pasos a algún valor $V$** ($M \twoheadrightarrow V$).
* Si la pregunta se refiere a reducción en **un solo paso** ($\to$): Vale únicamente cuando **$M$ ya es un valor $V$** ($M \in V$).



---

### c) ¿Para qué términos $M$ vale $\text{isZero(pred}(M)) \twoheadrightarrow \text{true}$? (Hay infinitos).



* **Respuesta:** Para que $\text{isZero(pred}(M))$ reduzca a `true`, el subtérmino $\text{pred}(M)$ debe reducir al valor `zero` (ya que la única forma de que `isZero(...)` dé `true` es mediante la regla $\text{isZero(zero)} \to \text{true}$).
* **Con la regla $\text{pred(zero)} \to \text{zero}$:** Vale para todos los infinitos términos $M$ tales que **$M \twoheadrightarrow \text{zero}$** o **$M \twoheadrightarrow \text{succ(zero)}$**.
* *Ejemplos de los infinitos términos $M$:* $\text{zero}$, $\text{succ(zero)}$, $\text{pred(succ(zero))}$, $\text{pred(succ(succ(zero)))}$, $(\lambda x:\text{Nat}. x)\text{ zero}$, $\text{if true then zero else succ(zero)}$, etc.


* **Sin la regla $\text{pred(zero)} \to \text{zero}$:** Vale para todos los infinitos términos $M$ tales que **$M \twoheadrightarrow \text{succ(zero)}$** (pues $\text{pred(succ(zero))} \to \text{zero}$).
* *(Nota: si se pide en **un único paso** $\to$, no existe ningún término $M$ porque primero debe reducirse `pred(M)` a `zero` en al menos un paso y luego `isZero(zero)` a `true` en otro paso).*



---

# Ejercicio 19

Se agrega la regla $\xi$ para reducir debajo de las abstracciones:


$$\frac{M \to M'}{\lambda x : \tau. M \to \lambda x : \tau. M'} \; (\xi)$$

### a) Repensar el conjunto de valores



* **Análisis:** Un principio fundamental de nuestra semántica operacional es que **los valores son formas normales** (ningún valor puede reducirse). Con la regla $\xi$, si el cuerpo $M$ de una abstracción $\lambda x : \tau. M$ puede reducirse ($M \to M'$), entonces la abstracción entera $\lambda x : \tau. M$ también se reduce.


* **Ejemplo de la guía:** El término $(\lambda x : \text{Bool}. (\lambda y : \text{Bool}. y) \text{ true})$ **ya NO puede ser considerado un valor**, porque su cuerpo contiene un redex que reduce: $(\lambda y : \text{Bool}. y) \text{ true} \to \text{true}$, y por la regla $\xi$ toda la expresión se reduce a $\lambda x : \text{Bool}. \text{true}$.


* **Nueva definición de valores:** Una abstracción $\lambda x : \tau. M$ solo es un valor cuando su cuerpo $M$ ya no puede seguir reduciéndose (es decir, cuando $M$ está en forma normal, o pertenece a una gramática de formas normales / valores abiertos que incluye variables y aplicaciones neutrales como $x~V$ que no pueden reducir hasta conocer $x$).

---

### b) ¿Qué reglas deberían modificarse para no perder el determinismo?



* **Análisis:** Al haber redefinido el conjunto de valores $V$ para que una abstracción $\lambda x : \tau. M$ solo pertenezca a $V$ cuando su cuerpo $M$ no puede seguir reduciéndose (es irreductible), las reglas que ya exigen que una abstracción sea un valor antes de actuar mantienen el determinismo automáticamente:


1. En **`E-App1`** ($\frac{M_1 \to M_1'}{M_1~M_2 \to M_1'~M_2}$): si $M_1 = \lambda x : \tau. P$ todavía tiene reducciones pendientes adentro de $P$, entonces $M_1$ **no es un valor**, por lo que `E-App2` y `E-AppAbs` están bloqueadas y la única regla aplicable es `E-App1` (usando $\xi$ en la premisa).
2. En **`E-App2`** ($\frac{M_2 \to M_2'}{V_1~M_2 \to V_1~M_2'}$): recién cuando el cuerpo de la abstracción izquierda $V_1$ terminó de reducirse por completo, $V_1$ pasa a ser un valor y habilita reducir el argumento $M_2$ (incluyendo reducir adentro de $M_2$ mediante $\xi$ si $M_2$ es otra abstracción).
3. En **`E-AppAbs` ($\beta$)** y **`E-Fix`**: debemos asegurarnos de que la regla $\beta$ se escriba exigiendo que **también la abstracción misma sea un valor** (es decir, $(\lambda x : \tau. M)~V \to M\{x := V\}$ solo cuando $\lambda x : \tau. M \in V$, o sea cuando $M$ ya está en forma normal), y análogamente que $\text{fix } V$ solo desdoble cuando la abstracción $V = \lambda x : \tau. M$ ya tenga su cuerpo $M$ en forma normal. Si no se restringiera $\beta$ a abstracciones cuyos cuerpos ya son irreductibles, en $(\lambda x : \tau. M)~V$ competirían `E-App1` (con $\xi$ sobre $M$) y `E-AppAbs`, perdiendo el determinismo.





---

### c) Reducción del término y conclusión



Reducimos la expresión $(\lambda x : \text{Nat} \to \text{Nat}. x~\underline{23}) (\lambda x : \text{Nat}. \text{pred(succ(zero))})$ (análoga al ejemplo de la diapositiva de la clase práctica):

1. **Término izquierdo ($M_1$):** $\lambda x : \text{Nat} \to \text{Nat}. x~\underline{23}$. Su cuerpo es la aplicación $x~\underline{23}$. Como $x$ es una variable (no es una abstracción $\lambda$), $x~\underline{23}$ no puede reducirse. Por lo tanto, $M_1$ **ya es un valor** ($V_1$).


2. **Término derecho ($M_2$):** $\lambda x : \text{Nat}. \text{pred(succ(zero))}$. Su cuerpo $\text{pred(succ(zero))}$ tiene un redex (`E-PredSucc`), por lo que debemos reducir adentro del argumento usando `E-App2` y $\xi$ antes de poder hacer la $\beta$-reducción principal:



$$(\lambda x : \text{Nat} \to \text{Nat}. x~\underline{23}) (\lambda x : \text{Nat}. \text{pred(succ(zero))}) \;\to\; (\lambda x : \text{Nat} \to \text{Nat}. x~\underline{23}) (\lambda x : \text{Nat}. \text{zero})$$


3. Ahora $\lambda x : \text{Nat}. \text{zero}$ sí es un valor ($V_2$). Aplicamos $\beta$-reducción (`E-AppAbs`) sustituyendo $x$ por $\lambda x : \text{Nat}. \text{zero}$:



$$\to (\lambda x : \text{Nat}. \text{zero})~\underline{23}$$


4. Nuevamente, al sustituir la variable $x$ por una función concreta, ¡se acaba de crear un **nuevo redex** $(\lambda x : \text{Nat}. \text{zero})~\underline{23}$! Aplicamos `E-AppAbs` una vez más:



$$\to \text{zero}$$



**¿Qué se puede concluir? ¿Es una buena idea agregar esta regla?**

* **Conclusión:** No es una buena idea agregar la regla $\xi$ en un lenguaje de programación estándar:


1. **Inutilidad del trabajo previo:** Como muestra el ejemplo (y más aún el caso de la diapositiva $\lambda z : \text{Nat} \to \text{Nat}. (\lambda x : \text{Nat} \to \text{Nat}. x~\underline{23}) \lambda z : \text{Nat}. \underline{0}$), reducir debajo de un $\lambda$ no evita tener que volver a reducir el cuerpo cada vez que la función se aplica a un argumento, porque al sustituir variables libres por funciones ($\lambda$) aparecen nuevos redexes que antes estaban "bloqueados" por las variables.


2. **Riesgo de errores o no terminación prematura:** Si una función tiene adentro código que se cuelga o da error (como `pred(zero)` en una rama que solo debería ejecutarse bajo ciertas entradas), la regla $\xi$ fuerza a evaluarlo antes de que la función siquiera sea llamada. En ningún lenguaje real se ejecuta el cuerpo de una función en el momento de declararla.





---

# Ejercicio 20 (Pares, o productos) ⋆

Se extiende el lenguaje con el tipo producto $\tau \times \tau$ y los términos $\langle M, N \rangle$, $\pi_1(M)$ y $\pi_2(M)$.

### a) Reglas de tipado para los nuevos constructores



$$\frac{\Gamma \vdash M : \sigma \quad \Gamma \vdash N : \tau}{\Gamma \vdash \langle M, N \rangle : \sigma \times \tau} \; \text{T-Pair}$$

$$\frac{\Gamma \vdash M : \sigma \times \tau}{\Gamma \vdash \pi_1(M) : \sigma} \; \text{T-Proj1} \qquad \frac{\Gamma \vdash M : \sigma \times \tau}{\Gamma \vdash \pi_2(M) : \tau} \; \text{T-Proj2}$$

---

### b) Habitantes de los tipos dados



* **i) Constructor de pares:** $\sigma \to \tau \to (\sigma \times \tau)$

$$\lambda x : \sigma. \lambda y : \tau. \langle x, y \rangle$$


* **ii) Proyecciones:** $(\sigma \times \tau) \to \sigma$ y $(\sigma \times \tau) \to \tau$

$$\lambda p : \sigma \times \tau. \pi_1(p) \qquad \text{y} \qquad \lambda p : \sigma \times \tau. \pi_2(p)$$


* **iii) Conmutatividad:** $(\sigma \times \tau) \to (\tau \times \sigma)$

$$\lambda p : \sigma \times \tau. \langle \pi_2(p), \pi_1(p) \rangle$$


* **iv) Asociatividad:**

* Para $((\sigma \times \tau) \times \rho) \to (\sigma \times (\tau \times \rho))$:

$$\lambda p : (\sigma \times \tau) \times \rho. \langle \pi_1(\pi_1(p)), \langle \pi_2(\pi_1(p)), \pi_2(p) \rangle \rangle$$


* Para $(\sigma \times (\tau \times \rho)) \to ((\sigma \times \tau) \times \rho)$:

$$\lambda p : \sigma \times (\tau \times \rho). \langle \langle \pi_1(p), \pi_1(\pi_2(p)) \rangle, \pi_2(\pi_2(p)) \rangle$$




* **v) Currificación:**

* Para $((\sigma \times \tau) \to \rho) \to (\sigma \to \tau \to \rho)$ (*curry*):

$$\lambda f : (\sigma \times \tau) \to \rho. \lambda x : \sigma. \lambda y : \tau. f~\langle x, y \rangle$$


* Para $(\sigma \to \tau \to \rho) \to ((\sigma \times \tau) \to \rho)$ (*uncurry*):

$$\lambda f : \sigma \to \tau \to \rho. \lambda p : \sigma \times \tau. (f~\pi_1(p))~\pi_2(p)$$





---

### c) Extensión del conjunto de los valores



En llamada por valor, un par es un valor si y solo si **ambas componentes ya fueron evaluadas hasta ser valores**:


$$V ::= \dots \mid \langle V_1, V_2 \rangle$$

---

### d) Reglas de semántica operacional (con congruencia)



**Reglas de congruencia (determinan el orden de evaluación de izquierda a derecha):**


$$\frac{M \to M'}{\langle M, N \rangle \to \langle M', N \rangle} \; (\text{E-Pair1}) \qquad \frac{N \to N'}{\langle V, N \rangle \to \langle V, N' \rangle} \; (\text{E-Pair2})$$

$$\frac{M \to M'}{\pi_1(M) \to \pi_1(M')} \; (\text{E-Proj1}) \qquad \frac{M \to M'}{\pi_2(M) \to \pi_2(M')} \; (\text{E-Proj2})$$

**Reglas de cómputo (reducción de proyecciones sobre valores pares):**


$$\frac{}{\pi_1(\langle V_1, V_2 \rangle) \to V_1} \; (\text{E-PairBeta1}) \qquad \frac{}{\pi_2(\langle V_1, V_2 \rangle) \to V_2} \; (\text{E-PairBeta2})$$

---

### e) Determinismo, Preservación de Tipos y Progreso



#### 1. Demostración del Determinismo de $\to$

Queremos probar por inducción en la derivación de $M \to N$ que para todo $N'$, si $M \to N$ y $M \to N'$, entonces $N = N'$. (Usamos el lema básico de que **ningún valor $V$ puede reducirse**: si $V \in \text{Valores}$, no existe $P$ tal que $V \to P$, lo cual se extiende trivialmente a $\langle V_1, V_2 \rangle$ porque ni $V_1$ ni $V_2$ reducen). Analizamos los nuevos casos:

* **Caso `E-Pair1`:** $M = \langle M_1, M_2 \rangle \to \langle M_1', M_2 \rangle = N$ con $M_1 \to M_1'$.
* ¿Qué regla pudo usarse para derivar $\langle M_1, M_2 \rangle \to N'$?
* No pudo ser `E-Pair2` porque `E-Pair2` exige que la primera componente sea un valor $V_1$, pero sabemos que $M_1 \to M_1'$ (y los valores no reducen).
* Por lo tanto, $M \to N'$ también debió derivarse por `E-Pair1` con alguna premisa $M_1 \to M_1''$ y $N' = \langle M_1'', M_2 \rangle$. Por Hipótesis Inductiva sobre $M_1 \to M_1'$, tenemos $M_1' = M_1''$, luego $N = N'$.


* **Caso `E-Pair2`:** $M = \langle V_1, M_2 \rangle \to \langle V_1, M_2' \rangle = N$ con $M_2 \to M_2'$.
* Como $V_1$ es un valor, no puede reducirse, por lo que `E-Pair1` no es aplicable a $M$.
* Entonces $M \to N'$ debió derivarse por `E-Pair2` con $M_2 \to M_2''$ y $N' = \langle V_1, M_2'' \rangle$. Por HI sobre $M_2 \to M_2'$, $M_2' = M_2''$, luego $N = N'$.


* **Caso `E-Proj1` (análogo `E-Proj2`):** $M = \pi_1(M_1) \to \pi_1(M_1') = N$ con $M_1 \to M_1'$.
* No pudo aplicarse `E-PairBeta1` para $M \to N'$, porque `E-PairBeta1` exige que $M_1$ sea un valor de la forma $\langle V_1, V_2 \rangle$, el cual no podría reducirse a $M_1'$.
* Luego $M \to N'$ proviene de `E-Proj1` con $M_1 \to M_1''$. Por HI, $M_1' = M_1''$, así que $N = N'$.


* **Caso `E-PairBeta1` (análogo `E-PairBeta2`):** $M = \pi_1(\langle V_1, V_2 \rangle) \to V_1 = N$.
* Como $\langle V_1, V_2 \rangle$ es un valor, no puede dar ningún paso de reducción, lo que impide aplicar la regla de congruencia `E-Proj1`.
* Por lo tanto, la única regla aplicable a $M$ es `E-PairBeta1`, dando obligatoriamente $N' = V_1 = N$. $\blacksquare$



#### 2. ¿Se verifica la propiedad de Preservación de Tipos (*Subject Reduction*)?



* **Sí, se verifica** ($\text{Si } \Gamma \vdash M : \tau \text{ y } M \to M' \implies \Gamma \vdash M' : \tau$).


* **Justificación:**
* En las reglas de congruencia (`E-Pair1`, `E-Pair2`, `E-Proj1`, `E-Proj2`), la preservación sale inmediatamente aplicando la Hipótesis Inductiva a la premisa que reduce y volviendo a aplicar la misma regla de tipado (`T-Pair`, `T-Proj1` o `T-Proj2`).
* En los pasos de cómputo `E-PairBeta1` ($\pi_1(\langle V_1, V_2 \rangle) \to V_1$): si $\Gamma \vdash \pi_1(\langle V_1, V_2 \rangle) : \sigma$, por inversión de `T-Proj1` debe existir $\tau$ tal que $\Gamma \vdash \langle V_1, V_2 \rangle : \sigma \times \tau$. A su vez, por inversión de `T-Pair`, deben valer $\Gamma \vdash V_1 : \sigma$ y $\Gamma \vdash V_2 : \tau$. Por lo tanto, el resultado $V_1$ tiene efectivamente tipo $\sigma$ en el contexto $\Gamma$.



#### 3. ¿Se verifica la propiedad de Progreso?



* **Sí, se verifica** (siempre que el cálculo base verifique progreso, es decir, incluyendo $\text{pred(zero)} \to \text{zero}$): todo término cerrado y bien tipado $\vdash M : \tau$ o bien es un valor, o bien existe $M'$ tal que $M \to M'$.


* **Justificación:**
* **Lema de Formas Canónicas para productos:** Si $V$ es un valor cerrado de tipo $\sigma \times \tau$ ($\vdash V : \sigma \times \tau$), inspeccionando las reglas de tipado de los valores vemos que la única forma de obtener el tipo $\sigma \times \tau$ para un valor es mediante `T-Pair`, por lo que $V$ tiene obligatoriamente la forma $\langle V_1, V_2 \rangle$ con $V_1, V_2$ valores.
* **Caso $\vdash \langle M_1, M_2 \rangle : \sigma \times \tau$:** Por HI en $M_1$ y $M_2$: si $M_1$ y $M_2$ son valores, entonces $\langle M_1, M_2 \rangle$ ya es un valor; si $M_1 \to M_1'$, reduce por `E-Pair1`; si $M_1$ es valor y $M_2 \to M_2'$, reduce por `E-Pair2`.
* **Caso $\vdash \pi_i(M_1) : \sigma$:** Por HI sobre $\vdash M_1 : \sigma \times \tau$, o bien $M_1 \to M_1'$ (y entonces $\pi_i(M_1) \to \pi_i(M_1')$ por `E-Proj`), o bien $M_1$ es un valor. Si $M_1$ es un valor de tipo $\sigma \times \tau$, por el Lema de Formas Canónicas sabemos que $M_1 = \langle V_1, V_2 \rangle$, por lo que aplica `E-PairBeta` ($\pi_i(\langle V_1, V_2 \rangle) \to V_i$). Nunca se traba.

Resolución detallada y justificada de los **Ejercicios 21 al 27** de la **Práctica N° 4 (Cálculo-$\lambda$: Tipado y Semántica Operacional)**.

---

# Ejercicio 21 (Uniones disjuntas, co-productos o sumas)

Extendemos las gramáticas de tipos y términos con el tipo suma $\sigma + \tau$, las inyecciones a izquierda y derecha, y el análisis por casos:


$$\tau ::= \dots \mid \tau + \tau$$

$$M, N, O ::= \dots \mid \text{left}_\tau(M) \mid \text{right}_\sigma(M) \mid \text{case } M \text{ of } \text{left}(x) \leadsto N \parallel \text{right}(y) \leadsto O$$


*(Nota sobre las anotaciones de tipos: Para conservar la propiedad de **unicidad de tipos**, $\text{left}_\tau(M)$ lleva anotado el tipo $\tau$ de la derecha —o bien el tipo suma completo $\sigma + \tau$—, y $\text{right}_\sigma(M)$ lleva anotado el tipo $\sigma$ de la izquierda).*

### a) Reglas de tipado para los nuevos constructores



$$\frac{\Gamma \vdash M : \sigma}{\Gamma \vdash \text{left}_\tau(M) : \sigma + \tau} \; (\text{T-Left}) \qquad \frac{\Gamma \vdash M : \tau}{\Gamma \vdash \text{right}_\sigma(M) : \sigma + \tau} \; (\text{T-Right})$$

$$\frac{\Gamma \vdash M : \sigma + \tau \quad \Gamma, x : \sigma \vdash N : \rho \quad \Gamma, y : \tau \vdash O : \rho}{\Gamma \vdash \text{case } M \text{ of } \text{left}(x) \leadsto N \parallel \text{right}(y) \leadsto O : \rho} \; (\text{T-Case})$$


*(En `T-Case`, las variables $x$ e $y$ quedan ligadas dentro de las ramas $N$ y $O$ respectivamente).*

---

### b) Habitantes de los tipos pedidos



* **i) Inyecciones:** $\sigma \to (\sigma + \tau)$ y $\tau \to (\sigma + \tau)$

$$\lambda x : \sigma. \text{left}_\tau(x) \qquad \text{y} \qquad \lambda y : \tau. \text{right}_\sigma(y)$$


* **ii) Análisis de casos:** $(\sigma + \tau) \to (\sigma \to \rho) \to (\tau \to \rho) \to \rho$

$$\lambda s : \sigma + \tau. \lambda f : \sigma \to \rho. \lambda g : \tau \to \rho. \text{case } s \text{ of } \text{left}(x) \leadsto f~x \parallel \text{right}(y) \leadsto g~y$$


* **iii) Conmutatividad:** $(\sigma + \tau) \to (\tau + \sigma)$

$$\lambda s : \sigma + \tau. \text{case } s \text{ of } \text{left}(x) \leadsto \text{right}_\tau(x) \parallel \text{right}(y) \leadsto \text{left}_\sigma(y)$$


* **iv) Asociatividad:**

* Para $((\sigma + \tau) + \rho) \to (\sigma + (\tau + \rho))$:



$$\lambda s : (\sigma + \tau) + \rho. \text{case } s \text{ of } \text{left}(u) \leadsto (\text{case } u \text{ of } \text{left}(x) \leadsto \text{left}_{\tau + \rho}(x) \parallel \text{right}(y) \leadsto \text{right}_\sigma(\text{left}_\rho(y))) \parallel \text{right}(z) \leadsto \text{right}_\sigma(\text{right}_\tau(z))$$


* Para $(\sigma + (\tau + \rho)) \to ((\sigma + \tau) + \rho)$:



$$\lambda s : \sigma + (\tau + \rho). \text{case } s \text{ of } \text{left}(x) \leadsto \text{left}_\rho(\text{left}_\tau(x)) \parallel \text{right}(u) \leadsto (\text{case } u \text{ of } \text{left}(y) \leadsto \text{left}_\rho(\text{right}_\sigma(y)) \parallel \text{right}(z) \leadsto \text{right}_{\sigma + \tau}(z))$$




* **v) Distributividad del producto sobre la suma:**

* Para $(\sigma \times (\tau + \rho)) \to ((\sigma \times \tau) + (\sigma \times \rho))$:



$$\lambda p : \sigma \times (\tau + \rho). \text{case } \pi_2(p) \text{ of } \text{left}(y) \leadsto \text{left}_{\sigma \times \rho}(\langle \pi_1(p), y \rangle) \parallel \text{right}(z) \leadsto \text{right}_{\sigma \times \tau}(\langle \pi_1(p), z \rangle)$$


* Para $((\sigma \times \tau) + (\sigma \times \rho)) \to (\sigma \times (\tau + \rho))$:



$$\lambda s : (\sigma \times \tau) + (\sigma \times \rho). \text{case } s \text{ of } \text{left}(p) \leadsto \langle \pi_1(p), \text{left}_\rho(\pi_2(p)) \rangle \parallel \text{right}(q) \leadsto \langle \pi_1(q), \text{right}_\tau(\pi_2(q)) \rangle$$




* **vi) Ley de los exponentes:**

* Para $((\sigma + \tau) \to \rho) \to ((\sigma \to \rho) \times (\tau \to \rho))$:



$$\lambda h : (\sigma + \tau) \to \rho. \langle \lambda x : \sigma. h~(\text{left}_\tau(x)), \, \lambda y : \tau. h~(\text{right}_\sigma(y)) \rangle$$


* Para $((\sigma \to \rho) \times (\tau \to \rho)) \to ((\sigma + \tau) \to \rho)$:



$$\lambda p : (\sigma \to \rho) \times (\tau \to \rho). \lambda s : \sigma + \tau. \text{case } s \text{ of } \text{left}(x) \leadsto \pi_1(p)~x \parallel \text{right}(y) \leadsto \pi_2(p)~y$$





---

### c) Extensión del conjunto de valores



Una inyección es un valor si y solo si el término inyectado ya fue reducido hasta ser un valor $V$:


$$V ::= \dots \mid \text{left}_\tau(V) \mid \text{right}_\sigma(V)$$

---

### d) Reglas de semántica operacional y Propiedad de Progreso



**Reglas de congruencia:**


$$\frac{M \to M'}{\text{left}_\tau(M) \to \text{left}_\tau(M')} \; (\text{E-Left}) \qquad \frac{M \to M'}{\text{right}_\sigma(M) \to \text{right}_\sigma(M')} \; (\text{E-Right})$$

$$\frac{M \to M'}{\text{case } M \text{ of } \text{left}(x) \leadsto N \parallel \text{right}(y) \leadsto O \;\to\; \text{case } M' \text{ of } \text{left}(x) \leadsto N \parallel \text{right}(y) \leadsto O} \; (\text{E-Case})$$

**Reglas de cómputo:**


$$\frac{}{\text{case } \text{left}_\tau(V) \text{ of } \text{left}(x) \leadsto N \parallel \text{right}(y) \leadsto O \;\to\; N\{x := V\}} \; (\text{E-CaseLeft})$$

$$\frac{}{\text{case } \text{right}_\sigma(V) \text{ of } \text{left}(x) \leadsto N \parallel \text{right}(y) \leadsto O \;\to\; O\{y := V\}} \; (\text{E-CaseRight})$$

**¿Se verifica la propiedad de Progreso?**

* **Sí, se verifica** (asumiendo que el cálculo base cuenta con $\text{pred(zero)} \to \text{zero}$).
* **Justificación por inducción en $\vdash M : \rho$:**
1. **Lema de Formas Canónicas para $\sigma + \tau$:** Todo valor cerrado $V$ tal que $\vdash V : \sigma + \tau$ es obligatoriamente de la forma $\text{left}_\tau(V_1)$ (con $\vdash V_1 : \sigma$) o $\text{right}_\sigma(V_2)$ (con $\vdash V_2 : \tau$), ya que `T-Left` y `T-Right` son las únicas reglas de tipado que asignan el tipo suma a un valor.
2. **Casos `T-Left` y `T-Right`:** Si $\vdash \text{left}_\tau(M_1) : \sigma + \tau$, por Hipótesis Inductiva sobre $\vdash M_1 : \sigma$, o bien $M_1$ es un valor $V_1$ (en cuyo caso $\text{left}_\tau(V_1)$ ya es un valor), o bien $M_1 \to M_1'$ (en cuyo caso reduce por `E-Left`). Análogo para `T-Right`.
3. **Caso `T-Case`:** Si $\vdash \text{case } M_1 \text{ of } \text{left}(x) \leadsto N \parallel \text{right}(y) \leadsto O : \rho$, por HI sobre $\vdash M_1 : \sigma + \tau$:
* Si $M_1 \to M_1'$, el término completo reduce mediante `E-Case`.
* Si $M_1$ ya es un valor $V$, por el Lema de Formas Canónicas para $\sigma + \tau$, o bien $V = \text{left}_\tau(V_1)$ (y reduce por `E-CaseLeft`), o bien $V = \text{right}_\sigma(V_2)$ (y reduce por `E-CaseRight`). Nunca se traba.





---

### e) Demostración de la Preservación de Tipos



> **Teorema:** Si $\Gamma \vdash M : \rho$ y $M \to M'$, entonces $\Gamma \vdash M' : \rho$.
> 
> 

*(Nota previa: El **Lema de Sustitución** del Ejercicio 12 se extiende de forma directa a los constructores `left`, `right` y `case` por inducción en $M$, tomando representantes con $x, y$ frescas en `case` por la Hipótesis de Barendregt).*

**Demostración por inducción en la derivación de $M \to M'$** (analizando las nuevas reglas):

1. **Caso `E-Left` ($\text{left}_\tau(M_1) \to \text{left}_\tau(M_1')$ con premisa $M_1 \to M_1'$):**
* Por hipótesis tenemos $\Gamma \vdash \text{left}_\tau(M_1) : \rho$.
* **Inversión de tipado:** La única regla aplicable es `T-Left`, de donde $\rho = \sigma + \tau$ y vale la premisa $\Gamma \vdash M_1 : \sigma$.
* **HI:** Aplicando la Hipótesis Inductiva a $M_1 \to M_1'$ y $\Gamma \vdash M_1 : \sigma$, obtenemos $\Gamma \vdash M_1' : \sigma$.
* **Reconstrucción:** Aplicando `T-Left`, concluimos $\Gamma \vdash \text{left}_\tau(M_1') : \sigma + \tau$. *(El caso `E-Right` es idéntico).*


2. **Caso `E-Case` (con premisa $M_1 \to M_1'$):**
* Por hipótesis, $\Gamma \vdash \text{case } M_1 \text{ of } \text{left}(x) \leadsto N \parallel \text{right}(y) \leadsto O : \rho$.
* **Inversión de tipado (`T-Case`):** Existen $\sigma, \tau$ tales que valen $\Gamma \vdash M_1 : \sigma + \tau$, $\Gamma, x : \sigma \vdash N : \rho$ y $\Gamma, y : \tau \vdash O : \rho$.
* **HI:** Por Hipótesis Inductiva sobre $M_1 \to M_1'$, obtenemos $\Gamma \vdash M_1' : \sigma + \tau$.
* **Reconstrucción:** Volviendo a aplicar `T-Case` con $\Gamma \vdash M_1' : \sigma + \tau$ y las otras dos premisas intactas, concluimos $\Gamma \vdash \text{case } M_1' \text{ of } \text{left}(x) \leadsto N \parallel \text{right}(y) \leadsto O : \rho$.


3. **Caso `E-CaseLeft` ($\text{case } \text{left}_\tau(V) \text{ of } \text{left}(x) \leadsto N \parallel \text{right}(y) \leadsto O \to N\{x := V\}$):**
* **Primera inversión (`T-Case`):** De $\Gamma \vdash \text{case } \text{left}_\tau(V) \text{ of } \dots : \rho$, deducimos que existen tipos $\sigma, \tau$ tales que:
1. $\Gamma \vdash \text{left}_\tau(V) : \sigma + \tau$
2. $\Gamma, x : \sigma \vdash N : \rho$
3. $\Gamma, y : \tau \vdash O : \rho$


* **Segunda inversión (`T-Left`):** La única regla que pudo derivar $\Gamma \vdash \text{left}_\tau(V) : \sigma + \tau$ es `T-Left`, cuya premisa nos asegura que:

$$\Gamma \vdash V : \sigma$$


* **Aplicación del Lema de Sustitución:** Como tenemos $\Gamma, x : \sigma \vdash N : \rho$ y $\Gamma \vdash V : \sigma$, por el Lema de Sustitución (Ejercicio 12) concluimos directamente:

$$\Gamma \vdash N\{x := V\} : \rho$$



*(El caso `E-CaseRight` es completamente análogo usando `T-Right` y el Lema de Sustitución sobre $\Gamma, y : \tau \vdash O : \rho$ y $\Gamma \vdash V : \tau$).* $\blacksquare$



---

# Ejercicio 22 ⋆ (Extensión con Listas)

Extendemos los tipos con $[\tau]$ y los términos con constructores y esquemas de recursión sobre listas:


$$M, N, O ::= \dots \mid []_\tau \mid M :: N \mid \text{case } M \text{ of } \{[] \leadsto N \mid h :: t \leadsto O\} \mid \text{foldr } M \text{ base } \leadsto N; \text{ rec}(h, r) \leadsto O$$

### a) Árboles sintácticos de los dos ejemplos



*(Recordatorio: el constructor `::` asocia a la **derecha**, por lo que $M_1 :: M_2 :: M_3$ se agrupa como $M_1 :: (M_2 :: M_3)$).*

* **Ejemplo 1:** $\text{case } (\text{zero} :: (\text{succ(zero)} :: []_{\text{Nat}})) \text{ of } \{[] \leadsto \text{false} \mid x :: xs \leadsto \text{isZero}(x)\}$

```text
               case _ of {[] ~> _ | x :: xs ~> _}
               /                |               \
             (::)             false           isZero
            /    \                              |
         zero    (::)                           x
                /    \
             succ    []_Nat
              |
             zero

```


* **Ejemplo 2:** $\text{foldr } (\underline{1} :: (\underline{2} :: (\underline{3} :: ((\lambda x : [\text{Nat}]. x)~[]_{\text{Nat}})))) \text{ base } \leadsto \text{zero}; \text{ rec}(\text{head}, \text{rec}) \leadsto (\text{head} + \text{rec})$


*(Donde $\underline{1} = \text{succ(zero)}$, $\underline{2} = \text{succ(succ(zero))}$, $\underline{3} = \text{succ(succ(succ(zero)))}$)*:


```text
       foldr _ base ~> _ ; rec(head, rec) ~> _
        /                    |                \
      (::)                 zero               (+)
     /    \                                  /   \
    1     (::)                            head   rec
         /    \
        2     (::)
             /    \
            3     (App)
                  /   \
         (λx:[Nat].x)  []_Nat

```



---

### b) Reglas de tipado para las nuevas expresiones



$$\frac{}{\Gamma \vdash []_\tau : [\tau]} \; (\text{T-Nil}) \qquad \frac{\Gamma \vdash M : \tau \quad \Gamma \vdash N : [\tau]}{\Gamma \vdash M :: N : [\tau]} \; (\text{T-Cons})$$

$$\frac{\Gamma \vdash M : [\tau] \quad \Gamma \vdash N : \sigma \quad \Gamma, h : \tau, t : [\tau] \vdash O : \sigma}{\Gamma \vdash \text{case } M \text{ of } \{[] \leadsto N \mid h :: t \leadsto O\} : \sigma} \; (\text{T-CaseList})$$

$$\frac{\Gamma \vdash M : [\tau] \quad \Gamma \vdash N : \sigma \quad \Gamma, h : \tau, r : \sigma \vdash O : \sigma}{\Gamma \vdash \text{foldr } M \text{ base } \leadsto N; \text{ rec}(h, r) \leadsto O : \sigma} \; (\text{T-Foldr})$$

---

### c) Demostración del juicio de tipado



**Juicio a demostrar:**


$$x : \text{Bool}, y : [\text{Bool}] \vdash \text{foldr } x :: x :: y \text{ base } \leadsto y; \text{ rec}(y, x) \leadsto \text{if } y \text{ then } x \text{ else } []_{\text{Bool}} : [\text{Bool}]$$

1. **Análisis de variables libres y ligadas (según la recomendación de la guía)**:


* Sea $\Gamma = \{x : \text{Bool}, \, y : [\text{Bool}]\}$ el contexto inicial.


* En la lista a plegar ($x :: (x :: y)$) y en el caso base ($y$), las variables $x$ e $y$ están **libres** y toman sus tipos de $\Gamma$ ($x : \text{Bool}$, $y : [\text{Bool}]$).


* En cambio, en la rama recursiva $\text{rec}(y, x) \leadsto \text{if } y \text{ then } x \text{ else } []_{\text{Bool}}$, el constructor `rec(y, x)` **liga** localmente a $y$ (como cabeza de la lista, de tipo $\tau = \text{Bool}$) y a $x$ (como resultado recursivo, de tipo $\sigma = [\text{Bool}]$), ocultando (*shadowing*) las variables homónimas de $\Gamma$.


* Por lo tanto, el contexto extendido para tipar la rama recursiva $O$ es $\Gamma' = \{y : \text{Bool}, \, x : [\text{Bool}]\}$.


2. **Construcción de las tres subderivaciones para `T-Foldr` (con $\tau = \text{Bool}$ y $\sigma = [\text{Bool}]$):**
* **Subderivación $\mathcal{D}_1$ (la lista $M = x :: (x :: y)$):**

$$\mathcal{D}_1 = \dfrac{        \dfrac{}{\Gamma \vdash x : \text{Bool}} \text{ T-Var}        \quad        \dfrac{          \dfrac{}{\Gamma \vdash x : \text{Bool}} \text{ T-Var}          \quad          \dfrac{}{\Gamma \vdash y : [\text{Bool}]} \text{ T-Var}        }{\Gamma \vdash x :: y : [\text{Bool}]} \text{ T-Cons}      }{\Gamma \vdash x :: x :: y : [\text{Bool}]} \text{ T-Cons}$$


* **Subderivación $\mathcal{D}_2$ (el caso base $N = y$):**

$$\mathcal{D}_2 = \dfrac{}{\Gamma \vdash y : [\text{Bool}]} \text{ T-Var}$$


* **Subderivación $\mathcal{D}_3$ (el paso recursivo $O = \text{if } y \text{ then } x \text{ else } []_{\text{Bool}}$ en contexto $\Gamma' = \{y : \text{Bool}, x : [\text{Bool}]\}$):**

$$\mathcal{D}_3 = \dfrac{        \dfrac{}{\Gamma' \vdash y : \text{Bool}} \text{ T-Var}        \quad        \dfrac{}{\Gamma' \vdash x : [\text{Bool}]} \text{ T-Var}        \quad        \dfrac{}{\Gamma' \vdash []_{\text{Bool}} : [\text{Bool}]} \text{ T-Nil}      }{\Gamma' \vdash \text{if } y \text{ then } x \text{ else } []_{\text{Bool}} : [\text{Bool}]} \text{ T-If}$$




3. **Árbol completo unido en la raíz:**

$$\dfrac{\mathcal{D}_1 \qquad \mathcal{D}_2 \qquad \mathcal{D}_3}{x : \text{Bool}, y : [\text{Bool}] \vdash \text{foldr } x :: x :: y \text{ base } \leadsto y; \text{ rec}(y, x) \leadsto \text{if } y \text{ then } x \text{ else } []_{\text{Bool}} : [\text{Bool}]} \text{ T-Foldr}$$



---

### d) Extensión del conjunto de valores



Una lista es un valor si es la lista vacía, o si es un constructor `::` cuya cabeza y cola son ambas valores:


$$V ::= \dots \mid []_\tau \mid V_1 :: V_2$$

---

### e) Reglas de reducción asociadas a las nuevas expresiones



**1. Reglas para constructores de listas (`::`):**


$$\frac{M \to M'}{M :: N \to M' :: N} \; (\text{E-Cons1}) \qquad \frac{N \to N'}{V :: N \to V :: N'} \; (\text{E-Cons2})$$

**2. Reglas para `case` de listas:**


$$\frac{M \to M'}{\text{case } M \text{ of } \{[] \leadsto N \mid h :: t \leadsto O\} \to \text{case } M' \text{ of } \{[] \leadsto N \mid h :: t \leadsto O\}} \; (\text{E-CaseList})$$

$$\frac{}{\text{case } []_\tau \text{ of } \{[] \leadsto N \mid h :: t \leadsto O\} \to N} \; (\text{E-CaseNil})$$

$$\frac{}{\text{case } V_1 :: V_2 \text{ of } \{[] \leadsto N \mid h :: t \leadsto O\} \to O\{h := V_1, t := V_2\}} \; (\text{E-CaseCons})$$

**3. Reglas para `foldr`:**


$$\frac{M \to M'}{\text{foldr } M \text{ base } \leadsto N; \text{ rec}(h, r) \leadsto O \to \text{foldr } M' \text{ base } \leadsto N; \text{ rec}(h, r) \leadsto O} \; (\text{E-Foldr})$$

$$\frac{}{\text{foldr } []_\tau \text{ base } \leadsto N; \text{ rec}(h, r) \leadsto O \to N} \; (\text{E-FoldrNil})$$

$$\frac{}{\text{foldr } V_1 :: V_2 \text{ base } \leadsto N; \text{ rec}(h, r) \leadsto O \to O\{h := V_1, \, r := (\text{foldr } V_2 \text{ base } \leadsto N; \text{ rec}(h, r) \leadsto O)\}} \; (\text{E-FoldrCons})$$


*(Observación: Si se desea estrategia estrictamente call-by-value en la sustitución de $r$, también es válido evaluar la llamada recursiva mediante una abstracción $(\lambda r : \sigma. O\{h := V_1\})~(\text{foldr } V_2 \text{ base } \leadsto N; \text{ rec}(h, r) \leadsto O)$).*

---

# Ejercicio 23 ⋆ (Extensión con `map`)

**Importante sobre la anotación de tipos:** Como advierte el enunciado, cuando la lista $N$ evalúa a la lista vacía $[]_\sigma$, la expresión $\text{map}$ debe reducir a la lista vacía del tipo de llegada $[]_\tau$. Para conocer $\tau$ durante la reducción y mantener tanto la **Preservación de Tipos** como la **Unicidad de Tipos**, existen dos maneras equivalentes de presentar la sintaxis:

1. Anotar el tipo de salida en el constructor: $\text{map}_\tau(M, N)$ (o $\text{map}_{\sigma, \tau}(M, N)$).
2. Evaluar primero la función $M$ hasta que sea un valor $\lambda x : \sigma. P$ o extraer el tipo cuando el lenguaje base no tiene otras funciones, aunque si $M$ se reduce después de $N$ o si se usa en general, anotar $\text{map}_\tau(M, N)$ es el estándar limpio. Presentamos a continuación el sistema con $\text{map}_\tau(M, N)$:



### 1. Regla de tipado



$$\frac{\Gamma \vdash M : \sigma \to \tau \quad \Gamma \vdash N : [\sigma]}{\Gamma \vdash \text{map}_\tau(M, N) : [\tau]} \; (\text{T-Map})$$

### 2. Conjunto de valores



No se agregan nuevos valores, ya que $\text{map}_\tau(M, N)$ es un operador que siempre reduce hasta devolver una lista construida con $[]_\tau$ y `::`.

### 3. Reglas de semántica operacional



**Reglas de congruencia (evaluamos primero la función $M$ a un valor $V_f$ y luego la lista $N$):**


$$\frac{M \to M'}{\text{map}_\tau(M, N) \to \text{map}_\tau(M', N)} \; (\text{E-Map1}) \qquad \frac{N \to N'}{\text{map}_\tau(V_f, N) \to \text{map}_\tau(V_f, N')} \; (\text{E-Map2})$$

**Reglas de cómputo:**


$$\frac{}{\text{map}_\tau(V_f, []_\sigma) \to []_\tau} \; (\text{E-MapNil})$$

$$\frac{}{\text{map}_\tau(V_f, V_1 :: V_2) \to (V_f~V_1) :: \text{map}_\tau(V_f, V_2)} \; (\text{E-MapCons})$$

---

# Ejercicio 24 ⋆ (Listas por comprensión)

Extendemos los términos con $[M \mid x \leftarrow S, P]$, donde $x$ queda ligada tanto en $M$ como en $P$.
*(Al igual que en el Ejercicio 23, cuando la lista $S$ es vacía $[]_\sigma$, la comprensión debe devolver la lista vacía del tipo de los elementos $M$, por lo que anotamos el tipo de salida $[M \mid x \leftarrow S, P]_\tau$ o asumimos que $\tau$ es el tipo de $M$)*.

### 1. Regla de tipado



$$\frac{\Gamma \vdash S : [\sigma] \quad \Gamma, x : \sigma \vdash P : \text{Bool} \quad \Gamma, x : \sigma \vdash M : \tau}{\Gamma \vdash [M \mid x \leftarrow S, P]_\tau : [\tau]} \; (\text{T-Comp})$$

### 2. Conjunto de valores



No se agregan valores nuevos (las listas por comprensión se reducen hasta expresarse mediante $[]_\tau$ y `::`).

### 3. Reglas de semántica operacional



**Regla de congruencia (evalúa la lista generadora $S$; no evalúa $M$ ni $P$ porque tienen a $x$ libre hasta sustituir):**


$$\frac{S \to S'}{[M \mid x \leftarrow S, P]_\tau \to [M \mid x \leftarrow S', P]_\tau} \; (\text{E-Comp})$$

**Reglas de cómputo:**


$$\frac{}{[M \mid x \leftarrow []_\sigma, P]_\tau \to []_\tau} \; (\text{E-CompNil})$$

$$\frac{}{[M \mid x \leftarrow V_1 :: V_2, P]_\tau \to \text{if } P\{x := V_1\} \text{ then } M\{x := V_1\} :: [M \mid x \leftarrow V_2, P]_\tau \text{ else } [M \mid x \leftarrow V_2, P]_\tau} \; (\text{E-CompCons})$$

---

# Ejercicio 25 (Conectivos booleanos como macros)

Definimos cada conectivo como azúcar sintáctica (macros) utilizando únicamente abstracciones, aplicaciones y el condicional `if-then-else` del lenguaje base:

* **Negación (`Not`):**

$$\text{Not } M \stackrel{\text{def}}{=} \text{if } M \text{ then false else true}$$



*(O como función cerrada de tipo $\text{Bool} \to \text{Bool}$: $\text{Not} \stackrel{\text{def}}{=} \lambda x : \text{Bool}. \text{if } x \text{ then false else true}$).*
* **Conjunción (`And`):**

$$\text{And } M~N \stackrel{\text{def}}{=} \text{if } M \text{ then } N \text{ else false}$$



*(O en versión estricta que evalúa ambos argumentos como función $\text{Bool} \to \text{Bool} \to \text{Bool}$: $\text{And} \stackrel{\text{def}}{=} \lambda x : \text{Bool}. \lambda y : \text{Bool}. \text{if } x \text{ then } y \text{ else false}$).*
* **Disyunción (`Or`):**

$$\text{Or } M~N \stackrel{\text{def}}{=} \text{if } M \text{ then true else } N$$



*(O como función $\text{Bool} \to \text{Bool} \to \text{Bool}$: $\text{Or} \stackrel{\text{def}}{=} \lambda x : \text{Bool}. \lambda y : \text{Bool}. \text{if } x \text{ then true else } y$).*
* **Disyunción exclusiva (`Xor`):**

$$\text{Xor } M~N \stackrel{\text{def}}{=} \text{if } M \text{ then (if } N \text{ then false else true) else } N$$



*(O como función $\text{Bool} \to \text{Bool} \to \text{Bool}$: $\text{Xor} \stackrel{\text{def}}{=} \lambda x : \text{Bool}. \lambda y : \text{Bool}. \text{if } x \text{ then (if } y \text{ then false else true) else } y$).*

---

# Ejercicio 26 (Funciones sobre Listas)

Todas las funciones de este ejercicio pueden definirse directamente como **macros** utilizando el cálculo con listas del Ejercicio 22, pares del Ejercicio 20 y el operador de punto fijo `fix`:

### a) $\text{head}_\sigma : [\sigma] \to \sigma$ y $\text{tail}_\sigma : [\sigma] \to [\sigma]$

Usando `case` de listas y $\bot_\sigma \stackrel{\text{def}}{=} \text{fix } \lambda x : \sigma. x$ para el caso de la lista vacía:


$$\text{head}_\sigma \stackrel{\text{def}}{=} \lambda xs : [\sigma]. \text{case } xs \text{ of } \{[] \leadsto \bot_\sigma \mid h :: t \leadsto h\}$$

$$\text{tail}_\sigma \stackrel{\text{def}}{=} \lambda xs : [\sigma]. \text{case } xs \text{ of } \{[] \leadsto \bot_{[\sigma]} \mid h :: t \leadsto t\}$$


*(Nota: En `tail`, en lugar de $\bot_{[\sigma]}$ también es válido devolver $[]_\sigma$, que tiene tipo $[\sigma]$).*

---

### b) $\text{iterate}_\sigma : (\sigma \to \sigma) \to \sigma \to [\sigma]$

* **Definición como macro usando `fix`:**

$$\text{iterate}_\sigma \stackrel{\text{def}}{=} \text{fix } \lambda \text{it} : (\sigma \to \sigma) \to \sigma \to [\sigma]. \lambda f : \sigma \to \sigma. \lambda x : \sigma. x :: (\text{it}~f~(f~x))$$


* *(Observación sobre la evaluación: En una estrategia call-by-value donde `::` evalúa su cola antes de ser un valor, `iterate f x` reduce indefinidamente generando los elementos sucesivos $x :: f~x :: f~(f~x) :: \dots$).*

---

### c) $\text{zip}_{\rho, \sigma} : [\rho] \to [\sigma] \to [\rho \times \sigma]$

* **Definición como macro usando `foldr` (o `fix`):**
Con `fix` y `case` anidado (muy claro y directo):

$$\text{zip}_{\rho, \sigma} \stackrel{\text{def}}{=} \text{fix } \lambda z : [\rho] \to [\sigma] \to [\rho \times \sigma]. \lambda xs : [\rho]. \lambda ys : [\sigma].$$


$$\quad \text{case } xs \text{ of } \{[] \leadsto []_{\rho \times \sigma} \mid h_1 :: t_1 \leadsto \text{case } ys \text{ of } \{[] \leadsto []_{\rho \times \sigma} \mid h_2 :: t_2 \leadsto \langle h_1, h_2 \rangle :: (z~t_1~t_2)\}\}$$


* **Alternativa sin `fix` (usando únicamente `foldr` y `case`):**
Fazemos `foldr` sobre $xs$ construyendo una función de tipo $[\sigma] \to [\rho \times \sigma]$:

$$\text{zip}_{\rho, \sigma} \stackrel{\text{def}}{=} \lambda xs : [\rho]. \text{foldr } xs \text{ base } \leadsto (\lambda ys : [\sigma]. []_{\rho \times \sigma});$$


$$\quad \text{rec}(h_1, r) \leadsto (\lambda ys : [\sigma]. \text{case } ys \text{ of } \{[] \leadsto []_{\rho \times \sigma} \mid h_2 :: t_2 \leadsto \langle h_1, h_2 \rangle :: (r~t_2)\})$$



---

### d) $\text{take}_\sigma : \text{Nat} \to ([\sigma] \to [\sigma])$

* **Definición como macro sin `fix` (usando `foldr` sobre la lista para construir una función de `Nat` en $[\sigma]$):**

$$\text{take}_\sigma \stackrel{\text{def}}{=} \lambda n : \text{Nat}. \lambda xs : [\sigma]. (\text{foldr } xs \text{ base } \leadsto (\lambda k : \text{Nat}. []_\sigma);$$


$$\quad \text{rec}(h, r) \leadsto (\lambda k : \text{Nat}. \text{if isZero}(k) \text{ then } []_\sigma \text{ else } h :: (r~\text{pred}(k))))~n$$


* **Alternativa con `fix`:**

$$\text{take}_\sigma \stackrel{\text{def}}{=} \text{fix } \lambda tk : \text{Nat} \to [\sigma] \to [\sigma]. \lambda n : \text{Nat}. \lambda xs : [\sigma].$$


$$\quad \text{if isZero}(n) \text{ then } []_\sigma \text{ else } (\text{case } xs \text{ of } \{[] \leadsto []_\sigma \mid h :: t \leadsto h :: (tk~\text{pred}(n)~t)\})$$



---

# Ejercicio 27 ⋆ (Colas bidireccionales / *Deque*)

En esta extensión:

* $\langle\rangle_\tau$ es la cola vacía de elementos de tipo $\tau$.


* $M_1 \bullet M_2$ encola el elemento $M_2$ al final de la cola $M_1$ (por ejemplo, en $\langle\rangle_{\text{Nat}} \bullet \underline{1} \bullet \underline{0} = (\langle\rangle_{\text{Nat}} \bullet \underline{1}) \bullet \underline{0}$, el primer elemento encolado fue $\underline{1}$ y el último fue $\underline{0}$).


* $\text{próximo}(M)$ devuelve el **primer** elemento que fue encolado en $M$ (el más antiguo, ubicado junto a $\langle\rangle_\tau$).


* $\text{desencolar}(M)$ elimina ese **primer** elemento encolado y devuelve la cola restante.


* $\text{case } M \text{ of } \langle\rangle \leadsto M_1; c \bullet x \leadsto M_2$ inspecciona desde el **final** de la cola (el encolado más reciente $x$ y el resto de la cola $c$).



---

### 1. Reglas de tipado para la extensión propuesta



$$\frac{}{\Gamma \vdash \langle\rangle_\tau : \text{Cola}_\tau} \; (\text{T-ColaVacía}) \qquad \frac{\Gamma \vdash M_1 : \text{Cola}_\tau \quad \Gamma \vdash M_2 : \tau}{\Gamma \vdash M_1 \bullet M_2 : \text{Cola}_\tau} \; (\text{T-Encolar})$$

$$\frac{\Gamma \vdash M : \text{Cola}_\tau}{\Gamma \vdash \text{próximo}(M) : \tau} \; (\text{T-Próximo}) \qquad \frac{\Gamma \vdash M : \text{Cola}_\tau}{\Gamma \vdash \text{desencolar}(M) : \text{Cola}_\tau} \; (\text{T-Desencolar})$$

$$\frac{\Gamma \vdash M : \text{Cola}_\tau \quad \Gamma \vdash M_1 : \sigma \quad \Gamma, c : \text{Cola}_\tau, x : \tau \vdash M_2 : \sigma}{\Gamma \vdash \text{case } M \text{ of } \langle\rangle \leadsto M_1; c \bullet x \leadsto M_2 : \sigma} \; (\text{T-CaseCola})$$

---

### 2. Conjunto de valores y nuevas reglas de reducción



**Conjunto de valores:**
Una cola es un valor si es la cola vacía $\langle\rangle_\tau$, o si es de la forma $V_c \bullet V_x$ donde $V_c$ es un valor cola y $V_x$ es un valor elemento:


$$V ::= \dots \mid \langle\rangle_\tau \mid V_1 \bullet V_2$$

**Cantidad de reglas de congruencia:**
Son necesarias **5 reglas de congruencia** en total:

1. Dos para el constructor $M_1 \bullet M_2$: una para evaluar la cola izquierda ($M_1 \to M_1' \implies M_1 \bullet M_2 \to M_1' \bullet M_2$) y otra para evaluar el elemento derecho cuando la izquierda ya es un valor ($M_2 \to M_2' \implies V_1 \bullet M_2 \to V_1 \bullet M_2'$).
2. Una para $\text{próximo}(M)$ ($M \to M' \implies \text{próximo}(M) \to \text{próximo}(M')$).
3. Una para $\text{desencolar}(M)$ ($M \to M' \implies \text{desencolar}(M) \to \text{desencolar}(M')$).
4. Una para la guarda del $\text{case}$ ($M \to M' \implies \text{case } M \text{ of } \dots \to \text{case } M' \text{ of } \dots$).

**Reglas de cómputo:**
Siguiendo la pista del enunciado (*"puede ser necesario mirar más de un nivel de un término para saber a qué reduce"*), para `próximo` y `desencolar` distinguimos si la cola tiene **un solo elemento** ($\langle\rangle_\tau \bullet V$) o **dos o más elementos** ($(V_c \bullet V_1) \bullet V_2$):

* **Para `próximo`:**

$$\frac{}{\text{próximo}(\langle\rangle_\tau \bullet V) \to V} \; (\text{E-Próx1}) \qquad \frac{}{\text{próximo}((V_c \bullet V_1) \bullet V_2) \to \text{próximo}(V_c \bullet V_1)} \; (\text{E-PróxRec})$$



*(Nota: $\text{próximo}(\langle\rangle_\tau)$ no tiene regla de reducción y queda como forma normal de error, tal como sugiere el inciso 3 donde `próximo(<>_Bool)` actúa como error si cayera en esa rama).*
* **Para `desencolar`:**

$$\frac{}{\text{desencolar}(\langle\rangle_\tau \bullet V) \to \langle\rangle_\tau} \; (\text{E-Desenc1}) \qquad \frac{}{\text{desencolar}((V_c \bullet V_1) \bullet V_2) \to \text{desencolar}(V_c \bullet V_1) \bullet V_2} \; (\text{E-DesencRec})$$


* **Para `case`:**

$$\frac{}{\text{case } \langle\rangle_\tau \text{ of } \langle\rangle \leadsto M_1; c \bullet x \leadsto M_2 \;\to\; M_1} \; (\text{E-CaseColaVacía})$$


$$\frac{}{\text{case } V_c \bullet V_x \text{ of } \langle\rangle \leadsto M_1; c \bullet x \leadsto M_2 \;\to\; M_2\{c := V_c, x := V_x\}} \; (\text{E-CaseColaEncolar})$$



---

### 3. Reducción paso a paso de la expresión



Expresión inicial (recordando que $\bullet$ asocia a izquierda: $\langle\rangle_{\text{Nat}} \bullet \underline{1} \bullet \underline{0} = (\langle\rangle_{\text{Nat}} \bullet \underline{1}) \bullet \underline{0}$):


$$\text{case } (\langle\rangle_{\text{Nat}} \bullet \underline{1}) \bullet \underline{0} \text{ of } \langle\rangle \leadsto \text{próximo}(\langle\rangle_{\text{Bool}}); c \bullet x \leadsto \text{isZero}(x)$$

1. **Paso 1 (`E-CaseColaEncolar`):**
Como $(\langle\rangle_{\text{Nat}} \bullet \underline{1}) \bullet \underline{0}$ ya es un valor de la forma $V_c \bullet V_x$ con $V_c = \langle\rangle_{\text{Nat}} \bullet \underline{1}$ y $V_x = \underline{0}$ (es decir, `zero`), aplicamos la regla de cómputo del `case`, sustituyendo $c := \langle\rangle_{\text{Nat}} \bullet \underline{1}$ y $x := \text{zero}$ en $\text{isZero}(x)$:

$$\to \text{isZero}(\text{zero})$$


2. **Paso 2 (`E-IsZeroZero`):**
Aplicamos la regla de cómputo de `isZero` sobre `zero`:

$$\to \text{true}$$



*(Llega al valor final `true` en 2 pasos)*.

---

### 4. Macro $\text{último}_\tau$ y su juicio de tipado



Como el constructor `case` desarma la cola exactamente por el último elemento encolado ($c \bullet x$), podemos definir $\text{último}_\tau$ directamente con `case`, devolviendo $\text{próximo}(\langle\rangle_\tau)$ (que es una forma normal bien tipada que no es valor) o $\bot_\tau$ en el caso de la cola vacía:

$$\text{último}_\tau \stackrel{\text{def}}{=} \lambda q : \text{Cola}_\tau. \text{case } q \text{ of } \langle\rangle \leadsto \text{próximo}(\langle\rangle_\tau); c \bullet x \leadsto x$$

* **Juicio de tipado válido**:



$$\vdash \text{último}_\tau : \text{Cola}_\tau \to \tau$$