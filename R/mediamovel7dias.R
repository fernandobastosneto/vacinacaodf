#' @export

mediamovel7dias <- function() {
  vacinacaodf::df_vac %>% 
    dplyr::group_by(data_aplicacao) %>% 
    dplyr::count() %>% 
    dplyr::ungroup() %>% 
    dplyr::mutate(agregado = zoo::rollapplyr(n, 7, mean, partial = T)) %>% 
    dplyr::filter(data_aplicacao == max(data_aplicacao)) %>% 
    dplyr::pull(agregado)
}