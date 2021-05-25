#' @export

quantotempofalta <- function() {
  
  populacao_total <- vacinacaodf::populacao_df %>% 
    dplyr::pull(populacao)
  
  quanto_falta <- vacinacaodf::df_vac %>% 
    dplyr::count() %>% 
    dplyr::mutate(faltam_vacinar = populacao_total - n) %>% 
    dplyr::mutate(faltam_vacinar = as.integer((faltam_vacinar/populacao_total)*100)) %>% 
    dplyr::pull(faltam_vacinar)
  
  velocidade <- (as.integer(vacinacaodf::mediamovel7dias())/populacao_total)*100
  
  dias = as.integer(quanto_falta/velocidade)
  
  
}