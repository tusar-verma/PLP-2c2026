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
