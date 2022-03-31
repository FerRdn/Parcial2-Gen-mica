######################
### PARCIAL 2 PT 3 ###
######################

## 31 03 22
## Fer Rendón

## Redes Booleanas

## Reglas de red generadas en nano "Rendón_Fernanda_P2-3.txt".
# A, NOT C
# B, NOT A
# C, NOT B

library (BoolNet)

ABC <- loadNetwork ("Rendón_Fernanda_P2-3.txt") # Cargar reglas
plotNetworkWiring (ABC) # Ver la red

## Atractores
atract <- getAttractors (ABC) # Se obtienen los atractores
atract
# Se tienen dos atractores, ambos cíclicos.


## Edo más probable
plotAttractors (atract) # Con esto se ven los atractores
# Abajo viene el porcentaje

# El atractor 1 tiene un 25%
# El atractor 2 tiene un 75%


## Atractores cíclicos
# Sí hay, son los dos atractores que se ven en
atract


## Dibujar atractores
plotAttractors (atract)
# Jaja ya lo había hecho pero ahí está otra vez


## Dibujar todos atractores
plotStateGraph (atract)
# Esa función mágica dibuja todos los estados y los atractores


