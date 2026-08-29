# Ejercicio 1

## I

```haskell
{I0} intercambiar (x, y) = (y, x)
```

$\forall p :: (a, b)$ intercambiar (intercambiar $p$) = $p$

Para demostrar esta igualdad, usamos el principio de extensionalidad funcional: 
$(\forall p::(a, b), f \ p = g \ p)$ entonces $f = g$. Donde $f$ y $g$ son el lado izquierdo y el lado derecho de la ecuación respectivamente

Como $p$ es un par, por lema de generación, $p :: (a, b)$ entonces $\exist x \in a, y \in b : p=(x,y)$  

Ahora demostremos $\forall p :: (a, b)$ intercambiar (intercambiar $p$) = $p$. Desarrollando el lado izquierdo de la ecuación:

```haskell
        intercambiar (intercambiar (x, y)) 
{IO} = intercambiar (y, x)
{IO} = (x, y)
```

Nos queda efectivamente el lado derecho de la ecuación. Queda demostrado.

## II

```haskell
{a0} asociarD ((x,y),z) = (x,(y,z))
{a1} asociarI (x,(y,z)) = ((x,y),z)
```

$\forall p::(a,(b,c))$ asociarD (asociarI $p$) $= p$

Aqui también usaremos el principio de extensionalidad funcional para probar la igualdad, y el lema de generación para la estructura de pares: 

$\{LG\}$ $(\exist x \in a, y \in b, z \in c) : p = (x, (y, z))$

Desarrollando el lado derecho de la ecuación:

```haskell
        asociarD (asociarI p)
{LG} = asociarD (asociarI (x, (y, z)))
{a1} = asociarD ((x, y), z)
{a0} =  (x, (y, z))
```

Obtenemos el lado izquierdo. Queda demostrado la propiedad.

## III

```haskell
{e0} espejar (Left x) = Right x
{e1} espejar (Right x) = Left x
```
Queremos demostrar

$(\forall p::$ Either a b $)$ espejar (espejar p) = p$

Por lema de generación sobre $p$: 
$\{LG\}$ $(\exist x \in a, y \in b) :$ o bien $p =$ Left $x$ o bien $p =$ Right $y$

Demotraremos la propiedad usando el principio de extencionalidad funcional separando en los casos de $p$.

> Caso $p =$ Left $x$
> ```haskell
>        espejar (espejar p)
> {LG} = espejar (espejar Left x)
> {e0} = espejar Right x
> {e1} = Left x
> {LG} = p
>```

> Caso $p =$ Right $x$
> ```haskell
>        espejar (espejar p)
> {LG} = espejar (espejar Right x)
> {e1} = espejar Left x
> {e0} = Right x
> {LG} = p
>```

Queda demostrado la propiedad

## IV

```haskell
{f0} flip f x y = f y x
```

Queremos demostrar

$(\forall f::a\rightarrow b \rightarrow c) \ (\forall x::a) \ (\forall y::b)$ flip (flip f) x y = f x y

Por principio de extensionalidad, basta con demostrar que para todo posible $f, x, y$ ambos lados de la ecuacion generar lo mismo.

(En cada paso deberiamos poner los para todos, pero para no escribir tanto lo omito (lo mismo para los demas ejercicios)).

```haskell
        flip (flip f) x y
{f0}  = flip f y x
{f0}  = f x y
```

Queda demostrado la propiedad.

## V

```haskell
{c0} curry f x y = f (x,y)
{c1} uncurry f (x,y) = f x y
```

Queremos demostrar

$(\forall f::a\rightarrow b \rightarrow c)  \ (\forall x::a) \ (\forall y::b)$ curry (uncurry f) x y = f x y

Nuevamente usaremos el principio de extensionalidad para demostrar la igualdad.

```haskell
       curry (uncurry f) x y = f x y
{c1} = curry ((x,y) -> f x y) x y
{c0} = f x y
```

otra forma

```haskell
                   curry (uncurry f) x y = f x y
{c0}             = (uncurry f) (x, y)
{asoc a izq}     = uncurry f (x, y)
(c1)             = f x y
```