#' @export
#' 

quantotempofaltamediatotal <- function() {
  
  populacao_total <- vacinacaodf::populacao_df %>% 
    dplyr::pull(populacao)

  dias <- df_vac %>% 
    dplyr::group_by(data_aplicacao) %>% 
    dplyr::count() %>% 
    dplyr::ungroup()
  
  dias <- nrow(dias)
  
  media <- vacinacaodf::df_vac %>% 
    dplyr::group_by(data_aplicacao) %>% 
    dplyr::count() %>% 
    dplyr::ungroup() %>% 
    dplyr::mutate(agregado = zoo::rollapplyr(n, dias, mean, partial = T)) %>% 
    dplyr::ungroup() %>% 
    dplyr::filter(data_aplicacao == max(data_aplicacao)) %>% 
    dplyr::pull(agregado) 
  
  quanto_falta <- vacinacaodf::df_vac %>% 
    dplyr::count() %>% 
    dplyr::mutate(faltam_vacinar = populacao_total - n) %>% 
    dplyr::mutate(faltam_vacinar = as.integer((faltam_vacinar/populacao_total)*100)) %>% 
    dplyr::pull(faltam_vacinar)
  
  velocidade <- (as.integer(media)/populacao_total)*100
  
  dias <- as.integer(quanto_falta/velocidade)
  
  dias
    
}