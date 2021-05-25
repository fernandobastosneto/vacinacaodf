library(DBI)
library(bigrquery)
library("basedosdados")
library(tidyverse)

bq_auth(path = "creds.json")
#
set_billing_id("vacinacaodf")

# Dados de vacinas (do distrito federal) --------------------------------------------------------

query <- "SELECT sigla_uf, `basedosdados.br_ms_vacinacao_covid19.microdados_vacinacao`.id_paciente, categoria, 
nome_fabricante, data_aplicacao, dose, vacina, `basedosdados.br_ms_vacinacao_covid19.microdados_paciente`.data_nascimento,
`basedosdados.br_ms_vacinacao_covid19.microdados_paciente`.sexo
FROM `basedosdados.br_ms_vacinacao_covid19.microdados_vacinacao`
LEFT JOIN `basedosdados.br_ms_vacinacao_covid19.microdados_paciente` 
ON `basedosdados.br_ms_vacinacao_covid19.microdados_paciente`.id_paciente = `basedosdados.br_ms_vacinacao_covid19.microdados_vacinacao`.id_paciente
WHERE sigla_uf = 'DF'"

df_vac <- read_sql(query)

usethis::use_data(df_vac, overwrite = T)

Sys.sleep(2)

# Dados de População do DF ------------------------------------------------


query <- "SELECT * FROM `basedosdados.br_ibge_populacao.municipios`"
df_populacao <- read_sql(query)

populacao_df <- df_populacao %>% 
  filter(ano == max(ano)) %>% 
  mutate(id_municipio = as.character(id_municipio),
         id_municipio = str_sub(id_municipio, 1, 2)) %>% 
  mutate(sigla_uf = case_when(id_municipio == "12" ~ "AC",
                              id_municipio == "27" ~ "AL",
                              id_municipio == "16" ~ "AP",
                              id_municipio == "13" ~ "AM",
                              id_municipio == "29" ~ "BA",
                              id_municipio == "23" ~ "CE",
                              id_municipio == "53" ~ "DF",
                              id_municipio == "32" ~ "ES",
                              id_municipio == "52" ~ "GO",
                              id_municipio == "21" ~ "MA",
                              id_municipio == "51" ~ "MT",
                              id_municipio == "50" ~ "MS",
                              id_municipio == "31" ~ "MG",
                              id_municipio == "15" ~ "PA",
                              id_municipio == "25" ~ "PB",
                              id_municipio == "41" ~ "PR",
                              id_municipio == "26" ~ "PE",
                              id_municipio == "22" ~ "PI",
                              id_municipio == "24" ~ "RN",
                              id_municipio == "43" ~ "RS",
                              id_municipio == "33" ~ "RJ",
                              id_municipio == "11" ~ "RO",
                              id_municipio == "14" ~ "RR",
                              id_municipio == "42" ~ "SC",
                              id_municipio == "35" ~ "SP",
                              id_municipio == "28" ~ "SE",
                              id_municipio == "17" ~ "TO")) %>% 
  group_by(sigla_uf) %>% 
  summarise(populacao = sum(populacao)) %>% 
  filter(sigla_uf == "DF")

usethis::use_data(populacao_df, overwrite = T)
