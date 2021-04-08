# searchGS
Algoritmo en R para scrapear datos de búsquedas realizada en Google scholar.<br>
Es necesario tener instalado el navegador Firefox para el uso con el paquete Selenium. <br>

# LISTA DE FUNCIONES  <br>

## Cargar archivo con funciones desde el repositorio <br>
source("https://github.com/dannymuPTY/searchGS/blob/main/busqueda-google-scholar.R")<br>

## Añadir enlace de la busqueda en Google Scholar (Este enlace es el que se genera al color un termino en la caja de busqueda de GS)<br>
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

<br>
## Nota: <br>
1. Al CONECTAR frecuente que el navegador no se inicie y envie el error: <br>
Error in wdman::selenium(port = port, verbose = verbose, version = version,  :  <br>
  Selenium server signals port = 4567 is already in use.  <br>
  Es necesario volver a cargar la fucnión para que se asigne otro numero de puerto. <br>
  
 2. Al scrapear es común que el servidor en GS bloque el scaneo enviando el error:<br>

Selenium message:No active session with ID 702281ae-8fcf-4833-970f-a2b3c273075e <br>

Error: 	 Summary: NoSuchDriver <br>
 	 Detail: A session is either terminated or not started <br>
	 Further Details: run errorDetails method <br>
     
 El navegador mostrará un verificador CAPTCHA para dar acceso a los contenidos.
  
  
