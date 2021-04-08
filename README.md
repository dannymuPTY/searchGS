# searchGS
Algoritmo en R para scrapear datos de búsquedas realizada en Google scholar.<br>
Es necesario tener instalado el navegador Firefox para el uso con el paquete Selenium. <br>

# LISTA DE FUNCIONES  <br>

## Cargar archivo con funciones desde el repositorio <br>
source("https://github.com/dannymuPTY/searchGS/blob/main/busqueda-google-scholar.R")<br>

## Añadir enlace de la busqueda en Google Scholar<br>
url_google <- "https://scholar.google.com/scholar?hl=es&as_sdt=0%2C5&q=%22ciencias+biologicas%22+%2B+%22ciencias+ambientales%22&btnG="<br>

## Instalar paquetes y cargar librerias (opcional, se puede instalar los paquetes individuales)<br>
Lista de paquetes c("(pipeR","xml2","rvest","plyr", "dplyr","curl","stringr","tidyverse","purrr", "httr", "RSelenium") <br>
    PubGS_library()<br>
  
## Abrir el navegador Firefox desde Selenium <br>
conectar(url_google)<br>

## Generar urls de paginación<br>
lista_pagina <- generar_urls(url_google)<br><br>

## Generar listado de publicaciones<br>
pulicaciones_busqueda <- lista_pagina %>% map(extraer_datos) %>% bind_rows()<br>
