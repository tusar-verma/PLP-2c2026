# Cálculo Lambda — resumen para examen

## 1. Idea general

El cálculo lambda formaliza la computación mediante tres construcciones:

- **variable**: `x`
- **abstracción**: `λx.M` — una función que recibe `x` y devuelve `M`
- **aplicación**: `MN` — aplicar `M` a `N`

Se estudian tres aspectos:

- **Sintaxis**: qué expresiones existen.
- **Semántica**: qué significan.
- **Cómputo**: cómo se ejecutan/reducen.

El cálculo lambda puro alcanza poder computacional general (Turing-completo). Booleanos, números, pares y listas pueden codificarse mediante funciones.

---

## 2. Sintaxis del cálculo lambda puro

La gramática es:

```text
M,N ::= x | (λx.M) | (MN)
```

Se lee:

> “M y N se generan como una variable, una abstracción o una aplicación”.

- `x`: variable.
- `λx.M`: abstracción.
- `MN`: aplicación.

### Convenciones

Se omiten paréntesis externos.

**Aplicación asocia a izquierda:**

```text
xyz = ((xy)z)
```

Se lee: “`x` aplicado a `y`, y el resultado aplicado a `z`”.

**Aplicación tiene mayor precedencia que λ:**

```text
λx.xy = λx.(xy)
```

**Lambdas consecutivas se agrupan:**

```text
λxy.M = λx.λy.M
```

La sintaxis concreta es el texto escrito; la sintaxis abstracta es la estructura del término, que puede verse como un árbol.

---

## 3. Ligadura de variables

En:

```text
λx.xy
```

- `x` después de `λ` es el **ligador**.
- el `x` del cuerpo es una **ocurrencia ligada**.
- `y` es una **ocurrencia libre**.
- el cuerpo `xy` es el **alcance (scope)** de `λx`.

### Variables libres

```text
fv(x) = {x}

fv(MN) = fv(M) ∪ fv(N)

fv(λx.M) = fv(M) \ {x}
```

Se lee:

- `fv(M)`: “variables libres de M”.
- `∪`: unión.
- `\`: diferencia de conjuntos.

Un término es **cerrado** si:

```text
fv(M) = ∅
```

La presentación llama **programas** a los términos cerrados.

---

## 4. Sustitución

La sustitución:

```text
M{x := N}
```

se lee:

> “M sustituyendo x por N”.

Reglas principales:

```text
x{x := N} = N

y{x := N} = y                 si y ≠ x

(PQ){x := N}
  = P{x := N} Q{x := N}

(λx.P){x := N}
  = λx.P
```

La última regla significa que el `λx` **bloquea** la sustitución: dentro de su cuerpo, esas `x` ya están ligadas por ese lambda.

Si el ligador tiene otro nombre:

```text
(λy.P){x := N}
```

puede hacerse directamente si:

```text
y ≠ x
y ∉ fv(N)
```

Entonces:

```text
(λy.P){x := N} = λy.P{x := N}
```

### Captura de variables

La sustitución ingenua puede cambiar el significado al capturar una variable que era libre.

Ejemplo:

```text
(λz.xz){x := λy.yz}
```

No conviene producir directamente:

```text
λz.(λy.yz)z
```

porque la `z` que venía dentro de `N` era libre y ahora queda ligada por `λz`.

Primero se hace **α-renombrado**:

```text
λz.xz  =α  λw.xw
```

y luego:

```text
(λw.xw){x := λy.yz}
= λw.(λy.yz)w
```

La variable `w` debe ser fresca.

---

# 5. α, β y η

Estas tres ideas son centrales para entender qué expresiones representan lo mismo y cómo se computan.

## α-equivalencia

Renombrar una variable ligada sin cambiar el significado:

```text
λx.x =α λy.y
```

Se lee:

> “lambda x. x es alfa-equivalente a lambda y. y”.

No se pueden renombrar variables libres arbitrariamente.

Ejemplo:

```text
λx.xy
```

puede renombrarse como:

```text
λz.zy
```

pero no como `λz.zz`, porque eso cambiaría qué ocurrencia es libre.

La α-equivalencia permite tratar dos términos que difieren solo en los nombres de sus ligadores como el mismo programa.

---

## β-reducción

Es la regla fundamental de **ejecución**:

```text
(λx.M)N →β M{x := N}
```

Se lee:

> “la función lambda x. M aplicada a N reduce, por beta, a M con x sustituida por N”.

Ejemplo:

```text
(λx.x) y
→β y
```

Otro:

```text
(λx.x x) a
→β a a
```

### β-redex

Un **β-redex** es una subexpresión con forma:

```text
(λx.M)N
```

Es una parte del programa que puede computarse.

### Contracción

**Contraer un redex** significa realizar esa reducción concreta.

Ejemplo:

```text
(λx.x) a
```

es un redex; contraerlo produce:

```text
a
```

### Reducción

`M → N` representa un paso de reducción.

`M ↠ N` representa cero o más pasos:

```text
M ↠ M

si M → N y N ↠ P,
entonces M ↠ P
```

Se lee:

> “M reduce en cero o más pasos a N”.

Es la **clausura reflexiva y transitiva** de `→`.

---

## Forma normal

Un término está en **forma normal** si no existe ningún término `N` tal que:

```text
M → N
```

Es decir: no quedan pasos de reducción posibles.

Una forma normal no necesariamente es un valor en todas las extensiones del lenguaje.

---

## Church-Rosser

El cálculo lambda tiene la propiedad de **confluencia**:

> si desde un término se pueden seguir dos caminos de reducción, los resultados pueden volver a converger.

Consecuencia importante:

> si un término tiene una forma normal, esa forma normal es única salvo α-equivalencia.

Esto **no** significa que toda reducción termine.

Ejemplo conceptual:

```text
Ω = (λx.xx)(λx.xx)
```

`Ω` se reduce a sí mismo y nunca termina.

Por eso puede existir un término que tenga una forma normal aunque algunas estrategias de reducción no lleguen a ella.

---

# 6. Semántica

La presentación distingue distintas maneras de dar significado a los programas.

## Semántica denotacional

Asigna a cada término un objeto matemático:

```text
⟦M⟧
```

Se lee:

> “la denotación de M”.

La idea es interpretar un programa como un objeto matemático que representa su significado.

Por ejemplo, una función puede denotar una función matemática.

La pregunta central es:

> **¿Qué objeto matemático representa este programa?**

---

## Semántica operacional

Describe el significado mediante la **ejecución**.

La presentación usa **small-step**:

```text
M → N
```

Se lee:

> “M da un paso de ejecución y se convierte en N”.

También existe **big-step**, que relaciona directamente un programa con su resultado final.

En el cálculo tipado, la semántica small-step se expresa mediante reglas de inferencia.

---

## Semántica algebraica

Las reglas `α`, `β` y `η` permiten establecer una teoría de equivalencia entre expresiones.

Idea:

> dos expresiones pueden considerarse iguales cuando las leyes del cálculo dicen que representan el mismo comportamiento.

La reducción orienta la β-reducción hacia una dirección de cómputo; las equivalencias permiten razonar sobre expresiones independientemente de una secuencia concreta de pasos.

---

# 7. Codificación de datos en el cálculo puro

El cálculo puro no tiene booleanos, números ni listas primitivas. Se pueden representar como funciones.

La técnica usada en la presentación es la **representación procedural de datos**:

> un dato se representa mediante la operación que permite consumirlo.

## Booleanos

```text
true  = λt.λf.t
false = λt.λf.f
```

Lectura conceptual:

- `true` recibe dos alternativas y devuelve la primera.
- `false` recibe dos alternativas y devuelve la segunda.

Entonces:

```text
ifthenelse = λb.λt.λf.b t f
```

Un booleano funciona como selector.

---

## Pares

La idea es representar:

```text
(a,b)
```

como una función que recibe una operación para extraer información:

```text
pair = λx.λy.λf.f x y
```

Una representación típica permite definir selectores como `fst` y `snd`.

La idea importante es que **los datos son funciones que reciben la operación que se quiere realizar sobre ellos**.

---

# 8. Números de Church

Los naturales también son funciones.

```text
0   = λs.λz.z

succ = λn.λs.λz.s (n s z)
```

El número `n` representa:

> “aplicar `s` exactamente n veces a `z`”.

Por ejemplo:

```text
2 = λs.λz.s (s z)

3 = λs.λz.s (s (s z))
```

Por eso:

```text
0 = λs.λz.z
```

no aplica `s` ninguna vez.

La suma puede expresarse usando el fold de naturales:

```text
suma = λn.λm.n succ m
```

La representación de `0` coincide sintácticamente con la de `False`. Esto no es un problema en el cálculo puro porque no existen tipos que separen ambos conceptos.

---

# 9. Listas y fold

Una lista también puede representarse como su propio esquema de recursión.

```text
nil  = λf.λz.z

cons = λx.λxs.λf.λz.f x (xs f z)

foldr = λf.λz.λxs.xs f z
```

Por ejemplo:

```text
[2,3]
```

se representa como:

```text
λf.λz.f 2 (f 3 z)
```

La idea:

> una lista ya contiene la información necesaria para realizar su `foldr`.

Por eso operaciones como `length`, `sum` y `map` se definen pasando al dato la función correspondiente.

Ejemplos de la presentación:

```text
length = λxs.xs (λx.λn.succ n) 0

sum = λxs.xs (λx.λy.suma x y) 0

map = λf.λxs.xs (λx.λzs.cons (f x) zs) nil
```

---

# 10. Recursión general y punto fijo

Los folds permiten recursión **estructural**: la recursión queda incorporada en la representación del dato.

Para recursión general necesitamos construirla explícitamente.

Se define:

```text
f = fix (λf....f....)
```

donde `fix` satisface:

```text
fix F ↠ F (fix F)
```

Se lee:

> “fix aplicado a F se reduce a F aplicado a su propio punto fijo”.

Una definición posible:

```text
fix =
(λx.λf.f (x x f))
(λx.λf.f (x x f))
```

La idea central es la **autoaplicación**.

Esto permite definir funciones recursivas generales, como `fact`.

El cálculo lambda puro tiene entonces suficiente poder para expresar computación general.

---

# 11. Cálculo lambda tipado con Bool

El cálculo puro permite expresiones como:

```text
xx
```

y eso hace posible construir términos que no tienen una interpretación de programa deseable en un lenguaje tipado.

Para restringir los programas se agrega un **sistema de tipos**.

## Tipos

```text
τ ::= Bool | τ → τ
```

Se lee:

> “un tipo es Bool o una función entre tipos”.

La flecha asocia a derecha:

```text
τ1 → τ2 → τ3
=
τ1 → (τ2 → τ3)
```

y no:

```text
(τ1 → τ2) → τ3
```

Esto está relacionado con la currificación.

---

# 12. Términos tipados

```text
M,N,P ::=
    x
  | λx : τ.M
  | MN
  | true
  | false
  | if P then M else N
```

La diferencia principal respecto del cálculo puro es que la abstracción indica el tipo del parámetro:

```text
λx : Bool.x
```

La aplicación sigue asociando a izquierda.

---

# 13. Contextos y juicios de tipado

Un **contexto de tipado** `Γ` contiene hipótesis sobre variables:

```text
Γ = {x : Bool, f : Bool → Bool}
```

`dom(Γ)` es el conjunto de variables del contexto.

El juicio de tipado es:

```text
Γ ⊢ M : τ
```

Se lee:

> “bajo las suposiciones de Γ, M tiene tipo τ”.

Ejemplo:

```text
⊢ λx : Bool.x : Bool → Bool
```

El contexto vacío significa que no necesitamos suposiciones externas; el término es cerrado.

El sistema de tipos es un **sistema deductivo**: los juicios se justifican mediante reglas de inferencia.

---

# 14. Reglas de tipado

## Variables

```text
Γ, x : τ ⊢ x : τ
```

Se lee:

> “si Γ contiene la hipótesis x : τ, entonces x tiene tipo τ”.

## Abstracción

```text
Γ, x : τ1 ⊢ M : τ2
-------------------------
Γ ⊢ λx : τ1.M : τ1 → τ2
```

Se lee:

> “si suponiendo que x tiene tipo τ1 podemos demostrar que M tiene τ2, entonces la función tiene tipo τ1 → τ2”.

Es análoga a introducir una implicación.

## Aplicación

```text
Γ ⊢ M : τ1 → τ2
Γ ⊢ N : τ1
----------------
Γ ⊢ MN : τ2
```

Se lee:

> “si M es una función de τ1 a τ2 y N tiene τ1, entonces M aplicado a N tiene τ2”.

Es análoga a eliminar una implicación.

## Booleanos

```text
Γ ⊢ true : Bool

Γ ⊢ false : Bool
```

## If

```text
Γ ⊢ P : Bool
Γ ⊢ M : τ
Γ ⊢ N : τ
-------------------------
Γ ⊢ if P then M else N : τ
```

La condición debe ser `Bool` y ambas ramas deben tener el mismo tipo.

---

# 15. Propiedades del sistema de tipos

## Unicidad

Si:

```text
Γ ⊢ M : τ1
Γ ⊢ M : τ2
```

entonces:

```text
τ1 = τ2
```

Por eso podemos hablar de **el tipo** de un término.

## Debilitamiento / fortalecimiento

El tipo de un término depende solamente de las hipótesis relevantes para sus variables libres.

En particular, agregar información sobre variables que no aparecen libres en `M` no cambia su tipado.

Estas propiedades se demuestran por inducción sobre las derivaciones.

---

# 16. Semántica operacional small-step del cálculo tipado

Un programa es:

> un término cerrado y tipable.

La evaluación se expresa mediante:

```text
M → N
```

que significa:

> “M da un paso de ejecución y produce N”.

Los **valores** son resultados completamente evaluados:

```text
V ::= true | false | λx : τ.M
```

Una función es un valor.

---

# 17. Reglas de evaluación de `if`

```text
if true then M else N → M

if false then M else N → N
```

Estas son reglas de **cómputo**: hacen trabajo.

También:

```text
P → P'
--------------------------------
if P then M else N
→ if P' then M else N
```

Esta es una regla de **congruencia**: no decide el resultado, sino dónde se permite seguir evaluando.

Solo se evalúa la condición; las ramas no se evalúan antes de saber cuál corresponde.

---

# 18. Reglas de evaluación de funciones

```text
M → M'
----------------
MN → M'N
```

Primero se evalúa la función.

```text
N → N'
-----------------------------
(λx : τ.M)N → (λx : τ.M)N'
```

Después se evalúa el argumento.

Finalmente:

```text
(λx : τ.M)V → M{x := V}
```

Esta es la regla **β**.

Importante: exige que el argumento sea un **valor `V`**.

Por eso esta semántica es **estricta**: primero se evalúa el argumento hasta un valor y recién después se sustituye.

---

# 19. Evaluación en muchos pasos

Se define:

```text
M ↠ M
```

y:

```text
M → N    N ↠ P
----------------
M ↠ P
```

Se lee:

> “M evalúa en cero o más pasos hasta P”.

Es la clausura reflexiva y transitiva de la evaluación de un paso.

---

# 20. Propiedades de la evaluación

## Determinismo

Si:

```text
M → N1
M → N2
```

entonces:

```text
N1 = N2
```

El siguiente paso de ejecución está determinado.

Esto se logra por cómo están diseñadas las reglas de congruencia: existe un único redex elegible.

## Preservación de tipos

Si:

```text
⊢ M : τ
```

y:

```text
M → N
```

entonces:

```text
⊢ N : τ
```

Se lee:

> “ejecutar el programa no cambia su tipo”.

## Progreso

Si:

```text
⊢ M : τ
```

entonces:

- `M` ya es un valor, o
- existe `N` tal que `M → N`.

Se lee:

> “un programa tipado nunca se queda trabado a mitad de camino”.

## Canonicidad

De preservación + progreso:

Si:

```text
⊢ M : Bool
```

entonces la evaluación termina en:

```text
true
```

o:

```text
false
```

Si:

```text
⊢ M : τ1 → τ2
```

entonces termina en una abstracción.

Idea clave:

> **el tipo predice la forma del resultado.**

---

# 21. Terminación y el costo del tipado

En el cálculo lambda simplemente tipado:

```text
⊢ M : τ
```

implica que no existe una cadena infinita:

```text
M → M1 → M2 → ...
```

Por lo tanto, todo programa tipable termina.

Esto tiene un costo:

- `bottom` no es tipable.
- `fix` no es tipable.
- no hay recursión general.
- el cálculo lambda simplemente tipado **no es Turing-completo**.

Los lenguajes reales, como Haskell, agregan mecanismos de recursión general y por eso pueden tener programas que no terminan.

La conclusión es:

> no es “tener tipos” lo que quita poder; lo que lo quita es **este sistema de tipos en particular**.

---

# 22. Agregar naturales

Se agrega el tipo:

```text
τ ::= ... | Nat
```

y términos:

```text
0
succ(M)
pred(M)
isZero(M)
```

Tipos:

```text
Γ ⊢ 0 : Nat

Γ ⊢ M : Nat
----------------
Γ ⊢ succ(M) : Nat

Γ ⊢ M : Nat
----------------
Γ ⊢ pred(M) : Nat

Γ ⊢ M : Nat
----------------
Γ ⊢ isZero(M) : Bool
```

Los valores se extienden:

```text
V ::= ... | 0 | succ(V)
```

Importante:

```text
succ(V)
```

y no:

```text
succ(M)
```

porque un valor debe estar completamente evaluado.

---

# 23. Evaluación de naturales

Si el argumento interno da un paso:

```text
M → M'
----------------
succ(M) → succ(M')

M → M'
----------------
pred(M) → pred(M')

M → M'
----------------
isZero(M) → isZero(M')
```

Reglas de cómputo:

```text
pred(succ(V)) → V

isZero(0) → true

isZero(succ(V)) → false
```

---

# 24. Términos de error

Al agregar `Nat`, aparece un problema:

```text
pred(0)
```

está bien tipado porque `0 : Nat`, pero no tiene ninguna regla que permita reducirlo.

Entonces es:

- cerrado;
- tipable;
- forma normal;
- pero **no es un valor**.

Esto rompe **progreso**.

Se llaman **términos de error** a formas normales cerradas y tipables que no son valores.

Ejemplo:

```text
pred(0)
```

y también:

```text
succ(pred(0))
```

porque contiene el error adentro.

El problema muestra que diseñar tipos implica decidir exactamente qué programas se quieren aceptar y qué comportamiento se garantiza.

---

# 25. Mapa mental final

```text
SINTAXIS
  |
  +-- variables
  +-- λx.M       abstracción
  +-- MN         aplicación
  |
  +-- ligadura
  |     +-- libre / ligada
  |     +-- fv(M)
  |     +-- términos cerrados
  |
  +-- sustitución
        +-- evita captura
        +-- variables frescas
        +-- α-renombrado

SEMÁNTICA / CÓMPUTO
  |
  +-- α : renombrar ligadores
  |
  +-- β : ejecutar una aplicación
  |       (λx.M)N → M{x:=N}
  |
  +-- η : equivalencia extensional
  |
  +-- redex
  +-- contracción
  +-- reducción
  +-- forma normal
  +-- Church-Rosser

DATOS CODIFICADOS
  |
  +-- booleanos
  +-- pares
  +-- números de Church
  +-- listas
  +-- folds
  +-- recursión general / fix

TIPOS
  |
  +-- τ ::= Bool | τ → τ
  +-- Γ ⊢ M : τ
  +-- t-var
  +-- t-abs
  +-- t-app
  +-- t-if
  |
  +-- unicidad
  +-- debilitamiento
  |
  +-- semántica small-step
  |      +-- valores
  |      +-- reglas de cómputo
  |      +-- reglas de congruencia
  |
  +-- determinismo
  +-- preservación
  +-- progreso
  +-- canonicidad
  +-- terminación

EXTENSIÓN NAT
  |
  +-- 0, succ, pred, isZero
  +-- aparece pred(0)
  +-- se rompe progreso
```

---

# 26. Fórmulas que conviene saber leer en el examen

| Fórmula | Lectura |
|---|---|
| `λx.M` | “lambda x, M”; función que recibe x y devuelve M |
| `MN` | “M aplicado a N” |
| `fv(M)` | “variables libres de M” |
| `M{x:=N}` | “M sustituyendo x por N” |
| `M =α N` | “M es alfa-equivalente a N” |
| `M → N` | “M reduce/evalúa en un paso a N” |
| `M ↠ N` | “M reduce/evalúa a N en cero o más pasos” |
| `M →β N` | “M beta-reduce a N” |
| `⟦M⟧` | “denotación de M” |
| `Γ` | “contexto de tipado” |
| `dom(Γ)` | “dominio del contexto” |
| `Γ ⊢ M : τ` | “bajo Γ, M tiene tipo τ” |
| `τ1 → τ2` | “tipo función de τ1 a τ2” |
| `M : τ` | “M tiene tipo τ” |
| `V` | “valor” |
| `M ∈ Λ` | “M pertenece al conjunto de términos lambda” |
| `τ ::= Bool \| τ → τ` | “los tipos se generan con Bool y el constructor función” |

## Lo esencial para recordar

1. **Sintaxis:** variable, abstracción, aplicación.
2. **Ligadura:** distinguir libres de ligadas.
3. **Sustitución:** no puede producir captura.
4. **α:** cambia nombres de ligadores.
5. **β:** modela la ejecución de una aplicación.
6. **η:** expresa equivalencia extensional.
7. **Redex:** parte reducible del término.
8. **Forma normal:** no quedan reducciones posibles.
9. **Church-Rosser:** si existe forma normal, es única salvo α.
10. **Los datos pueden codificarse como funciones.**
11. **Los tipos se expresan mediante juicios deductivos `Γ ⊢ M : τ`.**
12. **Preservación:** ejecutar conserva el tipo.
13. **Progreso:** un programa tipado es valor o puede avanzar.
14. **Canonicidad:** el tipo predice la forma del resultado.
15. **El lambda simplemente tipado termina**, pero por eso pierde recursión general y Turing-completitud.
16. **Agregar `Nat` ingenuamente rompe progreso** por términos como `pred(0)`.
