#' @export

mediamoveludanca <- function() {
  
  media_hoje <- vacinacaodf::mediamovel7dias()
  
  media_ontem <- vacinacaodf::df_vac %>% 
    group_by(data_aplicacao) %>% 
    count() %>% 
    ungroup() %>% 
    mutate(agregado = zoo::rollapplyr(n, 7, mean, partial = T)) %>% 
    filter(data_aplicacao == max(data_aplicacao)-1) %>% 
    pull(agregado)
  
  if (media_hoje > media_ontem) {
    return(paste0("Vacinação acelerando"))
  }
  else {
    return(paste0("Vacinação desacelerando"))
  }
}