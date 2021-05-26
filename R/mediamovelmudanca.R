#' @export

mediamovelmudanca <- function() {
  
  media_hoje <- vacinacaodf::mediamovel7dias()
  
  media_ontem <- vacinacaodf::df_vac %>% 
    dplyr::group_by(data_aplicacao) %>% 
    dplyr::count() %>% 
    dplyr::ungroup() %>% 
    dplyr::mutate(agregado = zoo::rollapplyr(n, 7, mean, partial = T)) %>% 
    dplyr::filter(data_aplicacao == max(data_aplicacao)-1) %>% 
    dplyr::pull(agregado)
  
  if (media_hoje > media_ontem) {
    return(paste0("Vacinação acelerando"))
  }
  else {
    return(paste0("Vacinação desacelerando"))
  }
}