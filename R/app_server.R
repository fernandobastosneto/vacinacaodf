#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_server <- function( input, output, session ) {
  # Your application server logic 
  
  output$ultimosdados <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      "Últimos Dados de Vacinas Disponíveis:", 
      paste0(vacinacaodf::ultimosdados()), icon = icon("calendar"),
      subtitle = "formato ano/mês/dia",
      color = "purple"
    )
  })
  
  output$mediatotal <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      "Média",
      paste0(as.integer(vacinacaodf::mediatotal()), " Vacinados por dia"),
      subtitle = "Desde o início da vacinação",
      icon = shiny::icon("fas fa-star-of-life"),
      color = "yellow"
    )
  })
  
  output$mediamovel7dias <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      "Média Móvel Diária",
      paste0(as.integer(vacinacaodf::mediamovel7dias()), " Vacinados por dia"),
      subtitle = "com base nos últimos 7 dias",
      icon = shiny::icon("fas fa-star-of-life"),
      color = "yellow"
    )
  })
  
  output$vacinadosdiaanterior <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      "Vacinados no Último Dia de Vacinação:",
      paste0(vacinacaodf::vacinadosdiaanterior()),
      icon = shiny::icon("fas fa-syringe"),
      color = "navy"

    )
  })
  
  output$quantotempofaltamediatotal <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      "Quanto Tempo Falta - Média",
      paste0("faltam ", vacinacaodf::quantotempofaltamediatotal(), " dias"),
      subtitle = "para que todos recebam ao menos uma dose",
      icon = shiny::icon("fas fa-hourglass-half"),
      color = "olive",
      width = 2,
    )
  })
  
  output$quantotempofalta <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      "Quanto Tempo Falta - Média Móvel de 7 Dias",
      paste0("faltam ", vacinacaodf::quantotempofalta(), " dias"),
      subtitle = "para que todos recebam ao menos uma dose",
      icon = shiny::icon("fas fa-hourglass-half"),
      color = "olive",
      width = 2,
    )
  })
  
  output$quantasvacinasfaltam <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      "Quantas Pessoas Falta Vacinar",
      paste0("Falta vacinar ", vacinacaodf::quantasvacinasfaltam(), " % da população"),
      icon = shiny::icon("fas fa-user-shield"),
      color = "teal"
    )
  })
  
  output$mediamudanca <- shinydashboard::renderInfoBox({
    
    if (stringr::str_detect(vacinacaodf::mediamudanca(), "desacelerando")) {
      
      shinydashboard::infoBox("Evolução da Média",
                              paste0(vacinacaodf::mediamudanca()), 
                              icon = shiny::icon("far fa-thumbs-down"),
                              color = "red")
      
    }
    
    else {
      shinydashboard::infoBox("Evolução da Média",
                              paste0(vacinacaodf::mediamudanca()), 
                              icon = shiny::icon("far fa-thumbs-up"),
                              color = "blue")
    }
  })
  
  
  output$mediamovelmudanca <- shinydashboard::renderInfoBox({
    
    if (stringr::str_detect(vacinacaodf::mediamovelmudanca(), "desacelerando")) {
      
      shinydashboard::infoBox("Evolução da Média Móvel",
                             paste0(vacinacaodf::mediamovelmudanca()), 
                             icon = shiny::icon("far fa-thumbs-down"),
                             color = "red")

    }
    
    else {
      shinydashboard::infoBox("Evolução da Média Móvel",
                              paste0(vacinacaodf::mediamovelmudanca()), 
                              icon = shiny::icon("far fa-thumbs-up"),
                              color = "blue")
    }
  })
  
  
  
  output$piramide <- shiny::renderPlot({
    vacinacaodf::piramide()
  })
  
  output$vacinados1dose <- shiny::renderPlot({
    vacinacaodf::vacinados1dose()
  })
  
  output$mediamovel7diasgrafico <- shiny::renderPlot({
    vacinacaodf::mediamovel7diasgrafico()
  })
  
  output$agregado <- shiny::renderPlot({
    vacinacaodf::agregado()
  })

  output$mediavacinadostotal <- shiny::renderPlot({
    vacinacaodf::mediavacinadostotal()
  })
  
  output$dosesporvacina <- shiny::renderPlot({
    vacinacaodf::dosesporvacina()
  })
  
}
