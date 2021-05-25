#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # Your application UI logic 
    shinydashboard::dashboardPage(
      shinydashboard::dashboardHeader(title = "Vacinação no DF"),
      shinydashboard::dashboardSidebar(
        shinydashboard::sidebarMenu(shinydashboard::menuItem("GitHub", icon = shiny::icon("fab fa-github"),
                                                             href = "https://github.com/fernandobastosneto/vacinacaodf/")
        )
      ),
      shinydashboard::dashboardBody(
        fluidRow(
          shinydashboard::infoBoxOutput("ultimosdados"),
          shinydashboard::infoBoxOutput("vacinadosdiaanterior"),
          shinydashboard::infoBoxOutput("mediamovel7dias")
        ),
        fluidRow(
          shinydashboard::infoBoxOutput("mediamovelmudanca"),
          shinydashboard::infoBoxOutput("quantasvacinasfaltam"),
          shinydashboard::infoBoxOutput("quantotempofalta")
        ),
        fluidRow(
          shinydashboard::box(title = "Pirâmide Etária", shiny::plotOutput("piramide")),
          shinydashboard::box(title = "Evolução", shiny::plotOutput("vacinados1dose"))
        ),
        fluidRow(
          shinydashboard::box(title = "Média Móvel", shiny::plotOutput("mediamovel7diasgrafico")),
          shinydashboard::box(title = "Total de Vacinas Aplicadas", shiny::plotOutput("agregado"))
        )
      )
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'vacinacaodf'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

