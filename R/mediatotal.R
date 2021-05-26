#' @export
#' 

mediatotal <- function() {
  
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
  
  as.integer(media)
  
}
