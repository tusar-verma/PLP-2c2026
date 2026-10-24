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


Aquí tenés la resolución completa y detallada de los **Ejercicios 5, 6, 7 y 8** de la **Práctica 6 (Lógica y Resolución)**, con todas las justificaciones paso a paso para que puedas copiarlas a tus notas.

---

# Sintaxis de la Lógica de Primer Orden (LPO)

---

# Ejercicio 5

Dado el conjunto de símbolos de función $\mathcal{F} = \{d, f, g\}$ con sus respectivas aridades:

* $d$: constante (aridad 0)
* $f$: función binaria (aridad 2)
* $g$: función ternaria (aridad 3)

### Definición formal de término sobre $\mathcal{F}$:

1. Toda variable $X, Y, Z, \dots$ es un término.
2. Toda constante (función de aridad 0) es un término.
3. Si $h \in \mathcal{F}$ tiene aridad $n \ge 1$ y $t_1, \dots, t_n$ son términos, entonces $h(t_1, \dots, t_n)$ es un término.

---

### Análisis de las cadenas:

* **I. $g(d, d)$**
* **Respuesta:** **NO es un término.**
* **Justificación:** El símbolo $g$ fue definido con aridad 3 (requiere 3 argumentos), pero en esta expresión recibe únicamente 2 argumentos ($d$ y $d$).


* **II. $g(X, f(d, Z), d)$**
* **Respuesta:** **SÍ es un término.**
* **Justificación:**
1. $X$ y $Z$ son variables (términos).
2. $d$ es una constante (término).
3. $f(d, Z)$ es un término válido porque $f$ (aridad 2) recibe 2 términos ($d$ y $Z$).
4. $g$ (aridad 3) recibe 3 términos válidos: $X$, $f(d, Z)$ y $d$.




* **III. $f(X, g(Y, Z), d)$**
* **Respuesta:** **NO es un término.**
* **Justificación:** Viola dos reglas de aridad:
1. $g$ (aridad 3) recibe solo 2 argumentos ($Y, Z$).
2. $f$ (aridad 2) recibe 3 argumentos ($X$, $g(Y,Z)$, $d$).




* **IV. $g(X, h(Y, Z), d)$**
* **Respuesta:** **NO es un término sobre $\mathcal{F}$.**
* **Justificación:** El símbolo de función $h$ no pertenece al alfabeto dado $\mathcal{F} = \{d, f, g\}$.


* **V. $f(f(g(d, X), f(g(d, X), Y, g(Y, d)), g(d, d)), g(f(d, d, X), d), Z)$**
* **Respuesta:** **NO es un término.**
* **Justificación:** Múltiples subexpresiones violan las aridades:
1. $g(d, X)$, $g(Y, d)$ y $g(d, d)$ pasan solo 2 argumentos a $g$ (requiere 3).
2. $f(d, d, X)$ pasa 3 argumentos a $f$ (requiere 2).
3. El símbolo $f$ más externo recibe 3 argumentos principales.





---

# Ejercicio 6

Dados los símbolos:

* $c$: constante
* $f$: función de aridad 1
* $S, B$: predicados binarios (aridad 2)

### Definición formal de fórmula en LPO:

1. Si $P$ es un predicado de aridad $n$ y $t_1, \dots, t_n$ son términos, entonces $P(t_1, \dots, t_n)$ es una **fórmula atómica**.
2. Si $\phi, \psi$ son fórmulas, entonces $\neg \phi$, $(\phi \wedge \psi)$, $(\phi \vee \psi)$, $(\phi \Rightarrow \psi)$ y $(\phi \Leftrightarrow \psi)$ son fórmulas.
3. Si $\phi$ es una fórmula y $X$ es una variable, $\forall X . \phi$ y $\exists X . \phi$ son fórmulas.

---

### Análisis de las cadenas:

* **I. $S(c, X)$**
* **Respuesta:** **SÍ es fórmula.** (Fórmula atómica: el predicado $S$ de aridad 2 se aplica sobre la constante $c$ y la variable $X$).


* **II. $B(c, f(c))$**
* **Respuesta:** **SÍ es fórmula.** (Fórmula atómica: el predicado $B$ se aplica a los términos válidos $c$ y $f(c)$).


* **III. $f(c)$**
* **Respuesta:** **NO es fórmula.** Es un **término** (denota un objeto del dominio, no una afirmación que pueda ser verdadera o falsa).


* **IV. $B(B(c, X), Y)$**
* **Respuesta:** **NO es fórmula.** Los predicados deben tomar **términos** como argumentos. $B(c, X)$ es una fórmula, no un término.


* **V. $S(B(c), Z)$**
* **Respuesta:** **NO es fórmula.** $B(c)$ es un predicado de aridad 2 mal aplicado (recibe 1 solo argumento) y además no es un término.


* **VI. $(B(X, Y) \Rightarrow (\exists Z . S(Z, Y)))$**
* **Respuesta:** **SÍ es fórmula.** Es una implicación bien formada entre la atómica $B(X, Y)$ y la fórmula cuantificada $\exists Z . S(Z, Y)$.


* **VII. $(S(X, Y) \Rightarrow S(Y, f(f(X))))$**
* **Respuesta:** **SÍ es fórmula.** Implicación entre dos fórmulas atómicas válidas.


* **VIII. $B(X, Y) \Rightarrow f(X)$**
* **Respuesta:** **NO es fórmula.** El conectivo $\Rightarrow$ debe unir dos fórmulas. $f(X)$ es un término.


* **IX. $S(X, f(Y)) \wedge B(X, Y)$**
* **Respuesta:** **SÍ es fórmula.** Conjunción de dos fórmulas atómicas.


* **X. $\forall X . B(X, f(X))$**
* **Respuesta:** **SÍ es fórmula.** Cuantificación universal sobre una fórmula atómica válida.


* **XI. $\exists X . B(Y, X(c))$**
* **Respuesta:** **NO es fórmula.** $X(c)$ intenta usar la variable $X$ como un símbolo de función.



---

# Ejercicio 7

Dada la fórmula:


$$\sigma = ((\exists X . P(Y, Z)) \wedge \forall Y . \neg Q(Y, X)) \vee P(Y, Z)$$

---

### I. Variables libres y ligadas

* **Ocurrencias de variables:**
* En $\exists X . P(Y, Z)$: $X$ está **ligada** por $\exists X$; $Y$ y $Z$ están **libres**.
* En $\forall Y . \neg Q(Y, X)$: $Y$ está **ligada** por $\forall Y$; $X$ está **libre** (no cae bajo la influencia de $\exists X$ de la subfórmula izquierda).
* En el $P(Y, Z)$ final: $Y$ y $Z$ están **libres**.


* **Conjunto de variables libres:**

$$\text{Libres}(\sigma) = \{X, Y, Z\}$$


* **Conjunto de variables ligadas:**

$$\text{Ligadas}(\sigma) = \{X, Y\}$$



---

### II. Cálculo de sustituciones

> **Regla formal:** La sustitución $\sigma\{V := t\}$ actúa únicamente sobre las **ocurrencias libres** de $V$. Si al sustituir surge una captura no deseada de variables del término $t$ por cuantificadores de $\sigma$, se debe **renombrar la variable ligada** (Alfa-conversión) por una variable fresca.

1. **$\sigma\{X := W\}$:**
Sustituye únicamente la ocurrencia libre de $X$ (en $\neg Q(Y, X)$):

$$\sigma\{X := W\} = ((\exists X . P(Y, Z)) \wedge \forall Y . \neg Q(Y, W)) \vee P(Y, Z)$$


2. **$\sigma\{Y := W\}$:**
Sustituye las ocurrencias libres de $Y$ (en $\exists X . P(Y, Z)$ y en $P(Y, Z)$):

$$\sigma\{Y := W\} = ((\exists X . P(W, Z)) \wedge \forall Y . \neg Q(Y, X)) \vee P(W, Z)$$


3. **$\sigma\{Y := f(X)\}$:**
Sustituye las ocurrencias libres de $Y$ por el término $f(X)$.
* *Atención:* En la subfórmula $\exists X . P(Y, Z)$, sustituir $Y$ por $f(X)$ provocaría que la variable $X$ quede **capturada** por el cuantificador $\exists X$.
* Se renombra la variable ligada $X$ a una variable fresca $X'$:

$$\sigma\{Y := f(X)\} = ((\exists X' . P(f(X), Z)) \wedge \forall Y . \neg Q(Y, X)) \vee P(f(X), Z)$$




4. **$\sigma\{Z := g(Y, Z)\}$:**
Sustituye las ocurrencias libres de $Z$ por $g(Y, Z)$. No hay capturas de variables:

$$\sigma\{Z := g(Y, Z)\} = ((\exists X . P(Y, g(Y, Z))) \wedge \forall Y . \neg Q(Y, X)) \vee P(Y, g(Y, Z))$$



---

# Ejercicio 8

Dada la fórmula:


$$\sigma = (\exists X . \forall Y . P(X, Y, Z)) \wedge \forall Z . P(X, Y, Z)$$

---

### I. Variables libres y ligadas

* **En $(\exists X . \forall Y . P(X, Y, Z))$:** $X$ e $Y$ están **ligadas**; $Z$ está **libre**.
* **En $\forall Z . P(X, Y, Z)$:** $X$ e $Y$ están **libres**; $Z$ está **ligada**.
* **Variables libres:** $\text{Libres}(\sigma) = \{X, Y, Z\}$
* **Variables ligadas:** $\text{Ligadas}(\sigma) = \{X, Y, Z\}$

---

### II. Sustituciones individuales con $t = g(f(Y), Y)$

1. **$\sigma\{X := t\}$:**
Reemplaza la ocurrencia libre de $X$ (en el segundo conjuncto):

$$\sigma\{X := t\} = (\exists X . \forall Y . P(X, Y, Z)) \wedge \forall Z . P(g(f(Y), Y), Y, Z)$$


2. **$\sigma\{Y := t\}$:**
Reemplaza la ocurrencia libre de $Y$ (en el segundo conjuncto):

$$\sigma\{Y := t\} = (\exists X . \forall Y . P(X, Y, Z)) \wedge \forall Z . P(X, g(f(Y), Y), Z)$$


3. **$\sigma\{Z := t\}$:**
Reemplaza la ocurrencia libre de $Z$ (en el primer conjuncto).
* *Atención:* Para evitar que la variable $Y$ del término $t$ sea capturada por $\forall Y$, se renombra la variable ligada $Y$ por $Y'$:

$$\sigma\{Z := t\} = (\exists X . \forall Y' . P(X, Y', g(f(Y), Y))) \wedge \forall Z . P(X, Y, Z)$$





---

### III. Sustitución simultánea $\sigma\{X := t, Y := t, Z := t\}$ con $t = g(f(Y), Y)$

Reemplaza de forma simultánea todas las ocurrencias libres de $X, Y, Z$ por $t$ (renombrando la variable ligada $Y$ a $Y'$ en la primera parte para evitar captura):

$$\sigma\{X := t, Y := t, Z := t\} = (\exists X . \forall Y' . P(X, Y', g(f(Y), Y))) \wedge \forall Z . P(g(f(Y), Y), g(f(Y), Y), Z)$$

---

### IV. Composición de sustituciones $\sigma(\{X := t\} \circ \{Y := t\} \circ \{Z := t\})$

Por definición, la composición de sustituciones $(\theta_1 \circ \theta_2 \circ \theta_3)$ aplicada a una fórmula equivale a aplicar secuencialmente de derecha a izquierda:

$$\sigma((\theta_1 \circ \theta_2) \circ \theta_3) = ((\sigma \theta_1) \theta_2) \theta_3$$

1. **Paso 1: Aplicar $\{Z := t\}$ a $\sigma$:**

$$\sigma_1 = \sigma\{Z := t\} = (\exists X . \forall Y' . P(X, Y', g(f(Y), Y))) \wedge \forall Z . P(X, Y, Z)$$


2. **Paso 2: Aplicar $\{Y := t\}$ a $\sigma_1$:**
Reemplaza las ocurrencias libres de $Y$ (tanto en la $Y$ libre del segundo conjuncto como en el término $t$ introducido en el paso anterior):

$$\sigma_2 = \sigma_1\{Y := t\} = (\exists X . \forall Y' . P(X, Y', g(f(g(f(Y), Y)), g(f(Y), Y)))) \wedge \forall Z . P(X, g(f(Y), Y), Z)$$


3. **Paso 3: Aplicar $\{X := t\}$ a $\sigma_2$:**
Reemplaza la ocurrencia libre de $X$ en el segundo conjuncto por $t$:

$$\sigma_3 = \sigma_2\{X := t\} = (\exists X . \forall Y' . P(X, Y', g(f(g(f(Y), Y)), g(f(Y), Y)))) \wedge \forall Z . P(g(f(Y), Y), g(f(Y), Y), Z)$$

A continuación se presenta la resolución completa, detallada y formal de los ejercicios 9 al 14 de la **Práctica 6: Lógica y Resolución**, justificando cada paso según las definiciones y algoritmos de la teórica.

---

# Ejercicio 9

El enunciado solicita unir con flechas las expresiones que unifican entre sí (entre una fila y la otra), y exhibir el unificador más general ($mgu$).

* Fila superior: $P(f(X))$, $P(a)$, $P(Y)$, $Q(X, f(Y))$, $Q(X, f(Z))$, $Q(X, f(a))$, $X$, $f(X)$.


* Fila inferior: $P(X)$, $P(f(a))$, $P(g(Z))$, $Q(f(Y), X)$, $Q(f(Y), f(X))$, $Q(f(Y), Y)$, $f(f(c))$, $f(g(Y))$.



Se asume que $a, c$ son constantes, $X, Y, Z$ son variables, $f, g$ son funciones y $P, Q$ predicados. Al considerar expresiones de dos listas distintas, renombramos las variables de cada par para evitar colisiones antes de unificar.

1. **Par 1: $P(f(X))$ y $P(f(a))$**

* Planteo: $\{P(f(X)) \stackrel{?}{=} P(f(a))\}$.


* Decompose: $\{f(X) \stackrel{?}{=} f(a)\} \rightarrow \{X \stackrel{?}{=} a\}$.


* Elim: queda el conjunto vacío con la sustitución resultante.


* **$mgu = \{X := a\}$**


2. **Par 2: $P(a)$ y $P(X)$**

* Planteo: $\{P(a) \stackrel{?}{=} P(X)\}$.


* Decompose: $\{a \stackrel{?}{=} X\}$.


* Swap: $\{X \stackrel{?}{=} a\}$.


* **$mgu = \{X := a\}$**


3. **Par 3: $P(Y)$ y $P(g(Z))$**

* Planteo: $\{P(Y) \stackrel{?}{=} P(g(Z))\}$.


* Decompose: $\{Y \stackrel{?}{=} g(Z)\}$.


* Como $Y \notin fv(g(Z))$, se elimina $Y$.


* **$mgu = \{Y := g(Z)\}$**


4. **Par 4: $Q(X_1, f(Y_1))$ y $Q(f(Y_2), f(X_2))$**

* Planteo con variables separadas: $\{Q(X_1, f(Y_1)) \stackrel{?}{=} Q(f(Y_2), f(X_2))\}$.


* Decompose: $\{X_1 \stackrel{?}{=} f(Y_2), \; f(Y_1) \stackrel{?}{=} f(X_2)\}$.


* Decompose sobre la segunda igualdad: $\{X_1 \stackrel{?}{=} f(Y_2), \; Y_1 \stackrel{?}{=} X_2\}$.


* **$mgu = \{X_1 := f(Y_2), \; Y_1 := X_2\}$** (o sobre las variables originales: $\{X := f(Y'), \; Y := X'\}$).




5. **Par 5: $Q(X_1, f(Z_1))$ y $Q(f(Y_2), X_2)$**

* Planteo: $\{Q(X_1, f(Z_1)) \stackrel{?}{=} Q(f(Y_2), X_2)\}$.


* Decompose: $\{X_1 \stackrel{?}{=} f(Y_2), \; f(Z_1) \stackrel{?}{=} X_2\}$.


* Swap en la segunda ecuación: $\{X_1 \stackrel{?}{=} f(Y_2), \; X_2 \stackrel{?}{=} f(Z_1)\}$.


* **$mgu = \{X_1 := f(Y_2), \; X_2 := f(Z_1)\}$**


6. **Par 6: $Q(X_1, f(a))$ y $Q(f(Y_2), Y_2)$**

* Planteo: $\{Q(X_1, f(a)) \stackrel{?}{=} Q(f(Y_2), Y_2)\}$.


* Decompose: $\{X_1 \stackrel{?}{=} f(Y_2), \; f(a) \stackrel{?}{=} Y_2\}$.


* Swap: $\{X_1 \stackrel{?}{=} f(Y_2), \; Y_2 \stackrel{?}{=} f(a)\}$.


* Elim de $Y_2$ aplicando $\{Y_2 := f(a)\}$ sobre $X_1$: $\{X_1 \stackrel{?}{=} f(f(a))\}$.


* **$mgu = \{X_1 := f(f(a)), \; Y_2 := f(a)\}$**


7. **Par 7: $X$ y $f(f(c))$**

* Planteo: $\{X \stackrel{?}{=} f(f(c))\}$.


* Como $X \notin fv(f(f(c)))$, se aplica Elim directamente.


* **$mgu = \{X := f(f(c))\}$**


8. **Par 8: $f(X)$ y $f(g(Y))$**

* Planteo: $\{f(X) \stackrel{?}{=} f(g(Y))\}$.


* Decompose: $\{X \stackrel{?}{=} g(Y)\}$.


* Como $X \notin fv(g(Y))$, se aplica Elim.


* **$mgu = \{X := g(Y)\}$**



---

# Ejercicio 10

Determinar si cada par de términos unifica aplicando el algoritmo de Martelli-Montanari paso a paso.

#### I. $f(X, X, Y)$ y $f(a, b, Z)$

* Sistema inicial: $E_0 = \{f(X, X, Y) \stackrel{?}{=} f(a, b, Z)\}$.


* Regla **Decompose** (mismo constructor $f$ con aridad 3):



$$E_1 = \{X \stackrel{?}{=} a, \; X \stackrel{?}{=} b, \; Y \stackrel{?}{=} Z\}$$


* Regla **Elim** sobre $X \stackrel{?}{=} a$ (sustituyendo $X$ por $a$ en el resto):
Sustitución parcial: $\{X := a\}$.



$$E_2 = \{a \stackrel{?}{=} b, \; Y \stackrel{?}{=} Z\}$$


* Regla **Clash** sobre $a \stackrel{?}{=} b$: son dos constantes distintas ($a \ne b$).


* **Conclusión:** El algoritmo **falla por Clash**. Los términos **no son unificables**.



#### II. $Y$ y $f(X)$

* Sistema inicial: $E_0 = \{Y \stackrel{?}{=} f(X)\}$.


* La ecuación tiene la forma $Y \stackrel{?}{=} t$ donde $Y$ es variable y $Y \notin fv(f(X))$.


* Regla **Elim**: se registra $\{Y := f(X)\}$ y el conjunto de ecuaciones queda vacío:



$$E_1 = \emptyset$$


* **Conclusión:** Son unificables con **$mgu = \{Y := f(X)\}$**.



#### III. $f(g(c, Y), X)$ y $f(Z, g(Z, a))$

* Sistema inicial: $E_0 = \{f(g(c, Y), X) \stackrel{?}{=} f(Z, g(Z, a))\}$.


* Regla **Decompose**:

$$E_1 = \{g(c, Y) \stackrel{?}{=} Z, \; X \stackrel{?}{=} g(Z, a)\}$$


* Regla **Swap** sobre la primera ecuación ($t \stackrel{?}{=} Z$ con $t$ no variable):



$$E_2 = \{Z \stackrel{?}{=} g(c, Y), \; X \stackrel{?}{=} g(Z, a)\}$$


* Regla **Elim** sobre $Z$: como $Z \notin fv(g(c, Y))$, aplicamos $\{Z := g(c, Y)\}$ al resto del sistema:



$$E_3 = \{X \stackrel{?}{=} g(g(c, Y), a)\}$$


* Regla **Elim** sobre $X$: como $X \notin fv(g(g(c, Y), a))$, aplicamos $\{X := g(g(c, Y), a)\}$:



$$E_4 = \emptyset$$


* Composición de las sustituciones:
* $Z \mapsto g(c, Y)$
* $X \mapsto g(g(c, Y), a)$


* **Conclusión:** Son unificables con **$mgu = \{Z := g(c, Y), \; X := g(g(c, Y), a)\}$**.



#### IV. $f(a)$ y $g(Y)$

* Sistema inicial: $E_0 = \{f(a) \stackrel{?}{=} g(Y)\}$.


* Regla **Clash**: los símbolos principales de función difieren ($f \ne g$).


* **Conclusión:** El algoritmo **falla por Clash**. Los términos **no son unificables**.



#### V. $f(X)$ y $X$

* Sistema inicial: $E_0 = \{f(X) \stackrel{?}{=} X\}$.


* Regla **Swap**:

$$E_1 = \{X \stackrel{?}{=} f(X)\}$$


* Como $X \ne f(X)$ y $X \in fv(f(X))$, se activa la regla **Occurs-Check**.


* **Conclusión:** El algoritmo **falla por Occurs-Check**. Los términos **no son unificables**.



#### VI. $g(X, Y)$ y $g(f(Y), f(X))$

* Sistema inicial: $E_0 = \{g(X, Y) \stackrel{?}{=} g(f(Y), f(X))\}$.


* Regla **Decompose**:

$$E_1 = \{X \stackrel{?}{=} f(Y), \; Y \stackrel{?}{=} f(X)\}$$


* Regla **Elim** sobre $X$ con $\{X := f(Y)\}$ (pues $X \notin fv(f(Y))$):



$$E_2 = \{Y \stackrel{?}{=} f(f(Y))\}$$


* Regla **Occurs-Check**: tenemos la ecuación $Y \stackrel{?}{=} f(f(Y))$ donde $Y \in fv(f(f(Y)))$.


* **Conclusión:** El algoritmo **falla por Occurs-Check**. Los términos **no son unificables**.



---

# Ejercicio 11

Preguntas conceptuales sobre unificación:

#### I. Propiedades de la relación "unifica con" entre términos



Sean $s, t, u$ términos de primer orden:

* **Reflexiva:** **Sí**. Para todo término $t$, el par $\{t \stackrel{?}{=} t\}$ siempre unifica mediante la sustitución identidad $\emptyset$, ya que $\emptyset(t) = t = \emptyset(t)$ (regla Delete).


* **Simétrica:** **Sí**. Si $s$ unifica con $t$, existe una sustitución $\sigma$ tal que $\sigma(s) = \sigma(t)$, lo cual es idéntico a $\sigma(t) = \sigma(s)$, por lo que $t$ unifica con $s$.


* **Transitiva:** **No**.
* Contraejemplo: Sean $s = a$, $t = X$, $u = b$ (con $a, b$ constantes distintas y $X$ variable).


* $s$ unifica con $t$ mediante $\{X := a\}$.


* $t$ unifica con $u$ mediante $\{X := b\}$.


* Sin embargo, $s$ ($a$) no unifica con $u$ ($b$) porque falla por Clash ($a \ne b$).





#### II. ¿Existe algún término $t$ tal que todo término $s$ unifique con él?



* **Respuesta:** **No, no existe.**
* **Justificación:** Si existiera dicho término $t$:
* Si $t$ fuera un término no variable (por ejemplo $f(\dots)$ o una constante $c$), no podría unificar con ningún término cuyo constructor principal sea distinto (falla por Clash, por ejemplo $g(\dots)$ con $f \ne g$).


* Si $t$ fuera una variable $X$, consideremos el término $s = f(X)$. La ecuación $X \stackrel{?}{=} f(X)$ falla por Occurs-Check ($X \in fv(f(X))$).


* Si se pretendiera renombrar la variable para que no coincida (tomando $s = f(Y)$), entonces no se estaría unificando contra *todo* término sintáctico fijado de antemano. Por definición estricta de la relación binaria entre términos fijos, para cualquier variable $X$, el término $f(X)$ no unifica con $X$.





#### III. Algoritmo de unificación para un conjunto finito de términos



* Dado un conjunto finito $\{t_1, t_2, \dots, t_n\}$, todos los términos unifican simultáneamente si y solo si existe una sustitución $\sigma$ tal que $\sigma(t_1) = \sigma(t_2) = \dots = \sigma(t_n)$.


* Para determinarlo mediante Martelli-Montanari, se construye el sistema de ecuaciones igualando un término fijo (por ejemplo $t_1$) con cada uno de los restantes:



$$E = \{t_1 \stackrel{?}{=} t_2, \; t_1 \stackrel{?}{=} t_3, \; \dots, \; t_1 \stackrel{?}{=} t_n\}$$


* Se ejecutan las reglas estándar de Martelli-Montanari sobre $E$. Si el algoritmo termina con éxito, devuelve el $mgu$ común a todos; si alguna ecuación falla por Clash u Occurs-Check, no existe tal unificador.



---

# Ejercicio 12

El operador $\rightarrow$ representa una función binaria infija. Aplicar el algoritmo MGU sobre los sistemas dados:

#### I. MGU $\{T_1 \rightarrow T_2 \stackrel{?}{=} Nat \rightarrow Bool\}$

1. Decompose sobre $\rightarrow$:



$$E_1 = \{T_1 \stackrel{?}{=} Nat, \; T_2 \stackrel{?}{=} Bool\}$$


2. Elim sobre $T_1$ con $\{T_1 := Nat\}$:



$$E_2 = \{T_2 \stackrel{?}{=} Bool\}$$


3. Elim sobre $T_2$ con $\{T_2 := Bool\}$:



$$E_3 = \emptyset$$



* **Resultado:** Éxito con **$\sigma = \{T_1 := Nat, \; T_2 := Bool\}$**

#### II. MGU $\{T_1 \rightarrow T_2 \stackrel{?}{=} T_3\}$

1. Swap ($T_3$ es variable y el término izquierdo no):



$$E_1 = \{T_3 \stackrel{?}{=} T_1 \rightarrow T_2\}$$


2. Elim sobre $T_3$ (dado que $T_3 \notin fv(T_1 \rightarrow T_2)$):



$$E_2 = \emptyset$$



* **Resultado:** Éxito con **$\sigma = \{T_3 := T_1 \rightarrow T_2\}$**

#### III. MGU $\{T_1 \rightarrow T_2 \stackrel{?}{=} T_2\}$

1. Swap:

$$E_1 = \{T_2 \stackrel{?}{=} T_1 \rightarrow T_2\}$$


2. Occurs-Check: la variable $T_2$ aparece en el miembro derecho ($T_2 \in fv(T_1 \rightarrow T_2)$).



* **Resultado:** **Falla por Occurs-Check** (no unifica).



#### IV. MGU $\{(T_2 \rightarrow T_1) \rightarrow Bool \stackrel{?}{=} T_2 \rightarrow T_3\}$

1. Decompose sobre la flecha principal:



$$E_1 = \{T_2 \rightarrow T_1 \stackrel{?}{=} T_2, \; Bool \stackrel{?}{=} T_3\}$$


2. Swap sobre la primera ecuación:

$$E_2 = \{T_2 \stackrel{?}{=} T_2 \rightarrow T_1, \; Bool \stackrel{?}{=} T_3\}$$


3. Occurs-Check sobre $T_2 \stackrel{?}{=} T_2 \rightarrow T_1$ ($T_2 \in fv(T_2 \rightarrow T_1)$).



* **Resultado:** **Falla por Occurs-Check**.



#### V. MGU $\{T_2 \rightarrow (T_1 \rightarrow Bool) \stackrel{?}{=} T_2 \rightarrow T_3\}$

*(Asociando a derecha la flecha del miembro izquierdo según la convención estándar de tipos)*

1. Decompose sobre la flecha exterior:



$$E_1 = \{T_2 \stackrel{?}{=} T_2, \; T_1 \rightarrow Bool \stackrel{?}{=} T_3\}$$


2. Delete sobre $T_2 \stackrel{?}{=} T_2$:



$$E_2 = \{T_1 \rightarrow Bool \stackrel{?}{=} T_3\}$$


3. Swap:



$$E_3 = \{T_3 \stackrel{?}{=} T_1 \rightarrow Bool\}$$


4. Elim sobre $T_3$:



$$E_4 = \emptyset$$



* **Resultado:** Éxito con **$\sigma = \{T_3 := T_1 \rightarrow Bool\}$**

#### VI. MGU $\{T_1 \rightarrow Bool \stackrel{?}{=} Nat \rightarrow Bool, \; T_1 \stackrel{?}{=} T_2 \rightarrow T_3\}$

1. Decompose sobre la primera ecuación:



$$E_1 = \{T_1 \stackrel{?}{=} Nat, \; Bool \stackrel{?}{=} Bool, \; T_1 \stackrel{?}{=} T_2 \rightarrow T_3\}$$


2. Delete sobre $Bool \stackrel{?}{=} Bool$:



$$E_2 = \{T_1 \stackrel{?}{=} Nat, \; T_1 \stackrel{?}{=} T_2 \rightarrow T_3\}$$


3. Elim sobre $T_1$ con $\{T_1 := Nat\}$ reemplazando en la restante:



$$E_3 = \{Nat \stackrel{?}{=} T_2 \rightarrow T_3\}$$


4. Clash: el constructor $Nat$ (aridad 0) difiere de $\rightarrow$ (aridad 2).



* **Resultado:** **Falla por Clash**.



#### VII. MGU $\{T_1 \rightarrow Bool \stackrel{?}{=} Nat \rightarrow Bool, \; T_2 \stackrel{?}{=} T_1 \rightarrow T_1\}$

1. Decompose sobre la primera ecuación:



$$E_1 = \{T_1 \stackrel{?}{=} Nat, \; Bool \stackrel{?}{=} Bool, \; T_2 \stackrel{?}{=} T_1 \rightarrow T_1\}$$


2. Delete sobre $Bool \stackrel{?}{=} Bool$:



$$E_2 = \{T_1 \stackrel{?}{=} Nat, \; T_2 \stackrel{?}{=} T_1 \rightarrow T_1\}$$


3. Elim sobre $T_1$ con $\{T_1 := Nat\}$ sustituyendo en la segunda ecuación:
Sustitución acumulada: $\{T_1 := Nat\}$.



$$E_3 = \{T_2 \stackrel{?}{=} Nat \rightarrow Nat\}$$


4. Elim sobre $T_2$ con $\{T_2 := Nat \rightarrow Nat\}$:



$$E_4 = \emptyset$$



* **Resultado:** Éxito con **$\sigma = \{T_1 := Nat, \; T_2 := Nat \rightarrow Nat\}$**

#### VIII. MGU $\{T_1 \rightarrow T_2 \stackrel{?}{=} T_3 \rightarrow T_4, \; T_3 \stackrel{?}{=} T_2 \rightarrow T_1\}$

1. Decompose sobre la primera ecuación:



$$E_1 = \{T_1 \stackrel{?}{=} T_3, \; T_2 \stackrel{?}{=} T_4, \; T_3 \stackrel{?}{=} T_2 \rightarrow T_1\}$$


2. Elim sobre $T_1$ con $\{T_1 := T_3\}$ reemplazando en el sistema:



$$E_2 = \{T_2 \stackrel{?}{=} T_4, \; T_3 \stackrel{?}{=} T_2 \rightarrow T_3\}$$


3. Occurs-Check en $T_3 \stackrel{?}{=} T_2 \rightarrow T_3$ ($T_3 \in fv(T_2 \rightarrow T_3)$).



* **Resultado:** **Falla por Occurs-Check**.



---

# Ejercicio 13

Convertir a Forma Normal Negada (NNF) aplicando:

1. Reemplazo de $\sigma \Rightarrow \tau$ por $\neg \sigma \vee \tau$.


2. Empuje de negaciones hacia los literales (De Morgan y dualidad de cuantificadores).



#### I. $\forall X. \forall Y. (\neg Q(X, Y) \Rightarrow \neg P(X, Y))$

1. Eliminación de la implicación:



$$\forall X. \forall Y. (\neg(\neg Q(X, Y)) \vee \neg P(X, Y))$$


2. Doble negación ($\neg\neg \sigma \equiv \sigma$):



$$\forall X. \forall Y. (Q(X, Y) \vee \neg P(X, Y))$$



* **Resultado en NNF:** $\forall X. \forall Y. (Q(X, Y) \vee \neg P(X, Y))$

#### II. $\forall X. \forall Y. ((P(X, Y) \wedge Q(X, Y)) \Rightarrow R(X, Y))$

1. Eliminación de la implicación:



$$\forall X. \forall Y. (\neg(P(X, Y) \wedge Q(X, Y)) \vee R(X, Y))$$


2. Ley de De Morgan ($\neg(A \wedge B) \equiv \neg A \vee \neg B$):



$$\forall X. \forall Y. (\neg P(X, Y) \vee \neg Q(X, Y) \vee R(X, Y))$$



* **Resultado en NNF:** $\forall X. \forall Y. (\neg P(X, Y) \vee \neg Q(X, Y) \vee R(X, Y))$

#### III. $\forall X. \exists Y. (P(X, Y) \Rightarrow Q(X, Y))$

1. Eliminación de la implicación:



$$\forall X. \exists Y. (\neg P(X, Y) \vee Q(X, Y))$$



* Las negaciones ya operan únicamente sobre fórmulas atómicas.


* **Resultado en NNF:** $\forall X. \exists Y. (\neg P(X, Y) \vee Q(X, Y))$

---

# Ejercicio 14

Convertir a Forma Normal de Skolem y luego a Forma Clausal aplicando los pasos de la teórica:

1. Pasar a NNF.


2. Skolemizar existenciales (introducir constantes para existenciales fuera del alcance de universales, o funciones de Skolem con las variables universales que lo encierran).


3. Extraer universales a la cabeza (Forma Normal de Skolem).


4. Pasar la matriz a CNF distribuyendo $\vee$ sobre $\wedge$.


5. Escribir como conjunto de cláusulas $\{\{l_1, \dots\}, \dots\}$.



#### I. $\exists X. \exists Y. X < Y$

1. **NNF:** La fórmula ya está en NNF.


2. **Skolemización:** Como no hay cuantificadores universales gobernando a $X$ ni a $Y$, ambos se reemplazan por constantes nuevas de Skolem, $c_1$ y $c_2$:



$$\{X := c_1, \; Y := c_2\}$$


3. **Forma Normal de Skolem:** $c_1 < c_2$.


4. **Forma Clausal:**

$$\{\{c_1 < c_2\}\}$$



#### II. $\forall X. \exists Y. X < Y$

1. **NNF:** Ya se encuentra en NNF.


2. **Skolemización:** El existencial $\exists Y$ está bajo el alcance del cuantificador universal $\forall X$. Se reemplaza $Y$ por el término funcional $f(X)$ donde $f$ es una función nueva de aridad 1:



$$\forall X. (X < f(X))$$


3. **Forma Normal de Skolem:** $\forall X. X < f(X)$.


4. **Forma Clausal:**

$$\{\{X < f(X)\}\}$$



#### III. $\forall X. \neg(P(X) \wedge \forall Y. (\neg P(Y) \vee Q(Y)))$

1. **Paso a NNF:**
* Empujar la negación exterior usando De Morgan:



$$\forall X. (\neg P(X) \vee \neg(\forall Y. (\neg P(Y) \vee Q(Y))))$$


* Negación del universal ($\neg \forall Y. \sigma \equiv \exists Y. \neg \sigma$):



$$\forall X. (\neg P(X) \vee \exists Y. \neg(\neg P(Y) \vee Q(Y)))$$


* De Morgan y doble negación en la subfórmula interna:



$$\forall X. (\neg P(X) \vee \exists Y. (P(Y) \wedge \neg Q(Y)))$$




2. **Skolemización:** El existencial $\exists Y$ está bajo el alcance de $\forall X$. Se reemplaza $Y$ por $f(X)$ ($f$ fresca):



$$\forall X. (\neg P(X) \vee (P(f(X)) \wedge \neg Q(f(X))))$$


3. **Forma Normal de Skolem:** $\forall X. (\neg P(X) \vee (P(f(X)) \wedge \neg Q(f(X))))$.


4. **Paso a CNF (distribuir $\vee$ sobre $\wedge$):**

$$(\neg P(X) \vee P(f(X))) \wedge (\neg P(X) \vee \neg Q(f(X)))$$



5. **Forma Clausal:**

$$\{\{\neg P(X), \; P(f(X))\}, \; \{\neg P(X), \; \neg Q(f(X))\}\}$$




#### IV. $\exists X. \forall Y. (P(X, Y) \wedge Q(X) \wedge \neg R(Y))$

1. **NNF:** La matriz ya está en NNF.


2. **Skolemización:** $\exists X$ no está dominado por ningún cuantificador universal; se reemplaza $X$ por una constante de Skolem $c$:



$$\forall Y. (P(c, Y) \wedge Q(c) \wedge \neg R(Y))$$


3. **Forma Normal de Skolem:** $\forall Y. (P(c, Y) \wedge Q(c) \wedge \neg R(Y))$.


4. **Paso a CNF:** Ya es una conjunción de cláusulas unitarias.


5. **Forma Clausal:**

$$\{\{P(c, Y)\}, \; \{Q(c)\}, \; \{\neg R(Y)\}\}$$




(Al separar en cláusulas independientes, cada una cuantifica universalmente sus variables por separado, pudiéndose renombrar si fuera necesario: $\{\{P(c, Y)\}, \{Q(c)\}, \{\neg R(Z)\}\}$).



#### V. $\forall X. (P(X) \wedge \exists Y. (Q(Y) \vee \forall Z. \exists W. (P(Z) \wedge \neg Q(W))))$

1. **NNF:** La fórmula ya está en NNF.


2. **Skolemización:**
* $\exists Y$ está bajo el alcance de $\forall X$. Se reemplaza $Y$ por $f(X)$ ($f$ símbolo nuevo de aridad 1):



$$\forall X. (P(X) \wedge (Q(f(X)) \vee \forall Z. \exists W. (P(Z) \wedge \neg Q(W))))$$


* $\exists W$ está bajo el alcance de los universales $\forall X$ y $\forall Z$. Se reemplaza $W$ por $g(X, Z)$ ($g$ símbolo nuevo de aridad 2):



$$\forall X. (P(X) \wedge (Q(f(X)) \vee \forall Z. (P(Z) \wedge \neg Q(g(X, Z)))))$$




3. **Forma Normal de Skolem (extrayendo $\forall Z$ hacia afuera):**
Como $Z$ no aparece libre en $Q(f(X))$ ni en $P(X)$, se extrae el cuantificador universal:



$$\forall X. \forall Z. (P(X) \wedge (Q(f(X)) \vee (P(Z) \wedge \neg Q(g(X, Z)))))$$


4. **Paso a CNF (distribución de $\vee$ sobre $\wedge$):**
* En la subfórmula interna: $Q(f(X)) \vee (P(Z) \wedge \neg Q(g(X, Z)))$

$$\equiv (Q(f(X)) \vee P(Z)) \wedge (Q(f(X)) \vee \neg Q(g(X, Z)))$$


* La conjunción completa queda:

$$P(X) \wedge (Q(f(X)) \vee P(Z)) \wedge (Q(f(X)) \vee \neg Q(g(X, Z)))$$




5. **Forma Clausal:**

$$\{\{P(X)\}, \; \{Q(f(X)), \; P(Z)\}, \; \{Q(f(X)), \; \neg Q(g(X, Z))\}\}$$


A continuación se presenta la resolución completa, formal y detallada de los ejercicios 15 a 22 de la Práctica 6 (Lógica y Resolución), siguiendo rigurosamente las pautas, reglas de transformación y algoritmos desarrollados en la clase teórica.

---

# Ejercicio 15

Para pensar (o jugar):

#### Item I: Exhibir una cláusula que arroje un resolvente consigo misma

.

* **Definición de resolución en LPO:** Dadas dos instancias de cláusulas (renombradas para que no compartan variables), se unifica un subconjunto no vacío de literales positivos con uno de literales negativos.


* **Cláusula propuesta:**

$$\kappa = \{P(X), \neg P(f(X))\}$$


* **Justificación:**
1. Tomamos una copia de $\kappa$ renombrando su variable para garantizar variables disjuntas:

$$\kappa_1 = \{P(X), \neg P(f(X))\}, \quad \kappa_2 = \{P(Y), \neg P(f(Y))\}$$


2. Seleccionamos el literal positivo $P(X)$ de $\kappa_1$ y el literal negativo $\neg P(f(Y))$ de $\kappa_2$.


3. Buscamos el unificador más general:

$$mgu(P(X) \stackrel{?}{=} P(f(Y))) = \{X := f(Y)\}$$





4. Aplicando la sustitución al resto de los literales se obtiene la resolvente:



$$\rho = \{\neg P(f(f(Y))), P(Y)\}$$



Por lo tanto, la cláusula resuelve consigo misma arrojando un resolvente no trivial.



#### Item II: Exhibir dos cláusulas, cada una con no más de dos literales, que arrojen tres o más resolventes distintos entre sí

.

* **Cláusulas propuestas:**

$$\kappa_1 = \{P(a), P(b)\}, \quad \kappa_2 = \{\neg P(X), Q(X)\}$$



Ambas tienen a lo sumo 2 literales.
Para obtener más variedad de resolventes entre dos cláusulas de tamaño 2, consideramos un predicado binario y dos variables:



$$\kappa_1 = \{P(X, Y), P(Y, X)\}, \quad \kappa_2 = \{\neg P(a, b), \neg P(b, a)\}$$


1. **Resolvente 1:** Se resuelve $P(X, Y)$ con $\neg P(a, b)$ vía $\{X := a, Y := b\}$.
El literal restante de $\kappa_1$ es $P(b, a)$, y el de $\kappa_2$ es $\neg P(b, a)$. Al resolver solo ese par, la resolvente es:

$$\rho_1 = \{P(b, a), \neg P(b, a)\}$$


2. **Resolvente 2:** Se resuelve $P(X, Y)$ con $\neg P(b, a)$ vía $\{X := b, Y := a\}$.
Queda:

$$\rho_2 = \{P(a, b), \neg P(a, b)\}$$


3. **Resolvente 3:** Se resuelven ambos literales positivos a la vez con ambos negativos (factorización/resolución general con $p=2, q=2$ o unificando ambos miembros). Con la sustitución $\{X := a, Y := b\}$, ambos literales de $\kappa_1$ unifican con ambos de $\kappa_2$, arrojando:



$$\rho_3 = \{\}$$



Dado que $\rho_1 \neq \rho_2 \neq \rho_3$, las dos cláusulas producen tres resolventes distintos.



#### Item III: Exhibir dos cláusulas que arrojen como resolvente la cláusula vacía si se unifican tres o más términos a la vez, pero no si se unifica solamente un término de cada lado

.

* **Marco conceptual:** La regla de resolución binaria (unificar exactamente un literal de cada lado) es incompleta para lógica de primer orden. La regla general permite unificar subconjuntos de tamaño $p \ge 1$ y $q \ge 1$.


* **Cláusulas propuestas:**

$$\kappa_1 = \{P(X), P(Y)\}, \quad \kappa_2 = \{\neg P(Z), \neg P(W)\}$$





* **Justificación:**
1. Si se unifica solamente un término de cada cláusula ($p=1, q=1$), por ejemplo $P(X)$ con $\neg P(Z)$ mediante $\{X := Z\}$:



$$\rho = \{P(Y), \neg P(W)\}$$



El resolvente obtenido tiene 2 literales, por lo que **no** es la cláusula vacía. Lo mismo ocurre para cualquier otra combinación de pares únicos.


2. Si se unifican tres o más términos a la vez (por ejemplo los cuatro términos, $p=2, q=2$):

$$mgu(\{P(X) \stackrel{?}{=} P(Y) \stackrel{?}{=} P(Z) \stackrel{?}{=} P(W)\}) = \{Y := X, Z := X, W := X\}$$



Al cancelarse simultáneamente todos los literales, el resolvente obtenido es directamente la cláusula vacía:



$$\rho = \{\}$$





---

# Ejercicio 16

Modelado y refutación del caso del Sr. Smullyan.

#### 1. Formalización del lenguaje y premisas

* **Predicados y constantes:**
* $Pag\acute{o}(X)$: "$X$ pagó su multa".


* $Esp\acute{i}a(X)$: "$X$ es un espía".


* $smullyan$: Sr. Smullyan.


* $jefeGob$: Jefe de gobierno.




* **Premisas:**
1. La computadora registró que Smullyan no pagó:

$$F_1 = \neg Pag\acute{o}(smullyan)$$


2. La computadora registró que Smullyan pagó la multa:

$$F_2 = Pag\acute{o}(smullyan)$$




* **Conclusión a demostrar:**
"El jefe de gobierno es un espía":



$$C = Esp\acute{i}a(jefeGob)$$



#### 2. Método de refutación

Para probar que $\{F_1, F_2\} \models C$, se niega la conclusión ($\neg C$) y se busca derivar la cláusula vacía a partir del conjunto de cláusulas:


$$\mathcal{C}_0 = \{F_1, F_2, \neg C\}$$

#### 3. Pasaje a forma clausal

* $F_1 \equiv \neg Pag\acute{o}(smullyan) \implies \kappa_1 = \{\neg Pag\acute{o}(smullyan)\}$
* $F_2 \equiv Pag\acute{o}(smullyan) \implies \kappa_2 = \{Pag\acute{o}(smullyan)\}$
* $\neg C \equiv \neg Esp\acute{i}a(jefeGob) \implies \kappa_3 = \{\neg Esp\acute{i}a(jefeGob)\}$

#### 4. Derivación por resolución

1. Cláusula 1: $\{\neg Pag\acute{o}(smullyan)\}$
2. Cláusula 2: $\{Pag\acute{o}(smullyan)\}$
3. Cláusula 3: $\{\neg Esp\acute{i}a(jefeGob)\}$
4. Resolvente entre $\kappa_1$ y $\kappa_2$:
Ambos literales son complementarios idénticos con unificador trivial $\sigma = \emptyset$.



$$\kappa_4 = \{\}$$



* **Conclusión:** Se derivó la cláusula vacía ($\mathcal{C}_0 \vdash \{\}$). Dado que las premisas iniciales contenían una contradicción explícita ($Pag\acute{o}(smullyan) \wedge \neg Pag\acute{o}(smullyan)$), por el principio de explosión (*ex falso sequitur quodlibet*) de premisas inconsistentes se deduce lógicamente cualquier fórmula, en particular que el jefe de gobierno es un espía.



---

# Ejercicio 17

Determinar cuáles fórmulas son lógicamente válidas y demostrar las válidas mediante el método de resolución (negando la fórmula, pasando a forma clausal y refutando).

---

#### I. $[\exists X. \forall Y. R(X, Y)] \Rightarrow \forall Y. \exists X. R(X, Y)$



* **Estado:** Es **válida**.


* **Demostración por resolución:**
1. **Negar la fórmula:**

$$\neg ([\exists X. \forall Y. R(X, Y)] \Rightarrow \forall Y. \exists X. R(X, Y))$$





2. **Pasar a NNF:**

$$(\exists X. \forall Y. R(X, Y)) \wedge \neg (\forall Y. \exists X. R(X, Y))$$





$$(\exists X. \forall Y. R(X, Y)) \wedge (\exists Y. \forall X. \neg R(X, Y))$$





3. **Renombrar variables ligadas para que sean disjuntas:**

$$(\exists X_1. \forall Y_1. R(X_1, Y_1)) \wedge (\exists Y_2. \forall X_2. \neg R(X_2, Y_2))$$





4. **Skolemización:**
* $\exists X_1$ no está bajo ningún universal $\implies$ constante de Skolem $c_1$.


* $\exists Y_2$ no está bajo ningún universal $\implies$ constante de Skolem $c_2$.
Fórmula de Skolem:



$$\forall Y_1. \forall X_2. (R(c_1, Y_1) \wedge \neg R(X_2, c_2))$$







5. **Forma clausal:**
* $\kappa_1 = \{R(c_1, Y_1)\}$


* $\kappa_2 = \{\neg R(X_2, c_2)\}$




6. **Resolución:**
* Unificar $R(c_1, Y_1)$ con $R(X_2, c_2)$:



$$mgu = \{X_2 := c_1, \; Y_1 := c_2\}$$





* Resolvente:

$$\kappa_3 = \{\}$$



Como se derivó la cláusula vacía, la fórmula es **válida**.







---

#### II. $[\forall X. \exists Y. R(X, Y)] \Rightarrow \exists Y. \forall X. R(X, Y)$



* **Estado:** **No es válida**.


* **Justificación (Contra-modelo):**
* Universo: $M = \mathbb{N}$.


* Interpretación: $I(R) = \{(x, y) \mid x < y\}$.


* El antecedente afirma: "Para todo número natural $X$, existe un natural $Y$ tal que $X < Y$". Esto es verdadero en $\mathbb{N}$ (basta tomar $Y = X + 1$).
* El consecuente afirma: "Existe un natural $Y$ que es mayor que todo número natural $X$". Esto es falso pues no existe un número mayor a todos en $\mathbb{N}$.
* Al tener antecedente verdadero y consecuente falso en esta estructura, la fórmula no es válida.





---

#### III. $\exists X. [P(X) \Rightarrow \forall X. P(X)]$ (Paradoja del Bebedor simplificada)



* **Estado:** Es **válida**.
* **Demostración por resolución:**
1. Renombramos la variable ligada interna para evitar confusiones de alcance:



$$\exists X. [P(X) \Rightarrow \forall Y. P(Y)]$$


2. **Negar la fórmula:**

$$\neg \exists X. [P(X) \Rightarrow \forall Y. P(Y)]$$





3. **Pasar a NNF:**

$$\forall X. \neg (\neg P(X) \vee \forall Y. P(Y))$$





$$\forall X. (P(X) \wedge \exists Y. \neg P(Y))$$





4. **Skolemización:**
* $\exists Y$ está bajo el alcance de $\forall X$. Se reemplaza $Y$ por $f(X)$:



$$\forall X. (P(X) \wedge \neg P(f(X)))$$







5. **Forma clausal:**
* $\kappa_1 = \{P(X)\}$


* $\kappa_2 = \{\neg P(f(Z))\}$ (renombrando la variable para separar cláusulas)




6. **Resolución:**
* Unificar $P(X)$ con $P(f(Z))$:

$$mgu = \{X := f(Z)\}$$





* Resolvente:

$$\kappa_3 = \{\}$$



Se derivó la cláusula vacía, por lo tanto es **válida**.







---

#### IV. $\exists X. [P(X) \vee Q(X)] \Rightarrow [\exists X. P(X) \vee \exists X. Q(X)]$



* **Estado:** Es **válida**.
* **Demostración por resolución:**
1. Renombrar variables para claridad:

$$(\exists X. (P(X) \vee Q(X))) \Rightarrow ((\exists Y. P(Y)) \vee (\exists Z. Q(Z)))$$





2. **Negar la fórmula:**

$$\neg [(\exists X. (P(X) \vee Q(X))) \Rightarrow ((\exists Y. P(Y)) \vee (\exists Z. Q(Z)))]$$





3. **Pasar a NNF:**

$$(\exists X. (P(X) \vee Q(X))) \wedge \neg (\exists Y. P(Y) \vee \exists Z. Q(Z))$$





$$(\exists X. (P(X) \vee Q(X))) \wedge (\forall Y. \neg P(Y)) \wedge (\forall Z. \neg Q(Z))$$





4. **Skolemización:**
* $\exists X$ no está dominado por universales $\implies$ constante $c$:



$$\forall Y. \forall Z. ((P(c) \vee Q(c)) \wedge \neg P(Y) \wedge \neg Q(Z))$$







5. **Forma clausal:**
* $\kappa_1 = \{P(c), Q(c)\}$


* $\kappa_2 = \{\neg P(Y)\}$


* $\kappa_3 = \{\neg Q(Z)\}$




6. **Resolución:**
* De $\kappa_1$ y $\kappa_2$ con $mgu = \{Y := c\}$:

$$\kappa_4 = \{Q(c)\}$$





* De $\kappa_4$ y $\kappa_3$ con $mgu = \{Z := c\}$:

$$\kappa_5 = \{\}$$



La fórmula es **válida**.







---

#### V. $\forall X. [P(X) \vee Q(X)] \Rightarrow [\forall X. P(X) \vee \forall X. Q(X)]$



* **Estado:** **No es válida**.
* **Justificación (Contra-modelo):**
* Universo: $M = \{1, 2\}$.


* Interpretación: $I(P) = \{1\}$, $I(Q) = \{2\}$.


* Todo elemento cumple $P$ o cumple $Q$, luego $\forall X. [P(X) \vee Q(X)]$ es verdadero.


* Sin embargo, no todos cumplen $P$ (el 2 no lo cumple) y no todos cumplen $Q$ (el 1 no lo cumple), por lo que $[\forall X. P(X) \vee \forall X. Q(X)]$ es falso.


* Al dar verdadero $\Rightarrow$ falso, la fórmula no es válida.





---

#### VI. $[\exists X. P(X) \wedge \forall X. Q(X)] \Rightarrow \exists X. [P(X) \wedge Q(X)]$



* **Estado:** Es **válida**.
* **Demostración por resolución:**
1. Renombrar variables ligadas:

$$[(\exists X. P(X)) \wedge (\forall Y. Q(Y))] \Rightarrow \exists Z. [P(Z) \wedge Q(Z)]$$





2. **Negar la fórmula:**

$$\neg ([(\exists X. P(X)) \wedge (\forall Y. Q(Y))] \Rightarrow \exists Z. [P(Z) \wedge Q(Z)])$$





3. **Pasar a NNF:**

$$(\exists X. P(X)) \wedge (\forall Y. Q(Y)) \wedge \forall Z. (\neg P(Z) \vee \neg Q(Z))$$





4. **Skolemización:**
* $\exists X$ se reemplaza por la constante $c$:



$$\forall Y. \forall Z. (P(c) \wedge Q(Y) \wedge (\neg P(Z) \vee \neg Q(Z)))$$







5. **Forma clausal:**
* $\kappa_1 = \{P(c)\}$


* $\kappa_2 = \{Q(Y)\}$


* $\kappa_3 = \{\neg P(Z), \neg Q(Z)\}$




6. **Resolución:**
* De $\kappa_1$ y $\kappa_3$ con $mgu = \{Z := c\}$:

$$\kappa_4 = \{\neg Q(c)\}$$





* De $\kappa_2$ y $\kappa_4$ con $mgu = \{Y := c\}$:

$$\kappa_5 = \{\}$$



La fórmula es **válida**.







---

#### VII. $\forall X. \exists Y. \forall Z. \exists W. [P(X, Y) \vee \neg P(W, Z)]$



* **Estado:** Es **válida**.
* **Demostración por resolución:**
1. **Negar la fórmula:**

$$\neg \forall X. \exists Y. \forall Z. \exists W. [P(X, Y) \vee \neg P(W, Z)]$$





2. **Pasar a NNF:**

$$\exists X. \forall Y. \exists Z. \forall W. [\neg P(X, Y) \wedge P(W, Z)]$$





3. **Skolemización:**
* $\exists X$ no está bajo universales $\implies$ constante $c_1$.


* $\exists Z$ está bajo $\forall Y \implies$ función $f(Y)$.



$$\forall Y. \forall W. [\neg P(c_1, Y) \wedge P(W, f(Y))]$$







4. **Forma clausal:**
* $\kappa_1 = \{\neg P(c_1, Y)\}$


* $\kappa_2 = \{P(W, f(Y'))\}$ (renombrando la variable universal de $\kappa_2$ a $Y'$)




5. **Resolución:**
* Unificar $P(c_1, Y)$ con $P(W, f(Y'))$:

$$mgu = \{W := c_1, \; Y := f(Y')\}$$





* Resolvente:

$$\kappa_3 = \{\}$$



La fórmula es **válida**.







---

#### VIII. $\forall X. \forall Y. \forall Z. ([\neg P(f(a)) \vee \neg P(Y) \vee Q(Y)] \wedge P(f(Z)) \wedge [\neg P(f(f(X))) \vee \neg Q(f(X))])$



* **Estado:** **No es válida** (de hecho, no toda estructura satisface una conjunción universal arbitraria; por ejemplo si tomamos una estructura donde $Q$ sea siempre falso y $P$ verdadero, la fórmula es falsa).


* Para demostrar que una fórmula es válida por resolución se debe refutar su negación. Al negar esta fórmula, se obtiene una disyunción existencial y su refutación es imposible porque la fórmula no es un teorema de primer orden.



---

# Ejercicio 18

Aplicaciones del método de resolución.

#### I. Regla del Modus Ponens



* **Fórmula lógica:**

$$((P \Rightarrow Q) \wedge P) \Rightarrow Q$$





* **Forma clausal de la negación:**
1. Negación: $\neg (((P \Rightarrow Q) \wedge P) \Rightarrow Q) \equiv (P \Rightarrow Q) \wedge P \wedge \neg Q \equiv (\neg P \vee Q) \wedge P \wedge \neg Q$


2. Cláusulas iniciales:
* $\kappa_1 = \{\neg P, Q\}$


* $\kappa_2 = \{P\}$


* $\kappa_3 = \{\neg Q\}$






* **Resolución:**
1. De $\kappa_1$ y $\kappa_2$ obtenemos $\kappa_4 = \{Q\}$.


2. De $\kappa_4$ y $\kappa_3$ obtenemos $\kappa_5 = \{\}$.




* La regla es **válida**.



#### II. Regla del Modus Tollens



* **Fórmula lógica:**

$$((P \Rightarrow Q) \wedge \neg Q) \Rightarrow \neg P$$


* **Forma clausal de la negación:**
1. Negación: $\neg (((P \Rightarrow Q) \wedge \neg Q) \Rightarrow \neg P) \equiv (\neg P \vee Q) \wedge \neg Q \wedge P$


2. Cláusulas iniciales:
* $\kappa_1 = \{\neg P, Q\}$
* $\kappa_2 = \{\neg Q\}$
* $\kappa_3 = \{P\}$




* **Resolución:**
1. De $\kappa_1$ y $\kappa_2$ obtenemos $\kappa_4 = \{\neg P\}$.


2. De $\kappa_4$ y $\kappa_3$ obtenemos $\kappa_5 = \{\}$.




* La regla es **válida**.



#### III. Regla de Especialización (de $\forall X. P(X)$ concluir $P(t)$ para cualquier término $t$)



* **Fórmula lógica:**

$$(\forall X. P(X)) \Rightarrow P(t)$$


* **Demostración por resolución:**
1. Negación: $\neg ((\forall X. P(X)) \Rightarrow P(t)) \equiv (\forall X. P(X)) \wedge \neg P(t)$


2. Cláusulas iniciales:
* $\kappa_1 = \{P(X)\}$


* $\kappa_2 = \{\neg P(t)\}$




3. Paso de resolución:
* Como $X$ es una variable universal que no aparece en $t$, unificamos $P(X)$ con $P(t)$ mediante:



$$mgu = \{X := t\}$$





* Resolvente:

$$\kappa_3 = \{\}$$









* La regla es **válida**.



---

# Ejercicio 19

Dadas las siguientes cláusulas:

* $C_1 = \{P(X), \neg P(X), Q(a)\}$


* $C_2 = \{P(X), \neg Q(Y), R(X, Y)\}$


* $C_3 = \{\neg P(X, X, Z), \neg Q(X, Y), \neg Q(Y, Z)\}$


* $C_4 = \{M(1, 2, X)\}$



#### I. ¿Cuáles son cláusulas de Horn?



* **Definición:** Una cláusula de Horn contiene **a lo sumo un literal positivo**.


* $C_1$: Contiene 2 literales positivos ($P(X)$ y $Q(a)$). **No es cláusula de Horn**.


* $C_2$: Contiene 2 literales positivos ($P(X)$ y $R(X, Y)$). **No es cláusula de Horn**.


* $C_3$: Contiene 0 literales positivos (todos son negativos). **Sí es cláusula de Horn**.


* $C_4$: Contiene exactamente 1 literal positivo ($M(1, 2, X)$). **Sí es cláusula de Horn**.





#### II. Clasificación de las cláusulas de Horn



* $C_3$: Al tener 0 literales positivos (solo literales negativos), es una **cláusula objetivo** (o consulta / *goal*).


* $C_4$: Al tener exactamente 1 literal positivo y ningún literal negativo, es una cláusula de definición de tipo **hecho** (*fact*).



#### III. Fórmula de primer orden correspondiente a cada cláusula



Una cláusula $\{l_1, \dots, l_k\}$ representa la cuantificación universal de la disyunción de sus literales: $\forall \vec{X}. (l_1 \vee \dots \vee l_k)$.

* Para $C_1$:

$$\forall X. (P(X) \vee \neg P(X) \vee Q(a))$$


* Para $C_2$:

$$\forall X. \forall Y. (P(X) \vee \neg Q(Y) \vee R(X, Y))$$



*(o equivalentemente en forma de implicación: $\forall X. \forall Y. (Q(Y) \Rightarrow (P(X) \vee R(X, Y)))$)*
* Para $C_3$:

$$\forall X. \forall Y. \forall Z. (\neg P(X, X, Z) \vee \neg Q(X, Y) \vee \neg Q(Y, Z))$$



*(o como implicación hacia $\bot$: $\forall X. \forall Y. \forall Z. ((P(X, X, Z) \wedge Q(X, Y) \wedge Q(Y, Z)) \Rightarrow \bot)$)*
* Para $C_4$:

$$\forall X. M(1, 2, X)$$



---

# Ejercicio 20

Condiciones necesarias para que una demostración por resolución sea **SLD** (*Selected literal, Linear resolution for Definite clauses*):

* **Realizarse de manera lineal (utilizando en cada paso el resolvente obtenido en el paso anterior):**
**SÍ, es necesaria.** La "L" de SLD significa *Linear*. Cada paso resuelve el objetivo actual con una cláusula del programa para obtener el siguiente objetivo linealmente.
* **Utilizar únicamente cláusulas de Horn:**
**SÍ, es necesaria.** SLD-resolución está definida estrictamente sobre cláusulas de Horn (un programa de cláusulas definidas y un objetivo con literales negativos).
* **Utilizar cada cláusula a lo sumo una vez:**
**NO es necesaria.** Un programa puede requerir aplicar el mismo hecho o regla múltiples veces a lo largo de una derivación (por ejemplo, en llamadas recursivas).
* **Empezar por una cláusula objetivo (sin literales positivos):**
**SÍ, es necesaria.** Toda refutación SLD comienza con la meta o consulta planteada (que es una cláusula objetivo compuesta exclusivamente por literales negativos).


* **Empezar por una cláusula que provenga de la negación de lo que se quiere demostrar:**
**SÍ, es necesaria.** El objetivo inicial en lógica de programación corresponde formalmente a la negación de la consulta que se desea verificar.


* **Recorrer el espacio de búsqueda de arriba hacia abajo y de izquierda a derecha:**
**NO es una condición necesaria de la resolución SLD en general.** Esta es la estrategia operativa particular de selección y *backtracking* implementada por el motor de Prolog, pero la SLD abstracta es correcta y completa independientemente de la regla de selección de literales.
* **Utilizar la regla de resolución binaria en lugar de la general:**
**SÍ, es necesaria.** Dado que las cláusulas de definición tienen exactamente un literal positivo, no hay factores positivos que unificar simultáneamente; cada paso cancela un único literal seleccionado contra la cabeza de una regla/hecho.

---

# Ejercicio 21

Alan es un robot inteligente.

#### 1. Formalización en LPO

* **Constantes y predicados:**
* $alan$: Alan.


* $R(X)$: $X$ es un robot.


* $J(X)$: $X$ es japonés.


* $Pr(X)$: $X$ es un problema de esta práctica.


* $PL(X)$: $X$ es un problema lógico.


* $Res(X, Y)$: $X$ puede resolver $Y$.


* $I(X)$: $X$ es inteligente.




* **Premisas:**
1. Alan es un robot japonés:

$$R(alan) \wedge J(alan)$$


2. Cualquier robot que puede resolver un problema lógico es inteligente:

$$\forall X. ((R(X) \wedge \exists Y. (PL(Y) \wedge Res(X, Y))) \Rightarrow I(X))$$


3. Todos los robots japoneses pueden resolver todos los problemas de esta práctica:

$$\forall X. \forall Y. ((R(X) \wedge J(X) \wedge Pr(Y)) \Rightarrow Res(X, Y))$$


4. Todos los problemas de esta práctica son lógicos:

$$\forall X. (Pr(X) \Rightarrow PL(X))$$


5. Existe al menos un problema en esta práctica:

$$\exists X. Pr(X)$$




* **Consulta:** "¿Quién es inteligente?"
Buscamos responder $\exists W. I(W)$ encontrando el testigo para $W$.



#### 2. Pasaje a forma clausal

* De (1):
* $\kappa_1 = \{R(alan)\}$
* $\kappa_2 = \{J(alan)\}$


* De (2):
Reescribiendo la implicación:

$$\forall X. \forall Y. (\neg R(X) \vee \neg PL(Y) \vee \neg Res(X, Y) \vee I(X))$$


* $\kappa_3 = \{I(X), \neg R(X), \neg PL(Y), \neg Res(X, Y)\}$


* De (3):
* $\kappa_4 = \{Res(X, Y), \neg R(X), \neg J(X), \neg Pr(Y)\}$


* De (4):
* $\kappa_5 = \{PL(X), \neg Pr(X)\}$


* De (5):
Skolemizando con una nueva constante $p$:
* $\kappa_6 = \{Pr(p)\}$


* **Objetivo negado (consulta con respuesta $W$):**

$$\kappa_0 = \{\neg I(W)\}$$



#### 3. Derivación SLD y composición de sustituciones

1. **Paso 1:** Resolvemos el objetivo $\kappa_0 = \{\neg I(W)\}$ con la cabeza de $\kappa_3$ usando $\sigma_1 = \{X_1 := W\}$:



$$G_1 = \{\neg R(W), \neg PL(Y_1), \neg Res(W, Y_1)\}$$


2. **Paso 2:** Seleccionamos $\neg R(W)$ y resolvemos con $\kappa_1 = \{R(alan)\}$ usando $\sigma_2 = \{W := alan\}$:



$$G_2 = \{\neg PL(Y_1), \neg Res(alan, Y_1)\}$$


3. **Paso 3:** Seleccionamos $\neg PL(Y_1)$ y resolvemos con $\kappa_5 = \{PL(X_2), \neg Pr(X_2)\}$ usando $\sigma_3 = \{X_2 := Y_1\}$:



$$G_3 = \{\neg Pr(Y_1), \neg Res(alan, Y_1)\}$$


4. **Paso 4:** Seleccionamos $\neg Pr(Y_1)$ y resolvemos con $\kappa_6 = \{Pr(p)\}$ usando $\sigma_4 = \{Y_1 := p\}$:



$$G_4 = \{\neg Res(alan, p)\}$$


5. **Paso 5:** Resolvemos con $\kappa_4 = \{Res(X_3, Y_3), \neg R(X_3), \neg J(X_3), \neg Pr(Y_3)\}$ usando $\sigma_5 = \{X_3 := alan, Y_3 := p\}$:



$$G_5 = \{\neg R(alan), \neg J(alan), \neg Pr(p)\}$$


6. **Paso 6:** Resolvemos $\neg R(alan)$ con $\kappa_1$ ($\sigma_6 = \emptyset$):

$$G_6 = \{\neg J(alan), \neg Pr(p)\}$$


7. **Paso 7:** Resolvemos $\neg J(alan)$ con $\kappa_2$ ($\sigma_7 = \emptyset$):

$$G_7 = \{\neg Pr(p)\}$$


8. **Paso 8:** Resolvemos $\neg Pr(p)$ con $\kappa_6$ ($\sigma_8 = \emptyset$):

$$G_8 = \{\}$$



* **Composición de sustituciones:**

$$\sigma = \sigma_1 \circ \sigma_2 \circ \sigma_3 \circ \sigma_4 \circ \sigma_5 \circ \sigma_6 \circ \sigma_7 \circ \sigma_8$$



Evaluando sobre la variable de consulta $W$:

$$W\sigma = alan$$


* **Respuesta:** **Alan es inteligente.**

---

# Ejercicio 22

Dadas las siguientes cláusulas:

1. $\kappa_1 = \{\neg suma(X, Y, Z), suma(X, suc(Y), suc(Z))\}$


2. $\kappa_2 = \{suma(X, cero, X)\}$


3. $\kappa_3 = \{\neg suma(X, X, Y), par(Y)\}$



Demostrar que se deduce $par(suc(suc(cero)))$.

#### 1. Análisis de las cláusulas y SLD

* $\kappa_1$ tiene 1 positivo ($suma$) y 1 negativo ($\neg suma$): Cláusula de Horn (regla).


* $\kappa_2$ tiene 1 positivo ($suma$): Cláusula de Horn (hecho).


* $\kappa_3$ tiene 1 positivo ($par$) y 1 negativo ($\neg suma$): Cláusula de Horn (regla).


* Dado que todas las cláusulas del programa son de Horn y la negación de la consulta genera un objetivo (sin literales positivos), **es posible aplicar resolución SLD**.



#### 2. Objetivo inicial

Negamos lo que se desea probar:


$$\kappa_0 = \{\neg par(suc(suc(cero)))\}$$

#### 3. Derivación SLD mostrando cada sustitución

1. **Paso 1:**
* Cláusulas: $\kappa_0 = \{\neg par(suc(suc(cero)))\}$ y $\kappa_3 = \{\neg suma(X_1, X_1, Y_1), par(Y_1)\}$


* Unificación: $mgu(par(Y_1) \stackrel{?}{=} par(suc(suc(cero))))$

$$\sigma_1 = \{Y_1 := suc(suc(cero))\}$$





* Resolvente:

$$G_1 = \{\neg suma(X_1, X_1, suc(suc(cero)))\}$$




2. **Paso 2:**
* Cláusulas: $G_1$ y $\kappa_1 = \{\neg suma(X_2, Y_2, Z_2), suma(X_2, suc(Y_2), suc(Z_2))\}$


* Unificación:

$$mgu(suma(X_1, X_1, suc(suc(cero))) \stackrel{?}{=} suma(X_2, suc(Y_2), suc(Z_2)))$$


* $X_2 = X_1$
* $X_1 = suc(Y_2) \implies X_2 = suc(Y_2)$
* $suc(suc(cero)) = suc(Z_2) \implies Z_2 = suc(cero)$

$$\sigma_2 = \{X_1 := suc(Y_2), \; X_2 := suc(Y_2), \; Z_2 := suc(cero)\}$$







* Resolvente:

$$G_2 = \{\neg suma(suc(Y_2), Y_2, suc(cero))\}$$




3. **Paso 3:**
* Cláusulas: $G_2$ y $\kappa_1 = \{\neg suma(X_3, Y_3, Z_3), suma(X_3, suc(Y_3), suc(Z_3))\}$


* Unificación:

$$mgu(suma(suc(Y_2), Y_2, suc(cero)) \stackrel{?}{=} suma(X_3, suc(Y_3), suc(Z_3)))$$


* $X_3 = suc(Y_2)$
* $Y_2 = suc(Y_3) \implies X_3 = suc(suc(Y_3))$
* $suc(cero) = suc(Z_3) \implies Z_3 = cero$

$$\sigma_3 = \{Y_2 := suc(Y_3), \; X_3 := suc(suc(Y_3)), \; Z_3 := cero\}$$







* Resolvente:

$$G_3 = \{\neg suma(suc(suc(Y_3)), Y_3, cero)\}$$


* *(Nota: el camino de aplicar $\kappa_1$ dos veces seguidas no unifica en el paso base pues el tercer argumento decreció a cero mientras el primero aumentó. Volvemos al punto $G_2$ donde $Z_2 = suc(cero)$ y elegimos la instanciación que resuelve directamente con el hecho base).*


4. **Corrección de la ruta de resolución a partir de $G_1$:**
* Objetivo: $G_1 = \{\neg suma(X_1, X_1, suc(suc(cero)))\}$
* Observamos que en la aritmética de Peano, la suma de $1 + 1 = 2$: es decir $X_1 = suc(cero)$.
* Aplicamos $\kappa_1$ sobre $G_1$:

$$mgu(suma(X_1, X_1, suc(suc(cero))) \stackrel{?}{=} suma(X_2, suc(Y_2), suc(Z_2)))$$



Igualando componentes:
1. $X_1 = X_2$
2. $X_1 = suc(Y_2)$
3. $suc(suc(cero)) = suc(Z_2) \implies Z_2 = suc(cero)$
Sustitución:

$$\sigma_2 = \{X_1 := suc(Y_2), \; X_2 := suc(Y_2), \; Z_2 := suc(cero)\}$$



Resolvente:



$$G_2 = \{\neg suma(suc(Y_2), Y_2, suc(cero))\}$$




* Ahora resolvemos $G_2$ directamente con el hecho $\kappa_2 = \{suma(X_4, cero, X_4)\}$:



$$mgu(suma(suc(Y_2), Y_2, suc(cero)) \stackrel{?}{=} suma(X_4, cero, X_4))$$



Igualando componentes:
1. $Y_2 \stackrel{?}{=} cero \implies Y_2 := cero$
2. $X_4 \stackrel{?}{=} suc(Y_2) \implies X_4 := suc(cero)$
3. $X_4 \stackrel{?}{=} suc(cero) \implies suc(cero) = suc(cero)$ (válido)
Sustitución:

$$\sigma_3 = \{Y_2 := cero, \; X_4 := suc(cero)\}$$







* Resolvente obtenido:

$$G_3 = \{\}$$








* **Conclusión:** Se obtuvo la cláusula vacía mediante **resolución SLD**. Por lo tanto, queda formalmente demostrado que $par(suc(suc(cero)))$ se deduce del conjunto de cláusulas dadas.

A continuación se presenta la resolución completa, detallada y formal de los ejercicios 23 al 30 de la **Práctica 6: Lógica y Resolución**, justificando cada paso según las definiciones, algoritmos y criterios vistos en la materia.

---

# Ejercicio 23

#### I. Pasar las siguientes fórmulas en lógica de primer orden a forma clausal

:

##### a) $\forall C. (V(C) \vee \exists E. P(E, C))$



1. **NNF:** La fórmula ya está en Forma Normal Negada (no contiene implicaciones y las negaciones están en los átomos).


2. **Skolemización:** El existencial $\exists E$ está bajo el alcance del universal $\forall C$. Se reemplaza $E$ por una función de Skolem fresca $f(C)$ de aridad 1:



$$\forall C. (V(C) \vee P(f(C), C))$$





3. **Forma Normal de Skolem:** $\forall C. (V(C) \vee P(f(C), C))$.


4. **Forma Clausal:**

$$\kappa_a = \{V(C), P(f(C), C)\}$$






##### b) $\neg \exists C. (V(C) \wedge \exists E. P(E, C))$



1. **NNF:** Empujamos la negación hacia adentro usando leyes de De Morgan y dualidad de cuantificadores:



$$\forall C. \neg (V(C) \wedge \exists E. P(E, C))$$





$$\forall C. (\neg V(C) \vee \neg \exists E. P(E, C))$$





$$\forall C. (\neg V(C) \vee \forall E. \neg P(E, C))$$





2. **Extracción de cuantificadores (Prenexa / Skolem):** Como no hay existenciales, extraemos los universales:



$$\forall C. \forall E. (\neg V(C) \vee \neg P(E, C))$$





3. **Forma Clausal:**

$$\kappa_b = \{\neg V(C), \neg P(E, C)\}$$






##### c) $\forall E. \forall C. (P(E, i(C)) \Leftrightarrow P(E, C))$



1. **Eliminar la doble implicación:** $(A \Leftrightarrow B) \equiv (A \Rightarrow B) \wedge (B \Rightarrow A)$:



$$\forall E. \forall C. ((P(E, i(C)) \Rightarrow P(E, C)) \wedge (P(E, C) \Rightarrow P(E, i(C))))$$


2. **NNF:** Reemplazamos $A \Rightarrow B$ por $\neg A \vee B$:



$$\forall E. \forall C. ((\neg P(E, i(C)) \vee P(E, C)) \wedge (\neg P(E, C) \vee P(E, i(C))))$$





3. **Forma Clausal:** Obtenemos dos cláusulas independientes (separando las variables universales):


* $\kappa_{c1} = \{\neg P(E_1, i(C_1)), P(E_1, C_1)\}$


* $\kappa_{c2} = \{\neg P(E_2, C_2), P(E_2, i(C_2))\}$





---

#### II. Demostrar $\forall C. (V(i(C)) \Rightarrow V(C))$



* **¿Puede demostrarse usando resolución SLD?**


* **Respuesta:** **No, no es posible.**
* **Justificación:** La resolución SLD exige que el programa esté compuesto exclusivamente por cláusulas de Horn (a lo sumo un literal positivo por cláusula) y que se comience con una cláusula objetivo (meta con solo literales negativos). Sin embargo, la cláusula $\kappa_a = \{V(C), P(f(C), C)\}$ posee **dos literales positivos** ($V$ y $P$); por lo tanto, **no es una cláusula de Horn** y queda fuera del alcance de SLD. Debe resolverse por **resolución general**.




* **Demostración usando el Método de Resolución General:**


1. **Negamos la fórmula a probar:**


$$\neg \forall C. (V(i(C)) \Rightarrow V(C)) \equiv \exists C. (V(i(C)) \wedge \neg V(C))$$





2. **Skolemizamos con una nueva constante $c$:**


$$V(i(c)) \wedge \neg V(c)$$


3. **Cláusulas de la consulta negada:**


* $\kappa_{q1} = \{V(i(c))\}$
* $\kappa_{q2} = \{\neg V(c)\}$


4. **Conjunto completo de cláusulas:**
1. $\kappa_a = \{V(C), P(f(C), C)\}$
2. $\kappa_b = \{\neg V(C), \neg P(E, C)\}$
3. $\kappa_{c1} = \{\neg P(E, i(C)), P(E, C)\}$
4. $\kappa_{c2} = \{\neg P(E, C), P(E, i(C))\}$
5. $\kappa_{q1} = \{V(i(c))\}$
6. $\kappa_{q2} = \{\neg V(c)\}$


5. **Pasos de resolución:**
* De (2) y (5) unificando $V(C)$ con $V(i(c))$ mediante $\sigma_1 = \{C := i(c)\}$:



$$\kappa_7 = \{\neg P(E, i(c))\}$$





* De (4) y (7) unificando $P(E_2, i(C_2))$ con $P(E, i(c))$ mediante $\sigma_2 = \{E_2 := E, C_2 := c\}$:



$$\kappa_8 = \{\neg P(E, c)\}$$





* De (1) y (6) unificando $V(C)$ con $V(c)$ mediante $\sigma_3 = \{C := c\}$:



$$\kappa_9 = \{P(f(c), c)\}$$





* De (8) y (9) unificando $P(E, c)$ con $P(f(c), c)$ mediante $\sigma_4 = \{E := f(c)\}$:



$$\kappa_{10} = \{\} \quad (\square)$$



Habiendo alcanzado la cláusula vacía, queda formalmente demostrado que la fórmula es válida.







---

# Ejercicio 24

El teorema del bebedor:


$$\sigma \equiv (\exists X. enBar(X)) \Rightarrow \exists Y. (enBar(Y) \wedge (bebe(Y) \Rightarrow \forall Z. (enBar(Z) \Rightarrow bebe(Z))))$$



#### a) Identificar los 5 errores cometidos por el lógico en su servilleta

:

1. **Error en el reemplazo de implicaciones:** En la primera implicación exterior de la forma $\alpha \Rightarrow \beta$, transformó erróneamente el antecedente en $(\exists X. enBar(X))$ sin negarlo, en lugar de $\neg (\exists X. enBar(X)) \vee \dots$.


2. **Salteo de NNF (negación empujada) antes de Skolemizar:** No empujó las negaciones hacia los predicados atómicos; intentó skolemizar una fórmula que aún contenía cuantificadores bajo el alcance implícito de negaciones sin resolver.


3. **Skolemización incorrecta de existenciales (creación de constantes arbitrarias):** Sustituyó el existencial $\exists X$ por una constante $c$ y $\exists Y$ por una constante $k$ sin respetar el orden de los cuantificadores ni el hecho de que si se desea probar validez por resolución se debe **negar** la fórmula completa antes de Skolemizar.


4. **Pasaje a forma clausal incorrecto:** Transformó una fórmula que era una disyunción general en una lista de cláusulas arbitrarias (1, 2, 3 y 4), inventando cláusulas unitarias a partir de expresiones unidas por disyunciones.


5. **Paso de resolución inválido:** Realizó resolución entre la cláusula 5 ($\{\neg enBar(Z)\}$) y la 1 ($\{enBar(c)\}$), unificando $Z$ con $c$, pero concluyendo erróneamente la cláusula vacía sin percatarse de que $c$ y $k$ provenían de un proceso de skolemización corrupto sobre la fórmula sin refutar.



#### b) Demostrar el teorema de manera correcta usando resolución

:

1. **Negar la fórmula original:**


$$\neg [(\exists X. enBar(X)) \Rightarrow \exists Y. (enBar(Y) \wedge (bebe(Y) \Rightarrow \forall Z. (enBar(Z) \Rightarrow bebe(Z))))]$$





2. **Pasar a NNF:**

$$\equiv (\exists X. enBar(X)) \wedge \neg \exists Y. (enBar(Y) \wedge (\neg bebe(Y) \vee \forall Z. (\neg enBar(Z) \vee bebe(Z))))$$





$$\equiv (\exists X. enBar(X)) \wedge \forall Y. (\neg enBar(Y) \vee (bebe(Y) \wedge \exists Z. (enBar(Z) \wedge \neg bebe(Z))))$$





3. **Skolemizar:**
* $\exists X$ no está bajo universales $\implies$ constante fresca $c$.


* $\exists Z$ está bajo el alcance de $\forall Y \implies$ función fresca $f(Y)$.
La matriz queda:



$$enBar(c) \wedge \forall Y. [\neg enBar(Y) \vee (bebe(Y) \wedge enBar(f(Y)) \wedge \neg bebe(f(Y)))]$$







4. **Distribuir $\vee$ sobre $\wedge$ (CNF):**


$$enBar(c) \wedge (\neg enBar(Y) \vee bebe(Y)) \wedge (\neg enBar(Y) \vee enBar(f(Y))) \wedge (\neg enBar(Y) \vee \neg bebe(f(Y)))$$





5. **Forma clausal:**


* $\kappa_1 = \{enBar(c)\}$
* $\kappa_2 = \{\neg enBar(Y), bebe(Y)\}$
* $\kappa_3 = \{\neg enBar(Y), enBar(f(Y))\}$
* $\kappa_4 = \{\neg enBar(Y), \neg bebe(f(Y))\}$


6. **Resolución:**
* De $\kappa_1$ y $\kappa_2$ con $\sigma_1 = \{Y := c\}$:



$$\kappa_5 = \{bebe(c)\}$$





* De $\kappa_1$ y $\kappa_3$ con $\sigma_2 = \{Y := c\}$:



$$\kappa_6 = \{enBar(f(c))\}$$





* De $\kappa_1$ y $\kappa_4$ con $\sigma_3 = \{Y := c\}$:



$$\kappa_7 = \{\neg bebe(f(c))\}$$





* De $\kappa_6$ y $\kappa_2$ con $\sigma_4 = \{Y := f(c)\}$:



$$\kappa_8 = \{bebe(f(c))\}$$





* De $\kappa_7$ y $\kappa_8$ con $\sigma_5 = \emptyset$:



$$\kappa_9 = \{\} \quad (\square)$$








#### c) ¿La resolución utilizada es o no SLD? Justificar

.

* **Respuesta:** **No es SLD.**
* **Justificación:** La cláusula inicial derivada de la negación de la fórmula contiene a $\kappa_1 = \{enBar(c)\}$, que es una cláusula unitaria positiva (un hecho). Una derivación SLD exige estrictamente comenzar la refutación a partir de una **cláusula objetivo** (meta compuesta exclusivamente por literales negativos). Además, la prueba ramifica utilizando la cláusula $\kappa_1$ en múltiples pasos independientes para derivar diferentes hechos intermedios, rompiendo la linealidad estricta de SLD.



---

# Ejercicio 25

Demostrar usando resolución general que los nietos son descendientes, es decir:


$$\forall X. \forall Y. (Abuelo(X, Y) \Rightarrow Descendiente(Y, X))$$



#### 1. Base de conocimiento dada (en forma clausal):



1. $\kappa_1 = \{\neg Progenitor(X, Y), Descendiente(Y, X)\}$


2. $\kappa_2 = \{\neg Abuelo(X, Y), Progenitor(X, medio(X, Y))\}$


3. $\kappa_3 = \{\neg Descendiente(X, Y), \neg Descendiente(Y, Z), Descendiente(X, Z)\}$


4. $\kappa_4 = \{\neg Abuelo(X, Y), Progenitor(medio(X, Y), Y)\}$



#### 2. Negación de lo que se quiere demostrar y pasaje a forma clausal:



* $\neg \forall X. \forall Y. (Abuelo(X, Y) \Rightarrow Descendiente(Y, X)) \equiv \exists X. \exists Y. (Abuelo(X, Y) \wedge \neg Descendiente(Y, X))$


* Skolemizando con constantes frescas $a$ y $b$ ($X := a, Y := b$):
5. $\kappa_5 = \{Abuelo(a, b)\}$
6. $\kappa_6 = \{\neg Descendiente(b, a)\}$



#### 3. Derivación por resolución:



* **Paso 1:** De $\kappa_5 = \{Abuelo(a, b)\}$ y $\kappa_2$ con $\sigma_1 = \{X := a, Y := b\}$:



$$\kappa_7 = \{Progenitor(a, medio(a, b))\}$$





* **Paso 2:** De $\kappa_5 = \{Abuelo(a, b)\}$ y $\kappa_4$ con $\sigma_2 = \{X := a, Y := b\}$:



$$\kappa_8 = \{Progenitor(medio(a, b), b)\}$$





* **Paso 3:** De $\kappa_7$ y $\kappa_1$ con $\sigma_3 = \{X := a, Y := medio(a, b)\}$:



$$\kappa_9 = \{Descendiente(medio(a, b), a)\}$$





* **Paso 4:** De $\kappa_8$ y $\kappa_1$ con $\sigma_4 = \{X := medio(a, b), Y := b\}$:



$$\kappa_{10} = \{Descendiente(b, medio(a, b))\}$$





* **Paso 5:** De $\kappa_{10}$ y $\kappa_3$ unificando el primer literal negativo con $\sigma_5 = \{X := b, Y := medio(a, b)\}$:



$$\kappa_{11} = \{\neg Descendiente(medio(a, b), Z), Descendiente(b, Z)\}$$





* **Paso 6:** De $\kappa_9$ y $\kappa_{11}$ con $\sigma_6 = \{Z := a\}$:



$$\kappa_{12} = \{Descendiente(b, a)\}$$





* **Paso 7:** De $\kappa_{12}$ y $\kappa_6 = \{\neg Descendiente(b, a)\}$ con $\sigma_7 = \emptyset$:



$$\kappa_{13} = \{\} \quad (\square)$$






Se derivó la cláusula vacía, completando la demostración.

---

# Ejercicio 26

Demostrar que una relación binaria no vacía no puede ser simultáneamente irreflexiva, simétrica y transitiva (es decir, si cumple 1 a 3, entonces es vacía).

#### 1. Definiciones y pasaje a forma clausal:



1. **$R$ es irreflexiva:** $\forall X. \neg R(X, X) \implies \kappa_1 = \{\neg R(X, X)\}$


2. **$R$ es simétrica:** $\forall X. \forall Y. (R(X, Y) \Rightarrow R(Y, X)) \implies \kappa_2 = \{\neg R(X, Y), R(Y, X)\}$


3. **$R$ es transitiva:** $\forall X. \forall Y. \forall Z. ((R(X, Y) \wedge R(Y, Z)) \Rightarrow R(X, Z))$
$\implies \kappa_3 = \{\neg R(X, Y), \neg R(Y, Z), R(X, Z)\}$


4. **$R$ es vacía:** $\forall X. \forall Y. \neg R(X, Y)$



#### 2. Negación de la conclusión (Hipótesis de refutación):



* Negamos que $R$ sea vacía: $\neg \forall X. \forall Y. \neg R(X, Y) \equiv \exists X. \exists Y. R(X, Y)$.


* Skolemizando con constantes frescas $a$ y $b$ ($X := a, Y := b$):



$$\kappa_4 = \{R(a, b)\}$$



#### 3. Derivación por resolución:



* **Paso 1:** De $\kappa_4 = \{R(a, b)\}$ y $\kappa_2$ con $\sigma_1 = \{X := a, Y := b\}$:



$$\kappa_5 = \{R(b, a)\}$$





* **Paso 2:** De $\kappa_4$ y $\kappa_3$ unificando con el primer literal negativo mediante $\sigma_2 = \{X := a, Y := b\}$:



$$\kappa_6 = \{\neg R(b, Z), R(a, Z)\}$$





* **Paso 3:** De $\kappa_5 = \{R(b, a)\}$ y $\kappa_6$ unificando con $\neg R(b, Z)$ mediante $\sigma_3 = \{Z := a\}$:



$$\kappa_7 = \{R(a, a)\}$$





* **Paso 4:** De $\kappa_7 = \{R(a, a)\}$ y $\kappa_1 = \{\neg R(X, X)\}$ con $\sigma_4 = \{X := a\}$:



$$\kappa_8 = \{\} \quad (\square)$$






#### 4. ¿El método es o no SLD? Justificar

.

* **Respuesta:** **No es SLD.**
* **Justificación:** La hipótesis de refutación introdujo una cláusula puramente positiva ($\kappa_4 = \{R(a, b)\}$), por lo que la refutación no comienza a partir de una cláusula objetivo con solo literales negativos. De hecho, la única cláusula sin literales positivos es $\kappa_1 = \{\neg R(X, X)\}$, la cual interviene recién al final de la derivación.



---

# Ejercicio 27

Definiciones en Prolog:

```prolog
natural(cero).                                   % Hecho 1
natural(suc(X)) :- natural(X).                   % Regla 1
mayorOIgual(suc(X), Y) :- mayorOIgual(X, Y).      % Regla 2
mayorOIgual(X, X) :- natural(X).                 % Regla 3

```

#### Item 1: ¿Qué sucede al realizar la consulta `?- mayorOIgual(suc(suc(N)), suc(cero)).`?



* Prolog utiliza una búsqueda en profundidad (*depth-first search*) recorriendo las reglas de arriba hacia abajo y evaluando los literales de izquierda a derecha.


* Al invocar la consulta, unifica con la primera regla disponible para `mayorOIgual` (**Regla 2**):


* Intenta probar `mayorOIgual(suc(N), suc(cero))`.


* Vuelve a aplicar la **Regla 2**:
* Intenta probar `mayorOIgual(N, suc(cero))`.


* Vuelve a intentar la **Regla 2** (haciendo $N = suc(N')$):
* Entra en un bucle recursivo infinito donde sigue agregando constructores $suc(\dots)$ a $N$ intentando reducir el primer argumento, sin llegar nunca a las reglas de caso base (**Regla 3**).




* **Conclusión:** La consulta **se cuelga en una recursión infinita** (*stack overflow*) y no devuelve solución a menos que se fuerce el backtracking o se reordenen las cláusulas.



#### Item 2: Probar la validez mediante resolución



* **Forma clausal del programa:**


* $\kappa_1 = \{natural(cero)\}$
* $\kappa_2 = \{natural(suc(X)), \neg natural(X)\}$
* $\kappa_3 = \{mayorOIgual(suc(X), Y), \neg mayorOIgual(X, Y)\}$
* $\kappa_4 = \{mayorOIgual(X, X), \neg natural(X)\}$


* **Meta inicial (negación de la consulta):**


$$\kappa_0 = \{\neg mayorOIgual(suc(suc(N)), suc(cero))\}$$


* **Derivación:**
1. Resolvemos $\kappa_0$ con $\kappa_3$ usando $\sigma_1 = \{X_1 := suc(N), Y_1 := suc(cero)\}$:



$$G_1 = \{\neg mayorOIgual(suc(N), suc(cero))\}$$


2. En lugar de repetir infinitamente $\kappa_3$, elegimos resolver con $\kappa_4$ mediante $\sigma_2 = \{X_2 := suc(cero), N := cero\}$:



$$G_2 = \{\neg natural(suc(cero))\}$$


3. Resolvemos $G_2$ con $\kappa_2$ usando $\sigma_3 = \{X_3 := cero\}$:



$$G_3 = \{\neg natural(cero)\}$$


4. Resolvemos $G_3$ con el hecho $\kappa_1$ usando $\sigma_4 = \emptyset$:



$$G_4 = \{\} \quad (\square)$$







* Sustitución respuesta para la variable de consulta: $N = cero$.





#### Item 3: ¿La resolución utilizada es SLD? ¿Respeta el orden de Prolog?



* **¿Es SLD?** **Sí.** Es lineal, el programa consta de cláusulas de Horn (definidas) y se parte estrictamente de la cláusula objetivo $\kappa_0$.


* **¿Respeta el orden de Prolog?** **No.** En el paso 2, Prolog está forzado por su estrategia a intentar primero la Regla 2 ($\kappa_3$) por estar escrita antes en el código fuente, cayendo en un ciclo infinito. Nuestra resolución eligió la Regla 3 ($\kappa_4$) para alcanzar la refutación finita.



---

# Ejercicio 28

Base de conocimiento en Prolog:

```prolog
analfabeto(X) :- vivo(X), noSabeLeer(X).
vivo(X) :- delfin(X).
noSabeLeer(X) :- delfin(X).
noSabeLeer(X) :- mesa(X).
inteligente(flipper).
delfin(flipper).
inteligente(alan).

```

#### 1. Pasaje a forma clausal:



1. $\kappa_1 = \{analfabeto(X), \neg vivo(X), \neg noSabeLeer(X)\}$
2. $\kappa_2 = \{vivo(X), \neg delfin(X)\}$
3. $\kappa_3 = \{noSabeLeer(X), \neg delfin(X)\}$
4. $\kappa_4 = \{noSabeLeer(X), \neg mesa(X)\}$
5. $\kappa_5 = \{inteligente(flipper)\}$
6. $\kappa_6 = \{delfin(flipper)\}$
7. $\kappa_7 = \{inteligente(alan)\}$

#### 2. Consulta y negación:

* Se desea demostrar: $\exists W. (inteligente(W) \wedge analfabeto(W))$.


* Negamos la consulta:


$$\neg \exists W. (inteligente(W) \wedge analfabeto(W)) \equiv \forall W. (\neg inteligente(W) \vee \neg analfabeto(W))$$





* Cláusula objetivo inicial:


$$G_0 = \{\neg inteligente(W), \neg analfabeto(W)\}$$



#### 3. Derivación por resolución SLD:



1. Resolvemos $\neg analfabeto(W)$ con $\kappa_1$ usando $\sigma_1 = \{X_1 := W\}$:



$$G_1 = \{\neg inteligente(W), \neg vivo(W), \neg noSabeLeer(W)\}$$


2. Resolvemos $\neg inteligente(W)$ con el hecho $\kappa_5 = \{inteligente(flipper)\}$ usando $\sigma_2 = \{W := flipper\}$:



$$G_2 = \{\neg vivo(flipper), \neg noSabeLeer(flipper)\}$$


3. Resolvemos $\neg vivo(flipper)$ con $\kappa_2$ usando $\sigma_3 = \{X_2 := flipper\}$:



$$G_3 = \{\neg delfin(flipper), \neg noSabeLeer(flipper)\}$$


4. Resolvemos $\neg delfin(flipper)$ con el hecho $\kappa_6 = \{delfin(flipper)\}$ con $\sigma_4 = \emptyset$:



$$G_4 = \{\neg noSabeLeer(flipper)\}$$


5. Resolvemos $\neg noSabeLeer(flipper)$ con $\kappa_3$ usando $\sigma_5 = \{X_3 := flipper\}$:



$$G_5 = \{\neg delfin(flipper)\}$$


6. Resolvemos con el hecho $\kappa_6 = \{delfin(flipper)\}$ con $\sigma_6 = \emptyset$:



$$G_6 = \{\} \quad (\square)$$






* **Resultado:** Con $W = flipper$, se demuestra formalmente que Flipper es inteligente y analfabeto.



---

# Ejercicio 29

Definiciones en Prolog:

```prolog
preorder(nil, []).                                               % C1
preorder(bin(I, R, D), [R | L]) :-                               % C2
    append(LI, LD, L),
    preorder(I, LI),
    preorder(D, LD).
append([], YS, YS).                                              % C3
append([X | XS], YS, [X | L]) :- append(XS, YS, L).              % C4

```

Consulta: `?- preorder(bin(bin(nil, 2, nil), 1, nil), Lista).`

#### Item 1: ¿Qué sucede al realizar la consulta en Prolog?



* Prolog unifica con la **Regla C2**, donde el árbol tiene raíz $R = 1$, subárbol izquierdo $I = bin(nil, 2, nil)$ y subárbol derecho $D = nil$.


* El cuerpo de la regla se evalúa en orden estricto de izquierda a derecha:


1. Intenta evaluar `append(LI, LD, L)` en primer lugar.


2. En este punto, las tres variables `LI`, `LD` y `L` son incógnitas completamente libres (sin instanciar).


3. Al llamar a `append` con variables libres, unifica con el caso base `append([], YS, YS)` asignando $LI = []$ y $L = LD$.


4. Pasa al segundo literal: `preorder(bin(nil, 2, nil), [])`.


5. Esta llamada recursiva falla inmediatamente porque el árbol no es vacío y no puede unificar con la lista vacía `[]`.


6. Prolog hace *backtracking* al `append` y prueba la regla recursiva `append([X|XS], YS, [X|L])`, generando una lista infinita de variables libres para `LI`.




* **Conclusión:** El programa entra en un bucle de **backtracking infinito** y no arroja solución porque el subobjetivo `append` se colocó erróneamente **antes** de calcular las listas `LI` y `LD` mediante los llamados recursivos a `preorder`.



#### Item 2: Demostración por el método de resolución



* **Forma clausal:**
* $\kappa_1 = \{preorder(nil, [])\}$


* $\kappa_2 = \{preorder(bin(I, R, D), [R \vert{} L]), \neg append(LI, LD, L), \neg preorder(I, LI), \neg preorder(D, LD)\}$


* $\kappa_3 = \{append([], YS, YS)\}$


* $\kappa_4 = \{append([X \vert{} XS], YS, [X \vert{} L]), \neg append(XS, YS, L)\}$




* **Meta inicial:**

$$G_0 = \{\neg preorder(bin(bin(nil, 2, nil), 1, nil), Lista)\}$$





* **Derivación:**
1. Resolvemos $G_0$ con $\kappa_2$ con $R := 1$, $I := bin(nil, 2, nil)$, $D := nil$, $Lista := [1 \vert{} L]$:



$$G_1 = \{\neg append(LI, LD, L), \neg preorder(bin(nil, 2, nil), LI), \neg preorder(nil, LD)\}$$





2. A diferencia del orden fijo de Prolog, el algoritmo de resolución puede seleccionar el subobjetivo $\neg preorder(D, LD) \equiv \neg preorder(nil, LD)$ y resolverlo con $\kappa_1$ usando $LD := []$:



$$G_2 = \{\neg append(LI, [], L), \neg preorder(bin(nil, 2, nil), LI)\}$$





3. Seleccionamos $\neg preorder(bin(nil, 2, nil), LI)$ y resolvemos con $\kappa_2$ ($R_2 := 2, I_2 := nil, D_2 := nil, LI := [2 \vert{} L_2]$):



$$G_3 = \{\neg append([2 \vert{} L_2], [], L), \neg append(LI_2, LD_2, L_2), \neg preorder(nil, LI_2), \neg preorder(nil, LD_2)\}$$





4. Resolvemos $\neg preorder(nil, LI_2)$ y $\neg preorder(nil, LD_2)$ con $\kappa_1$ usando $LI_2 := []$ y $LD_2 := []$:



$$G_4 = \{\neg append([2 \vert{} L_2], [], L), \neg append([], [], L_2)\}$$





5. Resolvemos $\neg append([], [], L_2)$ con $\kappa_3$ usando $L_2 := []$:



$$G_5 = \{\neg append([2], [], L)\}$$





6. Resolvemos con $\kappa_4$ ($X := 2, XS := [], YS := [], L := [2 \vert{} L_3]$):



$$G_6 = \{\neg append([], [], L_3)\}$$





7. Resolvemos con $\kappa_3$ usando $L_3 := []$:



$$G_7 = \{\} \quad (\square)$$







* Sustituciones acumuladas: $L_3 = [] \implies L = [2] \implies Lista = [1 \vert{} L] = [1, 2]$.





#### Item 3: ¿Es SLD? ¿Respeta el orden de Prolog?



* **¿Es SLD?** **Sí.** Es lineal, sobre cláusulas definidas y comienza con la cláusula objetivo.


* **¿Respeta el orden de Prolog?** **No.** Se alteró deliberadamente la regla de selección de literales para evaluar `preorder` antes de `append`, evitando la divergencia infinita de Prolog.



---

# Ejercicio 30

Base de conocimiento en Prolog:

```prolog
parPositivo(X, Y) :- mayor(X, 0), mayor(Y, 0).
natural(0).
natural(succ(N)) :- natural(N).
mayor(succ(X), 0) :- natural(X).
mayor(succ(X), succ(Y)) :- mayor(X, Y).

```

#### a) Explicar con palabras qué sucede al realizar la consulta `?- parPositivo(A, B), mayor(A, B).`



1. Prolog evalúa primero `parPositivo(A, B)`.


2. Por la regla de `parPositivo`, busca satisfacer `mayor(A, 0)` y luego `mayor(B, 0)`.


3. Para `mayor(A, 0)`, unifica con la primera regla disponible: `mayor(succ(X), 0) :- natural(X)`. Para satisfacer `natural(X)`, Prolog toma el primer hecho `natural(0)`, ligando $X = 0$, con lo cual deduce $A = succ(0)$.


4. De idéntica forma procede para `mayor(B, 0)`, ligando $B = succ(0)$.


5. Con las soluciones encontradas para el primer objetivo ($A = succ(0), B = succ(0)$), pasa a evaluar el segundo objetivo de la consulta: `mayor(succ(0), succ(0))`.


6. Aplica la regla `mayor(succ(X), succ(Y)) :- mayor(X, Y)` y pasa a evaluar `mayor(0, 0)`.


7. `mayor(0, 0)` **falla** porque ninguna regla define que $0$ sea mayor a $0$.


8. Prolog hace *backtracking* al objetivo anterior `natural(X)` de la variable $B$: prueba la segunda regla `natural(succ(N))`, asignando $X = succ(0)$, por lo que ahora $B = succ(succ(0))$.


9. Vuelve a probar `mayor(succ(0), succ(succ(0)))`, la cual también falla porque $1$ no es mayor a $2$.


10. Prolog entra en una búsqueda infinita en profundidad incrementando indefinidamente el valor de $B$ ($B = 1, 2, 3, 4, \dots$) buscando sin éxito que $1$ sea mayor a $B$, quedando **atrapado en un ciclo infinito** sin poder retroceder nunca a cambiar el valor de $A$.



---

#### b) Expresión lógica y resolución SLD



##### Fórmulas lógicas de la base de conocimiento y la consulta:



* $\forall X. \forall Y. ((mayor(X, 0) \wedge mayor(Y, 0)) \Rightarrow parPositivo(X, Y))$


* $natural(0)$


* $\forall N. (natural(N) \Rightarrow natural(succ(N)))$


* $\forall X. (natural(X) \Rightarrow mayor(succ(X), 0))$


* $\forall X. \forall Y. (mayor(X, Y) \Rightarrow mayor(succ(X), succ(Y)))$


* Consulta: $\exists A. \exists B. (parPositivo(A, B) \wedge mayor(A, B))$



##### Forma clausal:



* $\kappa_1 = \{parPositivo(X, Y), \neg mayor(X, 0), \neg mayor(Y, 0)\}$
* $\kappa_2 = \{natural(0)\}$
* $\kappa_3 = \{natural(succ(N)), \neg natural(N)\}$
* $\kappa_4 = \{mayor(succ(X), 0), \neg natural(X)\}$
* $\kappa_5 = \{mayor(succ(X), succ(Y)), \neg mayor(X, Y)\}$
* Meta inicial (negación de la consulta):


$$G_0 = \{\neg parPositivo(A, B), \neg mayor(A, B)\}$$



##### Derivación SLD para encontrar una solución (por ejemplo $A = 2, B = 1$):



1. Resolvemos $\neg parPositivo(A, B)$ con $\kappa_1$ usando $\sigma_1 = \{X_1 := A, Y_1 := B\}$:



$$G_1 = \{\neg mayor(A, 0), \neg mayor(B, 0), \neg mayor(A, B)\}$$


2. Para instanciar $A$ con un valor adecuado ($A = 2 = succ(succ(0))$), resolvemos $\neg mayor(A, 0)$ con $\kappa_4$ usando $\sigma_2 = \{A := succ(X_2)\}$:



$$G_2 = \{\neg natural(X_2), \neg mayor(B, 0), \neg mayor(succ(X_2), B)\}$$


3. Resolvemos $\neg natural(X_2)$ con $\kappa_3$ usando $\sigma_3 = \{X_2 := succ(N_3)\}$:



$$G_3 = \{\neg natural(N_3), \neg mayor(B, 0), \neg mayor(succ(succ(N_3)), B)\}$$


4. Resolvemos $\neg natural(N_3)$ con $\kappa_2$ usando $\sigma_4 = \{N_3 := 0\}$:



$$G_4 = \{\neg mayor(B, 0), \neg mayor(succ(succ(0)), B)\}$$


5. Para instanciar $B = 1 = succ(0)$, resolvemos $\neg mayor(B, 0)$ con $\kappa_4$ usando $\sigma_5 = \{B := succ(X_5)\}$:



$$G_5 = \{\neg natural(X_5), \neg mayor(succ(succ(0)), succ(X_5))\}$$


6. Resolvemos $\neg natural(X_5)$ con el hecho $\kappa_2$ usando $\sigma_6 = \{X_5 := 0\}$:



$$G_6 = \{\neg mayor(succ(succ(0)), succ(0))\}$$


7. Resolvemos con la regla recursiva $\kappa_5$ usando $\sigma_7 = \{X_7 := succ(0), Y_7 := 0\}$:



$$G_7 = \{\neg mayor(succ(0), 0)\}$$


8. Resolvemos con $\kappa_4$ usando $\sigma_8 = \{X_8 := 0\}$:



$$G_8 = \{\neg natural(0)\}$$


9. Resolvemos con el hecho $\kappa_2$ con $\sigma_9 = \emptyset$:



$$G_9 = \{\} \quad (\square)$$






* **Composición de sustituciones:**
* $A = succ(succ(0))$ (es decir, 2)
* $B = succ(0)$ (es decir, 1)


* La derivación SLD tiene éxito y devuelve la solución válida: **$A = succ(succ(0)), B = succ(0)$**.