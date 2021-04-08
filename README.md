# searchGS
Algoritmo para scrapear datos de búsqueda realizada en Googel scholar

#-------------------------------------
#FUNCIONES PARA HACER SCRAPING EN GS

#cargar archivo con funciones desde el repositorio 
source("https://github.com/dannymuPTY/searchGS/blob/main/busqueda-google-scholar.R")

#añadir enlace de la busqueda en Google Scholar
url_google <- "https://scholar.google.com/scholar?hl=es&as_sdt=0%2C5&q=%22ciencias+biologicas%22+%2B+%22ciencias+ambientales%22&btnG="

#concectar y cargar librerias
conectar(url_google)

#generar urls de paginación
lista_pagina <- generar_urls(url_google)

#generar listado de publicaciones
publicaciones_busqueda <- lista_pagina %>% map(extraer_datos) %>% bind_rows()
