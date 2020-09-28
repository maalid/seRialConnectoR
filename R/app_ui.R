#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd


puertos <- NULL

jscode <- "shinyjs.closeWindow = function() { window.close(); }"

app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    fluidPage(
      h1("seRialConnectoR"),
      
      shinyjs::useShinyjs(),
      shinyjs::extendShinyjs(text = jscode, functions = c("closeWindow")),
      
      shiny::actionButton(inputId = "ports",
                          label = "Buscar puertos disponibles",
                          icon = NULL,
                          width = NULL),
      
      shiny::selectInput(inputId = "COM",
                            label = "Puertos disponibles",
                            choices = puertos,
                            selected = "",
                            multiple = FALSE,
                            selectize = FALSE,
                            width = NULL,
                            size = NULL),
      
      shiny::actionButton(inputId = "connect",
                          label = "Conectar con Arduino",
                          icon = NULL,
                          width = NULL),
      
      br(),
      
      shiny::verbatimTextOutput(outputId = "connectionStatus"),
      
      br(),
      
      shiny::selectInput(inputId = "number",
                         label = "Selecciona numero",
                         choices = c(1, 2, 3, 4),
                         selected = NULL,
                         multiple = FALSE,
                         selectize = FALSE,
                         width = NULL,
                         size = NULL),
      
      shiny::actionButton(inputId = "sendNumber",
                          label = "Enviar a Arduino",
                          icon = NULL,
                          width = NULL),
      
      br(),
      
      shiny::verbatimTextOutput(outputId = "datoEnviado"),
      
      br(),
      
      shiny::actionButton(inputId = "close",
                          label = "Desconectar Arduino",
                          icon = NULL,
                          width = NULL),
      br(),
      
      shiny::verbatimTextOutput(outputId = "disconnectionStatus"),
      
      br(),
      
      shiny::actionButton(inputId = "stop",
                          label = "Cerrar app",
                          icon = icon("power-off"),
                          width = NULL)
      
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
      app_title = 'seRialConnectoR'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

