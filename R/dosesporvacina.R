#' @export
#' 

dosesporvacina <- function() {
  
  dias <- df_vac %>% 
    dplyr::group_by(data_aplicacao) %>% 
    dplyr::count() %>% 
    dplyr::ungroup()
  
  dias <- nrow(dias)
  
  vacinacaodf::df_vac %>% 
    dplyr::group_by(data_aplicacao, vacina) %>% 
    dplyr::count() %>% 
    tidyr::pivot_wider(names_from = vacina, values_from = n, values_fill = 0) %>% 
    tidyr::pivot_longer(cols = 2:5, names_to = "vacina", values_to = "n") %>% 
    dplyr::group_by(vacina) %>% 
    dplyr::mutate(agregado_vacina = zoo::rollapplyr(n, dias, sum, partial = T)) %>% 
    dplyr::mutate(vacina = dplyr::case_when(vacina == "85" ~ "Covishield",
                              vacina == "86" ~ "Coronavac",
                              vacina == "87" ~ "Pfizer",
                              vacina == "88" ~ "Jansen",
                              vacina == "89" ~ "AstraZeneca")) %>%
    ggplot2::ggplot() +
    ggplot2::geom_area(ggplot2::aes(data_aplicacao, agregado_vacina, 
                  fill = forcats::fct_reorder(vacina, agregado_vacina, .fun = sum, .desc = T)), 
              position = "stack") +
    ggplot2::scale_y_continuous(labels = scales::label_number_si(accuracy = 1)) +
    ggplot2::labs(y = "Doses Aplicadas", x = NULL,
                  title = "Total de Doses Aplicadas, por Vacinas") +
    ggplot2::theme_minimal() +
    ggthemes::scale_fill_tableau() +
    ggplot2::guides(fill=ggplot2::guide_legend(title="Vacina")) +
    ggplot2::theme(legend.position = "bottom")
  
}
