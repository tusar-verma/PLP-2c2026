```hs
alternado :: Circuito -> Circuito
{AC} alternado (Caja caja) = Caja (cajaAlternada caja)
{AS} alternado (Serie ci cf) = Serie (alternado ci) (alternado cf)
{AP} alternado (Paralelo ce ci cd cs) =
       Paralelo (cajaAlternada ce) (alternado ci) (alternado cd) (cajaAlternada cs)

cajaAlternada :: Caja -> Caja
{CAN} cajaAlternada Nada = Nada
{CAB} cajaAlternada Bombilla booleano = Bombilla not booleano

(.) :: (b -> c) -> (a -> b) -> a -> c
{C} (f . f) x = f (f x)

id :: a -> a
{I} id x = x

not :: Bool -> Bool
{NT} not True = False
{NF} not False = True
```

### Ejercicio 11 con colorcitos

Usando el principio de extensionalidad funcional basta con ver que para todo circuito $c$ vale: (alternado . alternado) $c$ = id $c$

Lo vamos a demostrar usando el principio de inducción estructural sobre c.

Un circuito tiene los siguientes constructores:

```hs
data Circuito = Caja Caja
    | Serie Circuito Circuito
    | Paralelo Caja Circuito Circuito Caja
    
```
Probaremos la propiedad para el constructor base ```Caja caja``` y los constructores recursivos ```Serie``` y ```Paralelo```.

Para esto usaremos 2 lemas:

#### Lema1
```hs
(∀ cj :: Caja)  cj = cajaAlternada (cajaAlternada cj)
```

Demo:

Usando lema de generación sorbe cj:

```hs
data Caja = Bombilla Bool | Nada

-- qvq: 
cajaAlternada (cajaAlternada cj) = cj 

  cajaAlternada (cajaAlternada Nada)              {CAN}
= cajaAlternada Nada                              {CAN}
= Nada

  cajaAlternada (cajaAlternada Bombilla b)        {CAB}
= cajaAlternada (Bombilla (not b))                {CAB}
= Bombilla (not (not b))                          {Lema2}
= Bombilla b
```

Para ambos constructores de Caja se obtiene la igualdad. Por lo tanto hemos demostrado el Lema1.

#### Lema2
```hs
(∀ x :: Bool) not (not x) = x
```

Demo: por principio de inducción en booleanos. Basta probar la propiedad para cada constructor booleano.

```hs
-- qvq: ∀x :: Bool
not (not x) = x

  not (not True)                  {NT}
= not False                       {NF}
= True

  not (not False)                 {NF}
= not True                        {NT}
= False
```

#### Caso base c = Caja cj 

```hs
-- qvq: 
(alternado . alternado) (Caja cj) = id (Caja cj)
```

desarrollando ambas partes de la ecuación:

```hs
  id (Caja cj)                                                                            {I}
= Caja cj

  (alternado . alternado) (Caja cj)                                                       {C}
= alternado (alternado (Caja cj))                                                         {AC}
= alternado (Caja (cajaAlternada cj))                                                     {AC}
= Caja (cajaAlternada (cajaAlternada cj))                                                 {Lema1}
= Caja cj
```



#### Caso inductivo c = Serie c1 c2 

```hs
-- HI: ∀ c1, c2:: Circuito
(alternado . alternado) c1 = id c1 AND (alternado . alternado) c2 = id c2

-- QVQ: 
(alternado . alternado) (Serie c1 c2) = id (Serie c1 c2)

  (alternado . alternado) (Serie c1 c2)                             {C}
= alternado (alternado (Serie c1 c2))                               {AS}
= alternado (Serie (alternado c1) (alternado c2))                   {AS}
= Serie (alternado (alternado c1)) (alternado (alternado c2))       {C}
= Serie (alternado . alternado c1) (alternado . alternado c2)       {HI}
= Serie (id c1) (id c2)                                             {I}
= Serie c1 c2                                                       {I}
= id (Serie c1 c2)   

```
Desarrollando el lado izquierdo llegamos al lado derecho de la ecuación. Vale la igualdad para circuitos serie.

#### Caso inductivo c = Paralelo cj1 c1 c2 cj2  

```hs
--HI: ∀ c1, c2 :: Circuito, ∀cj1 cj1 :: Caja
  alternado . alternado c1 = id c1 AND alternado . alternado c2 = id c2

--QVQ: 
  alternado . alternado (Paralelo cj1 c1 c2 cj2) = id (Paralelo cj1 c1 c2 cj2)


  (alternado . alternado) (Paralelo cj1 c1 c2 cj2)                                                  {C}
= alternado (alternado (Paralelo cj1 c1 c2 cj2))                                                    {AP}
= alternado (Paralelo (cajaAlternada cj1) (alternado c1) (alternado c2) (cajaAlternada cj2))        {AP}
= Paralelo
    cajaAlternada (cajaAlternada cj1)
    alternado (alternado c1)
    alternado (alternado c2)
    cajaAlternada (cajaAlternada cj2)                                                               {C}
= Paralelo
    cajaAlternada (cajaAlternada cj1)
    (alternado . alternado c1)
    (alternado . alternado c2)
    cajaAlternada (cajaAlternada cj2)                                                               {HI}
= Paralelo
    cajaAlternada (cajaAlternada cj1)
    (id c1)
    (id c2)
    cajaAlternada (cajaAlternada cj2)                                                               {Lema1}
= Paralelo
    cj1
    (id c1)
    (id c2)
    cj2                                                                                             {I}
= Paralelo cj1 c1 c2 cj2                                                                            {I}
= id (Paralelo cj1 c1 c2 cj2)                                                                       
```

Desarrollando el lado izquierdo llegamos al lado derecho de la ecuación. Vale la igualdad para circuitos paralelos.

Como probamos caso base y ambos casos recursivos, entonces demostramos que para todo $c::Circuito$ vale: ```(alternado . alternado) c = id c```

Y por principio de extensionalidad funcional vale: ```(alternado . alternado)= id```
