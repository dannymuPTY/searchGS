# searchGS
Algoritmo en R para scrapear datos de búsquedas realizada en Google scholar.<br>
Es necesario tener instalado el navegador Firefox para el uso con el paquete Selenium. <br>

# FUNCIONES PARA HACER SCRAPING EN GS <br>

## Cargar archivo con funciones desde el repositorio <br>
source("https://github.com/dannymuPTY/searchGS/blob/main/busqueda-google-scholar.R")<br>

## Añadir enlace de la busqueda en Google Scholar<br>
url_google <- "https://scholar.google.com/scholar?hl=es&as_sdt=0%2C5&q=%22ciencias+biologicas%22+%2B+%22ciencias+ambientales%22&btnG="<br>

## Conectar y cargar librerias<br>
conectar(url_google)<br>

## Generar urls de paginación<br>
lista_pagina <- generar_urls(url_google)<br><br>

## Generar listado de publicaciones<br>
pulicaciones_busqueda <- lista_pagina %>% map(extraer_datos) %>% bind_rows()<br>
