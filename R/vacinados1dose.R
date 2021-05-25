#' @export

vacinados1dose <- function() {
  
  df_vac %>% 
    dplyr::filter(dose == "1") %>% 
    dplyr::group_by(data_aplicacao) %>% 
    dplyr::count() %>% 
    dplyr::ungroup() %>% 
    dplyr::mutate(rownumber = row_number()) %>% 
    dplyr::mutate(agregado = zoo::rollapplyr(n, max(rownumber), sum, partial = T)) %>% 
    ggplot2::ggplot() +
    ggplot2::geom_area(ggplot2::aes(data_aplicacao, populacao_total_df, fill = populacao_total_df), alpha = 0.5, show.legend = F) +
    ggplot2::geom_area(ggplot2::aes(data_aplicacao, agregado)) +
    ggplot2::labs(y = "População", x = "Data de Aplicação",
         title = "Evolução da parcela da população com uma dose no DF",
         caption = "Formulação: Fernando Bastos, Fonte: Ministério da Saúde, IBGE e basedosdados.org") +
    ggplot2::scale_y_continuous(labels = scales::label_number_si(accuracy = 0.1)) +
    ggplot2::theme_minimal() +
    ggplot2::annotate(geom="text",x=as.Date("2021-05-05"),
                               y=250000,label="Vacinados",fontface="bold", color = "white") +
    ggplot2::annotate(geom="text",x=as.Date("2021-02-01"),
             y=2500000,label="Por Vacinar",fontface="bold", color = "black")
  
}