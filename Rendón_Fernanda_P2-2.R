######################
### PARCIAL 3 PT 2 ###
######################

## 31 03 22
## Fer Rendón

## Práctica Anotación Genómica

## Cargar librerías

BiocManager::install ("IRanges")
BiocManager::install ("rtracklayer")
BiocManager::install ("GenomicRanges")
BiocManager::install ("Rsamtools")

library (Biobase)
library (IRanges)
library (rtracklayer)
library (GenomicRanges)
library (Rsamtools)


## Objetos IRanges

x <- IRanges (start = c (11, 35, 40), end = c (20, 50, 63))
# Se genera el objeto tipo IRanges con inicio y final
x


## Extraer info básica
start (x) # Inicio
end (x) # Final
width (x) # Ancho
range (x) # Rango


## Otras infos
coverage (x) # Para c/posición, la suma
reduce (x) # Rangos encimados

exons <- reduce (x) # Objeto con rangos encimados

reads <- IRanges (start = c (1, 21, 30, 50, 80), width = 20) # Otro objeto
reads

countOverlaps (exons, reads)
# Compara entre ambos objetos en donde coinciden


## Subir archivo homo sapiens exons pequeñito
human <- import ("Homo_sapiens_exons_small_e70.gtf")
human
# Objeto de clase GRanges

seqnames (human) # no estoy segura de qué es
ranges (human) # Rangos de los 101 677 objetos
strand (human) # Muestra si es + o - la cadena
mcols (human) # Muestra las columnas de human

table (mcols (human)$gene_biotype) # Muestra lo que hay en gene_byotipe

mcols (human) <- mcols (human) [ , c ("source", "gene_id",
                                      "gene_name", "gene_biotype")]
# Seleccionar solo esas columnas
mcols (human)


## Ejercicios
# Solo anotaciones de miRNA
biotype <- human$gene_biotype
# Je, primero se selecciona solo los biotypes
miRNA <- subset (biotype, biotype == "miRNA")
# Luego se escogen los que son exactamente iguales a miRNA

# Solo anotaciones de cad -
neg <- subset (human, strand (human) == "-")
# Se hace un conjunto de los strans en human que sean
# exactamente igual a -


## Anotación de sec mapeadas

# Human mapped chiquito
what <- c ("rname", "strand", "pos", "qwidth")
# Vector con caracteres

param <- ScanBamParam (what = what)
# ? como que asigna what a what y luego lo escaneea para asignar parámetros?
# what indeed

bam <- scanBam ("human_mapped_small.bam", param = param)
# Cargar el archivo pero solo lo que se indica en param

class (bam)
# Es una lista

lapply (bam, names)
# Los nombres de bam

mapGR <- GRanges (seqnames = bam [[1]]$rname,
                 ranges = IRanges (start = bam [[1]]$pos,
                                   width = bam [[1]]$qwidth),
                 strand = bam [[1]]$strand)
# se asignan nombres y valores a esas categorías

mapGR

# Para ver las sec que coinciden con las anotaciones
mcols (human)$counts <- countOverlaps (human, mapGR)
# Los sobrelapados de human y mapGR se guardan en una columna de human
mcols (human)
# Ahí se ve counts


## Agregar valores
typeCounts <- aggregate (mcols (human)$counts,
                         by = list ("biotype" = mcols (human)$gene_biotype),
                         sum)
# En objeto se agregan columnas counts de human,
# se acomodan como lista de biotype
# y hace una suma de los elementos
typeCounts

geneCounts <- aggregate (mcols (human)$counts,
                         by = list ("id" = mcols (human)$gene_name),
                         sum)
# Lo mismo pero ahora de los id's
head (geneCounts)
# Ver solo las primeras seis


## Análisis de expresión diferencial
minCount <- 40000
# Objeto con valor de 40K

typeCountsHigh <- typeCounts [typeCounts$x > minCount, ]
# Objeto que tome los valores de x mayores a minCount, 40K

typeCountsHigh <- typeCountsHigh [order (typeCountsHigh$x), ]
# A ese mismo objeto se le pide que ordene las cuentas esas

typeCountsHigh <- rbind (data.frame ("biotype" = "other", 
                                     "x" = sum (typeCounts$x [typeCounts$x <= minCount])),
                         typeCountsHigh)
# A ese objeto nuevanente se le agrega algo
# Un renglón que asigne other a biotype?
# Es confuso el uso de "=" porque aquí lo usan para asignar como <-
# Pero se me confunde el cerebro si asigna o compara
# Creo que para comparar es "=="
# Entonces lo tomaré como que asigna
# Luego a x le asigna la suma de las cuentas 40K al typeCounts

pie (typeCountsHigh$x, labels = typeCountsHigh$biotype,
     col = rev (rainbow (nrow (typeCountsHigh))),
     main = "Number of aligned reads per biotype")
# Ya por fin para acabar con mi sufrimiento
# se hace una gráfica de pay/pastel
# Le pone etiquetas de acuerdo al biotipo
# Le pone colores del bello arcoiris según las cuentas >40K
# Pero yo nada más veo verde y rojo, onta el arcoíris?
# Ah, creo que en el ejercicio original utilizaron todos los datos
# Y yo usé la recortada jeje
# Bueno, después de eso se pone título


## Resumen
# Al final de todos los datos que se obtuvieron
# Sólo se tomaron aquellos que incluyen los productos funcionales
# De los genes
# Y con eso se acomodaron algunos datos
# Finalmente se hizo una gráfica de esos datos ya filtrados


