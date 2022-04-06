######################
### PARCIAL 2 PT 1 ###
######################

## 06 04 22
## Fer Rendón

## ExperimentoDesconocido.tsv

resultados1 <- read.csv (choose.files (), sep = "\t") # Archivo ExperimentoDesconocido
resultados1

## BOXPLOT DE EXPRESIÓN
boxplot (resultados1$logFC)
# Boxplot sencillo de las expresiones
# Es LogFC porque indica el cambio en la expresión


## SUB Y SOBRE-EXPRESIÓN
subexp <- subset (resultados1, c (resultados1$logFC > 0))
subexp
# De resultados1, toma todos aquellos cuyo valor de logFC sea negativo
# Porque esto indica que su expresión fue menor al control

sobreexp <- subset (resultados1, c (resultados1$logFC < 0))
sobreexp
# De resultados1, toma todos aquellos cuyo valor de logFC sea positivo
# Porque esto indica que su expresión fue mayor al control


## CONTEO DE SONDAS
summary (subexp)
# Length de 8 276

summary (sobreexp)
# Length de 14 007

# No sé pq no salía solo con length pero se obtuvo jajaj


## VOLCANO PLOT
plot (x = resultados1$logFC, y = resultados1$P.Value)
# Sale al revés jajaja
# Hay que ponerle el log raro para que salga mejor

plot (x = resultados1$logFC, y = -log10 (resultados1$P.Value))
# Genérico pero salió jajajaja


## GO
# Me metí a Panther y subí la tablita
# Pero solo me salió un ID jaja
# No lo hago en Cytoscape porque colapsa mi laptop y yo
# Luego le moví y pide lista de referencia pero noai
# Ya no supe qué hacer :()





