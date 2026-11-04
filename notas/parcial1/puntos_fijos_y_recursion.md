# Puntos fijos y recursión en cálculo lambda

## 1. Idea general

La sección de puntos fijos y recursión de la presentación parte de un problema:

> ¿Cómo podemos definir una función que se llame a sí misma?

Hasta este punto tenemos cálculo lambda tipado, pero no tenemos una forma directa de escribir definiciones recursivas.

Por ejemplo, queremos definir factorial:

```text
factorial(n) =
    si n = 0 entonces 1
    si no, n * factorial(n - 1)
```

El problema es que la definición de `factorial` usa a `factorial` dentro de su propia definición.

La idea de la presentación es transformar este problema de recursión en un problema de **punto fijo**.

La cadena conceptual es:

```text
recursión
    ↓
construir una función F que representa "un paso" de la definición
    ↓
buscar una función f tal que F f = f
    ↓
f es un punto fijo de F
    ↓
usar fix para obtener ese punto fijo
    ↓
podemos definir funciones recursivas
```

---

# 2. Antes de los puntos fijos: el problema de factorial

Supongamos que queremos:

```text
factorial(0) = 1
factorial(n) = n * factorial(n - 1)    si n > 0
```

La dificultad es que no podemos simplemente escribir:

```text
factorial =
    λx.
      if isZero(x)
      then 1
      else x * factorial(pred(x))
```

porque `factorial` tendría que existir previamente para poder aparecer dentro del término.

Hasta este momento, las macros no solucionan el problema.

Una macro solamente da un nombre a un término que ya existe. No crea un término nuevo capaz de referirse recursivamente a sí mismo.

La presentación propone entonces una forma indirecta de construir factorial.

---

# 3. Construir versiones sucesivas de factorial

Podemos imaginar funciones:

```text
fact0
fact1
fact2
...
```

donde cada una usa la anterior.

Por ejemplo:

```text
fact0 =
  λx.
    if isZero(x)
    then 1
    else ...

fact1 =
  λx.
    if isZero(x)
    then 1
    else x * fact0(pred(x))

fact2 =
  λx.
    if isZero(x)
    then 1
    else x * fact1(pred(x))
```

La idea general es:

```text
fact(n+1) = F factn
```

donde:

```text
F =
  λf : nat → nat.
    λx : nat.
      if isZero(x)
      then 1
      else x * f(pred(x))
```

`F` recibe una función que supuestamente hace de factorial y construye una nueva función que utiliza esa función como llamada recursiva.

Por ejemplo:

```text
F fact0
```

produce:

```text
λx.
  if isZero(x)
  then 1
  else x * fact0(pred(x))
```

que es justamente la idea de `fact1`.

Por eso:

```text
F fact0 = fact1
F fact1 = fact2
F fact2 = fact3
...
```

---

# 4. ¿Qué tiene de especial F?

Observemos nuevamente:

```text
F =
  λf.
    λx.
      if isZero(x)
      then 1
      else x * f(pred(x))
```

`F` recibe una función `f` y devuelve otra función.

Es decir, conceptualmente:

```text
f
↓
F
↓
otra función
```

La función `f` representa "la función recursiva que ya tengo disponible".

Por ejemplo:

```text
F fact0
```

construye una versión que puede usar `fact0`.

Luego:

```text
F fact1
```

construye una versión que puede usar `fact1`.

Y así sucesivamente.

Pero queremos dejar de construir infinitas versiones.

Queremos encontrar una única función `fact` que, al aplicarle `F`, produzca nuevamente `fact`:

```text
F fact = fact
```

---

# 5. ¿Qué es intuitivamente un punto fijo?

La idea de punto fijo es muy sencilla.

Dada una función `F`, un elemento `x` es un **punto fijo** de `F` si aplicar `F` a `x` no lo cambia:

```text
F x = x
```

Es decir:

```text
x
↓ F
x
```

La entrada y la salida son el mismo objeto.

## Ejemplo 1

Sea:

```text
F(x) = x
```

Entonces cualquier `x` es un punto fijo:

```text
F(5) = 5
F(10) = 10
F(42) = 42
```

## Ejemplo 2

Sea:

```text
F(x) = x²
```

Buscamos:

```text
F(x) = x
```

Entonces:

```text
x² = x
```

y por lo tanto:

```text
x(x - 1) = 0
```

Los puntos fijos son:

```text
0
1
```

porque:

```text
F(0) = 0
F(1) = 1
```

## Idea clave

Un punto fijo no significa que `F` sea la identidad.

Significa que **para ese elemento particular**, `F` devuelve el mismo elemento.

---

# 6. El punto fijo en el caso de factorial

Volvamos a:

```text
F =
  λf.
    λx.
      if isZero(x)
      then 1
      else x * f(pred(x))
```

Buscamos una función `fact` que satisfaga:

```text
F fact = fact
```

Desarrollamos `F fact`:

```text
F fact
```

por β-reducción:

```text
→ λx.
    if isZero(x)
    then 1
    else x * fact(pred(x))
```

Por lo tanto, decir:

```text
F fact = fact
```

equivale a decir:

```text
fact =
  λx.
    if isZero(x)
    then 1
    else x * fact(pred(x))
```

¡Esta es exactamente la definición recursiva de factorial!

Por eso la recursión puede verse como un problema de encontrar un punto fijo.

---

# 7. Definición formal de punto fijo

Formalmente:

> `f` es un punto fijo de `F` si:
>
> ```text
> F f = f
> ```

En el caso de factorial:

```text
F : (nat → nat) → (nat → nat)
```

y buscamos:

```text
fact : nat → nat
```

tal que:

```text
F fact = fact
```

Por lo tanto, `fact` es un punto fijo de `F`.

---

# 8. El operador fix

Ahora necesitamos una forma de obtener ese punto fijo.

La presentación extiende la sintaxis del cálculo lambda con un nuevo operador:

```text
M ::= ... | fix M
```

Es decir, ahora podemos escribir:

```text
fix M
```

La idea intuitiva es:

> `fix F` representa el punto fijo de `F`.

Si:

```text
F : τ → τ
```

entonces:

```text
fix F : τ
```

---

# 9. Regla de tipado de fix

La regla formal es:

```text
Γ ⊢ M : τ → τ
-----------------
Γ ⊢ fix M : τ
```

Interpretación:

1. `M` debe ser una función.
2. Esa función debe recibir un valor de tipo `τ`.
3. Debe devolver otro valor del mismo tipo `τ`.
4. Entonces podemos aplicar `fix` a `M`.
5. El resultado tiene tipo `τ`.

Por ejemplo, si:

```text
F : (nat → nat) → (nat → nat)
```

podemos elegir:

```text
τ = nat → nat
```

y entonces:

```text
fix F : nat → nat
```

Eso es exactamente lo que necesitamos para factorial.

---

# 10. ¿Por qué F tiene que tener tipo τ → τ?

Porque queremos que `F` pueda recibir una posible solución y producir otra versión del mismo tipo.

Si:

```text
f : τ
```

entonces:

```text
F f : τ
```

Así podemos buscar una solución a:

```text
F f = f
```

En factorial:

```text
τ = nat → nat
```

por lo tanto:

```text
F : (nat → nat) → (nat → nat)
```

y:

```text
fix F : nat → nat
```

---

# 11. ¿Cómo hace fix para producir recursión?

Esta es la parte fundamental de la semántica de `fix`.

La presentación introduce la regla:

```text
fix (λx : τ. M)
→
M{x := fix (λx : τ. M)}
```

La intuición es:

> Para calcular `fix (λx. M)`, reemplazamos `x` dentro de `M` por el propio `fix (λx. M)`.

Es decir, el término obtiene una referencia a sí mismo.

La estructura es:

```text
fix (λx. M)
        ↓
M{x := fix (λx. M)}
```

El propio término `fix (...)` aparece dentro de su cuerpo.

Eso es precisamente lo que permite la recursión.

---

# 12. Ejemplo simple de la regla

Tomemos:

```text
F = λf. λx. f(x)
```

Consideremos:

```text
fix F
```

es decir:

```text
fix (λf. λx. f(x))
```

Aplicamos la regla:

```text
fix (λf. λx. f(x))
→
(λx. f(x)){f := fix (λf. λx. f(x))}
```

Haciendo la sustitución:

```text
→
λx. (fix (λf. λx. f(x)))(x)
```

Es decir:

```text
fix F
→
λx. (fix F)(x)
```

La función resultante puede volver a utilizar `fix F`.

Tenemos entonces una forma de autorreferencia.

En este ejemplo concreto la recursión nunca termina, pero eso es intencional: sirve para mostrar que `fix` permite crear autorreferencia.

---

# 13. `fix` aplicado a factorial

Tenemos:

```text
F =
  λf : nat → nat.
    λx : nat.
      if isZero(x)
      then 1
      else x * f(pred(x))
```

Definimos:

```text
factorial = fix F
```

Como:

```text
F : (nat → nat) → (nat → nat)
```

entonces:

```text
fix F : nat → nat
```

Por lo tanto:

```text
factorial : nat → nat
```

Ahora podemos aplicar factorial:

```text
factorial 3
```

que es:

```text
(fix F) 3
```

---

# 14. Evaluación intuitiva de factorial 3

Primero desplegamos `fix F`.

Conceptualmente:

```text
fix F
→
λx.
  if isZero(x)
  then 1
  else x * (fix F)(pred(x))
```

Por lo tanto:

```text
(fix F) 3
```

se convierte en:

```text
3 * (fix F) 2
```

porque `3` no es cero.

Volvemos a desplegar:

```text
3 * (2 * (fix F) 1)
```

Volvemos a desplegar:

```text
3 * (2 * (1 * (fix F) 0))
```

Ahora:

```text
isZero(0)
```

es verdadero:

```text
(fix F) 0 → 1
```

Entonces:

```text
3 * 2 * 1
```

y finalmente:

```text
6
```

La recursión se despliega únicamente cuando es necesaria para evaluar el argumento.

---

# 15. La regla de evaluación de fix y el "despliegue"

La presentación enfatiza que la regla:

```text
fix (λx : τ. M)
→
M{x := fix (λx : τ. M)}
```

permite desplegar la definición tantas veces como sea necesario, pero no más.

Por ejemplo, al calcular:

```text
factorial 3
```

necesitamos aproximadamente:

```text
factorial
factorial
factorial
factorial
```

para llegar al caso base `0`.

No necesitamos desplegar factorial infinitamente antes de empezar a evaluar.

Esto es importante para que funciones recursivas que terminan puedan efectivamente terminar.

---

# 16. Una regla alternativa que NO se usa

La presentación considera una regla alternativa:

```text
fix M → M (fix M)
```

A primera vista parece natural porque queremos que `fix M` sea un punto fijo de `M`.

Sin embargo, la presentación advierte que esta regla no permitiría usar `fix` adecuadamente para definir funciones que terminan.

La regla utilizada es:

```text
fix (λx : τ. M)
→
M{x := fix (λx : τ. M)}
```

Esta regla introduce la autorreferencia dentro del cuerpo de la función.

La diferencia es importante:

```text
fix (λx. M)
```

se convierte en una función cuyo cuerpo contiene otra aparición de `fix`.

No se fuerza una expansión arbitraria de la aplicación completa.

---

# 17. Recursión como punto fijo

Podemos resumir todo el procedimiento así.

## Paso 1: escribir la definición recursiva

Por ejemplo:

```text
factorial(x) =
  if isZero(x)
  then 1
  else x * factorial(pred(x))
```

## Paso 2: sacar la llamada recursiva como parámetro

Construimos:

```text
F =
  λf.
    λx.
      if isZero(x)
      then 1
      else x * f(pred(x))
```

Ahora `F` no es recursiva.

Recibe la función que debería usar para la llamada recursiva.

## Paso 3: buscar un punto fijo

Queremos:

```text
F fact = fact
```

## Paso 4: usar `fix`

Definimos:

```text
fact = fix F
```

Entonces `fact` es el punto fijo de `F`.

---

# 18. El patrón general

Para una función recursiva cualquiera:

```text
f(x) = cuerpo que puede usar f
```

se construye una función:

```text
F =
  λf.
    λx.
      cuerpo donde la llamada a f
      aparece usando el parámetro f
```

Después:

```text
f = fix F
```

La estructura general es:

```text
                 F
                 │
                 │ recibe una posible f
                 ▼
             F f
                 │
                 │ produce una nueva f
                 ▼
                 f
```

y buscamos:

```text
F f = f
```

---

# 19. Otro ejemplo de la presentación: suma

La presentación también define suma mediante `fix`:

```text
suma =
  fix λf : nat → nat → nat.
    λx : nat.
      λy : nat.
        if isZero(x)
        then y
        else succ(f(pred(x)) y)
```

La función que está dentro de `fix` puede verse como:

```text
F =
  λf.
    λx.
      λy.
        if isZero(x)
        then y
        else succ(f(pred(x)) y)
```

Entonces:

```text
suma = fix F
```

y, conceptualmente:

```text
F suma = suma
```

Por lo tanto, la función `suma` se puede usar recursivamente dentro de su propia definición.

---

# 20. Punto fijo vs. recursión

Es importante no confundir los dos conceptos.

### Punto fijo

Es una propiedad matemática:

```text
F f = f
```

Dice que `f` queda igual al aplicarle `F`.

### Recursión

Es la posibilidad de definir una función haciendo referencia a sí misma.

### `fix`

Es el operador del cálculo lambda que permite obtener el punto fijo de una función apropiada y, de esa forma, expresar recursión.

Por eso:

```text
punto fijo
```

es el concepto matemático,

mientras que:

```text
fix
```

es el mecanismo del lenguaje.

---

# 21. El precio de agregar fix: pérdida de terminación

Antes de agregar `fix`, la presentación señala que el cálculo lambda tipado considerado tenía la propiedad de terminación:

```text
⊢ M : τ
```

implica que no existe una cadena infinita:

```text
M → M1 → M2 → ...
```

Es decir, un término bien tipado eventualmente termina de evaluarse.

Al agregar `fix`, esto deja de ser cierto.

Podemos escribir:

```text
fix (λx : σ. x)
```

La abstracción tiene tipo:

```text
λx : σ. x : σ → σ
```

por lo que:

```text
fix (λx : σ. x) : σ
```

Pero la evaluación es:

```text
fix (λx. x)
→
fix (λx. x)
→
fix (λx. x)
→
...
```

Nunca termina.

Por lo tanto:

> `fix` permite definir funciones recursivas, pero también permite definir términos que no terminan.

---

# 22. ¿Por qué esto importa para Curry–Howard?

La correspondencia de Curry–Howard identifica:

```text
proposiciones ↔ tipos
demostraciones ↔ términos
```

En particular, el tipo vacío:

```text
⊥
```

no tiene habitantes.

Por eso, antes de introducir `fix`, se podía obtener la consistencia de la lógica: no existe un término:

```text
M : ⊥
```

Sin embargo, con `fix` podemos escribir:

```text
fix (λx : ⊥. x)
```

La función:

```text
λx : ⊥. x
```

tiene tipo:

```text
⊥ → ⊥
```

Por la regla de `fix`:

```text
fix (λx : ⊥. x) : ⊥
```

Tenemos entonces un habitante de `⊥`.

Por Curry–Howard, esto corresponde a una demostración de falsedad.

Por eso la presentación concluye que si extendemos NJ con `fix`, la lógica resulta inconsistente.

---

# 23. La conexión completa con Curry–Howard

Antes de `fix`:

```text
tipos ↔ proposiciones
términos ↔ demostraciones
reducción β ↔ simplificación de demostraciones
terminación ↔ no hay demostraciones infinitamente circulares
```

Cuando agregamos `fix`:

```text
fix
↓
recursión
↓
pueden existir cómputos infinitos
↓
se pierde terminación
↓
también puede existir un término de tipo ⊥
↓
se pierde consistencia lógica
```

Esto explica por qué la presentación dice que la extensión da "más poder, pero a un precio".

Consecuencias en Curry-Howard: Inconsistencia Logica

La incorporacion del operador fix otorga un poder total de expresividad al software (alcanzando la Turing-completesa), pero introduce un costo matematico devastador sobre la dimension logica del sistema.

## Generacion de Terminos Infinitos
Con fix es trivial escribir funciones bien tipadas que entran en bucles infinitos no convergentes. Por ejemplo:
M = fix (\x : \sigma. x)

El termino anterior es sintacticamente valido y compila con exito para cualquier tipo \sigma existente en el universo.

## Quiebre de la Consistencia Logica (NJ)
Si aplicamos esta propiedad eligiendo especificamente como tipo destino al absurdo o tipo vacio (\sigma = \bot), obtenemos el siguiente juicio de tipado en el contexto vacio:
\emptyset |- fix (\x : \bot. x) : \bot

Bajo la Correspondencia de Curry-Howard, la existencia de un termino bien tipado y cerrado de tipo \bot significa que hemos logrado **habitar el tipo vacio**, lo cual es semánticamente equivalente a haber encontrado una demostracion valida para la falsedad absoluta. 

Por lo tanto, si la Logica Intuicionista (NJ) se extiende con las reglas de un operador de punto fijo general como fix, la dimension logica se vuelve **inconsistente** y el sistema colapsa, permitiendo derivar formalmente cualquier teorema falso o absurdo.


---

# 24. Resumen conceptual

La idea más importante de toda la sección es:

```text
Una definición recursiva necesita una función que pueda
referirse a sí misma.

Para conseguirla, construimos una función F que recibe
como argumento una posible versión de esa función.

Luego buscamos una función f tal que:

    F f = f

Esa f es un punto fijo de F.

El operador fix permite obtener ese punto fijo:

    f = fix F
```

Para factorial:

```text
F =
  λf : nat → nat.
    λx : nat.
      if isZero(x)
      then 1
      else x * f(pred(x))
```

y:

```text
factorial = fix F
```

de modo que:

```text
F factorial = factorial
```

---

# 25. Fórmulas y reglas que conviene saber para el examen

## Definición de punto fijo

```text
f es punto fijo de F
si y solo si

F f = f
```

## Sintaxis de `fix`

```text
M ::= ... | fix M
```

## Regla de tipado

```text
Γ ⊢ M : τ → τ
-----------------
Γ ⊢ fix M : τ
```

## Regla de evaluación

```text
M → M'
----------------
fix M → fix M'
```

## Regla fundamental

```text
fix (λx : τ. M)
→
M{x := fix (λx : τ. M)}
```

## Tipo general para recursión

Si:

```text
N : (τ → σ) → (τ → σ)
```

entonces:

```text
fix N : τ → σ
```

y conceptualmente `fix N` es una función `f` tal que:

```text
N f = f
```

## Factorial

```text
F =
  λf : nat → nat.
    λx : nat.
      if isZero(x)
      then 1
      else x * f(pred(x))

factorial = fix F
```

## Consecuencia

`fix` permite:

```text
recursión
```

pero también:

```text
no terminación
```

y por eso rompe la propiedad de terminación del cálculo lambda tipado anterior.

---

# 26. Qué deberías poder explicar

Para considerar aprendido este tema, deberías poder explicar sin memorizar mecánicamente:

1. **Qué es un punto fijo.**
   ```text
   F f = f
   ```

2. **Por qué aparece el problema de los puntos fijos al querer definir recursión.**

3. **Cómo transformar una definición recursiva en una función `F` que recibe la función recursiva como parámetro.**

4. **Por qué factorial puede escribirse como:**
   ```text
   factorial = fix F
   ```

5. **Qué significa la regla:**
   ```text
   fix (λx. M)
   →
   M{x := fix (λx. M)}
   ```

6. **Por qué esa regla introduce autorreferencia.**

7. **Por qué `fix` permite tanto recursión que termina como recursión infinita.**

8. **Por qué agregar `fix` hace que el cálculo lambda tipado pierda terminación.**

9. **Por qué esto afecta la correspondencia de Curry–Howard y permite construir un término de tipo `⊥`.**

La frase conceptual para recordar todo el tema es:

> **La recursión se puede expresar buscando un punto fijo: construimos una función `F` que describe un paso de la definición recursiva y usamos `fix F` para obtener una función `f` que satisface `F f = f`.**
