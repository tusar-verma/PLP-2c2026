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

# Ejercicio 2

Principio de extensionalidad funcional: 
Sean $f, g :: a \leftarrow b$
Si $(\forall x::a) \ f \ x = g \ x$ entocnes $f = g$

## I

```haskell
{c} (g . f) x = g (f x)
{f} flip f x y = f y x
{id} id x = x

```


```haskell
flip :: (a -> b -> c) -> b -> a -> c
(.) :: (d -> e) -> (f -> g) -> f -> e
(flip . flip) :: (b -> a -> c) -> (b -> a -> c)
```

renombrando las variables y (des)agrupando a derecha (por el operador ->) tenemos:
```haskell
(flip . flip) :: (a -> b -> c) -> (a -> b -> c)
(flip . flip) :: (a -> b -> c) -> a -> b -> c
```

Aplicamos el principio de extensionalidad funcional. Basta ver que $\forall f::a \rightarrow b \rightarrow c \ \forall x::a \ \forall y::b$ se cumple la igualdad flip .flip f x y = id f x y


```haskell
        flip . flip f x y
{c}   = flip (flip f x y)
{f}   = flip f y x
{f}   = f x y
{id}  = id f x y

```

## II

```haskell
f :: (a,b) -> c
curry :: ((a, b) -> c) -> a -> b -> c
uncurry :: (a -> b -> c) -> (a, b) -> c

uncurry (curry f) = f :: (a, b) -> c

{c0} curry f x y = f (x,y)
{c1} uncurry f (x,y) = f x y
```


Aplicamos el principio de extensionalidad funcional. Basta ver que $\forall p=(x,y)$ con $x\in a \wedge y \in b$ se cumple la igualdad $uncurry (curry f) (x,y) = f (x,y)$

```haskell
         uncurry (curry f) (x, y)
{c1}   = curry f x y
{c0}   = f (x, y)

```

## III

flip const = const id

```haskell
flip :: (a -> b -> c) -> b -> a -> c
const :: a -> b -> a

flip const :: b -> a -> a

{f} flip f x y = f y x
{c} const x y = x
{id} id x = x
```

Nuevamente usamos el principio de extensionalidad de funciones: $\forall x\in a, \forall y \in b$
qvq flip const y x = const id y x 

```haskell
        flip const y x
{f}   = const x y
{c}   = x
{id}  = id x
{c}   = (const id y) x
      = const id y x
```

## IV

Usando principio de extensionalidad de funciones $\forall x \in a$ basta con probar que 
((h . g) . f) x = (h . (g . f)) x

```haskell
{d} (.) f g x = f (g x)
```

```haskell
                 ((h . g) . f) x
{d}           = (h . g) (f x)
{d}           = h (g (f x))
{d}           = h (g . f) x
{d}           = (h . (g . f)) x
```