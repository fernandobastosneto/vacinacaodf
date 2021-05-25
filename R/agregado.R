#' @export

agregado <- function() {
  
  df_vac %>% 
    dplyr::group_by(data_aplicacao) %>% 
    dplyr::count() %>% 
    dplyr::ungroup() %>% 
    dplyr::mutate(rownumber = dplyr::row_number()) %>% 
    dplyr::mutate(agregado = zoo::rollapplyr(n, max(rownumber), sum, partial = T))  %>% 
    ggplot2::ggplot() +
    ggplot2::geom_line(ggplot2::aes(data_aplicacao, agregado)) +
    ggplot2::labs(x = NULL, y = "Vacinas Aplicadas",
         title = "Agregado de Vacinas Aplicadas",
         caption = "Fonte: Ministério da Saúde e basedosdados.org") +
    ggplot2::theme_minimal() +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::scale_y_continuous(labels = scales::label_number_si())
  
}