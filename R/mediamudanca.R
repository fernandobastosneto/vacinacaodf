#' @export
#' 

mediamudanca <- function() {
  
  dias <- df_vac %>% 
    dplyr::group_by(data_aplicacao) %>% 
    dplyr::count() %>% 
    dplyr::ungroup()
  
  dias <- nrow(dias)
  
  media_hoje <- vacinacaodf::df_vac %>% 
    dplyr::group_by(data_aplicacao) %>% 
    dplyr::count() %>% 
    dplyr::ungroup() %>% 
    dplyr::mutate(agregado = zoo::rollapplyr(n, dias, mean, partial = T)) %>% 
    dplyr::ungroup() %>% 
    dplyr::filter(data_aplicacao == max(data_aplicacao)) %>% 
    dplyr::pull(agregado) 
  
  media_ontem <- vacinacaodf::df_vac %>% 
    dplyr::group_by(data_aplicacao) %>% 
    dplyr::count() %>% 
    dplyr::ungroup() %>% 
    dplyr::mutate(agregado = zoo::rollapplyr(n, dias, mean, partial = T)) %>% 
    dplyr::ungroup() %>% 
    dplyr::filter(data_aplicacao == max(data_aplicacao-1)) %>% 
    dplyr::pull(agregado)
  
  if (media_hoje > media_ontem) {
    return(paste0("Vacinação acelerando"))
  }
  else {
    return(paste0("Vacinação desacelerando"))
  }
  
  
}