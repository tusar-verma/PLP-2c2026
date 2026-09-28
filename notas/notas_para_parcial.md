# Prácticas 3 y 4 — PLP

## PARTE I: Deducción Natural y Lógica Proposicional (Práctica 3)

### 1. Mapa Conceptual: Sintaxis vs. Semántica

-   **Fórmulas bien formadas ($\varphi \text{ form}$):** Nivel puramente sintáctico.
    
      
    
-   **Derivabilidad Sintáctica ($\Gamma \vdash \tau$):** Existe un árbol de derivación finito usando reglas de inferencia (en **NJ** intuicionista o **NK** clásica) cuya conclusión es $\Gamma \vdash \tau$ y cuyas hojas son axiomas. Un **teorema** es una fórmula derivable en contexto vacío ($\vdash \tau$).
    
      
    
-   **Consecuencia Semántica ($\Gamma \vDash \tau$):** Para toda valuación $v : \mathcal{P} \to \{V, F\}$, si $v$ satisface todas las fórmulas de $\Gamma$, entonces $v \vDash \tau$.
    
      
    
-   **Teoremas Puente (en NK):**
    
      
    -   **Correctitud (_Soundness_):** $\Gamma \vdash \tau \implies \Gamma \vDash \tau$ (todo lo demostrable por reglas es semánticamente verdadero).
        
          
        
    -   **Completitud (_Completeness_):** $\Gamma \vDash \tau \implies \Gamma \vdash \tau$ (toda verdad semántica tiene un árbol de derivación en NK).
        
          
        

### 2. Reglas de Inferencia: Intuicionista (NJ) vs. Clásica (NK)

(Abreviatura: $\alpha \Leftrightarrow \beta \stackrel{\text{def}}{=} (\alpha \Rightarrow \beta) \land (\beta \Rightarrow \alpha)$. Para probar $\Leftrightarrow$, probar ambas implicaciones y unir con $\land i$).

  

**Sistema Intuicionista (NJ / LJ):**

  

$$\frac{\tau \in \Gamma}{\Gamma \vdash \tau}\;(\text{ax}) \qquad \frac{\Gamma \vdash \tau \quad \Gamma \vdash \sigma}{\Gamma \vdash \tau \land \sigma}\;(\land i) \qquad \frac{\Gamma \vdash \tau \land \sigma}{\Gamma \vdash \tau}\;(\land e_1) \qquad \frac{\Gamma \vdash \tau \land \sigma}{\Gamma \vdash \sigma}\;(\land e_2)$$

$$\frac{\Gamma, \tau \vdash \sigma}{\Gamma \vdash \tau \Rightarrow \sigma}\;(\Rightarrow i) \qquad \frac{\Gamma \vdash \tau \Rightarrow \sigma \quad \Gamma \vdash \tau}{\Gamma \vdash \sigma}\;(\Rightarrow e) \qquad \frac{\Gamma \vdash \tau}{\Gamma \vdash \tau \lor \sigma}\;(\lor i_1) \qquad \frac{\Gamma \vdash \sigma}{\Gamma \vdash \tau \lor \sigma}\;(\lor i_2)$$

$$\frac{\Gamma \vdash \tau \lor \sigma \quad \Gamma, \tau \vdash \rho \quad \Gamma, \sigma \vdash \rho}{\Gamma \vdash \rho}\;(\lor e) \qquad \frac{\Gamma, \tau \vdash \bot}{\Gamma \vdash \neg\tau}\;(\neg i) \qquad \frac{\Gamma \vdash \tau \quad \Gamma \vdash \neg\tau}{\Gamma \vdash \bot}\;(\neg e) \qquad \frac{\Gamma \vdash \bot}{\Gamma \vdash \tau}\;(\bot e)$$

**Reglas Derivadas en NJ (Válidas sin lógica clásica):**


$$\frac{\Gamma \vdash \tau}{\Gamma \vdash \neg\neg\tau}\;(\neg\neg i) \qquad \frac{\Gamma \vdash \tau \Rightarrow \sigma \quad \Gamma \vdash \neg\sigma}{\Gamma \vdash \neg\tau}\;(\text{MT - Modus Tollens})$$

Extensión Clásica (NK / LK) — Las 3 reglas son equivalentes entre sí:

  

$$\frac{\Gamma \vdash \neg\neg\tau}{\Gamma \vdash \tau}\;(\neg\neg e) \qquad \frac{\Gamma, \neg\tau \vdash \bot}{\Gamma \vdash \tau}\;(\text{PBC}) \qquad \frac{}{\Gamma \vdash \tau \lor \neg\tau}\;(\text{LEM})$$

-   **Regla derivada clásica útil (Análisis de casos):** Si $\Gamma \vdash \tau \Rightarrow \sigma$ y $\Gamma \vdash \neg\tau \Rightarrow \sigma$, entonces $\Gamma \vdash \sigma$ (sale por $\lor e$ sobre $\text{LEM}: \Gamma \vdash \tau \lor \neg\tau$).
    
      
    

### 3. Derivaciones Clave y Patrones de Resolución (Práctica 3)

-   **Eliminación de la triple negación (en NJ): $\vdash \neg\neg\neg\rho \Rightarrow \neg\rho$**
    
      
    
      
    -   _Idea:_ Asumir $\Gamma_2 = \neg\neg\neg\rho, \rho$. Con $\neg i$ (asumiendo $\neg\rho$) probar $\Gamma_2 \vdash \neg\neg\rho$ (que es $\neg\neg i$). Cruzar $\Gamma_2 \vdash \neg\neg\neg\rho$ con $\Gamma_2 \vdash \neg\neg\rho$ vía $\neg e$ para obtener $\bot$, cerrar $\neg\rho$ con $\neg i$ y concluir con $\Rightarrow i$.
        
          
        
-   **Ley de Peirce (en NK): $\vdash ((\tau \Rightarrow \rho) \Rightarrow \tau) \Rightarrow \tau$**
    
      
    
      
    -   _Idea (Trampa clásica):_ Asumir $\Gamma_1 = (\tau \Rightarrow \rho) \Rightarrow \tau, \neg\tau$ (por PBC). Para usar la hipótesis principal necesitamos fabricar $\Gamma_1 \vdash \tau \Rightarrow \rho$. Asumimos $\tau$ ($\Gamma_2 = \Gamma_1, \tau$), chocamos $\tau$ y $\neg\tau$ con $\neg e$ para dar $\bot$, y aplicamos **$\bot e$ para inventar $\rho$** ($\Gamma_2 \vdash \rho$). Cerramos $\Rightarrow i$ obteniendo $\Gamma_1 \vdash \tau \Rightarrow \rho$, aplicamos $\Rightarrow e$ para obtener $\tau$, chocamos con $\neg\tau$ y cerramos PBC.
        
          
        
-   **Tercero Excluido demostrado desde PBC (en NK): $\vdash \tau \lor \neg\tau$**
    
      
    
      
    -   _Idea:_ No usar LEM como axioma. Asumir $\Gamma = \neg(\tau \lor \neg\tau)$ por PBC. Adentro, asumir $\tau$, inyectar $\tau \lor \neg\tau$ con $\lor i_1$, chocar con $\Gamma$ ($\neg e$) dando $\bot$, y **descargar $\tau$ con $\neg i$ para obtener $\Gamma \vdash \neg\tau$**. Ahora inyectar $\neg\tau$ en $\tau \lor \neg\tau$ con $\lor i_2$, volver a chocar con $\Gamma$ ($\neg e$) dando $\bot$, y cerrar PBC descargando $\neg(\tau \lor \neg\tau)$.
        
          
        
-   **De Morgan Intuicionista vs. Clásica:**
    
      
    -   En **NJ** valen: $\neg(P \lor Q) \Leftrightarrow (\neg P \land \neg Q)$ y $(\neg P \lor \neg Q) \Rightarrow \neg(P \land Q)$ (ver pizarrón: $P \lor Q \vdash \neg(\neg P \land \neg Q)$ sale por $\neg i$ y luego $\lor e$).
        
          
        
    -   En **NK** (requiere PBC/LEM): $\neg(P \land Q) \Rightarrow (\neg P \lor \neg Q)$ y $(\tau \Rightarrow \sigma) \Rightarrow (\neg\tau \lor \sigma)$.
        
          
        

### 4. Meta-Teoremas e Inducciones de la Práctica 3

#### A. Propiedad de Sin Implicación ni Negación (Ej. 4)

-   **Enunciado:** Toda tautología contiene al menos un $\neg$ o una $\Rightarrow$.
    
      
    
-   **Demostración:** Si no tiene $\neg$ ni $\Rightarrow$, pertenece a la gramática $\phi ::= P \mid \bot \mid \phi_1 \land \phi_2 \mid \phi_1 \lor \phi_2$. Tomamos la valuación constantemente falsa $v_F(P) = F$ para toda variable $P$. Por **inducción estructural en $\phi$**, se prueba que $v_F \not\vDash \phi$ siempre (Casos base: $v_F(P)=F$ y $v_F \not\vDash \bot$; Casos inductivos: en $\phi_1 \land \phi_2$ y $\phi_1 \lor \phi_2$, por HI ambos subtérminos son falsos bajo $v_F$, luego la conjunción y disyunción también son falsas). Como existe una valuación que la hace falsa, $\phi$ no puede ser tautología.
    
      
    

#### B. Lema de Debilitamiento / _Weakening_ (Ej. 7)

-   **Enunciado:** Si $\Gamma \vdash \sigma$ es válido, entonces $\Gamma, \tau \vdash \sigma$ es válido.
    
      
    
-   **Demostración:** Por **inducción estructural sobre la derivación** de $\Gamma \vdash \sigma$.
    
      
    -   _Caso base (`ax`):_ Si $\sigma \in \Gamma$, entonces $\sigma \in \Gamma \cup \{\tau\}$, por lo que $\Gamma, \tau \vdash \sigma$ sale por `ax`.
        
          
        
    -   _Casos inductivos:_ En reglas que no extienden el contexto ($\land i, \land e, \Rightarrow e, \lor i, \neg e, \bot e$), se aplica HI a cada premisa y se vuelve a aplicar la misma regla. En reglas con ligadores de hipótesis ($\Rightarrow i, \neg i, \lor e, \text{PBC}$), por ejemplo $\Rightarrow i$ con premisa $\Gamma, \alpha \vdash \beta$, la HI da $\Gamma, \alpha, \tau \vdash \beta$ (que como conjuntos es igual a $\Gamma, \tau, \alpha \vdash \beta$) y aplicando $\Rightarrow i$ se obtiene $\Gamma, \tau \vdash \alpha \Rightarrow \beta$.
        
          
        

#### C. Teorema de la Deducción Generalizado (Ej. 8)

-   **Enunciado:** Dadas $([] \Rightarrow^* \sigma) = \sigma$ y $([\tau_1, \dots, \tau_n] \Rightarrow^* \sigma) = \tau_1 \Rightarrow ([\tau_2, \dots, \tau_n] \Rightarrow^* \sigma)$, probar por inducción en $n$ que $\tau_1, \dots, \tau_n \vdash \sigma \iff \vdash [\tau_1, \dots, \tau_n] \Rightarrow^* \sigma$.
    
      
    
-   **Demostración (por inducción en $n \ge 0$):**
    
      
    -   _Caso base ($n=0$):_ $\vdash \sigma \iff \vdash ([] \Rightarrow^* \sigma) = \sigma$, trivial por definición.
        
          
        
    -   _Paso inductivo ($n \to n+1$):_ Queremos ver que $\tau_1, \tau_2, \dots, \tau_{n+1} \vdash \sigma \iff \vdash \tau_1 \Rightarrow ([\tau_2, \dots, \tau_{n+1}] \Rightarrow^* \sigma)$. Por HI (aplicada a los $n$ elementos $\tau_2, \dots, \tau_{n+1}$ con contexto base $\{\tau_1\}$), sabemos que $\tau_1, \tau_2, \dots, \tau_{n+1} \vdash \sigma \iff \tau_1 \vdash [\tau_2, \dots, \tau_{n+1}] \Rightarrow^* \sigma$. Luego: $(\Rightarrow)$ Si vale $\tau_1 \vdash [\tau_2, \dots, \tau_{n+1}] \Rightarrow^* \sigma$, aplicando una vez la regla $\Rightarrow i$ obtenemos $\vdash \tau_1 \Rightarrow ([\tau_2, \dots, \tau_{n+1}] \Rightarrow^* \sigma)$. $(\Leftarrow)$ Recíprocamente, si vale $\vdash \tau_1 \Rightarrow ([\tau_2, \dots, \tau_{n+1}] \Rightarrow^* \sigma)$, por _Weakening_ vale en el contexto $\{\tau_1\}$, y aplicando $\Rightarrow e$ con $\tau_1 \vdash \tau_1$ (`ax`) recuperamos $\tau_1 \vdash [\tau_2, \dots, \tau_{n+1}] \Rightarrow^* \sigma$.
        
          
        

## PARTE II: Cálculo-$\lambda$ Tipado, Semántica y Propiedades (Práctica 4)

### 1. Sustitución Libre de Captura y $\alpha$-Equivalencia

-   **$\alpha$-equivalencia ($=_\alpha$):** Congruencia generada por el axioma: si $y \notin \text{fv}(M)$, entonces $\lambda x.M =_\alpha \lambda y.M\{x := y\}$. Identificamos términos módulo $=_\alpha$.
    
      
    
-   **Convención de Barendregt:** En toda definición o demostración asumimos que las variables ligadas se eligen frescas (distintas de las variables libres en juego).
    
      
    
-   **Lema de Conmutación de Sustituciones (Ej. 6):** Si $x \notin \text{fv}(P)$ y $x \neq y$, entonces:
    
      
    
    $$M\{x := N\}\{y := P\} = M\{y := P\}\{x := N\{y := P\}\}$$
    
    -   _Contraejemplo cuando $x \in \text{fv}(P)$ (Ej. 6.b):_ Tomando $M = y$, $N = \text{true}$, $P = x$:
        
          
        -   Lado izquierdo: $y\{x := \text{true}\}\{y := x\} = y\{y := x\} = x$.
            
              
            
        -   Lado derecho: $y\{y := x\}\{x := \text{true}\{y := x\}\} = x\{x := \text{true}\} = \text{true} \neq x$.
            
              
            

### 2. Propiedades Sintácticas del Sistema de Tipos ($\lambda^{\text{Bool,Nat}}$)

1.  **Unicidad de Tipos:** Si $\Gamma \vdash M : \tau_1$ y $\Gamma \vdash M : \tau_2$, entonces $\tau_1 = \tau_2$.
    
      
    -   _Justificación:_ El sistema es **dirigido por la sintaxis** (hay exactamente una regla de tipado por cada constructor sintáctico de términos) y las abstracciones e inyecciones/listas vacías tienen sus tipos explícitamente anotados ($\lambda x:\tau.M$, $[]_\tau$, $\text{left}_\tau(M)$).
        
          
        
2.  **No Tipabilidad de la Auto-aplicación ($\lambda x : \tau. x~x$):**
    
      
    
      
    -   _Demostración:_ Para tipar $\lambda x : \tau. x~x$, por inversión de `T-Abs` necesitaríamos $x : \tau \vdash x~x : \rho$. Por inversión de `T-App`, el lado izquierdo $x$ debe tener tipo funcional $\tau = \sigma \to \rho$, mientras que el argumento derecho $x$ debe tener tipo $\tau = \sigma$. Eso exige $\sigma \to \rho = \sigma$, imposible para expresiones finitas de tipos.
        
          
        
3.  **Lema de Debilitamiento (_Weakening_) y Fortalecimiento (_Strengthening_):**
    
      
    -   _Weakening:_ Si $\Gamma \vdash M : \tau$ y $x \notin \text{dom}(\Gamma)$, entonces $\Gamma, x : \sigma \vdash M : \tau$.
        
          
        
    -   _Strengthening:_ Si $\Gamma, x : \sigma \vdash M : \tau$ y $x \notin \text{fv}(M)$, entonces $\Gamma \vdash M : \tau$.
        
          
        
4.  **Lema de Sustitución (Ej. 12 — Fundamental para Preservación de Tipos):**
    
      
    -   **Enunciado:** Si $\Gamma, x : \sigma \vdash M : \tau$ y $\Gamma \vdash N : \sigma$, entonces $\Gamma \vdash M\{x := N\} : \tau$.
        
          
        
    -   _Demostración:_ Por **inducción en la estructura de $M$** (o en la derivación de $\Gamma, x:\sigma \vdash M:\tau$). En el caso variable $M = x$, $x\{x:=N\} = N$ y por unicidad en el contexto $\tau = \sigma$, lo que coincide con $\Gamma \vdash N : \sigma$. En $M = y \neq x$, sale por _Strengthening_. En constructores con ligadores ($\lambda y:\rho.M_1$, `case`, `foldr`), por Barendregt $y \neq x$ y $y \notin \text{fv}(N)$, se aplica _Weakening_ a $\Gamma \vdash N : \sigma$ para sumar $y:\rho$, luego HI y se reconstruye con la misma regla de tipado.
        
          
        

### 3. Conceptos Clave de Semántica Operacional (_Small-Step_)

-   **Programa:** Término **cerrado** ($\text{fv}(M) = \emptyset$) y **tipable en el contexto vacío** ($\vdash M : \tau$).
    
      
    -   _¿Por qué contexto vacío?_ Porque una variable libre $x$ no es un valor ni tiene regla de reducción ($x \not\to$); si hubiera variables libres, el cómputo se trabaría al necesitar inspeccionarlas (fallaría Progreso).
        
          
        
-   **Reglas de Congruencia vs. Reglas de Cómputo:**
    
      
    -   **Congruencia ("dicen dónde trabajar"):** Tienen premisas $M \to M'$ arriba de la línea. Fijan el **orden de evaluación** metiéndose adentro de un subtérmino mientras el constructor externo se mantiene igual.
        
          
        -   _Regla de oro para crearlas:_ Van en todos los argumentos de **constructores de valores** ($\text{succ}$, $\langle M, N\rangle$, `left`, `::`, $\bullet$) secuenciados con valores $V$ de izquierda a derecha; y en los **eliminadores/operadores** (`if`, `case`, `foldr`, $\pi_i$, `próximo`), van **únicamente en el subtérmino inspeccionado** (el que necesita volverse valor en la regla de cómputo). **Nunca** se pone congruencia en ramas alternativas (`then`/`else`/ramas de `case`) ni debajo de ligadores ($\lambda$, variables ligadas de `case`, `foldr` o comprensión).
            
              
            
    -   **Cómputo ("hacen el trabajo"):** Son axiomas (sin premisas $\to$ arriba). Actúan cuando los subtérminos necesarios ya son valores $V$, destruyendo o transformando el constructor para dar un paso de cálculo hacia otro término.
        
          
        

### 4. Las 5 Propiedades Fundamentales y Sus Moldes de Demostración

**Propiedad**

**Enunciado Formal**

**¿Sobre qué árbol se hace Inducción?**

**Lema / Herramienta Estrella**

**1. Determinismo**

Si $M \to N_1$ y $M \to N_2$, entonces $N_1 = N_2$. _(Ojo: en $\twoheadrightarrow$ NO vale si no son formas normales, ej. Ej. 17.b)_.

  

Árbol de evaluación de un paso **$M \to N_1$**.

**Lema: Todo valor $V$ está en forma normal ($V \not\to$)**. Descarta solapamiento entre congruencia y cómputo.

**2. Preservación (_Subject Reduction_)**

Si $\Gamma \vdash M : \rho$ y $M \to N$, entonces $\Gamma \vdash N : \rho$.

  

Árbol de evaluación **$M \to N$**.

**Inversión de Tipado** sobre $\Gamma \vdash M : \rho$ + **HI** (en congruencia) o **Lema de Sustitución** (en cómputo con ligadores).

**3. Progreso (_Progress_)**

Si $\vdash M : \rho$ (cerrado), entonces $M \in \mathcal{V}$ o $\exists N.\, M \to N$. _(No hay términos de error)_.

  

Árbol de tipado **$\vdash M : \rho$**.

**Lema de Formas Canónicas:** El tipo de un valor cerrado $\vdash V : \rho$ determina su forma sintáctica exacta.

**4. Canonicidad (_Type Safety_)**

Si $\vdash M : \rho$ y $M \twoheadrightarrow F$ con $F$ en forma normal, entonces $F$ es un valor de tipo $\rho$.

Sale directo combinando **Determinismo + Preservación + Progreso**.

_"Well-typed programs cannot go wrong"_.

**5. Terminación (_Normalización_)**

Si $\vdash M : \rho$, no existe cadena infinita $M \to M_1 \to M_2 \to \dots$

Método de reducibilidad de Tait (no se pide probar en el examen).

Vale en $\lambda$ simplemente tipado **sin `fix`** (por eso no es Turing-completo). **Con `fix` se pierde Terminación**, pero se mantienen Determinismo, Preservación y Progreso.

> **Nota crítica para el examen:**
> 
>   
> 
> -   **Terminación $\neq$ Progreso:** En $\lambda^{\text{Bool,Nat}}$ _sin_ la regla $\text{pred(zero)} \to \text{zero}$, el término $\text{pred(zero)}$ frena en 0 pasos: **cumple Terminación, pero rompe Progreso** (es un _término de error_: forma normal cerrada y bien tipada que no es valor).
>     
>       
>     
> -   **Modularidad al extender el lenguaje:** Al probar Determinismo, Preservación y Progreso para una extensión (Pares, Sumas, Listas, Colas), **solo hace falta probar los casos de las reglas nuevas** (asumiendo que el lenguaje base ya cumple las propiedades con $\text{pred(zero)} \to \text{zero}$) porque:
>     
>       
>     1.  Las reglas nuevas de reducción tienen constructores nuevos en la raíz (no reducen valores viejos).
>         
>           
>         
>     2.  El tipado sigue teniendo una única regla por constructor.
>         
>           
>         
>     3.  Los **nuevos valores** solo habitan **tipos nuevos**, por lo que los Lemas de Formas Canónicas de los tipos viejos (`Bool`, `Nat`, $\sigma \to \tau$) permanecen intactos.
>         
>           
>         

### 5. Caso Especial: Reducir bajo $\lambda$ — La Regla $\zeta$ (Ejercicio 19)

Si agregamos la regla de congruencia $\zeta$: $\dfrac{M \to N}{\lambda x : \tau. M \to \lambda x : \tau. N}$:

  

1.  **Problema con los valores:** Con la definición vieja de valores ($V ::= \lambda x:\sigma. M \mid \dots$), una abstracción como $\lambda x:\text{Bool}. (\lambda y:\text{Bool}. y)~\text{true}$ sería valor pero reduciría con $\zeta$, rompiendo que los valores estén en forma normal y **rompiendo el determinismo** en $(\lambda x:\sigma. M)V_2$ (competirían reducir $M$ por $\zeta$ vs. hacer $\beta$-reducción).
    
      
    
2.  **Solución para recuperar el determinismo (Ej. 19.a y 19.b):**
    
      
    
      
    -   Redefinir valores exigiendo que el cuerpo esté en **forma normal $F$**: $V ::= \text{true} \mid \text{false} \mid \lambda x : \sigma. F \mid \text{zero} \mid \text{succ}(V)$.
        
          
        
    -   Restringir la regla $\beta$ a funciones cuyo cuerpo ya sea forma normal: $(\lambda x : \sigma. F)V \to F\{x := V\}$.
        
          
        
3.  **¿Por qué es mala idea agregar $\zeta$? (Ej. 19.c):**
    
      
    
      
    -   Porque obliga a evaluar el cuerpo de una función **antes** de conocer su argumento (con $x$ libre).
        
          
        
    -   En expresiones como $(\lambda x : \text{Nat} \to \text{Nat}.\, x~\underline{23})~(\lambda x : \text{Nat}.\, \text{pred(succ(zero))})$, o más aún si el cuerpo tiene algo que depende de la variable ligada como $\lambda z : \text{Nat}.\, \text{pred}(z)$, adentro del $\lambda$ quedan formas normales trabadas con variables libres (como $\text{pred}(z)$) o se pierde la noción de evaluación _call-by-value_ eficiente, y si hubiera `fix` adentro de una función no llamada, colgaría el programa antes de aplicarla.
        
          
        

### 6. Catálogo Completo de Extensiones (Ejercicios 20 a 27)

  

  

#### A. Pares / Productos $\sigma \times \tau$ (Ejercicio 20)

  

  

-   **Sintaxis y Valores:** $M ::= \dots \mid \langle M, N \rangle \mid \pi_1(M) \mid \pi_2(M)$ $\quad\mid\quad$ **$V ::= \dots \mid \langle V_1, V_2 \rangle$**.
    
      
    
-   **Tipado:**
    
      
    
    $$\frac{\Gamma \vdash M : \sigma \quad \Gamma \vdash N : \tau}{\Gamma \vdash \langle M, N \rangle : \sigma \times \tau}\;(\text{T-Pair}) \qquad \frac{\Gamma \vdash M : \sigma \times \tau}{\Gamma \vdash \pi_1(M) : \sigma}\;(\text{T-Proj1}) \qquad \frac{\Gamma \vdash M : \sigma \times \tau}{\Gamma \vdash \pi_2(M) : \tau}\;(\text{T-Proj2})$$
    
-   **Semántica Operacional (4 de congruencia + 2 de cómputo):**
    
      
    
    $$\frac{M \to M'}{\langle M, N \rangle \to \langle M', N \rangle}\;(\text{E-Pair1}) \quad \frac{N \to N'}{\langle V_1, N \rangle \to \langle V_1, N' \rangle}\;(\text{E-Pair2}) \quad \frac{M \to M'}{\pi_i(M) \to \pi_i(M')}\;(\text{E-Proj}_i) \quad \pi_i(\langle V_1, V_2 \rangle) \to V_i\;(\text{E-ProjBeta}_i)$$
    

  

  

#### B. Uniones Disjuntas / Sumas $\sigma + \tau$ (Ejercicio 21)

  

  

-   **Sintaxis y Valores:** $M ::= \dots \mid \text{left}_\tau(M) \mid \text{right}_\sigma(M) \mid \text{case } M \text{ of } \text{left}(x) \leadsto N \parallel \text{right}(y) \leadsto O$ $\quad\mid\quad$ **$V ::= \dots \mid \text{left}_\tau(V) \mid \text{right}_\sigma(V)$**.
    
      
    
-   **Tipado:**
    
      
    
    $$\frac{\Gamma \vdash M : \sigma}{\Gamma \vdash \text{left}_\tau(M) : \sigma + \tau}\;(\text{T-Left}) \quad \frac{\Gamma \vdash M : \tau}{\Gamma \vdash \text{right}_\sigma(M) : \sigma + \tau}\;(\text{T-Right}) \quad \frac{\Gamma \vdash M : \sigma + \tau \quad \Gamma, x:\sigma \vdash N : \rho \quad \Gamma, y:\tau \vdash O : \rho}{\Gamma \vdash \text{case } M \text{ of } \text{left}(x) \leadsto N \parallel \text{right}(y) \leadsto O : \rho}\;(\text{T-Case})$$
    
-   **Semántica Operacional (3 de congruencia + 2 de cómputo):**
    
      
    
    $$\frac{M \to M'}{\text{left}_\tau(M) \to \text{left}_\tau(M')} \qquad \frac{M \to M'}{\text{right}_\sigma(M) \to \text{right}_\sigma(M')} \qquad \frac{M \to M'}{\text{case } M \text{ of } \dots \to \text{case } M' \text{ of } \dots}$$
    
    $$\text{case left}_\tau(V) \text{ of } \text{left}(x) \leadsto N \parallel \text{right}(y) \leadsto O \;\to\; N\{x := V\} \qquad \text{case right}_\sigma(V) \text{ of } \text{left}(x) \leadsto N \parallel \text{right}(y) \leadsto O \;\to\; O\{y := V\}$$
    
-   **Isomorfismos de Tipos (Habitantes — Curry-Howard con Pares y Sumas):**
    
      
    -   **Currying (Adjunción):** $((\sigma \times \tau) \to \rho) \leftrightarrow (\sigma \to \tau \to \rho)$ vía $\lambda f. \lambda x. \lambda y. f~\langle x, y \rangle$ y $\lambda g. \lambda p. g~\pi_1(p)~\pi_2(p)$.
        
          
        
    -   **Distributividad ($\times$ sobre $+$):** $(\sigma \times (\tau + \rho)) \to ((\sigma \times \tau) + (\sigma \times \rho))$:
        
        $\lambda p : \sigma \times (\tau + \rho).\, \text{case } \pi_2(p) \text{ of } \text{left}(y) \leadsto \text{left}_{\sigma \times \rho}(\langle \pi_1(p), y \rangle) \parallel \text{right}(z) \leadsto \text{right}_{\sigma \times \tau}(\langle \pi_1(p), z \rangle)$.
        
          
        
    -   **Ley de Exponentes:** $((\sigma + \tau) \to \rho) \leftrightarrow ((\sigma \to \rho) \times (\tau \to \rho))$:
        
        Ida: $\lambda h.\, \langle \lambda x:\sigma. h~(\text{left}_\tau(x)),\, \lambda y:\tau. h~(\text{right}_\sigma(y)) \rangle$. Vuelta: $\lambda p. \lambda s. \text{case } s \text{ of } \text{left}(x) \leadsto \pi_1(p)~x \parallel \text{right}(y) \leadsto \pi_2(p)~y$.
        
          
        

#### C. Listas $[\tau]$, `case` y `foldr` (Ejercicio 22)

-   **Valores:** **$V ::= \dots \mid []_\tau \mid V_1 :: V_2$** (donde `::` asocia a la **derecha**).
    
      
    
-   **Tipado:**
    
      
    
    $$\frac{}{\Gamma \vdash []_\tau : [\tau]}\;(\text{T-Nil}) \qquad \frac{\Gamma \vdash M : \tau \quad \Gamma \vdash N : [\tau]}{\Gamma \vdash M :: N : [\tau]}\;(\text{T-Cons})$$
    
    $$\frac{\Gamma \vdash M : [\tau] \quad \Gamma \vdash N : \sigma \quad \Gamma, h:\tau, t:[\tau] \vdash O : \sigma}{\Gamma \vdash \text{case } M \text{ of } \{[] \leadsto N \mid h :: t \leadsto O\} : \sigma}\;(\text{T-CaseList}) \qquad \frac{\Gamma \vdash M : [\tau] \quad \Gamma \vdash N : \sigma \quad \Gamma, h:\tau, r:\sigma \vdash O : \sigma}{\Gamma \vdash \text{foldr } M \text{ base } \leadsto N; \text{ rec}(h, r) \leadsto O : \sigma}\;(\text{T-Foldr})$$
    
-   **Semántica Operacional (4 de congruencia: 2 en `::`, 1 en `case`, 1 en `foldr` + 4 de cómputo):**
    
      
    -   Congruencias de `::`: $M :: N \to M' :: N$ y $V_1 :: N \to V_1 :: N'$. Congruencias de `case` y `foldr`: solo reducen la lista $M \to M'$.
        
          
        
    -   Cómputo `case`: $\text{case } []_\tau \dots \to N$ $\quad\mid\quad$ $\text{case } V_1 :: V_2 \dots \to O\{h := V_1, t := V_2\}$.
        
          
        
    -   Cómputo `foldr`: $\text{foldr } []_\tau \dots \to N$, y para $V_1 :: V_2$ (dos variantes aceptadas):
        
          
        -   _Sustitución directa (lazy en $r$):_ $\text{foldr } V_1 :: V_2 \text{ base } \leadsto N; \text{ rec}(h, r) \leadsto O \;\to\; O\{h := V_1, \, r := (\text{foldr } V_2 \text{ base } \leadsto N; \text{ rec}(h, r) \leadsto O)\}$.
            
              
            
        -   _Estricta con $\lambda$ (call-by-value en $r$):_ $\to (\lambda r : \sigma.\, O\{h := V_1\})~(\text{foldr } V_2 \text{ base } \leadsto N; \text{ rec}(h, r) \leadsto O)$.
            
              
            

#### D. `map` y Listas por Comprensión (Ejercicios 23 y 24)

_(No agregan valores nuevos. Necesitan anotar el tipo de llegada $\tau$ para no romper Preservación ni Unicidad de Tipos cuando la lista evalúa a vacía $[]_\sigma \to []_\tau$)._

  

-   **`map` (Ej. 23):**
    
      
    -   **Tipado:** $\dfrac{\Gamma \vdash M : \sigma \to \tau \quad \Gamma \vdash N : [\sigma]}{\Gamma \vdash \text{map}_\tau(M, N) : [\tau]}$
        
          
        
    -   **Evaluación:** 2 congruencias ($\text{map}_\tau(M, N) \to \text{map}_\tau(M', N)$ y $\text{map}_\tau(V_f, N) \to \text{map}_\tau(V_f, N')$) + 2 cómputos:
        
          
        
        $$\text{map}_\tau(V_f, []_\sigma) \to []_\tau \qquad\text{y}\qquad \text{map}_\tau(V_f, V_1 :: V_2) \to (V_f~V_1) :: \text{map}_\tau(V_f, V_2)$$
        
-   **Comprensión $[M \mid x \leftarrow S, P]_\tau$ (Ej. 24):**
    
      
    -   **Tipado:** $\dfrac{\Gamma \vdash S : [\sigma] \quad \Gamma, x:\sigma \vdash P : \text{Bool} \quad \Gamma, x:\sigma \vdash M : \tau}{\Gamma \vdash [M \mid x \leftarrow S, P]_\tau : [\tau]}$
        
          
        
    -   **Evaluación:** 1 sola congruencia (sobre $S \to S'$) + 2 cómputos:
        
          
        
        $$[M \mid x \leftarrow []_\sigma, P]_\tau \to []_\tau \qquad\text{y}\qquad [M \mid x \leftarrow V_1 :: V_2, P]_\tau \to \text{if } P\{x := V_1\} \text{ then } M\{x := V_1\} :: [M \mid x \leftarrow V_2, P]_\tau \text{ else } [M \mid x \leftarrow V_2, P]_\tau$$
        

#### E. Funciones sobre Listas como Macros (Ejercicio 26)

_(Usando $\bot_\sigma \stackrel{\text{def}}{=} \text{fix } \lambda x : \sigma. x$)_:

  

-   $\text{head}_\sigma \stackrel{\text{def}}{=} \lambda xs : [\sigma].\, \text{case } xs \text{ of } \{[] \leadsto \bot_\sigma \mid h :: t \leadsto h\}$ $\quad\mid\quad$ $\text{tail}_\sigma \stackrel{\text{def}}{=} \lambda xs : [\sigma].\, \text{case } xs \text{ of } \{[] \leadsto \bot_{[\sigma]} \mid h :: t \leadsto t\}$.
    
      
    
-   $\text{iterate}_\sigma \stackrel{\text{def}}{=} \text{fix } \lambda \text{it} : (\sigma \to \sigma) \to \sigma \to [\sigma].\, \lambda f : \sigma \to \sigma.\, \lambda x : \sigma.\, x :: (\text{it}~f~(f~x))$.
    
      
    
-   $\text{zip}_{\rho,\sigma}$ **(sin `fix`, usando `foldr` devolviendo una función $[\sigma] \to [\rho \times \sigma]$):**
    
      
    
    $$\lambda xs : [\rho].\, \text{foldr } xs \text{ base } \leadsto (\lambda ys : [\sigma].\, []_{\rho \times \sigma}); \; \text{rec}(h_1, r) \leadsto (\lambda ys : [\sigma].\, \text{case } ys \text{ of } \{[] \leadsto []_{\rho \times \sigma} \mid h_2 :: t_2 \leadsto \langle h_1, h_2 \rangle :: (r~t_2)\})$$
    
-   $\text{take}_\sigma$ **(sin `fix`, usando `foldr` devolviendo una función $\text{Nat} \to [\sigma]$):**
    
      
    
    $$\lambda n : \text{Nat}.\, \lambda xs : [\sigma].\, (\text{foldr } xs \text{ base } \leadsto (\lambda k : \text{Nat}.\, []_\sigma); \; \text{rec}(h, r) \leadsto (\lambda k : \text{Nat}.\, \text{if isZero}(k) \text{ then } []_\sigma \text{ else } h :: (r~\text{pred}(k))))~n$$
    

  

  

#### F. Colas Bidireccionales / _Deque_ $\text{Cola}_\tau$ (Ejercicio 27)

  

  

-   **Valores:** **$V ::= \dots \mid \langle\rangle_\tau \mid V_1 \bullet V_2$** (donde $\bullet$ asocia a la **izquierda**: el elemento más antiguo está pegado a $\langle\rangle_\tau$).
    
      
    
-   **Tipado:**
    
      
    
      
    
    $$\frac{}{\Gamma \vdash \langle\rangle_\tau : \text{Cola}_\tau} \quad \frac{\Gamma \vdash M_1 : \text{Cola}_\tau \quad \Gamma \vdash M_2 : \tau}{\Gamma \vdash M_1 \bullet M_2 : \text{Cola}_\tau} \quad \frac{\Gamma \vdash M : \text{Cola}_\tau}{\Gamma \vdash \text{próximo}(M) : \tau} \quad \frac{\Gamma \vdash M : \text{Cola}_\tau}{\Gamma \vdash \text{desencolar}(M) : \text{Cola}_\tau}$$
    
    $$\frac{\Gamma \vdash M : \text{Cola}_\tau \quad \Gamma \vdash M_1 : \sigma \quad \Gamma, c : \text{Cola}_\tau, x : \tau \vdash M_2 : \sigma}{\Gamma \vdash \text{case } M \text{ of } \langle\rangle \leadsto M_1; \; c \bullet x \leadsto M_2 : \sigma}$$
    
-   **Semántica Operacional (5 reglas de congruencia: 2 en $\bullet$, 1 en `próximo`, 1 en `desencolar`, 1 en `case`):**
    
      
    
      
    -   **Cómputo de `case`:** $\text{case } \langle\rangle_\tau \dots \to M_1$ $\quad\mid\quad$ $\text{case } V_c \bullet V_x \text{ of } \langle\rangle \leadsto M_1; c \bullet x \leadsto M_2 \;\to\; M_2\{c := V_c, x := V_x\}$.
        
          
        
    -   **Cómputo de `próximo` y `desencolar` (Opción A: mirando 2 niveles):**
        
          
        
          
        
        $$\text{próximo}(\langle\rangle_\tau \bullet V) \to V \qquad \text{próximo}((V_c \bullet V_1) \bullet V_2) \to \text{próximo}(V_c \bullet V_1)$$
        
        $$\text{desencolar}(\langle\rangle_\tau \bullet V) \to \langle\rangle_\tau \qquad \text{desencolar}((V_c \bullet V_1) \bullet V_2) \to \text{desencolar}(V_c \bullet V_1) \bullet V_2$$
        
    -   **Cómputo de `próximo` y `desencolar` (Opción B equivalente: usando `case` sobre la subcola $V_1$):**
        
          
        
        $$\text{próximo}(V_1 \bullet V_2) \to \text{case } V_1 \text{ of } \langle\rangle \leadsto V_2; \; c \bullet x \leadsto \text{próximo}(V_1)$$
        
        $$\text{desencolar}(V_1 \bullet V_2) \to \text{case } V_1 \text{ of } \langle\rangle \leadsto \langle\rangle_\tau; \; c \bullet x \leadsto \text{desencolar}(V_1) \bullet V_2$$
        
-   **Macro $\text{último}_\tau$ y su juicio de tipado válido (Ej. 27.4):**
    
      
    
      
    
    $$\text{último}_\tau \stackrel{\text{def}}{=} \lambda q : \text{Cola}_\tau.\, \text{case } q \text{ of } \langle\rangle \leadsto \text{próximo}(\langle\rangle_\tau); \; c \bullet x \leadsto x \qquad\text{con juicio:}\qquad \vdash \text{último}_\tau : \text{Cola}_\tau \to \tau$$
    
## 0. Lenguaje Base: Cálculo $\lambda^{\text{Bool,Nat}}$ (Sintaxis, Tipado y Evaluación)

### A. Gramáticas y Conjunto de Valores
* **Tipos ($\to$ asocia a derecha: $\tau_1 \to \tau_2 \to \tau_3 \equiv \tau_1 \to (\tau_2 \to \tau_3)$):**
  $$\tau, \sigma ::= \text{Bool} \mid \text{Nat} \mid \tau \to \tau$$
* **Términos (la aplicación asocia a izquierda: $M~N~P \equiv (M~N)~P$):**
  $$M, N, P ::= x \mid \lambda x : \tau.\, M \mid M~N \mid \text{true} \mid \text{false} \mid \text{if } P \text{ then } M \text{ else } N \mid \text{zero} \mid \text{succ}(M) \mid \text{pred}(M) \mid \text{isZero}(M)$$
* **Valores (formas normales cerradas válidas como resultados):**
  $$V ::= \text{true} \mid \text{false} \mid \lambda x : \tau.\, M \mid \text{zero} \mid \text{succ}(V)$$
  *(Ojo: $\text{succ}(V)$ exige que el interior ya sea un valor $V$; las abstracciones $\lambda x:\tau.M$ son valores sin importar su cuerpo $M$, salvo que se agregue la regla $\zeta$).*

---

### B. Reglas de Tipado del Lenguaje Base

**1. Variables, Abstracción y Aplicación (Funciones):**
$$\frac{}{\Gamma, x : \tau \vdash x : \tau}\;(\text{T-Var}) \qquad \frac{\Gamma, x : \tau_1 \vdash M : \tau_2}{\Gamma \vdash \lambda x : \tau_1.\, M : \tau_1 \to \tau_2}\;(\text{T-Abs}) \qquad \frac{\Gamma \vdash M : \tau_1 \to \tau_2 \quad \Gamma \vdash N : \tau_1}{\Gamma \vdash M~N : \tau_2}\;(\text{T-App})$$

**2. Booleanos:**
$$\frac{}{\Gamma \vdash \text{true} : \text{Bool}}\;(\text{T-True}) \qquad \frac{}{\Gamma \vdash \text{false} : \text{Bool}}\;(\text{T-False}) \qquad \frac{\Gamma \vdash P : \text{Bool} \quad \Gamma \vdash M : \tau \quad \Gamma \vdash N : \tau}{\Gamma \vdash \text{if } P \text{ then } M \text{ else } N : \tau}\;(\text{T-If})$$

**3. Números Naturales:**
$$\frac{}{\Gamma \vdash \text{zero} : \text{Nat}}\;(\text{T-Zero}) \qquad \frac{\Gamma \vdash M : \text{Nat}}{\Gamma \vdash \text{succ}(M) : \text{Nat}}\;(\text{T-Succ}) \qquad \frac{\Gamma \vdash M : \text{Nat}}{\Gamma \vdash \text{pred}(M) : \text{Nat}}\;(\text{T-Pred}) \qquad \frac{\Gamma \vdash M : \text{Nat}}{\Gamma \vdash \text{isZero}(M) : \text{Bool}}\;(\text{T-IsZero})$$

---

### C. Semántica Operacional Call-by-Value (Congruencia vs. Cómputo)

#### 1. Reglas de Congruencia ("Dicen dónde trabajar" — Tienen premisa $\to$ arriba)
* **En la Aplicación (primero función a izquierda, luego argumento a derecha):**
  $$\frac{M \to M'}{M~N \to M'~N}\;(\text{E-App1} / \mu) \qquad\qquad \frac{N \to N'}{V~N \to V~N'}\;(\text{E-App2} / \nu)$$
  *(Nota:En $\text{E-App2}$ a veces se escribe $(\lambda x:\tau.M)~N \to (\lambda x:\tau.M)~N'$, que para términos bien tipados es equivalente porque todo valor de tipo funcional es un $\lambda$).*
* **En el Condicional Booleano (solo se reduce la guarda $P$, nunca las ramas $M, N$):**
  $$\frac{P \to P'}{\text{if } P \text{ then } M \text{ else } N \to \text{if } P' \text{ then } M \text{ else } N}\;(\text{E-If})$$
* **En los Operadores de Naturales:**
  $$\frac{M \to M'}{\text{succ}(M) \to \text{succ}(M')}\;(\text{E-Succ}) \qquad \frac{M \to M'}{\text{pred}(M) \to \text{pred}(M')}\;(\text{E-Pred}) \qquad \frac{M \to M'}{\text{isZero}(M) \to \text{isZero}(M')}\;(\text{E-IsZero})$$

#### 2. Reglas de Cómputo ("Hacen el trabajo" — Axiomas sin premisas $\to$ arriba)
* **En la Aplicación ($\beta$-reducción por valor: exige que el argumento ya sea un valor $V$):**
  $$\frac{}{(\lambda x : \tau.\, M)~V \to M\{x := V\}}\;(\text{E-AppAbs} / \beta)$$
* **En el Condicional Booleano:**
  $$\frac{}{\text{if true then } M \text{ else } N \to M}\;(\text{E-IfTrue}) \qquad\qquad \frac{}{\text{if false then } M \text{ else } N \to N}\;(\text{E-IfFalse})$$
* **En los Números Naturales:**
  $$\frac{}{\text{pred}(\text{succ}(V)) \to V}\;(\text{E-PredSucc}) \qquad \frac{}{\text{isZero}(\text{zero}) \to \text{true}}\;(\text{E-IsZeroZero}) \qquad \frac{}{\text{isZero}(\text{succ}(V)) \to \text{false}}\;(\text{E-IsZeroSucc})$$
  * **Regla opcional para recuperar la Propiedad de Progreso en $\lambda^{\text{Bool,Nat}}$:**
    $$\frac{}{\text{pred}(\text{zero}) \to \text{zero}}\;(\text{E-Pred0})$$
    *(Sin `E-Pred0`, $\text{pred}(\text{zero})$ es una forma normal cerrada y bien tipada que no es valor, es decir, un término de error).*

---

### D. Bonus del Lenguaje Base: Suma ($M + N$) y Punto Fijo ($\text{fix } M$)
* **Suma de Naturales ($M + N$):**
  * **Tipado:** $\dfrac{\Gamma \vdash M : \text{Nat} \quad \Gamma \vdash N : \text{Nat}}{\Gamma \vdash M + N : \text{Nat}}\;(\text{T-Sum})$
  * **Congruencia:** $\dfrac{M \to M'}{M + N \to M' + N}\;(\text{E-Sum1}) \qquad \dfrac{N \to N'}{V + N \to V + N'}\;(\text{E-Sum2})$
  * **Cómputo:** $V + \text{zero} \to V \qquad V_1 + \text{succ}(V_2) \to \text{succ}(V_1 + V_2)$ *(o simétrico induciendo en el 1er argumento)*.
* **Operador de Recursión General ($\text{fix } M$):** *(No agrega valores nuevos; rompe Terminación pero mantiene Determinismo, Preservación y Progreso)*.
  * **Tipado:** $\dfrac{\Gamma \vdash M : \tau \to \tau}{\Gamma \vdash \text{fix } M : \tau}\;(\text{T-Fix})$
  * **Congruencia:** $\dfrac{M \to M'}{\text{fix } M \to \text{fix } M'}\;(\text{E-Fix})$
  * **Cómputo:** $\dfrac{}{\text{fix } (\lambda x : \tau.\, M) \to M\{x := \text{fix } (\lambda x : \tau.\, M)\}}\;(\text{E-FixBeta})$


### Definición de Variables Libres ($\text{fv}$) y Sustitución ($M\{x := N\}$)

#### 1. Conjunto de Variables Libres ($\text{fv}(M)$)
Se define por recursión estructural sobre el término $M$:
* **Variables y Constantes:** $\text{fv}(x) = \{x\} \quad\mid\quad \text{fv}(\text{true}) = \text{fv}(\text{false}) = \text{fv}(\text{zero}) = \text{fv}([]_\tau) = \text{fv}(\langle\rangle_\tau) = \emptyset$
* **Constructores sin ligadores (unarios, binarios, ternarios):**
  * $\text{fv}(\text{succ}(M)) = \text{fv}(\text{pred}(M)) = \text{fv}(\text{isZero}(M)) = \text{fv}(\pi_i(M)) = \text{fv}(\text{left}_\tau(M)) = \text{fv}(\text{right}_\sigma(M)) = \text{fv}(M)$
  * $\text{fv}(M~N) = \text{fv}(\langle M, N \rangle) = \text{fv}(M :: N) = \text{fv}(M \bullet N) = \text{fv}(M) \cup \text{fv}(N)$
  * $\text{fv}(\text{if } P \text{ then } M \text{ else } N) = \text{fv}(P) \cup \text{fv}(M) \cup \text{fv}(N)$
* **Constructores con ligadores (restan las variables que ligan en esa rama):**
  * **Abstracción:** $\text{fv}(\lambda x : \tau.\, M) = \text{fv}(M) \setminus \{x\}$
  * **Case de sumas:** $\text{fv}(\text{case } M \text{ of } \text{left}(x) \leadsto N \parallel \text{right}(y) \leadsto O) = \text{fv}(M) \cup (\text{fv}(N) \setminus \{x\}) \cup (\text{fv}(O) \setminus \{y\})$
  * **Case de listas:** $\text{fv}(\text{case } M \text{ of } \{[] \leadsto N \mid h :: t \leadsto O\}) = \text{fv}(M) \cup \text{fv}(N) \cup (\text{fv}(O) \setminus \{h, t\})$
  * **Foldr:** $\text{fv}(\text{foldr } M \text{ base } \leadsto N; \text{ rec}(h, r) \leadsto O) = \text{fv}(M) \cup \text{fv}(N) \cup (\text{fv}(O) \setminus \{h, r\})$
  * **Comprensión:** $\text{fv}([M \mid x \leftarrow S, P]_\tau) = \text{fv}(S) \cup (\text{fv}(P) \setminus \{x\}) \cup (\text{fv}(M) \setminus \{x\})$

---

#### 2. Definición Completa de Sustitución sin Captura (Sin asumir Barendregt)
El término $M\{x := N\}$ (sustituir las ocurrencias libres de $x$ por $N$ en $M$) se define por recursión en $M$:
1. $x\{x := N\} = N$
2. $y\{x := N\} = y \quad \text{si } y \neq x$
3. $(P~Q)\{x := N\} = P\{x := N\}~Q\{x := N\}$
4. $(\lambda x : \tau.\, P)\{x := N\} = \lambda x : \tau.\, P \quad$ *(el ligador $x$ tapa la sustitución)*
5. $(\lambda y : \tau.\, P)\{x := N\} = \lambda y : \tau.\, P\{x := N\} \quad \text{si } y \neq x \text{ e } y \notin \text{fv}(N)$ *(sin peligro de captura)*
6. $(\lambda y : \tau.\, P)\{x := N\} = \lambda z : \tau.\, P\{y := z\}\{x := N\} \quad \text{si } y \neq x \text{ e } y \in \text{fv}(N)$, tomando $z \notin \text{fv}(N) \cup \text{fv}(P)$ *(renombre previo con variable fresca $z$ para evitar capturar la $y$ libre de $N$)*.

---

#### 3. Definición Corta de Sustitución (Asumiendo la Hipótesis de Barendregt)
Si trabajamos módulo $=_\alpha$ eligiendo representantes donde las variables ligadas no colisionan con $\{x\} \cup \text{fv}(N)$:
* **Variables:**
  $$x\{x := N\} = N \qquad\qquad y\{x := N\} = y \quad (\text{si } y \neq x)$$
* **Abstracción (suponiendo $y \notin \{x\} \cup \text{fv}(N)$):**
  $$(\lambda y : \tau.\, P)\{x := N\} = \lambda y : \tau.\, P\{x := N\}$$
* **Aplicación, Booleanos y Naturales (homomorfismo directo):**
  * $$(P~Q)\{x := N\} = P\{x := N\}~Q\{x := N\}$$
  * $$\text{true}\{x := N\} = \text{true} \quad\mid\quad \text{false}\{x := N\} = \text{false} \quad\mid\quad \text{zero}\{x := N\} = \text{zero}$$
  * $$(\text{if } P \text{ then } M_1 \text{ else } M_2)\{x := N\} = \text{if } P\{x := N\} \text{ then } M_1\{x := N\} \text{ else } M_2\{x := N\}$$
  * $$\text{succ}(M)\{x := N\} = \text{succ}(M\{x := N\}) \quad\mid\quad \text{pred}(M)\{x := N\} = \text{pred}(M\{x := N\}) \quad\mid\quad \text{isZero}(M)\{x := N\} = \text{isZero}(M\{x := N\})$$
* **Extensiones con ligadores (bajo Barendregt, con variables ligadas frescas $\notin \{x\} \cup \text{fv}(N)$):**
  * $$(\text{case } M \text{ of } \text{left}(u) \leadsto M_1 \parallel \text{right}(v) \leadsto M_2)\{x := N\} = \text{case } M\{x := N\} \text{ of } \text{left}(u) \leadsto M_1\{x := N\} \parallel \text{right}(v) \leadsto M_2\{x := N\}$$
  * $$(\text{foldr } M \text{ base } \leadsto M_1; \text{ rec}(h, r) \leadsto M_2)\{x := N\} = \text{foldr } M\{x := N\} \text{ base } \leadsto M_1\{x := N\}; \text{ rec}(h, r) \leadsto M_2\{x := N\}$$

---

#### 4. Propiedades Útiles de la Sustitución (módulo $=_\alpha$)
* **Recolección de basura:** Si $x \notin \text{fv}(M)$, entonces $M\{x := N\} =_\alpha M$.
* **Conmutación de sustituciones:** Si $x \neq y$ y $x \notin \text{fv}(Q)$, entonces:
  $$M\{x := P\}\{y := Q\} =_\alpha M\{y := Q\}\{x := P\{y := Q\}\}$$


## Extensiones $\lambda^{\bot}$, $\lambda^{\top}$ y Propiedades de $\lambda^{\times, +, \bot, \top}$

## 1. Extensión con el Tipo Vacío / Absurdo ($\lambda^{\bot}$)

* **Intuición y correspondencia lógica:** El tipo $\bot$ (*bottom*) corresponde al absurdo ($\bot$) de la Deducción Natural Intuicionista ($NJ$).


* **Habitantes:** Es el **tipo vacío** (no tiene constructores ni habitantes cerrados) y equivale a un tipo de datos algebraico con $0$ constructores.


* **Gramática de tipos y términos:** Se agrega el tipo $\bot$ y su eliminador $\text{case}_{\tau}\,M\,\{\}$ (un `case` con $0$ ramas anotado con el tipo resultado $\tau$):



$$\tau ::= \dots \mid \bot$$


$$M ::= \dots \mid \text{case}_{\tau}\,M\,\{\}$$


* **Regla de tipado ($\bot_e$ / Ex Falso Quodlibet):** En correspondencia con la eliminación del absurdo en lógica ($\Gamma \vdash \bot \implies \Gamma \vdash \tau$), si un término $M$ tiene tipo $\bot$, podemos obtener cualquier tipo $\tau$:



$$\frac{\Gamma \vdash M : \bot}{\Gamma \vdash \text{case}_{\tau}\,M\,\{\} : \tau}\;(\bot_e)$$


* **Valores y semántica operacional:**
* **No se agregan valores nuevos** (no existen valores cerrados de tipo $\bot$).


* **No hay regla de cómputo** para $\text{case}_{\tau}\,M\,\{\}$ porque nunca puede formarse un valor de tipo $\bot$, por lo que toda ocurrencia de $\text{case}_{\tau}\,M\,\{\}$ representa una situación imposible o código inalcanzable.


* *(Nota práctica)*: En caso de evaluar bajo una reducción paso a paso un término que aún no es valor dentro del eliminador, la única regla aplicable a un término $M : \bot$ que reduce ($M \to M'$) es reducir $M$ hasta que falle o cicle si hubiera recursión, pero en el sistema puro sin `fix` las reglas de valores y reducción ni siquiera necesitan extenderse para cómputo porque no existe ningún valor canónico $V : \bot$.





---

## 2. Extensión con el Tipo Unit / Verdadero ($\lambda^{\top}$)

* **Intuición y correspondencia lógica:** El tipo $\top$ (*top* o `Unit`) corresponde a la constante lógica $\top$ ("verdadero") en $NJ$, cuya regla de introducción es el axioma $\Gamma \vdash \top$ ($\top_i$).


* **Habitantes:** Es un tipo algebraico con **un único constructor** constante denotado $*$.


* **Gramática de tipos y términos:** Se extiende con el tipo $\top$ y el término constante $*$:



$$\tau ::= \dots \mid \top$$


$$M ::= \dots \mid *$$


* **Regla de tipado ($\top_i$):** La constante $*$ tiene tipo $\top$ en cualquier contexto $\Gamma$ sin premisas:



$$\frac{}{\Gamma \vdash * : \top}\;(\top_i)$$


* **Valores y semántica operacional:**
* **Nuevo valor:** La constante $*$ es el único valor canónico del tipo $\top$ ($V ::= \dots \mid *$).


* **Reglas de reducción:** No requiere reglas de cómputo ni de congruencia adicionales porque $*$ ya es un valor (forma normal) y el tipo $\top$ no necesita eliminadores primitivos.





---

## 3. Codificaciones Derivadas usando $\bot$, $\top$ y $+$

Con la presencia de $\bot$, $\top$ y el tipo suma $+$, no es necesario agregar conectivos de negación ni booleanos primitivos al cálculo:

* **Codificación de la Negación ($\neg \sigma$):**
* **Definición de tipo:** Se define como una función hacia el tipo vacío:



$$\neg \sigma \equiv \sigma \to \bot$$


* **Correspondencia de reglas:** La introducción de la negación ($\neg_i$) es exactamente la abstracción ($\Rightarrow_i$ / `T-Abs`) y la eliminación de la negación ($\neg_e$) es exactamente la aplicación ($\Rightarrow_e$ / `T-App`).




* **Codificación de los Booleanos ($\text{Bool}$):**
* **Definición de tipo:** Un booleano se codifica como la suma disjunta de dos tipos `Unit`:



$$\text{Bool} \equiv \top + \top$$


* **Constructores (`true` y `false`):** Se codifican inyectando $*$ a izquierda o derecha:



$$\text{true} \equiv \text{left}_{\top}(*)$$


$$\text{false} \equiv \text{right}_{\top}(*)$$


* **Condicional (`if-then-else`):** Se codifica mediante el `case` de la suma ignorando la variable ligada:



$$\text{if } M \text{ then } N \text{ else } P \equiv \text{case } M\,\{\text{left}(\_) \mapsto N \;\Vert{}\; \text{right}(\_) \mapsto P\}$$





---

## 4. Propiedades Fundamentales de $\lambda^{\times, +, \bot, \top}$

El cálculo $\lambda^{\times, +, \bot, \top}$ verifica las siguientes 6 propiedades estructurales y semánticas:

### 4.1. Unicidad de Tipos

* **Enunciado:** Si $\Gamma \vdash M : \tau$ y $\Gamma \vdash M : \sigma$ son derivables, entonces $\tau = \sigma$.


* **Justificación en $\top$ y $\bot$:** El sistema sigue siendo dirigido por la sintaxis (una única regla por constructor). El constructor $*$ tiene tipo único $\top$, y el eliminador $\text{case}_{\tau}\,M\,\{\}$ lleva explícitamente anotado en su subíndice el tipo resultante $\tau$.



### 4.2. Debilitamiento (*Weakening*) y Fortalecimiento (*Strengthening*)

* **Enunciado unificado:** Si $\Gamma \vdash M : \tau$ es derivable y $\text{fv}(M) \subseteq \text{dom}(\Gamma \cap \Gamma')$, entonces $\Gamma' \vdash M : \tau$ es derivable.


* **En particular:**
* *Weakening:* Si $\Gamma \vdash M : \tau$ y $x \notin \text{dom}(\Gamma)$, entonces $\Gamma, x : \sigma \vdash M : \tau$.


* *Strengthening:* Si $\Gamma, x : \sigma \vdash M : \tau$ y $x \notin \text{fv}(M)$, entonces $\Gamma \vdash M : \tau$.





### 4.3. Determinismo

* **Enunciado:** Si $M \to N_1$ y $M \to N_2$, entonces $N_1 = N_2$.


* **Justificación:** Todo valor $V$ está en forma normal ($V \not\to$), y para cada término que no es valor existe a lo sumo un único *redex* y una única regla aplicable.



### 4.4. Preservación de Tipos (*Subject Reduction*)

* **Enunciado:** Si $\vdash M : \tau$ (o en general $\Gamma \vdash M : \tau$) y $M \to N$, entonces $\vdash N : \tau$ ($\Gamma \vdash N : \tau$).


* **Método de prueba:** Inducción en la derivación de $M \to N$, aplicando **Inversión de Tipado** sobre $\Gamma \vdash M : \tau$.


* **Herramienta clave en las reglas de cómputo ($\beta$, `E-CASEL`, `E-CASER`):** Se utiliza el **Lema de Sustitución** ($\Gamma, x : \sigma \vdash M : \tau \land \Gamma \vdash V : \sigma \implies \Gamma \vdash M\{x := V\} : \tau$). En el plano lógico de Curry-Howard, un paso de reducción corresponde a un paso de **eliminación de cortes** (*cut-elimination*), y las formas normales corresponden a demostraciones sin cortes.



### 4.5. Propiedad de Progreso (*Progress*) y Formas Canónicas

* **Enunciado:** Si $\vdash M : \tau$ (término cerrado y bien tipado), entonces:


1. O bien $M$ es un **valor**.


2. O bien existe $N$ tal que $M \to N$.




* **Lema de Formas Canónicas en $\lambda^{\times, +, \bot, \top}$:** Si $\vdash V : \tau$ es un valor cerrado:


* Si $\tau = \sigma \to \rho$, entonces $V = \lambda x : \sigma.\, M$.


* Si $\tau = \sigma \times \rho$, entonces $V = \langle V_1, V_2 \rangle$.


* Si $\tau = \sigma + \rho$, entonces $V = \text{left}_{\rho}(V_1)$ o $V = \text{right}_{\sigma}(V_2)$.


* Si $\tau = \top$, entonces $V = *$.


* **Si $\tau = \bot$, NO existe ningún valor $V$ tal que $\vdash V : \bot$** (por inspección de todos los constructores de valores posibles, ninguno tipa con $\bot$).




* **¿Cómo se prueba el caso $\bot_e$ ($\text{case}_{\tau}\,M\,\{\}$) en Progreso?**
* Si $\vdash \text{case}_{\tau}\,M\,\{\} : \tau$, por inversión de $\bot_e$ la premisa es $\vdash M : \bot$.


* Por Hipótesis Inductiva sobre $\vdash M : \bot$, o bien $M$ es un valor o bien $M$ puede reducir.


* Pero por el Lema de Formas Canónicas para $\bot$, **$M$ nunca puede ser un valor** (y de hecho, por consistencia, ni siquiera existe un término cerrado $\vdash M : \bot$ en el lenguaje sin `fix`), por lo que el caso se cumple vacuamente sin trabarse jamás.





### 4.6. Terminación (*Strong Normalization*) y Consistencia Lógica

* **Enunciado de Terminación:** Si $\vdash M : \tau$, entonces **no existe** una cadena infinita de reducciones $M \to M_1 \to M_2 \to \dots$.


* **Teorema de Curry-Howard:** El juicio $\tau_1, \dots, \tau_n \vdash \sigma$ es derivable en $NJ$ si y solo si existe un término $M$ tal que $x_1 : \tau_1, \dots, x_n : \tau_n \vdash M : \sigma$ (identificando $\to$ con $\Rightarrow$, $\times$ con $\land$, $+$ con $\lor$, $\bot$ con $\bot$ y $\top$ con $\top$).


* **Corolario (Consistencia de la lógica $NJ$):** El juicio $\vdash \bot$ **no es derivable** en $NJ$.


* **Demostración usando las propiedades del lenguaje:**
1. Supongamos que $\vdash \bot$ fuera derivable en $NJ$; por Curry-Howard, existiría un término cerrado $M$ tal que $\vdash M : \bot$.


2. Por **Terminación**, **Preservación de tipos** y **Progreso**, la reducción de $M$ debe terminar en un **valor** cerrado $V$ tal que $\vdash V : \bot$.


3. Por análisis de casos sobre los posibles constructores de valores ($V$), ningún valor tiene tipo $\bot$, lo cual es una contradicción.







---

## 5. Impacto de agregar Recursión General ($\text{fix}$) sobre estas Propiedades

Si extendemos el lenguaje con el operador de punto fijo $M ::= \dots \mid \text{fix } M$:

* **Regla de tipado:**

$$\frac{\Gamma \vdash M : \tau \to \tau}{\Gamma \vdash \text{fix } M : \tau}\;(\text{T-FIX})$$


* **Reglas de reducción (sin valores nuevos):**

$$\frac{M \to M'}{\text{fix } M \to \text{fix } M'}\;(\text{E-FIX}) \qquad \frac{}{\text{fix }(\lambda x : \tau.\, M) \to M\{x := \text{fix }(\lambda x : \tau.\, M)\}}\;(\text{E-FIXBETA})$$


* **¿Qué propiedades se mantienen y cuáles se rompen?**
* **Se mantienen:** Unicidad de tipos, Weakening/Strengthening, Determinismo, Preservación de tipos y Progreso.


* **Se ROMPE la Terminación:** Ahora podemos escribir programas bien tipados que ciclan infinitamente, como $\text{fix }(\lambda x : \sigma.\, x) \to \text{fix }(\lambda x : \sigma.\, x) \to \dots$.


* **Se ROMPE la Consistencia Lógica (si se interpreta como lógica):** Como $\vdash \text{fix }(\lambda x : \sigma.\, x) : \sigma$ es derivable para **cualquier** tipo $\sigma$, tomando $\sigma = \bot$ obtenemos un término cerrado $\vdash \text{fix }(\lambda x : \bot.\, x) : \bot$, lo que haría que el absurdo $\vdash \bot$ sea derivable y la lógica resulte **inconsistente**.


# Practica 2

## Las tres leyes de la generación infinita

1. Nunca debe usarse m´as de un generador infinito.
2. El generador infinito siempre va a la izquierda de cualquier otro generador.
3. Los generadores infinitos deben usarse ´unicamente para generar infinitas soluciones1.
   
Otra cosa a tener en cuenta: es importante es que las soluciones generadas en cada paso sean finitas, y que entre todas cubran todo el espacio de soluciones que se busca generar. Por ejemplo, si queremos generar todas las listas finitas de enteros positivos, no nos sirve que el generador infinito nos vaya dando la longitud de la lista, porque para cada longitud hay infinitas listas posibles. Tampoco nos sirve que vaya generando el primer elemento de la lista y que los demás estén acotados por el primero, porque entonces nunca generaríamos las listas cuyo primer elemento no es el máximo. En cambio la suma de los elementos de la lista sí es un buen valor para ir generando en cada paso, ya que hay una cantidad finita de listas para cada suma posible, y entre todas las sumas obtenemos todas las listas (además las soluciones en cada paso son disjuntas, lo cual siempre es útil, ya que no tenemos que ocuparnos de eliminar soluciones repetidas).

En caso de que haya más de una forma posible de ir recorriendo el espacio de búsqueda generando finitas soluciones en cada paso, conviene pensar cual es la forma más sencilla. Por ejemplo, para generar árboles binarios, no es muy útil que el generator infinito genere la altura, ya que la altura de un subárbol no determina la del otro. No hay una receta para resolver todos los problemas posibles, pero si ven que el problema de cómo generar las soluciones en cada paso es muy complejo, probablemente haya otra forma de usar el generador infinito que divida el espacio en particiones más sencillas de generar.

## Tipos de recursión

- Estructural: permite acceder a los argumentos no recursivos de los constructores, y a los resultados de la recursión para las subestructuras.
- Primitiva: como la estructural, pero además permite acceder a las subestructuras.
-  Global: como la primitiva, pero además permite acceder a los resultados de las recursiones anteriores.

```haskell
longitud [] = 0
longitud (_:xs) = 1 + longitud xs

insertarOrdenado e [] = [e]
insertarOrdenado e (x:xs) = if e < x then e:x:xs
                            else x:(insertarOrdenado e xs)

elementosEnPosicionesPares [] = []
elementosEnPosicionesPares (x:xs) = if null xs then [x]
                                    else x:elementosEnPosicionesPares (tail xs)
```
1. La recursión de longitud es estructural, porque hace recursión sobre la cola de la lista (xs) pero no accede a la cola en sí, ni a resultados de recursiones anteriores.
2. La recursión de insertarOrdenado es primitiva porque accede directamente a xs (además de hacer recursión), pero no accede a los resultados anteriores.
3. La recursión de elementosEnPosicionesPares es global, ya que accede a un resultado anterior: el de la recursión sobre la cola de la cola de la lista (es decir   tail xs).