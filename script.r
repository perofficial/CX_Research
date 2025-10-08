##########################################################
# 1. ANALISI DESCRITTIVA
# Scopo: descrivere le caratteristiche di base del campione 
#        (età, genere, occupazione, soddisfazione, frequenze, ecc.)
##########################################################

dati = report_questionario_valori

### --- Età ---
mean(dati$eta)
sd(dati$eta)

eta = data.frame(dati$eta)
eta

# Classi di età
eta_classe = cut(dati$eta, 
                 breaks = c(10, 20, 30, 40, 50, 60, 70, 80), 
                 labels = c("10-20", "21-30", "31-40", "41-50", "51-60", "61-70", "71-80"))
table(eta_classe)

colori = c("10-20" = "grey", "21-30" = "blue", "31-40" = "grey",
           "41-50" = "grey", "51-60" = "grey", "61-70" = "grey", "71-80" = "grey")

library(ggplot2)
ggplot(data.frame(eta_classe), aes(x = eta_classe, fill = eta_classe)) +
  geom_bar() +
  labs(title = "Distribuzione delle età", x = "Classi di età", y = "Conteggio") +
  theme_minimal() +
  scale_fill_manual(values = colori) +
  theme(plot.title = element_text(hjust = 0.5))


### --- Soddisfazione online e store ---
mean(dati$soddisfazione_online); sd(dati$soddisfazione_online)
mean(dati$soddisfazione_store); sd(dati$soddisfazione_store)


### --- Genere ---
genere = round(prop.table(table(dati$genere)), 2) * 100
lblsgen = c("Maschi", "Femmine")
lblsgen = paste(lblsgen, genere, "%", sep = " ")
pie(genere, col = c("lightskyblue2", "palevioletred1"), 
    main = "Genere popolazione", labels = lblsgen)


### --- Occupazione ---
barplot(table(dati$occupazione), main = "Distribuzione occupazione popolazione")


### --- Score online ---
table_nav = round(prop.table(table(dati$score_navigazione)), 2) * 100
table_facilita = round(prop.table(table(dati$score_facilita)), 2) * 100
table_risparmiot = round(prop.table(table(dati$risparmiotempo_online)), 2) * 100
table_sugg = round(prop.table(table(dati$score_suggerimenti)), 2) * 100
table_soddon = round(prop.table(table(dati$soddisfazione_online)), 2) * 100

barplot(table_nav, main = "Distribuzione score navigazione online")
barplot(table_facilita, main = "Distribuzione score facilità online")
barplot(table_risparmiot, main = "Distribuzione score risparmio tempo online")
barplot(table_sugg, main = "Distribuzione score suggerimenti online")
barplot(table_soddon, main = "Distribuzione score soddisfazione online")


### --- Score store ---
table_personale = round(prop.table(table(dati$score_personale)), 2) * 100
table_prodplac = round(prop.table(table(dati$score_productplacement)), 2) * 100
table_sicurezza = round(prop.table(table(dati$score_sicurezzaacquisto_store)), 2) * 100
table_utilizzoai = round(prop.table(table(dati$score_utilizzoai)), 2) * 100
table_soddoff = round(prop.table(table(dati$soddisfazione_store)), 2) * 100

barplot(table_personale, main = "Distribuzione score personale store")
barplot(table_prodplac, main = "Distribuzione score product placement")
barplot(table_sicurezza, main = "Distribuzione sicurezza acquisto store")
barplot(table_utilizzoai, main = "Distribuzione score utilizzo strumenti digitali in store")
barplot(table_soddoff, main = "Distribuzione score soddisfazione store")


### --- Score integrazione online/offline ---
table_purchonoff = round(prop.table(table(dati$acquisto_online_terminato_offline)), 2) * 100
table_integrazione_onoff = round(prop.table(table(dati$score_integrazione_online_offline)), 2) * 100
table_integrazione = round(prop.table(table(dati$score_integrazione)), 2) * 100
table_sodd_strumenti_off = round(prop.table(table(dati$soddisfazione_strumentidigitali_store)), 2) * 100
table_coinvolgimento_brand = round(prop.table(table(dati$coinvolgimento_brand_integrato)), 2) * 100

barplot(table_purchonoff, main = "Distribuzione score acquisto iniziato online e terminato in store")
barplot(table_integrazione_onoff, main = "Distribuzione score integrazione tra online e store")
barplot(table_integrazione, main = "Distribuzione score percezione brand integrati")
barplot(table_sodd_strumenti_off, main = "Distribuzione score strumenti digitali in store")
barplot(table_coinvolgimento_brand, main = "Distribuzione score coinvolgimento brand digitali")


### --- Frequenze di acquisto (online e store) ---
barplot(table(dati$frequenza_acquisto_abbigliamento_online), main = "Acquisti abbigliamento online")
barplot(table(dati$frequenza_acquisto_abbigliamento_store), main = "Acquisti abbigliamento store")

# (ripetuti per gli altri settori, come da script originale)


### --- Boxplot distribuzioni ---
par(mfrow = c(1, 5))
boxplot(dati$score_navigazione, main = "Navigazione online")
boxplot(dati$score_facilita, main = "Facilità online")
boxplot(dati$risparmiotempo_online, main = "Risparmio tempo online")
boxplot(dati$score_suggerimenti, main = "Suggerimenti online")
boxplot(dati$soddisfazione_online, main = "Soddisfazione online")

par(mfrow = c(1, 5))
boxplot(dati$score_personale, main = "Personale store")
boxplot(dati$score_productplacement, main = "Product placement")
boxplot(dati$score_sicurezzaacquisto_store, main = "Sicurezza store")
boxplot(dati$score_utilizzoai, main = "Uso strumenti digitali")
boxplot(dati$soddisfazione_store, main = "Soddisfazione store")


##########################################################
# 2. ANALISI DELLE COMPONENTI PRINCIPALI (PCA)
# Scopo: ridurre la dimensionalità e identificare le componenti
#        principali che spiegano la maggior parte della varianza.
##########################################################

par(mfrow = c(1, 1))
dati_pca = data.frame(dati[, 7:26])
matrice_cor = cor(dati_pca, use = "na.or.complete")

# Analisi correlazioni
valore_cor_min = min(matrice_cor[lower.tri(matrice_cor)])
valore_cor_max = max(matrice_cor[lower.tri(matrice_cor)])

library(corrplot)
corrplot(corr = matrice_cor, order = "original", tl.col = 'black')

# KMO test per verificare adeguatezza PCA
library(REdaS)
KMOS(dati_pca, use = "na.or.complete")

# Scree plot per scelta componenti
scree = prcomp(na.omit(dati_pca))
screeplot(scree, type = "lines", main = "Scree Plot")
abline(h = 1, col = "red")

pca_result = prcomp(dati_pca, center = TRUE, scale. = TRUE)
summary(pca_result)

# Grafico dei pesi delle variabili sui primi 4 PC
library(tidyr)
library(dplyr)

loadings = pca_result$rotation
pca_pesi_variabili = data.frame(loadings)[, 1:4]
pca_pesi_variabili$variabile = rownames(pca_pesi_variabili)
pc_long = pca_pesi_variabili %>% gather(key = "PC", value = "value", -variabile)

colori_pc = c("PC1" = "purple", "PC2" = "red", "PC3" = "blue", "PC4" = "green")

ggplot(pc_long, aes(x = reorder(variabile, value), y = value, fill = PC)) +
  geom_bar(stat = "identity", position = "dodge") +
  facet_wrap(~PC, scales = "free_y") +
  coord_flip() +
  theme_minimal() +
  labs(x = "Variabile", y = "Peso", title = "Importanza delle variabili per ciascun PC") +
  scale_fill_manual(values = colori_pc)

# Manteniamo le prime 4 componenti
dati_pca = pca_result$x[, 1:4]


##########################################################
# 3. ANALISI DEI CLUSTER
# Scopo: identificare gruppi omogenei di rispondenti
#        in base alle componenti principali.
##########################################################

library(cluster)
dati_clust = data.frame(dati_pca)
dis = daisy(dati_clust, metric = "gower")

# Confronto metodi di clustering gerarchico
dati_co = hclust(dis, method = "complete")
dati_si = hclust(dis, method = "single")
dati_me = hclust(dis, method = "average")
dati_med = hclust(dis, method = "median")

par(mfrow = c(2, 2))
plot(dati_co, main = "Legame completo")
plot(dati_si, main = "Legame singolo")
plot(dati_me, main = "Legame medio")
plot(dati_med, main = "Legame mediano")

# Determinazione numero cluster
library(NbClust)
NbClust(data = dati_pca, max.nc = 5, method = "complete")

plot(dati_co, main = "Dendrogramma (3 cluster scelti)")
abline(h = 0.53)

num_clus = 3
gruppi = cutree(dati_co, k = num_clus)
clust = data.frame(gruppi, dati_clust)

# Visualizzazione cluster
colori_gruppi2 = c("1" = "red", "2" = "blue", "3" = "black")
clust$colore = colori_gruppi2[as.character(clust$gruppi)]

par(mfrow = c(3, 3))
plot(clust$PC1, clust$PC2, main = "PC1 vs PC2", col = clust$colore, pch = 19)
plot(clust$PC1, clust$PC3, main = "PC1 vs PC3", col = clust$colore, pch = 19)
plot(clust$PC2, clust$PC3, main = "PC2 vs PC3", col = clust$colore, pch = 19)


##########################################################
# 4. CLUSTER NON GERARCHICO (K-MEANS)
# Scopo: confronto con metodo precedente per validare i gruppi
##########################################################

set.seed(48)
num_clusters = 3
km.out = kmeans(dati_pca, centers = num_clusters, nstart = 20)
clust_ger = data.frame(dati_pca, cluster = km.out$cluster)
colori_gruppi = c("1" = "red", "2" = "blue", "3" = "black")
clust_ger$colore = colori_gruppi[as.character(clust_ger$cluster)]

# Confronto grafico tra metodi
par(mfrow = c(2, 1))
plot(clust$PC1, clust$PC2, main = "Metodo Gerarchico", col = clust$colore, pch = 19)
plot(clust_ger$PC1, clust_ger$PC2, main = "Metodo Non Gerarchico", col = clust_ger$colore, pch = 19)


##########################################################
# 5. ANALISI DESCRITTIVA PER CLUSTER
# Scopo: descrivere i cluster ottenuti in termini socio-demografici
#        e comportamentali.
##########################################################

dati_completi = cbind(clust_ger, dati)
clust_rosso = subset(dati_completi, cluster == 1)
clust_blu = subset(dati_completi, cluster == 2)
clust_nero = subset(dati_completi, cluster == 3)

### Età per cluster
par(mfrow = c(1, 3))
boxplot(clust_rosso$eta, main = "Età Cluster Rosso")
boxplot(clust_blu$eta, main = "Età Cluster Blu")
boxplot(clust_nero$eta, main = "Età Cluster Nero")

### Genere per cluster
par(mfrow = c(1, 3))
lbls = c("Maschi", "Femmine")
pie(round(prop.table(table(clust_rosso$genere)), 2) * 100, 
    labels = paste(lbls, round(prop.table(table(clust_rosso$genere)), 2) * 100, "%"),
    col = c("lightskyblue2", "pink"), main = "Genere Cluster Rosso")
pie(round(prop.table(table(clust_blu$genere)), 2) * 100, 
    labels = paste(lbls, round(prop.table(table(clust_blu$genere)), 2) * 100, "%"),
    col = c("lightskyblue2", "pink"), main = "Genere Cluster Blu")
pie(round(prop.table(table(clust_nero$genere)), 2) * 100, 
    labels = paste(lbls, round(prop.table(table(clust_nero$genere)), 2) * 100, "%"),
    col = c("lightskyblue2", "pink"), main = "Genere Cluster Nero")


### Occupazione e reddito per cluster
par(mfrow = c(3, 1))
barplot(table(clust_rosso$occupazione), main = "Occupazione Cluster Rosso")
barplot(table(clust_blu$occupazione), main = "Occupazione Cluster Blu")
barplot(table(clust_nero$occupazione), main = "Occupazione Cluster Nero")

barplot(table(clust_rosso$reddito), main = "Reddito Cluster Rosso")
barplot(table(clust_blu$reddito), main = "Reddito Cluster Blu")
barplot(table(clust_nero$reddito), main = "Reddito Cluster Nero")

### Analisi sintetica variabili chiave
mean(clust_rosso$coinvolgimento_brand_integrato)
mean(clust_blu$coinvolgimento_brand_integrato)
mean(clust_nero$score_percezionebrand_strumentidigitali)

##########################################################
# 6. RISULTATI FINALI
# Scopo: interpretazione dei cluster ottenuti (da integrare nel report)
# - Cluster 1 (rosso): profilo e comportamento medio
# - Cluster 2 (blu): profilo e comportamento medio
# - Cluster 3 (nero): profilo e comportamento medio
##########################################################
