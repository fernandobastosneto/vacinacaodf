#' @export

ultimosdados <- function() {
  
  vacinacaodf::df_vac %>% 
    dplyr::filter(data_aplicacao == max(data_aplicacao)) %>% 
    dplyr::distinct(data_aplicacao) %>% 
    dplyr::pull(data_aplicacao)
  
}