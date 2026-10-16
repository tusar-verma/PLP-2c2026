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