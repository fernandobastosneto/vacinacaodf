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
      paste0(vacinacaodf::vacinadosdiaanterior())
    )
  })
  
  output$mediamovel7dias <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      "Média Móvel Diária",
      paste0(as.integer(vacinacaodf::mediamovel7dias()), " Vacinados por dia"),
      subtitle = "com base nos últimos 7 dias"
    )
  })
  
  output$mediamovelmudanca <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      "Evolução da Média Móvel Diária",
      paste0(vacinacaodf::mediamoveludanca())
    )
  })
  
  output$quantasvacinasfaltam <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      "Quantas Pessoas Falta Vacinar",
      paste0("Falta vacinar ", vacinacaodf::quantasvacinasfaltam(), " % das população")
    )
  })
  
  output$quantotempofalta <- shinydashboard::renderInfoBox({
    shinydashboard::infoBox(
      "Quanto Tempo Falta",
      paste0("No ritmo da média móvel, faltam ", vacinacaodf::quantotempofalta(), " dias"),
      subtitle = "para que todos recebam ao menos uma dose"
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
