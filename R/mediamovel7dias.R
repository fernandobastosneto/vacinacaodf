mediamovel7dias <- function() {
  vacinacaodf::df_vac %>% 
    group_by(data_aplicacao) %>% 
    count() %>% 
    ungroup() %>% 
    mutate(agregado = zoo::rollapplyr(n, 7, mean, partial = T)) %>% 
    filter(data_aplicacao == max(data_aplicacao)) %>% 
    pull(agregado)
}