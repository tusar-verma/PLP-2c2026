# Ejercicio 1

## i
$(\neg P \lor Q) \equiv (\neg V \lor V) \equiv (F \lor V) \equiv V$.   

## ii
$(P \lor (S \land T) \lor Q) \equiv (V \lor (F \land F) \lor V) \equiv (V \lor F \lor V) \equiv V$.   

## iii
$\neg(Q \lor S) \equiv \neg(V \lor F) \equiv \neg V \equiv F$.   

## iv
$(\neg P \lor S) \Leftrightarrow (\neg P \land \neg S) \equiv (\neg V \lor F) \Leftrightarrow (\neg V \land \neg F) \equiv (F \lor F) \Leftrightarrow (F \land V) \equiv F \Leftrightarrow F \equiv V$.   

## v
$((P \lor S) \land (T \lor Q)) \equiv ((V \lor F) \land (F \lor V)) \equiv (V \land V) \equiv V$.  

## vi
$(((P \lor S) \land (T \lor Q)) \Leftrightarrow (P \lor (S \land T) \lor Q))$ equivale a comparar los resultados de (v) y (ii): $V \Leftrightarrow V \equiv V$.

## vii
vii. $(\neg Q \land \neg S) \equiv (\neg V \land \neg F) \equiv (F \land V) \equiv F$.


# Ejercicio 2


# Ejercicio 3

A partir de las hipótesis del enunciado, primero determinaremos el valor de verdad de las proposiciones involucradas utilizando las reglas de la semántica bivaluada.

Sabemos que $\tau \Rightarrow \sigma$ es una tautología, lo que significa que para toda valuación $v$, $v \vDash \tau \Rightarrow \sigma$.


Sabemos que $\rho \Rightarrow \zeta$ es una contradicción, lo que significa que para ninguna valuación $v$ se cumple $v \vDash \rho \Rightarrow \zeta$. Por la semántica de la implicación, $v \vDash \rho \Rightarrow \zeta$ se cumple si y solo si $v \not\vDash \rho$ o $v \vDash \zeta$. Como esto es siempre falso, su negación debe ser siempre verdadera: para toda valuación $v$, necesariamente **$v \vDash \rho$ y $v \not\vDash \zeta$**. En consecuencia, $\rho$ es una tautología y $\zeta$ es una contradicción.


## i
$(\tau \Rightarrow \sigma) \lor (\rho \Rightarrow \zeta)$:Es una **tautología**. Por hipótesis, $\tau \Rightarrow \sigma$ es una tautología ($v \vDash \tau \Rightarrow \sigma$ para todo $v$). Por la regla de la disyunción ($v \vDash \alpha \lor \beta$ si $v \vDash \alpha$ o $v \vDash \beta$), basta que el lado izquierdo sea verdadero para que toda la fórmula sea satisfecha por cualquier valuación.


## ii
$(\tau \Rightarrow \rho) \lor (\sigma \Rightarrow \zeta)$: Es una **tautología**. Como demostramos que $\rho$ es una tautología, $v \vDash \rho$ para todo $v$. Por la regla de la implicación, $v \vDash \tau \Rightarrow \rho$ se cumple si $v \not\vDash \tau$ o $v \vDash \rho$. Al cumplirse siempre la segunda condición, $\tau \Rightarrow \rho$ es una tautología, haciendo que la disyunción completa también lo sea.


## iii
$(\rho \Rightarrow \sigma) \lor (\zeta \Rightarrow \sigma)$: Es una **tautología**. Como demostramos que $\zeta$ es una contradicción, $v \not\vDash \zeta$ para todo $v$. Por la regla de la implicación, $v \vDash \zeta \Rightarrow \sigma$ se cumple si $v \not\vDash \zeta$ o $v \vDash \sigma$. Al ser el antecedente siempre falso, la implicación $\zeta \Rightarrow \sigma$ es una tautología, lo que vuelve tautológica a toda la disyunción.



# Ejercicio 4
Demostraremos por el absurdo e inducción estructural que toda tautología debe contener al menos un conectivo $\neg$ o $\Rightarrow$.

Supongamos que existe una fórmula $\alpha$ que es una tautología y no contiene $\neg$ ni $\Rightarrow$. Esto restringe la gramática de $\alpha$ al siguiente fragmento sintáctico:


$$\tau ::= P \mid \bot \mid \tau \land \tau \mid \tau \lor \tau$$

Sea $v_F$ la valuación particular tal que asigna falso a todas las variables proposicionales (es decir, $v_F(P) = F$ para todo $P$).
Demostraremos por inducción estructural sobre el fragmento restringido que $v_F \not\vDash \tau$ para toda fórmula $\tau$:

* **Caso base ($P$):** Por definición de nuestra valuación, $v_F(P) = F$, por lo tanto $v_F \not\vDash P$.


* **Caso base ($\bot$):** Por definición de la semántica, $v_F \not\vDash \bot$ siempre.


* **Paso Inductivo ($\tau_1 \land \tau_2$):** Por hipótesis inductiva, $v_F \not\vDash \tau_1$ y $v_F \not\vDash \tau_2$. Como la conjunción requiere que se satisfagan ambas partes, $v_F \not\vDash \tau_1 \land \tau_2$.


* **Paso Inductivo ($\tau_1 \lor \tau_2$):** Por hipótesis inductiva, $v_F \not\vDash \tau_1$ y $v_F \not\vDash \tau_2$. Como la disyunción requiere que se satisfaga al menos una parte, $v_F \not\vDash \tau_1 \lor \tau_2$.

Queda demostrado que cualquier fórmula construida únicamente con variables, $\bot$, $\land$ y $\lor$ evaluará a falso bajo la valuación $v_F$. Como una tautología requiere evaluar a verdadero para *todas* las valuaciones posibles, es imposible construir una tautología en este fragmento. Por lo tanto, es obligatorio incluir al menos un $\neg$ o un $\Rightarrow$.

# Ejercicio 5

Para resolver el **Ejercicio 5** completo tal como se presenta en la guía, construiremos los árboles de derivación para cada teorema utilizando las reglas de la Deducción Natural. Salvo en el caso que se indique explícitamente, todas las demostraciones se realizarán en **Lógica Intuicionista (NJ)**, es decir, sin utilizar el Principio del Tercero Excluido (LEM), Reducción al Absurdo Clásico (PBC) ni Eliminación de la Doble Negación ($\neg\neg e$).

Para los teoremas que presentan una equivalencia ($\Leftrightarrow$), recordamos que esta notación es una abreviatura de la conjunción de las implicaciones en ambos sentidos: $(\alpha \Rightarrow \beta) \land (\beta \Rightarrow \alpha)$. Por lo tanto, se demostrarán ambas direcciones por separado ($\mathcal{D}_1$ y $\mathcal{D}_2$) y se unirán en la raíz aplicando la regla de introducción de la conjunción ($\land i$).

---

## I. Modus ponens relativizado: $\vdash (\rho \Rightarrow \sigma \Rightarrow \tau) \Rightarrow (\rho \Rightarrow \sigma) \Rightarrow \rho \Rightarrow \tau$

Definimos el contexto $\Gamma = \rho \Rightarrow \sigma \Rightarrow \tau, \rho \Rightarrow \sigma, \rho$.


$$\frac{ \frac{ \Gamma \vdash \rho \Rightarrow \sigma \Rightarrow \tau \ (\text{ax}) \quad \Gamma \vdash \rho \ (\text{ax}) }{ \Gamma \vdash \sigma \Rightarrow \tau } \Rightarrow e \quad \frac{ \Gamma \vdash \rho \Rightarrow \sigma \ (\text{ax}) \quad \Gamma \vdash \rho \ (\text{ax}) }{ \Gamma \vdash \sigma } \Rightarrow e }{ \frac{ \Gamma \vdash \tau }{ \frac{ \rho \Rightarrow \sigma \Rightarrow \tau, \rho \Rightarrow \sigma \vdash \rho \Rightarrow \tau }{ \frac{ \rho \Rightarrow \sigma \Rightarrow \tau \vdash (\rho \Rightarrow \sigma) \Rightarrow \rho \Rightarrow \tau }{ \vdash (\rho \Rightarrow \sigma \Rightarrow \tau) \Rightarrow (\rho \Rightarrow \sigma) \Rightarrow \rho \Rightarrow \tau } \Rightarrow i } \Rightarrow i } \Rightarrow i } \Rightarrow e$$

## II. Reducción al absurdo: $\vdash (\rho \Rightarrow \bot) \Rightarrow \neg\rho$

Definimos el contexto $\Gamma = \rho \Rightarrow \bot, \rho$.


$$\frac{ \frac{ \Gamma \vdash \rho \Rightarrow \bot \ (\text{ax}) \quad \Gamma \vdash \rho \ (\text{ax}) }{ \Gamma \vdash \bot } \Rightarrow e }{ \frac{ \rho \Rightarrow \bot \vdash \neg\rho }{ \vdash (\rho \Rightarrow \bot) \Rightarrow \neg\rho } \Rightarrow i } \neg i$$

## III. Introducción de la doble negación: $\vdash \rho \Rightarrow \neg\neg\rho$

Definimos el contexto $\Gamma = \rho, \neg\rho$.


$$\frac{ \frac{ \Gamma \vdash \neg\rho \ (\text{ax}) \quad \Gamma \vdash \rho \ (\text{ax}) }{ \Gamma \vdash \bot } \neg e }{ \frac{ \rho \vdash \neg\neg\rho }{ \vdash \rho \Rightarrow \neg\neg\rho } \Rightarrow i } \neg i$$

## IV. Eliminación de la triple negación: $\vdash \neg\neg\neg\rho \Rightarrow \neg\rho$

Definimos el contexto $\Gamma_1 = \neg\neg\neg\rho$ y $\Gamma_2 = \neg\neg\neg\rho, \rho$. Utilizaremos como lema intermedio el teorema III, demostrando $\neg\neg\rho$ a partir de $\rho$.


$$\frac{ \Gamma_2 \vdash \neg\neg\neg\rho \ (\text{ax}) \quad \frac{ \frac{ \Gamma_2, \neg\rho \vdash \neg\rho \ (\text{ax}) \quad \Gamma_2, \neg\rho \vdash \rho \ (\text{ax}) }{ \Gamma_2, \neg\rho \vdash \bot } \neg e }{ \Gamma_2 \vdash \neg\neg\rho } \neg i }{ \frac{ \Gamma_2 \vdash \bot }{ \frac{ \Gamma_1 \vdash \neg\rho }{ \vdash \neg\neg\neg\rho \Rightarrow \neg\rho } \Rightarrow i } \neg i } \neg e$$

## V. Contraposición: $\vdash (\rho \Rightarrow \sigma) \Rightarrow (\neg\sigma \Rightarrow \neg\rho)$

Definimos el contexto $\Gamma = \rho \Rightarrow \sigma, \neg\sigma, \rho$.


$$\frac{ \Gamma \vdash \neg\sigma \ (\text{ax}) \quad \frac{ \Gamma \vdash \rho \Rightarrow \sigma \ (\text{ax}) \quad \Gamma \vdash \rho \ (\text{ax}) }{ \Gamma \vdash \sigma } \Rightarrow e }{ \frac{ \Gamma \vdash \bot }{ \frac{ \rho \Rightarrow \sigma, \neg\sigma \vdash \neg\rho }{ \frac{ \rho \Rightarrow \sigma \vdash \neg\sigma \Rightarrow \neg\rho }{ \vdash (\rho \Rightarrow \sigma) \Rightarrow (\neg\sigma \Rightarrow \neg\rho) } \Rightarrow i } \Rightarrow i } \neg i } \neg e$$

## VI. Adjunción: $\vdash ((\rho \land \sigma) \Rightarrow \tau) \Leftrightarrow (\rho \Rightarrow \sigma \Rightarrow \tau)$

Se requieren dos derivaciones que luego se unen con $\land i$.

**Ida ($\mathcal{D}_1$):** $\vdash ((\rho \land \sigma) \Rightarrow \tau) \Rightarrow (\rho \Rightarrow \sigma \Rightarrow \tau)$
Con $\Gamma = (\rho \land \sigma) \Rightarrow \tau, \rho, \sigma$.


$$\frac{ \Gamma \vdash (\rho \land \sigma) \Rightarrow \tau \ (\text{ax}) \quad \frac{ \Gamma \vdash \rho \ (\text{ax}) \quad \Gamma \vdash \sigma \ (\text{ax}) }{ \Gamma \vdash \rho \land \sigma } \land i }{ \frac{ \Gamma \vdash \tau }{ \vdash \mathcal{D}_1 } \Rightarrow i \times 3 } \Rightarrow e$$


*(Nota: $\Rightarrow i \times 3$ indica la aplicación sucesiva de la introducción de la implicación para descargar las 3 hipótesis de $\Gamma$)*.

**Vuelta ($\mathcal{D}_2$):** $\vdash (\rho \Rightarrow \sigma \Rightarrow \tau) \Rightarrow ((\rho \land \sigma) \Rightarrow \tau)$
Con $\Gamma = \rho \Rightarrow \sigma \Rightarrow \tau, \rho \land \sigma$.


$$\frac{ \frac{ \Gamma \vdash \rho \Rightarrow \sigma \Rightarrow \tau \ (\text{ax}) \quad \frac{ \Gamma \vdash \rho \land \sigma \ (\text{ax}) }{ \Gamma \vdash \rho } \land e_1 }{ \Gamma \vdash \sigma \Rightarrow \tau } \Rightarrow e \quad \frac{ \Gamma \vdash \rho \land \sigma \ (\text{ax}) }{ \Gamma \vdash \sigma } \land e_2 }{ \frac{ \Gamma \vdash \tau }{ \vdash \mathcal{D}_2 } \Rightarrow i \times 2 } \Rightarrow e$$

## VII. de Morgan (I): $\vdash \neg(\rho \lor \sigma) \Leftrightarrow (\neg\rho \land \neg\sigma)$

**Ida ($\mathcal{D}_1$):** $\vdash \neg(\rho \lor \sigma) \Rightarrow (\neg\rho \land \neg\sigma)$
Sea $\Gamma_1 = \neg(\rho \lor \sigma)$. Demostramos $\neg\rho$ y $\neg\sigma$ por separado.


$$\frac{ \frac{ \Gamma_1, \rho \vdash \neg(\rho \lor \sigma) \ (\text{ax}) \quad \frac{ \Gamma_1, \rho \vdash \rho \ (\text{ax}) }{ \Gamma_1, \rho \vdash \rho \lor \sigma } \lor i_1 }{ \frac{ \Gamma_1, \rho \vdash \bot }{ \Gamma_1 \vdash \neg\rho } \neg i } \neg e \quad \frac{ \Gamma_1, \sigma \vdash \neg(\rho \lor \sigma) \ (\text{ax}) \quad \frac{ \Gamma_1, \sigma \vdash \sigma \ (\text{ax}) }{ \Gamma_1, \sigma \vdash \rho \lor \sigma } \lor i_2 }{ \frac{ \Gamma_1, \sigma \vdash \bot }{ \Gamma_1 \vdash \neg\sigma } \neg i } \neg e }{ \frac{ \Gamma_1 \vdash \neg\rho \land \neg\sigma }{ \vdash \neg(\rho \lor \sigma) \Rightarrow (\neg\rho \land \neg\sigma) } \Rightarrow i } \land i$$

**Vuelta ($\mathcal{D}_2$):** $\vdash (\neg\rho \land \neg\sigma) \Rightarrow \neg(\rho \lor \sigma)$
Sea $\Gamma_2 = \neg\rho \land \neg\sigma, \rho \lor \sigma$. Aplicamos eliminación de la disyunción ($\lor e$) sobre $\rho \lor \sigma$.


$$\frac{ \Gamma_2 \vdash \rho \lor \sigma \ (\text{ax}) \quad \frac{ \frac{ \Gamma_2 \vdash \neg\rho \land \neg\sigma \ (\text{ax}) }{ \Gamma_2, \rho \vdash \neg\rho } \land e_1 \quad \Gamma_2, \rho \vdash \rho \ (\text{ax}) }{ \Gamma_2, \rho \vdash \bot } \neg e \quad \frac{ \frac{ \Gamma_2 \vdash \neg\rho \land \neg\sigma \ (\text{ax}) }{ \Gamma_2, \sigma \vdash \neg\sigma } \land e_2 \quad \Gamma_2, \sigma \vdash \sigma \ (\text{ax}) }{ \Gamma_2, \sigma \vdash \bot } \neg e }{ \frac{ \Gamma_2 \vdash \bot }{ \vdash (\neg\rho \land \neg\sigma) \Rightarrow \neg(\rho \lor \sigma) } \Rightarrow i, \neg i } \lor e$$

## VIII. de Morgan (II): $\vdash \neg(\rho \land \sigma) \Leftrightarrow (\neg\rho \lor \neg\sigma)$

Como indica el enunciado, la dirección $\Rightarrow$ requiere lógica clásica (NK).

**Ida ($\mathcal{D}_1$ - Requiere Lógica Clásica):** $\vdash \neg(\rho \land \sigma) \Rightarrow (\neg\rho \lor \neg\sigma)$
Sea $\Gamma = \neg(\rho \land \sigma)$. Usaremos el principio LEM ($\vdash \tau \lor \neg\tau$) sobre $\rho$.


$$\frac{ \Gamma \vdash \rho \lor \neg\rho \ (\text{LEM}) \quad \mathcal{D}_{1a} \quad \frac{ \Gamma, \neg\rho \vdash \neg\rho \ (\text{ax}) }{ \Gamma, \neg\rho \vdash \neg\rho \lor \neg\sigma } \lor i_1 }{ \frac{ \Gamma \vdash \neg\rho \lor \neg\sigma }{ \vdash \neg(\rho \land \sigma) \Rightarrow (\neg\rho \lor \neg\sigma) } \Rightarrow i } \lor e$$


Donde la sub-derivación $\mathcal{D}_{1a}$ (asumiendo $\rho$) requiere otro LEM sobre $\sigma$:


$$\frac{ \Gamma, \rho \vdash \sigma \lor \neg\sigma \ (\text{LEM}) \quad \frac{ \Gamma, \rho, \sigma \vdash \neg(\rho \land \sigma) \ (\text{ax}) \quad \frac{ \Gamma, \rho, \sigma \vdash \rho \ (\text{ax}) \quad \Gamma, \rho, \sigma \vdash \sigma \ (\text{ax}) }{ \Gamma, \rho, \sigma \vdash \rho \land \sigma } \land i }{ \frac{ \Gamma, \rho, \sigma \vdash \bot }{ \Gamma, \rho, \sigma \vdash \neg\rho \lor \neg\sigma } \bot e } \neg e \quad \frac{ \Gamma, \rho, \neg\sigma \vdash \neg\sigma \ (\text{ax}) }{ \Gamma, \rho, \neg\sigma \vdash \neg\rho \lor \neg\sigma } \lor i_2 }{ \Gamma, \rho \vdash \neg\rho \lor \neg\sigma } \lor e$$

**Vuelta ($\mathcal{D}_2$ - Intuicionista):** $\vdash (\neg\rho \lor \neg\sigma) \Rightarrow \neg(\rho \land \sigma)$
Sea $\Gamma = \neg\rho \lor \neg\sigma, \rho \land \sigma$.


$$\frac{ \Gamma \vdash \neg\rho \lor \neg\sigma \ (\text{ax}) \quad \frac{ \Gamma, \neg\rho \vdash \neg\rho \ (\text{ax}) \quad \frac{ \Gamma, \neg\rho \vdash \rho \land \sigma \ (\text{ax}) }{ \Gamma, \neg\rho \vdash \rho } \land e_1 }{ \Gamma, \neg\rho \vdash \bot } \neg e \quad \frac{ \Gamma, \neg\sigma \vdash \neg\sigma \ (\text{ax}) \quad \frac{ \Gamma, \neg\sigma \vdash \rho \land \sigma \ (\text{ax}) }{ \Gamma, \neg\sigma \vdash \sigma } \land e_2 }{ \Gamma, \neg\sigma \vdash \bot } \neg e }{ \frac{ \Gamma \vdash \bot }{ \vdash (\neg\rho \lor \neg\sigma) \Rightarrow \neg(\rho \land \sigma) } \Rightarrow i, \neg i } \lor e$$

## IX. Conmutatividad ($\land$): $\vdash (\rho \land \sigma) \Rightarrow (\sigma \land \rho)$

Sea $\Gamma = \rho \land \sigma$.


$$\frac{ \frac{ \Gamma \vdash \rho \land \sigma \ (\text{ax}) }{ \Gamma \vdash \sigma } \land e_2 \quad \frac{ \Gamma \vdash \rho \land \sigma \ (\text{ax}) }{ \Gamma \vdash \rho } \land e_1 }{ \frac{ \Gamma \vdash \sigma \land \rho }{ \vdash (\rho \land \sigma) \Rightarrow (\sigma \land \rho) } \Rightarrow i } \land i$$

## X. Asociatividad ($\land$): $\vdash ((\rho \land \sigma) \land \tau) \Leftrightarrow (\rho \land (\sigma \land \tau))$

Ambas direcciones son análogas, aplicando desestructuración con $\land e_1$ y $\land e_2$ y rearmando con $\land i$.

**Ida:** $\Gamma = (\rho \land \sigma) \land \tau$.


$$\frac{ \frac{ \frac{ \Gamma \vdash (\rho \land \sigma) \land \tau \ (\text{ax}) }{ \Gamma \vdash \rho \land \sigma } \land e_1 }{ \Gamma \vdash \rho } \land e_1 \quad \frac{ \frac{ \frac{ \Gamma \vdash (\rho \land \sigma) \land \tau \ (\text{ax}) }{ \Gamma \vdash \rho \land \sigma } \land e_1 }{ \Gamma \vdash \sigma } \land e_2 \quad \frac{ \Gamma \vdash (\rho \land \sigma) \land \tau \ (\text{ax}) }{ \Gamma \vdash \tau } \land e_2 }{ \Gamma \vdash \sigma \land \tau } \land i }{ \frac{ \Gamma \vdash \rho \land (\sigma \land \tau) }{ \vdash ((\rho \land \sigma) \land \tau) \Rightarrow (\rho \land (\sigma \land \tau)) } \Rightarrow i } \land i$$


*(La vuelta se realiza extrayendo los tres elementos de forma espejada).*

## XI. Conmutatividad ($\lor$): $\vdash (\rho \lor \sigma) \Rightarrow (\sigma \lor \rho)$

Sea $\Gamma = \rho \lor \sigma$. Aplicamos $\lor e$.


$$\frac{ \Gamma \vdash \rho \lor \sigma \ (\text{ax}) \quad \frac{ \Gamma, \rho \vdash \rho \ (\text{ax}) }{ \Gamma, \rho \vdash \sigma \lor \rho } \lor i_2 \quad \frac{ \Gamma, \sigma \vdash \sigma \ (\text{ax}) }{ \Gamma, \sigma \vdash \sigma \lor \rho } \lor i_1 }{ \frac{ \Gamma \vdash \sigma \lor \rho }{ \vdash (\rho \lor \sigma) \Rightarrow (\sigma \lor \rho) } \Rightarrow i } \lor e$$

## XII. Asociatividad ($\lor$): $\vdash ((\rho \lor \sigma) \lor \tau) \Leftrightarrow (\rho \lor (\sigma \lor \tau))$

El árbol de la ida ($\Rightarrow$) requiere anidar dos reglas $\lor e$.
Sea $\Gamma = (\rho \lor \sigma) \lor \tau$.


$$\frac{ \Gamma \vdash (\rho \lor \sigma) \lor \tau \ (\text{ax}) \quad \mathcal{D}_{\rho \lor \sigma} \quad \frac{ \Gamma, \tau \vdash \tau \ (\text{ax}) }{ \frac{ \Gamma, \tau \vdash \sigma \lor \tau }{ \Gamma, \tau \vdash \rho \lor (\sigma \lor \tau) } \lor i_2 } \lor i_2 }{ \frac{ \Gamma \vdash \rho \lor (\sigma \lor \tau) }{ \vdash ((\rho \lor \sigma) \lor \tau) \Rightarrow (\rho \lor (\sigma \lor \tau)) } \Rightarrow i } \lor e$$


Donde $\mathcal{D}_{\rho \lor \sigma}$ resuelve el subcaso interno asumiendo $\rho \lor \sigma$:


$$\frac{ \Gamma, \rho \lor \sigma \vdash \rho \lor \sigma \ (\text{ax}) \quad \frac{ \Gamma, \rho \lor \sigma, \rho \vdash \rho \ (\text{ax}) }{ \Gamma, \rho \lor \sigma, \rho \vdash \rho \lor (\sigma \lor \tau) } \lor i_1 \quad \frac{ \Gamma, \rho \lor \sigma, \sigma \vdash \sigma \ (\text{ax}) }{ \frac{ \Gamma, \rho \lor \sigma, \sigma \vdash \sigma \lor \tau }{ \Gamma, \rho \lor \sigma, \sigma \vdash \rho \lor (\sigma \lor \tau) } \lor i_2 } \lor i_1 }{ \Gamma, \rho \lor \sigma \vdash \rho \lor (\sigma \lor \tau) } \lor e$$


*(La dirección de vuelta sigue la estructura exactamente simétrica).*

---

## Pregunta Final del Ejercicio 5:

> *¿Encuentra alguna relación entre teoremas de adjunción, asociatividad y conmutatividad con algunas de las propiedades demostradas en la práctica 2?*
> 

Sí, existe una relación directa fundamental a través del **Isomorfismo de Curry-Howard**. Las propiedades lógicas demostradas aquí se corresponden exactamente con las propiedades estructurales de los tipos en el Cálculo Lambda Tipado (vistos en la Práctica 2):

* **Adjunción ($(\rho \land \sigma) \Rightarrow \tau \Leftrightarrow \rho \Rightarrow \sigma \Rightarrow \tau$):** Se corresponde con el **Currying / Uncurrying** de funciones. Un tipo función que recibe una tupla $(A \times B) \to C$ es isomorfo a una función que devuelve otra función $A \to (B \to C)$.
* **Conmutatividad y Asociatividad de $\land$:** Se corresponden con los isomorfismos del **Producto Cartesiano** de tipos ($A \times B \cong B \times A$ y $(A \times B) \times C \cong A \times (B \times C)$).
* **Conmutatividad y Asociatividad de $\lor$:** Se corresponden con los isomorfismos de la **Unión Disjunta** (o tipos suma) ($A + B \cong B + A$ y $(A + B) + C \cong A + (B + C)$).

# Ejercicio 6

Para resolver el **Ejercicio 6**, es indispensable extender el sistema intuicionista incorporando los principios de la **Lógica Clásica (NK)**. En deducción natural, esto significa que podemos utilizar cualquiera de las tres reglas clásicas equivalentes: el Principio del Tercero Excluido (LEM: $\Gamma \vdash \tau \lor \neg\tau$), la Reducción al Absurdo Clásico (PBC: si $\Gamma, \neg\tau \vdash \bot$ entonces $\Gamma \vdash \tau$), o la Eliminación de la Doble Negación ($\neg\neg e$).

A continuación, se presentan los árboles de derivación construidos de abajo hacia arriba para cada uno de los teoremas.

### i. Absurdo clásico: $\vdash (\neg\tau \Rightarrow \bot) \Rightarrow \tau$

Para probar $\tau$, utilizamos la regla PBC asumiendo su negación ($\neg\tau$) con el objetivo de llegar a una contradicción ($\bot$).
Sea $\Gamma = \neg\tau \Rightarrow \bot, \neg\tau$.


$$\frac{ \Gamma \vdash \neg\tau \Rightarrow \bot \ (\text{ax}) \quad \Gamma \vdash \neg\tau \ (\text{ax}) }{ \frac{ \Gamma \vdash \bot }{ \frac{ \neg\tau \Rightarrow \bot \vdash \tau }{ \vdash (\neg\tau \Rightarrow \bot) \Rightarrow \tau } \Rightarrow i } \text{PBC} } \Rightarrow e$$

### ii. Ley de Peirce: $\vdash ((\tau \Rightarrow \rho) \Rightarrow \tau) \Rightarrow \tau$

Nuevamente usamos PBC sobre la conclusión final. Asumimos el antecedente principal y la negación de la tesis: $\Gamma_1 = (\tau \Rightarrow \rho) \Rightarrow \tau, \neg\tau$.
Para poder usar la hipótesis principal mediante $\Rightarrow e$, necesitamos probar la implicación $\tau \Rightarrow \rho$. Para ello, abrimos un subcontexto asumiendo transitoriamente $\tau$: sea $\Gamma_2 = \Gamma_1, \tau$.


$$\frac{ \Gamma_1 \vdash (\tau \Rightarrow \rho) \Rightarrow \tau \ (\text{ax}) \quad \frac{ \frac{ \Gamma_2 \vdash \tau \ (\text{ax}) \quad \Gamma_2 \vdash \neg\tau \ (\text{ax}) }{ \Gamma_2 \vdash \bot } \neg e }{ \frac{ \Gamma_2 \vdash \rho }{ \Gamma_1 \vdash \tau \Rightarrow \rho } \Rightarrow i } \bot e }{ \frac{ \Gamma_1 \vdash \tau \quad \Gamma_1 \vdash \neg\tau \ (\text{ax}) }{ \frac{ \Gamma_1 \vdash \bot }{ \frac{ (\tau \Rightarrow \rho) \Rightarrow \tau \vdash \tau }{ \vdash ((\tau \Rightarrow \rho) \Rightarrow \tau) \Rightarrow \tau } \text{PBC} } \Rightarrow i } \neg e } \Rightarrow e$$

### iii. Tercero excluido: $\vdash \tau \lor \neg\tau$

Como el objetivo del inciso es *demostrar* el principio LEM en sí mismo, no podemos usarlo como axioma. Lo demostramos usando PBC asumiendo la negación de toda la disyunción.
Sea $\Gamma = \neg(\tau \lor \neg\tau)$.


$$\frac{ \frac{ \frac{ \frac{ \Gamma, \tau \vdash \tau \ (\text{ax}) }{ \Gamma, \tau \vdash \tau \lor \neg\tau } \lor i_1 \quad \Gamma, \tau \vdash \neg(\tau \lor \neg\tau) \ (\text{ax}) }{ \Gamma, \tau \vdash \bot } \neg e }{ \Gamma \vdash \neg\tau } \neg i }{ \frac{ \Gamma \vdash \tau \lor \neg\tau } \lor i_2 \quad \Gamma \vdash \neg(\tau \lor \neg\tau) \ (\text{ax}) }{ \frac{ \Gamma \vdash \bot }{ \vdash \tau \lor \neg\tau } \text{PBC} } \neg e$$

### iv. Consecuencia milagrosa: $\vdash (\neg\tau \Rightarrow \tau) \Rightarrow \tau$

Aplicamos PBC asumiendo $\neg\tau$ para forzar una contradicción utilizando la propia implicación dada.
Sea $\Gamma = \neg\tau \Rightarrow \tau, \neg\tau$.


$$\frac{ \frac{ \Gamma \vdash \neg\tau \Rightarrow \tau \ (\text{ax}) \quad \Gamma \vdash \neg\tau \ (\text{ax}) }{ \Gamma \vdash \tau } \Rightarrow e \quad \Gamma \vdash \neg\tau \ (\text{ax}) }{ \frac{ \Gamma \vdash \bot }{ \frac{ \neg\tau \Rightarrow \tau \vdash \tau }{ \vdash (\neg\tau \Rightarrow \tau) \Rightarrow \tau } \text{PBC} } \Rightarrow i } \neg e$$

### v. Contraposición clásica: $\vdash (\neg\rho \Rightarrow \neg\tau) \Rightarrow (\tau \Rightarrow \rho)$

Desarmamos ambas implicaciones asumiendo los antecedentes por $\Rightarrow i$. Para probar $\rho$, usamos PBC asumiendo $\neg\rho$.
Sea $\Gamma = \neg\rho \Rightarrow \neg\tau, \tau, \neg\rho$.


$$\frac{ \Gamma \vdash \tau \ (\text{ax}) \quad \frac{ \Gamma \vdash \neg\rho \Rightarrow \neg\tau \ (\text{ax}) \quad \Gamma \vdash \neg\rho \ (\text{ax}) }{ \Gamma \vdash \neg\tau } \Rightarrow e }{ \frac{ \Gamma \vdash \bot }{ \frac{ \neg\rho \Rightarrow \neg\tau, \tau \vdash \rho }{ \frac{ \neg\rho \Rightarrow \neg\tau \vdash \tau \Rightarrow \rho }{ \vdash (\neg\rho \Rightarrow \neg\tau) \Rightarrow (\tau \Rightarrow \rho) } \Rightarrow i } \Rightarrow i } \text{PBC} } \neg e$$

### vi. Análisis de casos: $\vdash (\tau \Rightarrow \rho) \Rightarrow (\neg\tau \Rightarrow \rho) \Rightarrow \rho$

Aquí es directo utilizar el principio LEM ya demostrado ($\vdash \tau \lor \neg\tau$) para bifurcar el árbol con la regla de eliminación de la disyunción ($\lor e$).
Sea $\Gamma = \tau \Rightarrow \rho, \neg\tau \Rightarrow \rho$.


$$\frac{ \Gamma \vdash \tau \lor \neg\tau \ (\text{LEM}) \quad \frac{ \Gamma, \tau \vdash \tau \Rightarrow \rho \ (\text{ax}) \quad \Gamma, \tau \vdash \tau \ (\text{ax}) }{ \Gamma, \tau \vdash \rho } \Rightarrow e \quad \frac{ \Gamma, \neg\tau \vdash \neg\tau \Rightarrow \rho \ (\text{ax}) \quad \Gamma, \neg\tau \vdash \neg\tau \ (\text{ax}) }{ \Gamma, \neg\tau \vdash \rho } \Rightarrow e }{ \frac{ \Gamma \vdash \rho }{ \vdash (\tau \Rightarrow \rho) \Rightarrow (\neg\tau \Rightarrow \rho) \Rightarrow \rho } \Rightarrow i \times 2 } \lor e$$

### vii. Implicación vs. disyunción: $\vdash (\tau \Rightarrow \rho) \Leftrightarrow (\neg\tau \lor \rho)$

Se demuestra la conjunción de las implicaciones bidireccionales ($\mathcal{D}_1 \land \mathcal{D}_2$). La ida requiere lógica clásica (LEM), mientras que la vuelta es derivable en lógica intuicionista.

**Ida ($\mathcal{D}_1$): $\vdash (\tau \Rightarrow \rho) \Rightarrow (\neg\tau \lor \rho)$**
Sea $\Gamma = \tau \Rightarrow \rho$. Usamos LEM sobre $\tau$.


$$\frac{ \Gamma \vdash \tau \lor \neg\tau \ (\text{LEM}) \quad \frac{ \frac{ \Gamma, \tau \vdash \tau \Rightarrow \rho \ (\text{ax}) \quad \Gamma, \tau \vdash \tau \ (\text{ax}) }{ \Gamma, \tau \vdash \rho } \Rightarrow e }{ \Gamma, \tau \vdash \neg\tau \lor \rho } \lor i_2 \quad \frac{ \Gamma, \neg\tau \vdash \neg\tau \ (\text{ax}) }{ \Gamma, \neg\tau \vdash \neg\tau \lor \rho } \lor i_1 }{ \frac{ \Gamma \vdash \neg\tau \lor \rho }{ \vdash (\tau \Rightarrow \rho) \Rightarrow (\neg\tau \lor \rho) } \Rightarrow i } \lor e$$

**Vuelta ($\mathcal{D}_2$): $\vdash (\neg\tau \lor \rho) \Rightarrow (\tau \Rightarrow \rho)$**
Sea $\Gamma = \neg\tau \lor \rho, \tau$. Aplicamos $\lor e$ sobre el axioma.


$$\frac{ \Gamma \vdash \neg\tau \lor \rho \ (\text{ax}) \quad \frac{ \frac{ \Gamma, \neg\tau \vdash \tau \ (\text{ax}) \quad \Gamma, \neg\tau \vdash \neg\tau \ (\text{ax}) }{ \Gamma, \neg\tau \vdash \bot } \neg e }{ \Gamma, \neg\tau \vdash \rho } \bot e \quad \Gamma, \rho \vdash \rho \ (\text{ax}) }{ \frac{ \Gamma \vdash \rho }{ \vdash (\neg\tau \lor \rho) \Rightarrow (\tau \Rightarrow \rho) } \Rightarrow i \times 2 } \lor e$$

**Ensamblaje:** Ambas derivaciones se unen en la raíz con $\land i$ para completar el bicondicional.


$$\frac{ \vdash \mathcal{D}_1 \quad \vdash \mathcal{D}_2 }{ \vdash (\tau \Rightarrow \rho) \Leftrightarrow (\neg\tau \lor \rho) } \land i$$