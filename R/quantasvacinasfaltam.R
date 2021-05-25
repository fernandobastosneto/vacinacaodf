#' @export

quantasvacinasfaltam <- function() {
  
  populacao_total <- vacinacaodf::populacao_df %>% 
    dplyr::pull(populacao)
   
  vacinacaodf::df_vac %>% 
    dplyr::filter(dose == "1") %>% 
    dplyr::count() %>% 
    dplyr::mutate(faltam_vacinar = populacao_total - n) %>% 
    dplyr::mutate(faltam_vacinar = as.integer((faltam_vacinar/populacao_total)*100)) %>% 
    dplyr::pull(faltam_vacinar)
  
}