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
  
  output$vacinadosdiaanterior <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      "Vacinados no Último Dia de Vacinação:",
      paste0(vacinacaodf::vacinadosdiaanterior()),
      icon = shiny::icon("fas fa-syringe"),
      color = "navy"

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
  
  output$mediamovelmudanca <- shinydashboard::renderInfoBox({
    
    if (stringr::str_detect(vacinacaodf::mediamoveludanca(), "desacelerando")) {
      
      shinydashboard::infoBox("Evolução da Média Móvel Diária",
                             paste0(vacinacaodf::mediamoveludanca()), 
                             icon = shiny::icon("far fa-thumbs-down"),
                             color = "red")

    }
    
    else {
      shinydashboard::infoBox("Evolução da Média Móvel Diária",
                              paste0(vacinacaodf::mediamoveludanca()), 
                              icon = shiny::icon("far fa-thumbs-up"),
                              color = "blue")
    }
  })
  
  output$quantasvacinasfaltam <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      "Quantas Pessoas Falta Vacinar",
      paste0("Falta vacinar ", vacinacaodf::quantasvacinasfaltam(), " % da população"),
      icon = shiny::icon("fas fa-user-shield"),
      color = "teal"
    )
  })
  
  output$quantotempofalta <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      "Quanto Tempo Falta",
      paste0("Na média móvel, faltam ", vacinacaodf::quantotempofalta(), " dias"),
      subtitle = "para que todos recebam ao menos uma dose",
      icon = shiny::icon("fas fa-hourglass-half"),
      color = "olive"
    )
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
}
