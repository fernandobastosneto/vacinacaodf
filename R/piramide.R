piramide <- function() {
  
  populacao_total_df <- vacinacaodf::populacao_df %>% 
    mutate(populacao = as.numeric(populacao)) %>% 
    pull(populacao)
  
  # Faixas da população https://www.ibge.gov.br/apps/populacao/projecao/box_piramideplay.php?ag=53
  
  faixa_etaria_df <- tibble::tibble(faixa = c("90+", "85-89", "80-84", "75-79", 
                                      "70-74", "65-69", "60-64", "55-59", 
                                      "50-54", "45-49", "40-44", "35-39", 
                                      "30-34", "25-29", "20-24", "15-19", 
                                      "10-15", "5-9", "0-4"),
                            homens = c(0.06, 0.14, 0.33, 0.54,
                                       0.88, 1.28, 1.74, 2.33, 
                                       2.89, 3.37, 4.03, 4.3,
                                       4.18, 4.06, 4.15, 3.89,
                                       3.31, 3.17, 3.42),
                            mulheres = c(0.15, 0.26, 0.51, 0.79,
                                         1.22, 1.69, 2.20, 2.79,
                                         3.28, 3.83, 4.57, 4.74,
                                         4.37, 4.2, 4.11, 3.79,
                                         3.17, 3.01, 3.25))
  
  populacao_estimada_df <- faixa_etaria_df %>% 
    dplyr::mutate(pop_total_homens = (homens/100)*populacao_total_df,
           pop_total_mulheres = (mulheres/100)*populacao_total_df) %>% 
    dplyr::select(faixa, pop_total_homens, pop_total_mulheres) %>% 
    tidyr::pivot_longer(pop_total_homens:pop_total_mulheres, names_to = "Gênero", values_to = "População Total") %>% 
    dplyr::mutate(sexo = dplyr::case_when(stringr::str_detect(Gênero,"homens") ~ "M",
                            stringr::str_detect(Gênero, "mulheres") ~ "F")) %>% 
    dplyr::select(-Gênero)
  
  
  # População vacinada com uma dose
  
  # Dados
  
  populacao_vacinada_por_idade_faixa <- df_vac %>% 
    dplyr::filter(dose == 1) %>% 
    dplyr::mutate(data_nascimento = lubridate::year(data_nascimento)) %>% 
    dplyr::group_by(sexo, data_nascimento) %>% 
    dplyr::count() %>% 
    dplyr::ungroup() %>% 
    dplyr::mutate(idade = (data_nascimento-2021)*-1) %>% 
    dplyr::mutate(faixa = dplyr::case_when(idade >= 90 ~ "90+", 
                             idade >= 85 & idade <= 89 ~ "85-89", 
                             idade >= 80 & idade <= 84 ~ "80-84", 
                             idade >= 75 & idade <= 79 ~ "75-79",
                             idade >= 70 & idade <= 74 ~ "70-74", 
                             idade >= 65 & idade <= 69 ~ "65-69", 
                             idade >= 60 & idade <= 64 ~ "60-64", 
                             idade >= 55 & idade <= 59 ~ "55-59",
                             idade >= 50 & idade <= 54 ~ "50-54", 
                             idade >= 45 & idade <= 49 ~ "45-49", 
                             idade >= 40 & idade <= 44 ~ "40-44", 
                             idade >= 35 & idade <= 39 ~ "35-39",
                             idade >= 30 & idade <= 34 ~ "30-34", 
                             idade >= 25 & idade <= 29 ~ "25-29", 
                             idade >= 20 & idade <= 24 ~ "20-24", 
                             idade >= 15 & idade <= 19 ~ "15-19", 
                             idade >= 10 & idade <= 15 ~ "10-15",
                             idade >= 5 & idade <= 9 ~ "5-9", 
                             idade >= 0 & idade <= 4 ~ "0-4")) %>% 
    dplyr::group_by(faixa, sexo) %>% 
    dplyr::summarise(n = sum(n)) %>% 
    dplyr::ungroup() %>% 
    tidyr::drop_na() %>% 
    dplyr::left_join(populacao_estimada_df)
  
  # Gráfico
  
  populacao_vacinada_por_idade_faixa %>% 
    ggplot2::ggplot() +
    ggplot2::geom_bar(data = . %>% dplyr::filter(sexo == "F"), 
                      ggplot2::aes(faixa, -`População Total`, fill = sexo), stat = "identity", alpha = 0.5) +
    ggplot2::geom_bar(data = . %>% dplyr::filter(sexo == "M"), 
                      ggplot2::aes(faixa, `População Total`, fill = sexo), stat = "identity", alpha = 0.5) +
    ggplot2::geom_bar(data = . %>% dplyr::filter(sexo == "M"), 
                      ggplot2::aes(faixa, n, fill = sexo), stat = "identity") +
    ggplot2::geom_bar(data = . %>% dplyr::filter(sexo == "F"), 
                      ggplot2::aes(faixa, -n, fill = sexo), stat = "identity") +
    ggplot2::scale_y_continuous(breaks = seq(-150000, 150000, 50000),
                       labels = paste0(as.character(c(150, 100, 50, 0, 50, 100, 150)), " mil")) +
    ggplot2::coord_flip() +
    ggplot2::scale_fill_brewer(palette = "Set1") + 
    ggplot2::theme_bw() +
    ggplot2::labs(y = "População", x = "Faixa Etária",
         title = "Proporção da População Vacinada no Distrito Federal",
         caption = "Formulação: Fernando Bastos, Fonte: Ministério da Saúde, IBGE e basedosdados.org")
  
}