agregado <- function() {
  
  df_vac %>% 
    group_by(data_aplicacao) %>% 
    count() %>% 
    ungroup() %>% 
    mutate(rownumber = row_number()) %>% 
    mutate(agregado = zoo::rollapplyr(n, max(rownumber), sum, partial = T))  %>% 
    ggplot() +
    geom_line(aes(data_aplicacao, agregado)) +
    labs(x = NULL, y = "Vacinas Aplicadas",
         title = "Agregado de Vacinas Aplicadas",
         caption = "Fonte: Ministério da Saúde e basedosdados.org") +
    theme_minimal() +
    theme(legend.position = "bottom") +
    scale_y_continuous(labels = scales::label_number_si())
  
}