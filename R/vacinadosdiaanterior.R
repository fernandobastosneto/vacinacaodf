#' @export

vacinadosdiaanterior <- function() {
  
  vacinacaodf::df_vac %>% 
    dplyr::filter(data_aplicacao == max(data_aplicacao)) %>% 
    dplyr::count() %>% 
    dplyr::pull()
}