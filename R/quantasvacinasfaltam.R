quantasvacinasfaltam <- function() {
  
  populacao_total <- vacinacaodf::populacao_df %>% 
    pull(populacao)
   
  vacinacaodf::df_vac %>% 
    filter(dose == "1") %>% 
    count() %>% 
    mutate(faltam_vacinar = populacao_total - n) %>% 
    mutate(faltam_vacinar = as.integer((faltam_vacinar/populacao_total)*100)) %>% 
    pull(faltam_vacinar)
  
}