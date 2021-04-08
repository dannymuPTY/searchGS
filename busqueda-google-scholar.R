
# INSTALAR PAQUETES DE FUNCIONES
#-----------------------------------------

PubGS_library<-function(){

  # Lista de paquetes de funciones a instalar
  packages = c("(pipeR","xml2","rvest","plyr", "dplyr","curl", "stringr","tidyverse","purrr", "httr", "RSelenium")
  
  # Instala los paquetes sinï¿½ los tienes instalados
  inst <- packages %in% installed.packages()
  if(length(packages[!inst]) > 0) install.packages(packages[!inst])
  
  # CARGAR PAQUETES O CREAR FUNCIONES
  #-----------------------------------------
  # Carga los paquetes sinï¿½ los tienes cargados
  lapply(packages, require, character.only=TRUE)
  #-----------------------------------------
  
}


# GENERAR URL DE PAGINACIÓN 
#-----------------------------------------

generar_urls <- function(url_google){
  
  #codigo SELENIUM
  remote_driver$navigate(url_google)
  html <- remote_driver$getPageSource()[[1]]
  
  #leer enlaces
  busqueda <- read_html(html)
  
  #numero de resultados
  num_resultado <- busqueda %>% html_nodes(".gs_ab_mdw")
  num_resultado_ <- num_resultado[2]  %>% html_text() %>% str_split(" ") %>%  unlist()
  num_resultado_ <- num_resultado_[2] %>% str_split(",") %>%  unlist()
  x <- length(num_resultado_)
  
  #inicializar variable numero de resultados
  num_resultadoN <- ""
  
  for (n in 1:x) {
    #print(num_resultadoN)
    num_resultadoN <- paste0(num_resultadoN,num_resultado_[n])
  }
  
  num_resultadoN <- num_resultadoN %>% as.numeric() 
  num_resultadoN <- num_resultadoN / 10
  
  #numeros de enlaces a generar
  cant_resultados <- ifelse(num_resultadoN < 30, num_resultadoN, 30)
  
  #generar numeros 
  numeros_url <- seq(0,(cant_resultados*10), by = 10)
  
  #crear urls 
  url_google2 <- url_google %>% str_split("\\?") %>%  unlist()
  url_google3 <- url_google2[2] %>% str_split("\\&") %>%  unlist()
  #str(url_google)
  
  # Generate the target URLs
  lista_pagina <- str_c(url_google2[1], '?start=', numeros_url,"&",url_google3[3],"&",url_google3[1],"&as_sdt=0,5")
  
  return(lista_pagina)
}

# CONECTAR UTILIZANDO SELENIUM Y FIREFOX
#-----------------------------------------

conectar <- function(url_google){
  #codigo selenium --------------
  driver <- rsDriver(browser=c("firefox"))
  remote_driver <- driver[["client"]]
  remote_driver$navigate(url_google)
  
}




# EXTRAER DATOS DE NOSDOS HTML
#-----------------------------------------

extraer_datos <- function(url_google){
  
  #url_google <- lista_pagina[1]
  #codigo SELENIUM
  remote_driver$navigate(url_google)
  html <- remote_driver$getPageSource()[[1]]
  
  #leer enlaces
  busqueda <- read_html(html)
  #leer enlaces
  #busqueda <- read_html(url_google)
  
  #busqueda de nodos
  data_lista <- busqueda %>% html_nodes(".gs_r")  
  num <-length(data_lista)-1
  lista_items <- tibble()
  lista_ <- tibble()
  
  print(url_google)
  #n <-6
  #----------------------------------
  #-- funcion extracción de nodos --- 
  #----------------------------------
  for (n in 1:num) {
    
    print(n)
    #formato
    #formato <- data_lista[n] %>% html_nodes(".gs_ct1") %>% html_text()
    #titulo
    titulo <- data_lista[n] %>% html_nodes(".gs_rt > a") %>% html_text()
    #url_titulo
    url_titulo <- data_lista[n] %>% html_nodes(".gs_rt > a") %>% html_attr("href")
    #autores - fecha - dominio
    autores_citas <- data_lista[n] %>% html_nodes(".gs_a") %>% html_text() %>% str_split("-") %>%  unlist()
    autores <- autores_citas[1]
    autores <- ifelse(length(autores) > 0,autores,NA)
    anio <- autores_citas[2]
    anio  <- ifelse(length(anio) > 0,anio,NA)
    dominio <- autores_citas[3]
    dominio <- ifelse(length(dominio) > 0,dominio,NA)
    
    #resumen
    resumen <- data_lista[n] %>% html_nodes(".gs_rs") %>% html_text()
    resumen  <- ifelse(length(resumen) > 0, resumen,NA)
    #citas 
    citas <- data_lista[n] %>% html_nodes(".gs_fl > a") %>% html_text()
    cita_ <- citas[3] %>% str_split(" ") %>%  unlist()
    cita__ <- is.na(cita_[3])
    cita <- ifelse(cita__ == TRUE, 0,as.numeric(cita_[3]))
    
    #enlace documento
    doc <- data_lista[n] %>% html_nodes(".gs_ggs a") %>% html_text() 
    doc_eval <- ifelse(length(doc) == 0, 0, 1)
    #evaluar enlace vacio
    if(doc_eval==1){
      doc_dominio_ <- doc %>% str_split(" ") %>%  unlist()
      doc_dominio <- doc_dominio_[2]
      #formato <- doc_dominio_[1]
      pattern_ <- "([a-zA-Z]{3,4})"
      formato <- str_extract(doc_dominio_[1], pattern = pattern_)
    }else{
      doc_dominio <- NA 
      formato <- NA 
    }
    
    #------------------------
    #url_titulo
    url_doc <- data_lista[n] %>% html_nodes(".gs_ggs a") %>% html_attr("href")
    url_eval <- ifelse(length(url_doc) == 0, 0, 1)
    #evaluar enlace vacio
    if(url_eval==1){
      nume <- length(url_doc)
      if(nume>1){
        url_doc  <- url_doc[1]
      }else{
        url_doc <- url_doc 
        
      }
      
      url_doc_  <- url_doc %>% str_split("/") %>%  unlist()
      #nombre archivo
      url_doc_name <- url_doc_[length(url_doc_)]
    }else{
      url_doc  <- NA
      #nombre archivo
      url_doc_name <- NA
    }
    
    
    
    #generar data frame
    lista_ <- tibble(titulo, url_titulo ,autores, anio, dominio, resumen, cita ,url_doc, url_doc_name, formato)
    #print(lista_)
    lista_items <- rbind(lista_items, lista_)
  }
  
  return(lista_items)
  
}




