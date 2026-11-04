# Compendio Fundamental: Cálculo Lambda, Sistemas de Tipos y Lógica Proposicional

Este documento sintetiza la teoría del Cálculo Lambda No Tipado, su extensión con Tipos Simples ($\lambda^{\to}$), el proceso formal para añadir nuevas estructuras de datos, la dualidad Cómputo/Inferencia y el profundo puente hacia la Lógica Matemática.

---

## 1. El Cálculo Lambda No Tipado ($\lambda$-cálculo)
Diseñado por Alonzo Church en la década de 1930, es el modelo de computación universal basado en la noción matemática de **evaluación de funciones**. 

### Sintaxis Base
Toda expresión en el cálculo lambda se denomina **término** ($M, N, P$) y se construye bajo tres únicas reglas gramaticales:
* **Variables:** $x, y, z$ (Identificadores o incógnitas flotantes).
* **Abstracción (Definición de funciones):** $\lambda x . M$ (Una función que recibe un argumento $x$ y ejecuta el cuerpo $M$).
* **Aplicación (Uso de funciones):** $(M \ N)$ (Pasar el término $N$ como argumento al término $F$).

### Variables Libres y Ligadas
* **Variable Ligada:** Una variable está ligada si está bajo el alcance de un operador $\lambda$. En $\lambda x. x$, la $x$ interna está ligada.
* **Variable Libre:** Una variable está libre si no está capturada por una abstracción. En $\lambda x. x \ y$, la variable $y$ está libre.

### Semántica Operacional (Reglas de Cómputo)
1. **$\alpha$-conversión (Renombrado):** Permite cambiar el nombre de una variable ligada para evitar colisiones accidentales de nombres (ej. $\lambda x. x \equiv \lambda y. y$).
2. **$\beta$-reducción (Cómputo Real):** El motor principal de ejecución. Cuando una abstracción se aplica a un argumento, se sustituyen todas las apariciones libres de la variable en el cuerpo de la función por dicho argumento.
   $$(\lambda x. M) \ N \longrightarrow M[x := N]$$
3. **Sustitución Formal ($M[x := N]$):** Un algoritmo recursivo estricto. Reemplaza las $x$ libres en $M$ por $N$. Si encuentra una sub-abstracción que vuelve a redefinir $x$ ($\lambda x. B$), la sustitución **se detiene** en esa rama (sombreado de variables o *shadowing*).

---

## 2. El Cálculo Lambda con Tipos Simples ($\lambda^{\to}$)
Añadir tipos restringe qué términos son válidos para evitar comportamientos indefinidos (como intentar aplicar un número a otro número). El sistema define un conjunto de **Tipos** ($\sigma, \tau$) que incluye tipos base (como $Bool$ o $Int$) y tipos funcionales ($\sigma \to \tau$).

### El Juicio de Tipado
Se escribe formalmente como:
$$\Gamma \vdash M : \tau$$
* $\Gamma$ (Contexto / Entorno): Un diccionario que mapea variables libres a sus respectivos tipos (ej. $\{x: Int, y: Bool\}$).
* $\vdash$ (Torniquete): Se lee *"demuestra que"* o *"concluye que"*.
* $M : \tau$: El término $M$ posee el tipo $\tau$.

---

## 3. Inferencia de Tipos vs. Reducción para Cómputo
El Cálculo Lambda con tipos opera en dos dimensiones ortogonales pero perfectamente sincronizadas:
```
  CÁLCULO LAMBDA CON TIPOS
                             │
            ┌────────────────┴────────────────┐
            ▼                                 ▼
   INFERENCIA DE TIPOS              REDUCCIONES (CÓMPUTO)
  ¿El programa tiene sentido?      ¿Cómo se ejecuta el programa?
    (Lógica Estática)                 (Dinámica Operacional)
```

| Dimensión | Inferencia de Tipos (Estática) | Reducción para Cómputo (Dinámica) |
| :--- | :--- | :--- |
| **¿Cuándo actúa?** | En "tiempo de compilación". | En "tiempo de ejecución". |
| **Herramienta** | Reglas de Deducción (Árboles de inferencia). | Reglas de Cómputo (\beta) y Congruencia. |
| **Objetivo** | Verificar la consistencia estructural del término. | Simplificar el término hasta llegar a un valor irreducible. |
| **En Curry-Howard** | Actúa como el **Verificador de Demostraciones**. | Actúa como la **Simplificación/Normalización** de la prueba. |

### El Teorema de Conexión: Preservación de Tipo (Subject Reduction)
Si un término bien tipado da un paso de cómputo, su resultado mantiene garantizadamente el mismo tipo original:
[Si \Gamma \vdash M : \tau y M \longrightarrow M', entonces \Gamma \vdash M' : \tau]

---

## 4. Los 5 Componentes para Extender el Lenguaje
Para añadir cualquier tipo de dato nuevo (como Tuplas, Either, Maybe, Listas) al núcleo del cálculo lambda, se deben especificar obligatoriamente 5 componentes distribuidos en 3 bloques:

### BLOQUE A: SINTAXIS
1. Sintaxis de Tipos: Definir la gramática de cómo se escribe el nuevo tipo (ej. A x B para productos, A + B para sumas/Either).
2. Sintaxis de Términos: Definir las nuevas expresiones que el usuario puede codificar. Siempre se dividen en:
   * Constructores (Introducción): Elementos para crear valores de ese tipo (ej. Left M, Right M, parejas \langle M, N \rangle).
   * Destructores / Operadores (Eliminación): Mecanismos para consumir o desarmar el tipo (ej. la estructura case ... of, proyecciones \pi_1, \pi_2).

### BLOQUE B: INFERENCIA
3. Reglas de Tipado: Las fracciones lógicas con barras divisorias que dictan cómo el compilador deduce los tipos de los nuevos constructores y destructores bajo un contexto \Gamma.

### BLOQUE C: SEMÁNTICA OPERACIONAL
4. Reglas de Reducción: Se dividen estrictamente en dos subtipos:
   * Reglas de Cómputo: Describen la aniquilación inmediata entre un operador y su constructor (ej. un case sobre un Right M reduce directamente a la rama derecha aplicando sustitución).
   * Reglas de Congruencia (Contexto): Reglas que le permiten al evaluador sumergirse dentro de términos complejos no resueltos para buscar qué evaluar primero (ej. evaluar el término interno de un case si este es otra operación).
5. Estrategia de Evaluación (Valuaciones): Especificar explícitamente cuáles de los nuevos términos formados se consideran Valores (resultados finales abstractos donde la máquina se detiene).

---

## 5. La Correspondencia de Curry-Howard: Lógica y Cómputo
El Isomorfismo de Curry-Howard establece una equivalencia matemática biyectiva e identitaria entre los sistemas lógicos constructivistas y los sistemas de tipos de la computación.

### La Tabla de Equivalencias Absoluta

| Concepto en Lógica Proposicional | Concepto en Computación (Cálculo Lambda / Haskell) |
| :--- | :--- |
| Proposición (Teorema) | Tipo (\tau) |
| Demostración (Evidencia) | Término (Programa / Código) (M) |
| Verificación de la Demostración | Inferencia / Chequeo de Tipos |
| Simplificación de Pruebas (Normalización) | Ejecución del programa (Reducción-\beta) |
| Hipótesis | Variables libres en el contexto (\Gamma) |
| Implicación (A => B) | Tipo Funcional (A -> B) |
| Conjunción / "Y" (A y B) | Tipo Producto / Tupla (A x B) |
| Disyunción / "O" (A o B) | Tipo Suma / Alternativa (Either A B o A + B) |
| Regla de Eliminación de la Disyunción (\lor E) | La Expresión case ... of |
| Falsedad / Absurdo (\bot) | Tipo Vacío (en Haskell: Void) |

### El case y el Either bajo Curry-Howard
Cuando escribes la regla semántica de tu imagen:
[case (Right M) of {Left x -> N; Right y -> P} $\longrightarrow$ $P[y := M]$]

Estás ejecutando una Reducción de Desvío en teoría de demostraciones:
1. Alguien demostró la proposición A o B usando el camino de la derecha (Right M), aportando la prueba M.
2. Luego, un argumento por análisis de casos (case) evalúa esa disyunción para extraer una conclusión.
3. El cómputo destruye la redundancia: salta inmediatamente al escenario derecho (P o rama correspondiente) inyectándole directamente la evidencia real (M). El camino izquierdo (N) se descarta porque lógicamente nunca ocurrió.

---

## 6. ¿Por qué es útil relacionar la Lógica con el Cómputo?
Esta unificación no es un mero accidente filosófico, tiene ramificaciones críticas en la ingeniería de software moderna y las ciencias de la computación:

1. El Software como Teorema: Si diseñar un programa con tipo \tau es equivalente a demostrar un teorema \tau, podemos usar la lógica matemática para garantizar que el software es 100% correcto por diseño. Si el compilador tipa el programa con éxito, la demostración matemática no tiene fallas.
2. Asistentes de Demostración Automática: Herramientas de software como Coq, Agda o Lean (usadas para verificar sistemas críticos de seguridad ferroviaria, aeronáutica o contratos inteligentes) no son más que lenguajes de programación funcionales con sistemas de tipos extremadamente avanzados (Tipos Dependientes). Demostrar un teorema matemático complejo en Lean es, literalmente, escribir una función de código.
3. Optimización de Compiladores: Las leyes lógicas de simplificación de pruebas dan fundamentos matemáticos ultra-rigurosos a las optimizaciones de los compiladores. Eliminar código muerto o desarmar bucles redundantes es semánticamente equivalente a limpiar desvíos lógicos en una demostración.
4. Diseño Unificado de Lenguajes: Permite que los nuevos elementos de un lenguaje no se diseñen "por intuición", sino siguiendo la simetría perfecta de las reglas de introducción y eliminación lógicas, garantizando que el lenguaje resultante sea robusto, seguro y libre de estados atascados.


### ¿Por qué los programas deben tipar en el contexto vacío ($\emptyset \vdash M : \tau$)?

Para que un programa sea considerado **autónomo y ejecutable**, su término debe estar **cerrado** (es decir, tiparse bajo el contexto vacío $\emptyset$). Esto responde a tres razones fundamentales:

1. **Autonomía (Términos Cerrados):** Si un término requiere un contexto $\Gamma$ con variables (ej. $\{x:\text{Int}\} \vdash M : \tau$), significa que contiene **variables libres**. Un programa con variables libres está incompleto; depende de incógnitas externas y fallará en tiempo de ejecución al no saber cómo evaluarlas. El contexto vacío garantiza que toda variable interna está correctamente ligada.
2. **Garantía de Progreso (Evitar Bloqueos):** El *Teorema de Progreso* estipula que si un término está bien tipado bajo el **contexto vacío**, entonces o bien ya es un **Valor** (resultado final) o bien puede dar un **paso de reducción** (seguir ejecutándose). Si el contexto no estuviera vacío, el programa podría quedarse "atascado" permanentemente a mitad de la ejecución al chocar con una variable sin valor.
3. **Consistencia Lógica (Curry-Howard):** En lógica, las variables en $\Gamma$ representan hipótesis. Demostrar un tipo bajo un contexto lleno es una prueba condicional. Demostrar un tipo bajo el **contexto vacío ($\emptyset$)** equivale a demostrar una **tautología o verdad absoluta**. Un programa ejecutable real debe ser una verdad lógica en sí misma, válida sin necesidad de premisas externas.


# Formalización y Propiedades del Cálculo Lambda Extendido ($\lambda^{\times, +, \perp, \top}$)

Este documento resume la extensión del Cálculo Lambda con tipos según la **Correspondencia de Curry-Howard** para los tipos Producto, Suma, Absurdo y Unit, junto con la justificación de sus propiedades globales basándose en el material teórico.

---

## 1. Tipo Producto / Pares ($\lambda^{\times}$)
Se corresponde con la **Conjunción Lógica ($A \wedge B$)**. Permite representar la posesión simultánea de dos pruebas o datos.

###  Bloque A: Sintaxis
* **Sintaxis de Tipos ($\tau$):** Se añade el producto cartesiano: $\tau \times \tau$
* **Sintaxis de Términos ($M$):**
  * **Constructor (Introducción):** El par ordenado $\langle M, M \rangle$
  * **Destructores (Eliminación):** Las proyecciones primera $\pi_1(M)$ y segunda $\pi_2(M)$

###  Bloque B: Inferencia (Reglas de Tipado)
* **Introducción ($\times_i$):** Si se posee una prueba de $\tau$ y una de $\sigma$, se puede construir el par.
  $$\frac{\Gamma\vdash M:\tau \quad \Gamma\vdash N:\sigma}{\Gamma\vdash \langle M,N \rangle : \tau\times\sigma}\times_i$$
* **Eliminación ($\times_{e_1}, \times_{e_2}$):** Si se tiene una prueba de la conjunción, se puede extraer la componente respectiva.
  $$\frac{\Gamma\vdash M:\tau\times\sigma}{\Gamma\vdash \pi_1(M):\tau}\times_{e_1} \quad \quad \frac{\Gamma\vdash M:\tau\times\sigma}{\Gamma\vdash \pi_2(M):\sigma}\times_{e_2}$$

###  Bloque C: Semántica Operacional
* **Valores ($V$):** Un par es un valor terminal si sus componentes lo son: $V ::= \dots \mid \langle V, V \rangle$
* **Reglas de Cómputo ($\beta$-reducciones):** Eliminan el rodeo innecesario de introducir un par para proyectarlo inmediatamente.
  $$\pi_1(\langle V, W \rangle) \rightarrow V \quad (\text{E-FSTPAIR})$$
  $$\pi_2(\langle V, W \rangle) \rightarrow W \quad (\text{E-SNDPAIR})$$
* **Reglas de Congruencia:** Permiten guiar la reducción hacia el interior de las parejas o proyecciones.
  $$\frac{M\rightarrow M'}{\langle M, N \rangle \rightarrow \langle M', N \rangle} \quad \quad \frac{N\rightarrow N'}{\langle V, N \rangle \rightarrow \langle V, N' \rangle}$$
  $$\frac{M\rightarrow M'}{\pi_1(M) \rightarrow \pi_1(M')} \quad \quad \frac{M\rightarrow M'}{\pi_2(M) \rightarrow \pi_2(M')}$$

---

## 2. Tipo Suma / Alternativa ($\lambda^{+}$)
Se corresponde con la **Disyunción Lógica ($A \vee B$)**. Representa una prueba que proviene legítimamente del lado izquierdo o del derecho.

###  Bloque A: Sintaxis
* **Sintaxis de Tipos ($\tau$):** Se añade la suma disjunta: $\tau + \tau$
* **Sintaxis de Términos ($M$):**
  * **Constructores (Introducción):** Las inyecciones indexadas $left_{\tau}(M)$ y $right_{\tau}(M)$.
  * **Destructor (Eliminación):** El análisis por casos exhaustivo $case\ M\ \{left(x) \mapsto N \mid right(y) \mapsto P\}$.

###  Bloque B: Inferencia (Reglas de Tipado)
* **Introducción ($+i_1, +i_2$):** Una prueba de una de las partes valida la disyunción total.
  $$\frac{\Gamma\vdash M:\tau}{\Gamma\vdash left_{\sigma}(M):\tau+\sigma}+i_1 \quad \quad \frac{\Gamma\vdash M:\sigma}{\Gamma\vdash right_{\tau}(M):\tau+\sigma}+i_2$$
* **Eliminación ($+e$):** Si se asume el caso izquierdo para deducir $\rho$ y de igual manera con el caso derecho, se concluye $\rho$.
  $$\frac{\Gamma\vdash M:\tau+\sigma \quad \Gamma, x:\tau\vdash N:\rho \quad \Gamma, y:\sigma\vdash P:\rho}{\Gamma\vdash case\ M\ \{left(x) \mapsto N \mid right(y) \mapsto P\} : \rho}+e$$

###  Bloque C: Semántica Operacional
* **Valores ($V$):** Estructuras inyectadas con un valor resuelto: $V ::= \dots \mid left_{\tau}(V) \mid right_{\tau}(V)$
* **Reglas de Cómputo ($\beta$-reducciones):** Bifurcan el flujo hacia la rama correspondiente mediante la sustitución formal.
  $$case\ left_{\tau}(V)\ \{left(x) \mapsto M \mid right(y) \mapsto N\} \rightarrow M\{x:=V\}$$
  $$case\ right_{\tau}(V)\ \{left(x) \mapsto M \mid right(y) \mapsto N\} \rightarrow N\{y:=V\}$$
* **Reglas de Congruencia:** Guían la reducción hacia el interior de las inyecciones o evalúan el término bajo escrutinio del *case*.

---

## 3. Tipo Absurdo / Vacío ($\lambda^{\perp}$)
Se corresponde con la **Falsedad o Contradicción Lógica ($\bot$)**. Representa una aserción matemáticamente imposible de habitar en un contexto consistente.

###  Bloque A: Sintaxis
* **Sintaxis de Tipos ($\tau$):** Se añade el símbolo terminal: $\bot$
* **Sintaxis de Términos ($M$):**
  * **Constructores (Introducción):** **No existen**. Es un tipo algebraico sin constructores.
  * **Destructor (Eliminación):** Un operador de análisis de casos con 0 ramas: $case_{\tau}\ M\ \{\}$

###  Bloque B: Inferencia (Reglas de Tipado)
* **Eliminación del Absurdo ($\bot_e$):** Codifica el principio *Ex Falso Sequitur Quodlibet* (de una falsedad se deduce cualquier cosa).
  $$\frac{\Gamma\vdash M:\perp}{\Gamma\vdash case_{\tau}\ M\ \{\} : \tau}\bot_e$$

###  Bloque C: Semántica Operacional
* **Valores y Reducciones:** **No se extienden los valores ni las reglas de reducción**. Al no existir constructores sintácticos para $\bot$, nunca es posible generar un Valor de tipo absurdo. El destructor representa un escenario inalcanzable (código muerto).

---

## 4. Tipo Unit / Unidad ($\lambda^{\top}$)
Se corresponde con la **Tautología o Verdad Absoluta ($T$)** de la Lógica Intuicionista, almacena una estructura trivial que siempre se puede validar sin hipótesis.

###  Bloque A: Sintaxis
* **Sintaxis de Tipos ($\tau$):** Se añade la constante de tipo: $\top$
* **Sintaxis de Términos ($M$):**
  * **Constructor (Introducción):** El elemento canónico unitario (el asterisco): $*$
  * **Destructores (Eliminación):** **No existen**. Al no almacenar información, no hay nada que deconstruir.

###  Bloque B: Inferencia (Reglas de Tipado)
* **Introducción de la Unidad ($\top_i$):** El valor $*$ se puede derivar instantáneamente bajo cualquier contexto sin premisas.
  $$\overline{\Gamma\vdash * : \top}\top_i$$

###  Bloque C: Semántica Operacional
* **Valores ($V$):** El término $*$ se define explícitamente como un **Valor**. No posee reglas de reducción asociadas.

---

## 5. Propiedades Globales del Cálculo Lambda Extendido y sus Justificaciones

### 1. Unicidad de Tipos
* **Definición:** Si $\Gamma\vdash M:\tau$ y $\Gamma\vdash M:\sigma$, entonces $\tau = \sigma$.
* **Justificación:** El sistema de tipado es determinista y estructural. Cada término constructor y destructor cuenta con una única regla sintáctica de asignación aplicable bajo el mismo entorno, impidiendo tipos heterogéneos.

### 2. Debilitamiento y Fortalecimiento (Weakening + Strengthening)
* **Definición:** Si $\Gamma\vdash M:\tau$ es derivable y $fv(M) \subseteq dom(\Gamma \cap \Gamma')$, entonces $\Gamma'\vdash M:\tau$ es derivable.
* **Justificación:** Agregar variables muertas al contexto no afecta las premisas usadas (Weakening), y remover del contexto variables que el término no utiliza libremente preserva la validez de la derivación (Strengthening).

### 3. Determinismo de la Evaluación
* **Definición:** Si $M \rightarrow N_1$ y $M \rightarrow N_2$, entonces $N_1 = N_2$.
* **Justificación:** Las reglas operacionales (*small-step*) y sus contextos de evaluación eliminan ambigüedades. Cada término tiene un único paso de reducción posible según su estructura sintáctica gramatical.

### 4. Preservación de Tipos (Subject Reduction)
* **Definición:** Si $\Gamma\vdash M:\tau$ y $M \rightarrow N$, entonces $\Gamma\vdash N:\tau$.
* **Justificación:** Las reglas de computación ($\beta$-reducciones) están en simetría exacta con la eliminación de cortes lógicos. La deconstrucción preserva rigurosamente el tipo establecido por las reglas de introducción.

### 5. Progreso
* **Definición:** Si $\vdash M:\tau$, entonces o bien $M$ es un **Valor**, o bien existe $N$ tal que $M \rightarrow N$.
* **Justificación:** Un programa cerrado y bien tipado nunca se encalla. Las reglas de congruencia garantizan el avance hasta exponer un constructor que habilite una $\beta$-reducción, o el término ya es un valor terminal.

### 6. Terminación (Fuerte Normalización)
* **Definición:** Si $\Gamma\vdash M:\tau$, no hay cadenas infinitas de reducción $M \rightarrow M_1 \rightarrow M_2 \rightarrow \dots$
* **Justificación:** Cada reducción $\beta$ elimina un corte (rodeo lógico), disminuyendo estrictamente la complejidad de la prueba. Al no haber recursión sin tipar (como un operador `fix`), todo término alcanza su forma normal en pasos finitos.

### 7 Extensiones que rompen intencionalmente las propiedades de Progreso y Terminación

En el diseño de lenguajes de programación reales, a menudo existe una tensión entre la pureza logico-matemática y la expresividad o utilidad práctica del software. Por esta razón, los diseñadores extienden intencionalmente el cálculo lambda con operadores que sacrifican de forma deliberada las propiedades de Terminación (Fuerte Normalización) o Progreso.

---

#### A. ¿Por qué se desea romper estas propiedades?

1. **Romper la Terminación (Turing-completesa):**
   Un sistema que garantiza que todos sus programas terminan (como el cálculo lambda con tipos simples o el cálculo extendido visto previamente) no puede ser Turing-completo. Esto significa que es matemáticamente imposible programar en él algoritmos de recursión general o funciones donde el número de iteraciones dependa de condiciones dinámicas que no se sabe de antemano si convergerán. Para que un lenguaje sirva para la programación de propósito general, se debe permitir la posibilidad de ciclos infinitos.
   
2. **Romper el Progreso (Control de Errores y Excepciones):**
   El teorema de Progreso clásico asegura que un término cerrado bien tipado nunca se queda "atascado" (o es un valor o puede reducir). Sin embargo, en el software real ocurren situaciones anómalas insalvables (como la división por cero, el desborde de memoria o accesos indexados fuera de rango). Para modelar esto sin romper la ejecución de la máquina virtual completa, se introducen operadores de error que detienen la evaluación de forma controlada, lo que formalmente se traduce en un término bien tipado que no es un valor y no puede dar más pasos de reducción tradicionales.

---

#### B. ¿Cómo se demuestra si una extensión rompe o preserva una propiedad?

* **Para demostrar que se PRESERVA el Progreso:**
  Se utiliza inducción estructural sobre la derivación del juicio de tipado. En el paso inductivo del nuevo destructor o término introducido, se analizan las premisas del juicio. Si las subexpresiones son valores, se debe demostrar que existe una regla de cómputo (reducción beta) que puede aplicarse de inmediato. Si no son valores, se debe demostrar que una regla de congruencia permite avanzar la evaluación.
  
* **Para demostrar que se ROMPE el Progreso:**
  Basta con exhibir un contraejemplo: un término cerrado M, que esté bien tipado bajo el contexto vacio, pero que no cumpla con ser un valor según la definición de valores del lenguaje, y para el cual ninguna regla de reducción (de cómputo o congruencia) sea aplicable.

* **Para demostrar que se PRESERVA la Terminación:**
  Es una de las pruebas más complejas de la teoría de tipos. No basta con inducción simple porque la reducción beta puede aumentar el tamaño del término. Se utiliza el Método de Reducibilidad (o Candidatos de Reducibilidad de Tait-Girard), definiendo un conjunto de términos "buenos" de manera inductiva sobre la estructura de los tipos y probando que todo término bien tipado pertenece a ese conjunto.
  
* **Para demostrar que se ROMPE la Terminación:**
  Basta con construir un término bien tipado M y encontrar una secuencia o estrategia de evaluación válida que genere una cadena infinita de pasos de reducción.

---

#### C. Ejemplos de extensiones que rompen las propiedades

##### 1. El Operador de Punto Fijo (`fix`) - Rompe la Terminación
Para permitir la recursión general, se extiende la sintaxis con el operador `fix M`, cuya regla de tipado es:

```
  Gamma |- M : T -> T
----------------------- (T-FIX)
    Gamma |- fix M : T
```

Y su semántica operacional de paso pequeño está dictada por la regla de cómputo:
`fix (\x:T. M) -> M[x := fix (\x:T. M)]` (E-FIXBETA)

* **Justificación de la rotura:**
  Consideremos el término cerrado `fix (\x:T. x)`. Evaluemos su tipado bajo el contexto vacío:
  El término interno es la identidad `\x:T. x`, la cual tiene tipo `T -> T`. Al aplicar la regla T-FIX, el término completo `fix (\x:T. x)` está bien tipado y tiene tipo `T`.
  Sin embargo, si intentamos reducir este término aplicando la regla E-FIXBETA, obtenemos de inmediato:
  `fix (\x:T. x) -> x[x := fix (\x:T. x)]` lo cual se evalúa exactamente a `fix (\x:T. x)`.
  Esto genera una cadena infinita de reducción idéntica:
  `fix (\x:T. x) -> fix (\x:T. x) -> fix (\x:T. x) -> ...`
  Por lo tanto, la propiedad de Terminación queda completamente destruida en presencia de `fix`.

##### 2. El Constructor `error` - Rompe el Progreso
Imagine que queremos simular un fallo controlado en el cálculo lambda e introducimos el término especial `error` con la siguiente regla de tipado para cualquier tipo `T`:

```
--------------------- (T-ERROR)
 Gamma |- error : T
```

If decidimos mantener a `error` fuera de la categoría sintáctica de Valores (porque un error no es un resultado final deseado, sino una anomalía) y no proporcionamos ninguna regla de reducción donde un `error` aislado pueda dar un paso (es decir, no hay ninguna regla que diga `error -> M`), entonces el sistema rompe el progreso.

* **Justificación de la rotura:**
  Tomemos el término `error` bajo el contexto vacío. Por la regla T-ERROR, el término está bien tipado con tipo `T`. Sin embargo, analicemos las dos condiciones de Progreso:
  1. ¿Es un valor? No, por definición sintáctica los valores no incluyen a `error`.
  2. ¿Existe un N tal que `error -> N`? No, no se definió ninguna regla de reducción para el término `error` por sí solo.
  Por lo tanto, el término está bien tipado pero bloqueado de forma estática, lo que representa una violación directa al teorema de Progreso tradicional.

---

#### D. Consecuencias en la Correspondencia de Curry-Howard

El costo de dotar al lenguaje de programación de mayor poder expresivo mediante operadores como `fix` es la pérdida de la consistencia del sistema lógico subyacente.

Bajo Curry-Howard, si la propiedad de Terminación se rompe a través de `fix`, la Lógica Intuicionista (NJ) se vuelve **inconsistente**. Esto significa que es posible derivar y demostrar cualquier proposición falsa o absurda (el tipo vacío `Void` o `_|_`).

* **Demostración de la inconsistencia:**
  Queremos ver si el juicio `|- M : _|_` es derivable bajo el contexto vacío.
  Tomemos el término problemático que usamos antes, pero asignándole el tipo absurdo: `fix (\x:_|_. x)`.
  1. El cuerpo es `\x:_|_. x`, que se tipa bajo la regla T-ABS como `_|_ -> _|_`.
  2. Al aplicar la regla T-FIX sobre este término, el sistema infiere con éxito:
     `|- fix (\x:_|_. x) : _|_`
  
Como el término está perfectamente tipado en el contexto vacío, significa que hemos construido una prueba para el absurdo lógico. A través del principio de explosión (`case`), ahora podríamos usar este término para demostrar cualquier teorema falso en el sistema, destruyendo la utilidad del compilador como un verificador de pruebas matemáticas fiables.


---

## 6. Consistencia de la Lógica

* **Teorema:** El juicio absurdo $\vdash \bot$ **no es derivable** en NJ.
* **Justificación:** Si fuera derivable, existiría un término cerrado $M$ tal que $\vdash M : \bot$. Por **Terminación**, $M$ reduciría en pasos finitos, y por **Preservación**, el resultado final sería un valor $V$ tal que $\vdash V : \bot$. Sin embargo, al inspeccionar la sintaxis de todos los posibles valores del cálculo ($true, false, \langle V,V \rangle, left(V), right(V), *$), ninguno pertenece al tipo vacío $\bot$. Por contradicción, el juicio es inderivable.
