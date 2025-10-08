# 🧩 Analisi dell’Esperienza Utente Online e Offline

### Autore: Matteo Peroni  
**Corso di Laurea:** Digital Marketing – II anno  
**Data progetto:** 17/06/2025  
**Software:** RStudio  
**Dataset:** `report_questionario_valori`  
**File di analisi principale:** `analisi_customer_experience.R`

---

## 📖 Panoramica

Il progetto analizza l’esperienza utente (customer experience) **online e offline**, con l’obiettivo di individuare **pattern comportamentali e segmenti di consumatori** sulla base delle loro abitudini di acquisto e della propensione all’utilizzo di tecnologie digitali (AI, VR, IoT, strumenti integrati in store).

L’analisi è stata condotta su un **campione di 99 individui**, tramite un questionario diffuso online.  
L’indagine combina **analisi descrittive**, **riduzione dimensionale (PCA)** e **clustering multivariato**, per identificare gruppi omogenei di clienti.

---

## 🎯 Obiettivi

- Analizzare le caratteristiche demografiche e comportamentali dei consumatori.  
- Identificare le **componenti principali** che sintetizzano la percezione dell’esperienza utente.  
- Segmentare i consumatori in **cluster significativi** basati su preferenze e attitudini tecnologiche.  
- Fornire **spunti strategici per il marketing**, mirati a migliorare l’esperienza d’acquisto integrata (online/offline).  

---

## 🧠 Metodologia

L’analisi è stata sviluppata interamente in **R**, utilizzando metodi statistici multivariati.  
Le fasi principali del progetto sono le seguenti:

### 1️⃣ Analisi descrittiva
- Calcolo di media, deviazione standard, distribuzioni di frequenza.
- Analisi di variabili demografiche (età, genere, occupazione, reddito).
- Valutazione delle esperienze **online** e **in-store** tramite score di soddisfazione e frequenza d’acquisto.
- Visualizzazione con **barplot**, **boxplot** e **grafici a torta**.

### 2️⃣ PCA – Analisi delle Componenti Principali
- Riduzione della dimensionalità da 20 variabili a 4 componenti principali.  
- Verifica di adeguatezza tramite indice **KMO = 0.77**.  
- Visualizzazione della correlazione tra variabili (`corrplot`) e **screeplot**.  
- Interpretazione delle componenti:
  - **PC1:** Futurista – interesse per l’uso di tecnologie avanzate.  
  - **PC2:** Digitale–Online – qualità e facilità dell’esperienza online.  
  - **PC3:** Tradizionale–In Store – importanza dell’esperienza fisica.  
  - **PC4:** Ibrida – equilibrio tra efficienza digitale e interazione personale.

### 3️⃣ Analisi Cluster
- Distanza calcolata con **metrica di Gower**.  
- Confronto di diversi metodi di linkage (complete, single, average, median).  
- Identificazione del numero ottimale di cluster con **NbClust** → *3 cluster*.  
- Implementazione di clustering **gerarchico** e **non gerarchico (k-means)**.  
- Visualizzazione con scatterplot multipli su componenti principali.

### 4️⃣ Analisi descrittiva per cluster
Per ogni cluster sono state analizzate:
- Distribuzioni di età, genere, reddito, occupazione.  
- Preferenze di acquisto online/offline.  
- Coinvolgimento con i brand digitali e percezione tecnologica.

---

## 🧩 Librerie principali utilizzate

| Tipologia | Libreria | Funzione principale |
|------------|-----------|---------------------|
| Visualizzazione | `ggplot2`, `corrplot` | Grafici di distribuzione e correlazione |
| Analisi statistica | `REdaS`, `cluster`, `NbClust` | PCA, KMO, clustering |
| Manipolazione dati | `dplyr`, `tidyr` | Ristrutturazione e aggregazione dati |
| Base R | `stats`, `graphics` | PCA, barplot, boxplot, pie chart |

---

## 📊 Risultati principali

L’analisi ha identificato **tre cluster di consumatori**:

| Cluster | Nome | Caratteristiche principali |
|----------|------|-----------------------------|
| 🔴 | **Futuristi** | Giovani, studenti/lavoratori, reddito medio, grande apertura verso AI/VR e integrazione online–offline. |
| 🔵 | **Tradizionali** | Maggioranza femminile, redditi più alti, preferenza per esperienze fisiche e contatto diretto col prodotto. |
| ⚫ | **Outliers** | Gruppo eterogeneo con basso engagement tecnologico, acquisti ridotti sia online che offline. |

La segmentazione consente ai brand di **personalizzare le strategie di marketing**:
- **Futuristi:** esperienze immersive e digitali integrate, campagne di awareness tecnologica.  
- **Tradizionali:** valorizzazione dell’esperienza fisica e della qualità tangibile del prodotto.  
- **Outliers:** campagne di educazione digitale e incentivi alla sperimentazione omnicanale.

---

## 📈 Conclusioni

L’analisi dimostra come la **customer experience ibrida** rappresenti un vantaggio competitivo per i brand che riescono a fondere mondo fisico e digitale.  
L’approccio analitico in R consente di:
- Individuare con precisione i segmenti di consumatori.  
- Comprendere le leve di soddisfazione e coinvolgimento.  
- Fornire basi quantitative per decisioni di marketing mirate.  

---

## 🚀 Miglioramenti futuri

Il progetto rappresenta una solida base di analisi esplorativa, ma sono previsti ulteriori sviluppi per rafforzarne la validità statistica e le applicazioni predittive:

1. **Aumento del campione:**  
   Mi impegno a estendere la raccolta dei dati a un numero più ampio di intervistati (idealmente >300) per migliorare la robustezza statistica delle analisi e la rappresentatività dei cluster.

2. **Pulizia e validazione avanzata dei dati:**  
   Implementazione di controlli più sofisticati per gestire outlier e risposte incomplete, garantendo una maggiore qualità del dataset.

3. **Evoluzione verso il Machine Learning:**  
   Una volta raggiunta una base dati adeguata, l’obiettivo sarà **addestrare modelli predittivi di comportamento del consumatore** (es. Random Forest, k-NN, Logistic Regression o Neural Networks) per:
   - Predire la propensione all’uso di tecnologie digitali.  
   - Stimare la probabilità di appartenenza a ciascun cluster.  
   - Fornire suggerimenti automatizzati per strategie di marketing personalizzate.

4. **Dashboard interattiva:**  
   In futuro, verrà realizzata una **Shiny App in R** per visualizzare dinamicamente i cluster e i risultati principali, facilitando l’uso operativo da parte di manager e analisti.

---

## 🧮 Struttura del progetto

```
📁 customer_experience_analysis/
│
├── data/
│   └── report_questionario_valori.csv
│
├── script/
│   └── analisi_customer_experience.R
│
├── output/
│   ├── grafici_PCA/
│   ├── grafici_cluster/
│   └── tabelle_descrittive/
│
├── report/
│   └── report_analisi_Matteo_Peroni.pdf
│
└── README.md
```


---

## 💡 Citazioni

- Accenture (2020). *Studio Accenture Interactive – L’esperienza di brand come leva di trasformazione.*  
  [Accenture Italia Newsroom](https://newsroom.accenture.it/it/content/lesperienza-di-brand-sempre-piu-legata-al-purpose-diventa-elemento-chiave-di-trasformazione-per-le-organizzazioni.pdf)

---

## 👨‍💻 Licenza

Questo progetto è distribuito con licenza **MIT**, liberamente riutilizzabile a fini didattici e di ricerca, citando l’autore.

© 2025 Matteo Peroni – Università di Modena e Reggio Emilia

---

## 📬 Contatti

📧 329566@studenti.unimore.it  
📍 Università di Modena e Reggio Emilia – Corso di Digital Marketing  
