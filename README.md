# searchGS
Algoritmo en R para scrapear datos de búsquedas realizada en Google scholar.<br>
Es necesario tener instalado el navegador Firefox para el uso con el paquete Selenium. <br>

# LISTA DE FUNCIONES  <br>

## Cargar archivo con funciones desde el repositorio <br>
source("https://github.com/dannymuPTY/searchGS/blob/main/busqueda-google-scholar.R")<br>

## Añadir enlace de la busqueda en Google Scholar <br>
(Este enlace es el que se genera al colorCcar un termino en la caja de busqueda de GS)<br>
url_google <- "https://scholar.google.com/scholar?hl=es&as_sdt=0%2C5&q=%22biologia+celular%22+&btnG="<br>

## Instalar paquetes y cargar librerias (opcional, se puede instalar los paquetes individuales)<br>
    PubGS_library()
  
## Abrir el navegador Firefox desde Selenium <br>
	conectar(url_google)<br>

## Generar urls de paginación<br>
	lista_pagina <- generar_urls(url_google)<br><br>

## Generar listado de publicaciones<br>
	pulicaciones_busqueda <- lista_pagina %>% map(extraer_datos) %>% bind_rows()<br>

## Guardar resultado en MS Excel (opcional)<br>
library(xlsx) <br>
write.xlsx(publicaciones_busqueda, paste("publicaciones_busqueda_",format(Sys.Date(),"%Y_%m_%d") , ".xls"),
           sheetName="publica-UTP", append=FALSE) <br>

<br>
## Nota: <br>
1. Al CONECTAR frecuente que el navegador no se inicie y envie el error: <br>
Error in wdman::selenium(port = port, verbose = verbose, version = version,  :  <br>
  Selenium server signals port = 4567 is already in use.  <br>
  Es necesario volver a cargar la fucnión para que se asigne otro numero de puerto. <br>
  
 2. Al scrapear es común que el servidor en GS bloquee el scaneo enviando el error:<br>

Selenium message:No active session with ID 702281ae-8fcf-4833-970f-a2b3c273075e <br>

Error: 	 Summary: NoSuchDriver <br>
 	 Detail: A session is either terminated or not started <br>
	 Further Details: run errorDetails method <br>
     
 El navegador mostrará un verificador CAPTCHA para dar acceso a los contenidos.
  
  3. Existe una limitante del algoritmo para escrapear solo 30 páginas, el máximo es 98.
