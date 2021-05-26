#' @export

mediavacinadostotal <- function() {
  
  dias <- df_vac %>% 
    dplyr::group_by(data_aplicacao) %>% 
    dplyr::count() %>% 
    dplyr::ungroup()

  dias <- nrow(dias)
  
  vacinacaodf::df_vac %>% 
    dplyr::group_by(data_aplicacao) %>% 
    dplyr::count() %>% 
    dplyr::ungroup() %>% 
    dplyr::mutate(agregado = zoo::rollapplyr(n, dias, mean, partial = T)) %>% 
    ggplot2::ggplot() +
    ggplot2::geom_area(ggplot2::aes(data_aplicacao, agregado), fill = "red") +
    ggplot2::labs(x = NULL, y = "Média Vacinas Aplicadas",
                  title = "Evolução da média diária de vacinados no DF",
                  subtitle = "Desde o início da vacinação",
                  caption = "Fonte: Ministério da Saúde e basedosdados.org") +
    ggplot2::theme_minimal() +
    ggplot2::theme(legend.position = "bottom") +
    ggplot2::scale_y_continuous(labels = scales::label_number_si())
  # ggplot2::scale_fill_brewer(palette = "Set1")
    
}