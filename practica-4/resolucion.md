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