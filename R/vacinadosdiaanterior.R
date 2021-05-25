#' @export

vacinadosdiaanterior <- function() {
  
  vacinacaodf::df_vac %>% 
    filter(data_aplicacao == max(data_aplicacao)) %>% 
    count() %>% 
    pull()
}