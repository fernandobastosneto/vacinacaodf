ultimosdados <- function() {
  
  vacinacaodf::df_vac %>% 
    filter(data_aplicacao == max(data_aplicacao)) %>% 
    distinct(data_aplicacao) %>% 
    pull(data_aplicacao)
  
}