#' The application server-side
#' 
#' @param input,output,session Internal parameters for {shiny}. 
#'     DO NOT REMOVE.
#' @import shiny
#' @importFrom dplyr %>%
#' @noRd


if(getRversion() >= "2.15.1")  utils::globalVariables("conn")

app_server <- function(input, output, session) {
    
    # Buscar puertos COM activos
    observeEvent(input$ports, {
        
        puertos <- serial::listPorts() %>% tibble::enframe(name = NULL)
        # print(puertos)
        
        shiny::updateSelectInput(session, 
                                 inputId = "COM", 
                                 label = "Puertos disponibles", 
                                 choices = puertos$value,
                                 selected = NULL)
        
    })
    
    
    # Conectar con arduino
    observeEvent(input$connect, {
        
        com <- input$COM
        
        conn <<- serial::serialConnection("arduino", 
                                         port = glue::glue("{com}"), 
                                         mode = "9600,n,8,1")
        
        open(conn)
        
        output$connectionStatus <- shiny::renderPrint({summary(conn)})
        
        # print(summary(conn))
    })
    
    # cerrar coneccion
    observeEvent(input$close, {
        close(conn)
        
        output$disconnectionStatus <- shiny::renderPrint({summary(conn)})
        
        # print(summary(conn))
    })
    
    # Enviar datos a Arduino
    observeEvent(input$sendNumber, {
        
        dato <- input$number
        # print(utils::str(dato))
        
        serial::write.serialConnection(conn, dato)
        
        output$datoEnviado <- renderText({dato})
    })
    
    # Boton para cerrar app y cesión en R
    observeEvent(input$stop, {
            shinyjs::js$closeWindow()
            stopApp()
    })

}
