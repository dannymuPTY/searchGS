# searchGS
Algoritmo para scrapear datos de búsqueda realizada en Google scholar<br><br>

#FUNCIONES PARA HACER SCRAPING EN GS <br><br>

#cargar archivo con funciones desde el repositorio <br>
source("https://github.com/dannymuPTY/searchGS/blob/main/busqueda-google-scholar.R")<br><br>

#añadir enlace de la busqueda en Google Scholar<br>
url_google <- "https://scholar.google.com/scholar?hl=es&as_sdt=0%2C5&q=%22ciencias+biologicas%22+%2B+%22ciencias+ambientales%22&btnG="<br><br>

#conectar y cargar librerias<br>
conectar(url_google)<br><br>

#generar urls de paginación<br>
lista_pagina <- generar_urls(url_google)<br><br>

#generar listado de publicaciones<br>
publicaciones_busqueda <- lista_pagina %>% map(extraer_datos) %>% bind_rows()<br>
