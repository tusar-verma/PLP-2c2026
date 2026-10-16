# Ejercicio 1

Convertir a Forma Normal Conjuntiva (CNF) y a Forma Clausal (notación de conjuntos) las siguientes fórmulas proposicionales.

---

### Item I: $P \Rightarrow P$

1. **Eliminación de la implicación ($\Rightarrow$):**
Utilizando la equivalencia $A \Rightarrow B \equiv \neg A \vee B$:

$$P \Rightarrow P \equiv \neg P \vee P$$


2. **Forma Normal Conjuntiva (CNF):**
La fórmula ya se encuentra en CNF, pues es una conjunción de un solo término disyuntivo:

$$(\neg P \vee P)$$


3. **Forma Clausal:**
Expresando la disyunción como un conjunto de literales y la fórmula como un conjunto de cláusulas:

$$\mathcal{C} = \{\{\neg P, P\}\}$$



---

### Item II: $(P \wedge Q) \Rightarrow P$

1. **Eliminación de la implicación ($\Rightarrow$):**

$$\neg (P \wedge Q) \vee P$$


2. **Paso a NNF (Leyes de De Morgan):**

$$\neg P \vee \neg Q \vee P$$


3. **Forma Normal Conjuntiva (CNF):**

$$(\neg P \vee \neg Q \vee P)$$


4. **Forma Clausal:**

$$\mathcal{C} = \{\{\neg P, \neg Q, P\}\}$$



---

### Item III: $(P \vee Q) \Rightarrow P$

1. **Eliminación de la implicación ($\Rightarrow$):**

$$\neg (P \vee Q) \vee P$$


2. **Paso a NNF (Leyes de De Morgan):**

$$(\neg P \wedge \neg Q) \vee P$$


3. **Distribución de $\vee$ sobre $\wedge$ (CNF):**
Aplicando la ley distributiva $(A \wedge B) \vee C \equiv (A \vee C) \wedge (B \vee C)$:

$$(\neg P \vee P) \wedge (\neg Q \vee P)$$


4. **Forma Clausal:**

$$\mathcal{C} = \{\{\neg P, P\}, \{\neg Q, P\}\}$$



---

### Item IV: $\neg (P \Leftrightarrow \neg P)$

1. **Descomposición del bicondicional ($\Leftrightarrow$):**
Sabiendo que $A \Leftrightarrow B \equiv (A \Rightarrow B) \wedge (B \Rightarrow A)$:

$$\neg ((P \Rightarrow \neg P) \wedge (\neg P \Rightarrow P))$$


2. **Eliminación de las implicaciones ($\Rightarrow$):**

$$\neg ((\neg P \vee \neg P) \wedge (\neg \neg P \vee P))$$


3. **Simplificación e idempotencia:**
Como $\neg P \vee \neg P \equiv \neg P$ y $\neg \neg P \equiv P$, $P \vee P \equiv P$:

$$\neg (\neg P \wedge P)$$


4. **Paso a NNF (Leyes de De Morgan y Doble Negación):**

$$\neg \neg P \vee \neg P \equiv P \vee \neg P$$


5. **Forma Normal Conjuntiva (CNF):**

$$(P \vee \neg P)$$


6. **Forma Clausal:**

$$\mathcal{C} = \{\{P, \neg P\}\}$$



---

### Item V: $\neg (P \wedge Q) \Rightarrow (\neg P \vee \neg Q)$

1. **Eliminación de la implicación ($\Rightarrow$):**

$$\neg \neg (P \wedge Q) \vee (\neg P \vee \neg Q)$$


2. **Doble negación:**

$$(P \wedge Q) \vee (\neg P \vee \neg Q)$$


3. **Distribución de $\vee$ sobre $\wedge$ (CNF):**

$$(P \vee \neg P \vee \neg Q) \wedge (Q \vee \neg P \vee \neg Q)$$


4. **Forma Clausal:**

$$\mathcal{C} = \{\{P, \neg P, \neg Q\}, \{Q, \neg P, \neg Q\}\}$$



---

### Item VI: $(P \wedge Q) \vee (P \wedge R)$

1. **Distribución de $\vee$ sobre $\wedge$ (CNF):**
Aplicando la regla distributiva dos veces:

$$((P \wedge Q) \vee P) \wedge ((P \wedge Q) \vee R)$$


$$(P \vee P) \wedge (Q \vee P) \wedge (P \vee R) \wedge (Q \vee R)$$



Por idempotencia ($P \vee P \equiv P$):

$$P \wedge (Q \vee P) \wedge (P \vee R) \wedge (Q \vee R)$$


2. **Forma Clausal:**

$$\mathcal{C} = \{\{P\}, \{Q, P\}, \{P, R\}, \{Q, R\}\}$$



---

### Item VII: $(P \wedge Q) \Rightarrow R$

1. **Eliminación de la implicación ($\Rightarrow$):**

$$\neg (P \wedge Q) \vee R$$


2. **Paso a NNF (Leyes de De Morgan):**

$$\neg P \vee \neg Q \vee R$$


3. **Forma Normal Conjuntiva (CNF):**

$$(\neg P \vee \neg Q \vee R)$$


4. **Forma Clausal:**

$$\mathcal{C} = \{\{\neg P, \neg Q, R\}\}$$



---

### Item VIII: $P \Rightarrow (Q \Rightarrow R)$

1. **Eliminación de las implicaciones ($\Rightarrow$):**

$$P \Rightarrow (\neg Q \vee R) \equiv \neg P \vee \neg Q \vee R$$


2. **Forma Normal Conjuntiva (CNF):**

$$(\neg P \vee \neg Q \vee R)$$


3. **Forma Clausal:**

$$\mathcal{C} = \{\{\neg P, \neg Q, R\}\}$$



---

# Ejercicio 2

### Parte I

#### Análisis de Tautologías y Demostraciones por Resolución

Para determinar si una fórmula $\sigma$ es una tautología (válida), se aplica el método de refutación:

1. Se toma la negación de la fórmula $\neg \sigma$.
2. Se convierte $\neg \sigma$ a forma clausal.
3. Se aplica el algoritmo de refutación por resolución para derivar la cláusula vacía $\{\}$ ($\bot$).
4. Si se deriva $\{\}$, $\neg \sigma$ es insatisfactible, por lo que $\sigma$ es una tautología ($\vdash \sigma$). Si no es posible derivar $\{\}$ y el algoritmo se detiene, $\neg \sigma$ es satisfactible, luego $\sigma$ no es una tautología.

---

#### 1. Fórmula $P \Rightarrow P$

* **Negación de la fórmula:** $\neg (P \Rightarrow P) \equiv \neg (\neg P \vee P) \equiv P \wedge \neg P$.
* **Forma Clausal de la negación:** $\mathcal{C}_0 = \{\{P\}, \{\neg P\}\}$.
* **Resolución:**
1. Cláusula 1: $\{P\}$
2. Cláusula 2: $\{\neg P\}$
3. Resolvente de 1 y 2: $\{\}$ (Cláusula vacía).


* **Conclusión:** Se derivó la cláusula vacía ($\mathcal{C}_0 \vdash \{\}$). Por lo tanto, $\neg (P \Rightarrow P)$ es insatisfactible y $P \Rightarrow P$ es una **tautología**.

---

#### 2. Fórmula $(P \wedge Q) \Rightarrow P$

* **Negación de la fórmula:** $\neg ((P \wedge Q) \Rightarrow P) \equiv (P \wedge Q) \wedge \neg P$.
* **Forma Clausal de la negación:** $\mathcal{C}_0 = \{\{P\}, \{Q\}, \{\neg P\}\}$.
* **Resolución:**
1. Cláusula 1: $\{P\}$
2. Cláusula 2: $\{Q\}$
3. Cláusula 3: $\{\neg P\}$
4. Resolvente de 1 y 3: $\{\}$.


* **Conclusión:** Se derivó la cláusula vacía. La fórmula original es una **tautología**.

---

#### 3. Fórmula $(P \vee Q) \Rightarrow P$

* **Negación de la fórmula:** $\neg ((P \vee Q) \Rightarrow P) \equiv (P \vee Q) \wedge \neg P$.
* **Forma Clausal de la negación:** $\mathcal{C}_0 = \{\{P, Q\}, \{\neg P\}\}$.
* **Resolución:**
1. Cláusula 1: $\{P, Q\}$
2. Cláusula 2: $\{\neg P\}$
3. Resolvente de 1 y 2: $\{Q\}$.


* **Análisis de terminación:** El conjunto ampliado es $\mathcal{C} = \{\{P, Q\}, \{\neg P\}, \{Q\}\}$. No existen más pares de cláusulas con literales opuestos para resolver. No se pudo derivar la cláusula vacía $\{\}$.
* **Conclusión:** La negación es satisfactible (por ejemplo, con la interpretación $v(P) = F, v(Q) = V$). Por lo tanto, $(P \vee Q) \Rightarrow P$ **no es una tautología**.

---

#### 4. Fórmula $\neg (P \Leftrightarrow \neg P)$

* **Negación de la fórmula:** $\neg \neg (P \Leftrightarrow \neg P) \equiv P \Leftrightarrow \neg P \equiv (P \Rightarrow \neg P) \wedge (\neg P \Rightarrow P) \equiv (\neg P \vee \neg P) \wedge (P \vee P) \equiv \neg P \wedge P$.
* **Forma Clausal de la negación:** $\mathcal{C}_0 = \{\{\neg P\}, \{P\}\}$.
* **Resolución:**
1. Cláusula 1: $\{\neg P\}$
2. Cláusula 2: $\{P\}$
3. Resolvente de 1 y 2: $\{\}$.


* **Conclusión:** Se derivó la cláusula vacía. La fórmula es una **tautología**.

---

#### 5. Fórmula $\neg (P \wedge Q) \Rightarrow (\neg P \vee \neg Q)$

* **Negación de la fórmula:** $\neg (\neg (P \wedge Q) \Rightarrow (\neg P \vee \neg Q)) \equiv \neg (P \wedge Q) \wedge \neg (\neg P \vee \neg Q) \equiv (\neg P \vee \neg Q) \wedge P \wedge Q$.
* **Forma Clausal de la negación:** $\mathcal{C}_0 = \{\{\neg P, \neg Q\}, \{P\}, \{Q\}\}$.
* **Resolución:**
1. Cláusula 1: $\{\neg P, \neg Q\}$
2. Cláusula 2: $\{P\}$
3. Cláusula 3: $\{Q\}$
4. Resolvente de 1 y 2: $\{\neg Q\}$
5. Resolvente de 3 y 4: $\{\}$.


* **Conclusión:** Se derivó la cláusula vacía. La fórmula es una **tautología**.

---

#### 6. Fórmula $(P \wedge Q) \vee (P \wedge R)$

* **Negación de la fórmula:** $\neg ((P \wedge Q) \vee (P \wedge R)) \equiv \neg (P \wedge Q) \wedge \neg (P \wedge R) \equiv (\neg P \vee \neg Q) \wedge (\neg P \vee \neg R)$.
* **Forma Clausal de la negación:** $\mathcal{C}_0 = \{\{\neg P, \neg Q\}, \{\neg P, \neg R\}\}$.
* **Resolución:** No hay literales complementarios entre las cláusulas. No se pueden generar resolventes.
* **Conclusión:** No se deriva la cláusula vacía. La fórmula **no es una tautología**.

---

#### 7. Fórmula $(P \wedge Q) \Rightarrow R$

* **Negación de la fórmula:** $\neg ((P \wedge Q) \Rightarrow R) \equiv P \wedge Q \wedge \neg R$.
* **Forma Clausal de la negación:** $\mathcal{C}_0 = \{\{P\}, \{Q\}, \{\neg R\}\}$.
* **Resolución:** No existen literales complementarios. No se pueden generar resolventes.
* **Conclusión:** No se deriva la cláusula vacía. La fórmula **no es una tautología**.

---

#### 8. Fórmula $P \Rightarrow (Q \Rightarrow R)$

* **Negación de la fórmula:** $\neg (P \Rightarrow (Q \Rightarrow R)) \equiv P \wedge \neg (\neg Q \vee R) \equiv P \wedge Q \wedge \neg R$.
* **Forma Clausal de la negación:** $\mathcal{C}_0 = \{\{P\}, \{Q\}, \{\neg R\}\}$.
* **Resolución:** No existen literales complementarios. No se pueden generar resolventes.
* **Conclusión:** No se deriva la cláusula vacía. La fórmula **no es una tautología**.

---

### Parte II

#### Deducción de $(P \wedge Q)$ a partir de $(\neg P \Rightarrow Q) \wedge (P \Rightarrow Q) \wedge (\neg P \Rightarrow \neg Q)$

Para demostrar si el conjunto de premisas $\{(\neg P \Rightarrow Q), (P \Rightarrow Q), (\neg P \Rightarrow \neg Q)\}$ deduce la conclusión $(P \wedge Q)$, se debe verificar la insatisfactibilidad de la conjunción de las premisas con la negación de la conclusión.

1. **Premisas y negación de la conclusión:**
* Premisa 1: $\neg P \Rightarrow Q \equiv P \vee Q$
* Premisa 2: $P \Rightarrow Q \equiv \neg P \vee Q$
* Premisa 3: $\neg P \Rightarrow \neg Q \equiv P \vee \neg Q$
* Negación de la conclusión: $\neg (P \wedge Q) \equiv \neg P \vee \neg Q$


2. **Forma Clausal Inicial ($\mathcal{C}_0$):**
1. $\kappa_1 = \{P, Q\}$
2. $\kappa_2 = \{\neg P, Q\}$
3. $\kappa_3 = \{P, \neg Q\}$
4. $\kappa_4 = \{\neg P, \neg Q\}$


3. **Derivación por Resolución:**
* **Paso 1:** Resolvente de $\kappa_1 = \{P, Q\}$ y $\kappa_2 = \{\neg P, Q\}$ eliminando $P$:

$$\kappa_5 = \{Q\}$$


* **Paso 2:** Resolvente de $\kappa_3 = \{P, \neg Q\}$ y $\kappa_4 = \{\neg P, \neg Q\}$ eliminando $P$:

$$\kappa_6 = \{\neg Q\}$$


* **Paso 3:** Resolvente de $\kappa_5 = \{Q\}$ y $\kappa_6 = \{\neg Q\}$ eliminando $Q$:

$$\kappa_7 = \{\}$$




4. **Conclusión:**
Al haber alcanzado la cláusula vacía $\{\}$, el conjunto formado por las premisas y la negación de la conclusión es insatisfactible. Por consiguiente, $(P \wedge Q)$ se deduce válidamente del conjunto de premisas dado.

---

# Ejercicio 3

Demostrar las siguientes tautologías utilizando el método de refutación por resolución proposicional.

---

### Item I: $(P \Rightarrow (P \Rightarrow Q)) \Rightarrow (P \Rightarrow Q)$

1. **Negación de la fórmula total:**

$$\neg (((P \Rightarrow (P \Rightarrow Q)) \Rightarrow (P \Rightarrow Q))$$


2. **Transformación a Forma Clausal:**
* Negación de la implicación principal: $(P \Rightarrow (P \Rightarrow Q)) \wedge \neg (P \Rightarrow Q)$
* Antecedente a cláusulas:

$$P \Rightarrow (P \Rightarrow Q) \equiv \neg P \vee (\neg P \vee Q) \equiv \neg P \vee Q$$


* Consecuente negado a cláusulas:

$$\neg (P \Rightarrow Q) \equiv P \wedge \neg Q$$




3. **Conjunto inicial de cláusulas ($\mathcal{C}_0$):**
1. $\kappa_1 = \{\neg P, Q\}$
2. $\kappa_2 = \{P\}$
3. $\kappa_3 = \{\neg Q\}$


4. **Derivación por Resolución:**
* Resolvente de $\kappa_1 = \{\neg P, Q\}$ y $\kappa_2 = \{P\}$:

$$\kappa_4 = \{Q\}$$


* Resolvente de $\kappa_4 = \{Q\}$ y $\kappa_3 = \{\neg Q\}$:

$$\kappa_5 = \{\}$$




5. **Conclusión:** Se obtuvo la cláusula vacía ($\{\}$), demostrando que la fórmula es una tautología.

---

### Item II: $(R \Rightarrow \neg Q) \Rightarrow ((R \wedge Q) \Rightarrow P)$

1. **Negación de la fórmula total:**

$$\neg ((R \Rightarrow \neg Q) \Rightarrow ((R \wedge Q) \Rightarrow P))$$


2. **Transformación a Forma Clausal:**
* Expresión simplificada de la negación:

$$(R \Rightarrow \neg Q) \wedge (R \wedge Q) \wedge \neg P$$


* Reescribiendo $R \Rightarrow \neg Q$ como disyunción:

$$\neg R \vee \neg Q$$


* Cláusulas resultantes:

$$(\neg R \vee \neg Q) \wedge R \wedge Q \wedge \neg P$$




3. **Conjunto inicial de cláusulas ($\mathcal{C}_0$):**
1. $\kappa_1 = \{\neg R, \neg Q\}$
2. $\kappa_2 = \{R\}$
3. $\kappa_3 = \{Q\}$
4. $\kappa_4 = \{\neg P\}$


4. **Derivación por Resolución:**
* Resolvente de $\kappa_1 = \{\neg R, \neg Q\}$ y $\kappa_2 = \{R\}$:

$$\kappa_5 = \{\neg Q\}$$


* Resolvente de $\kappa_5 = \{\neg Q\}$ y $\kappa_3 = \{Q\}$:

$$\kappa_6 = \{\}$$





*(Nota: La cláusula $\kappa_4 = \{\neg P\}$ no se necesitó utilizar para derivar la refutación).*

5. **Conclusión:** Se obtuvo la cláusula vacía ($\{\}$), demostrando que la fórmula es una tautología.

---

### Item III: $((P \Rightarrow Q) \Rightarrow (R \Rightarrow \neg Q)) \Rightarrow \neg (R \wedge Q)$

1. **Negación de la fórmula total:**

$$\neg (((P \Rightarrow Q) \Rightarrow (R \Rightarrow \neg Q)) \Rightarrow \neg (R \wedge Q))$$


2. **Transformación a Forma Clausal:**
* Eliminando la implicación principal:

$$((P \Rightarrow Q) \Rightarrow (R \Rightarrow \neg Q)) \wedge \neg \neg (R \wedge Q)$$


* Simplificando el lado derecho (doble negación):

$$R \wedge Q$$


* Reescribiendo el lado izquierdo $(P \Rightarrow Q) \Rightarrow (R \Rightarrow \neg Q)$:

$$\neg (\neg P \vee Q) \vee (\neg R \vee \neg Q) \equiv (P \wedge \neg Q) \vee \neg R \vee \neg Q$$


* Aplicando distributividad sobre $P \wedge \neg Q$:

$$(P \vee \neg R \vee \neg Q) \wedge (\neg Q \vee \neg R \vee \neg Q) \equiv (P \vee \neg R \vee \neg Q) \wedge (\neg Q \vee \neg R)$$




3. **Conjunto inicial de cláusulas ($\mathcal{C}_0$):**
1. $\kappa_1 = \{P, \neg R, \neg Q\}$
2. $\kappa_2 = \{\neg Q, \neg R\}$
3. $\kappa_3 = \{R\}$
4. $\kappa_4 = \{Q\}$


4. **Derivación por Resolución:**
* Resolvente de $\kappa_2 = \{\neg Q, \neg R\}$ y $\kappa_4 = \{Q\}$:

$$\kappa_5 = \{\neg R\}$$


* Resolvente de $\kappa_5 = \{\neg R\}$ y $\kappa_3 = \{R\}$:

$$\kappa_6 = \{\}$$



5. **Conclusión:** Se derivó la cláusula vacía ($\{\}$), demostrando que la fórmula dada es una tautología.

# Ejercicio 4: Resolución en Lógica Proposicional

## Definición de Variables Proposicionales

Asignamos una variable a cada enunciado atómico presente en el problema:

* $P$: El pronóstico anuncia lluvia.
* $L$: Efectivamente llueve.
* $F$: Se reúnen en la casa de Fabiana.
* $M$: Se reúnen en la casa de Manuel.

---

## Planteo de la Fórmula Lógica a Demostrar ($\sigma$)

Representamos el problema como un condicional donde el antecedente es la conjunción de las premisas y el consecuente es la afirmación de que el pronóstico se equivocó ($P \Leftrightarrow \neg L$):

$$\sigma \equiv ((P \Rightarrow F) \wedge (\neg P \Rightarrow M) \wedge \neg(F \wedge M) \wedge F \wedge \neg L) \Rightarrow ((P \Rightarrow \neg L) \wedge (\neg P \Rightarrow L))$$

---

## Plantear la Negación de la Fórmula ($\neg \sigma$)

Para realizar la prueba por el método de refutación, negamos la fórmula completa:

$$\neg \sigma \equiv \neg [((P \Rightarrow F) \wedge (\neg P \Rightarrow M) \wedge \neg(F \wedge M) \wedge F \wedge \neg L) \Rightarrow ((P \Rightarrow \neg L) \wedge (\neg P \Rightarrow L))]$$

Aplicando la regla de negación de la implicación ($\neg(A \Rightarrow B) \equiv A \wedge \neg B$), se obtiene:

$$\neg \sigma \equiv (P \Rightarrow F) \wedge (\neg P \Rightarrow M) \wedge \neg(F \wedge M) \wedge F \wedge \neg L \wedge \neg ((P \Rightarrow \neg L) \wedge (\neg P \Rightarrow L))$$

---

## Pasaje a Forma Normal Conjuntiva (CNF)

Transformamos cada uno de los términos de la conjunción principal a su respectiva forma de disyunción de literales:

1. **Premisa 1 ($P \Rightarrow F$):**

$$\neg P \vee F$$


2. **Premisa 2 ($\neg P \Rightarrow M$):**

$$P \vee M$$


3. **Premisa 3 ($\neg(F \wedge M)$):**
Aplicando De Morgan:

$$\neg F \vee \neg M$$


4. **Premisa 4 ($F$):**

$$F$$


5. **Premisa 5 ($\neg L$):**

$$\neg L$$


6. **Negación del consecuente ($\neg ((P \Rightarrow \neg L) \wedge (\neg P \Rightarrow L))$):**
* Aplicando Leyes de De Morgan:

$$\neg (P \Rightarrow \neg L) \vee \neg (\neg P \Rightarrow L)$$


* Negando las implicaciones internas:

$$(P \wedge \neg \neg L) \vee (\neg P \wedge \neg L) \equiv (P \wedge L) \vee (\neg P \wedge \neg L)$$


* Aplicando la ley distributiva de $\vee$ sobre $\wedge$:

$$((P \wedge L) \vee \neg P) \wedge ((P \wedge L) \vee \neg L)$$


$$(P \vee \neg P) \wedge (L \vee \neg P) \wedge (P \vee \neg L) \wedge (L \vee \neg L)$$


* Eliminando las cláusulas tautológicas $(P \vee \neg P)$ y $(L \vee \neg L)$, la expresión en CNF queda:

$$(\neg P \vee L) \wedge (P \vee \neg L)$$





**Fórmula global en CNF:**


$$(\neg P \vee F) \wedge (P \vee M) \wedge (\neg F \vee \neg M) \wedge F \wedge \neg L \wedge (\neg P \vee L) \wedge (P \vee \neg L)$$

---

## Cálculo de la Forma Clausal ($\mathcal{C}_0$)

Expresamos la fórmula en notación de conjuntos, donde cada elemento es una cláusula (conjunto de literales unida por disyunciones):

$$\mathcal{C}_0 = \{\{\neg P, F\}, \{P, M\}, \{\neg F, \neg M\}, \{F\}, \{\neg L\}, \{\neg P, L\}, \{P, \neg L\}\}$$

---

## Método de Resolución (Derivación hacia la contradicción $\bot$)

Asignamos identificadores a las cláusulas iniciales de $\mathcal{C}_0$:

1. $\kappa_1 = \{\neg P, F\}$
2. $\kappa_2 = \{P, M\}$
3. $\kappa_3 = \{\neg F, \neg M\}$
4. $\kappa_4 = \{F\}$
5. $\kappa_5 = \{\neg L\}$
6. $\kappa_6 = \{\neg P, L\}$
7. $\kappa_7 = \{P, \neg L\}$

**Pasos de resolución:**

* **Paso 1:** Resolvente entre $\kappa_5 = \{\neg L\}$ y $\kappa_6 = \{\neg P, L\}$ eliminando el literal $L$:

$$\kappa_8 = \{\neg P\}$$


* **Paso 2:** Resolvente entre $\kappa_3 = \{\neg F, \neg M\}$ y $\kappa_4 = \{F\}$ eliminando el literal $F$:

$$\kappa_9 = \{\neg M\}$$


* **Paso 3:** Resolvente entre $\kappa_2 = \{P, M\}$ y $\kappa_9 = \{\neg M\}$ eliminando el literal $M$:

$$\kappa_{10} = \{P\}$$


* **Paso 4:** Resolvente entre $\kappa_8 = \{\neg P\}$ y $\kappa_{10} = \{P\}$ eliminando el literal $P$:

$$\kappa_{11} = \{\} \quad (\text{Cláusula vacía } \bot)$$



---

## Conclusión

Mediante el algoritmo de resolución se derivó la cláusula vacía ($\mathcal{C}_0 \vdash \{\}$), lo que demuestra que el conjunto de cláusulas obtenido a partir de la negación de la fórmula es **insatisfactible**.

Por el principio de refutación, se concluye formalmente que la fórmula original $\sigma$ es una **tautología** (válida en toda interpretación), confirmando que el pronóstico efectivamente se equivocó.