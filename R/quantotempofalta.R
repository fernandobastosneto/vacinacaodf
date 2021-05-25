#' @export

quantotempofalta <- function() {
  
  populacao_total <- vacinacaodf::populacao_df %>% 
    pull(populacao)
  
  quanto_falta <- vacinacaodf::df_vac %>% 
    count() %>% 
    mutate(faltam_vacinar = populacao_total - n) %>% 
    mutate(faltam_vacinar = as.integer((faltam_vacinar/populacao_total)*100)) %>% 
    pull(faltam_vacinar)
  
  velocidade <- (as.integer(vacinacaodf::mediamovel7dias())/populacao_total)*100
  
  dias = as.integer(quanto_falta/velocidade)
  
  
}