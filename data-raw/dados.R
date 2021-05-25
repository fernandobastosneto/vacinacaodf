library(DBI)
library(bigrquery)
library("basedosdados")
library(tidyverse)

bq_auth(path = "~/creds.json")
set_billing_id("dadoscovid")

# Dados de vacinas (do distrito federal) --------------------------------------------------------

query <- "SELECT sigla_uf, `basedosdados.br_ms_vacinacao_covid19.microdados_vacinacao`.id_paciente, categoria, 
nome_fabricante, data_aplicacao, dose, vacina, `basedosdados.br_ms_vacinacao_covid19.microdados_paciente`.data_nascimento,
`basedosdados.br_ms_vacinacao_covid19.microdados_paciente`.sexo
FROM `basedosdados.br_ms_vacinacao_covid19.microdados_vacinacao`
LEFT JOIN `basedosdados.br_ms_vacinacao_covid19.microdados_paciente` 
ON `basedosdados.br_ms_vacinacao_covid19.microdados_paciente`.id_paciente = `basedosdados.br_ms_vacinacao_covid19.microdados_vacinacao`.id_paciente
WHERE sigla_uf = 'DF'"

df_vac <- read_sql(query)


teste <- jsonlite::fromJSON("data-raw/dadoscovid-9483c906fc54.json")


bq_auth(scopes = "https://www.googleapis.com/auth/bigquery",
        # email = teste$client_email,
        token = teste$token_uri,
        use_oob = "out of band")

        type = teste$type,
        project_id = teste$project_id,
        private_key_id = teste$private_key_id)

teste <- c('[{
  "type": "service_account",
  "project_id": "dadoscovid",
  "private_key_id": "9483c906fc5434819c98acdfc065cbd2b692ac13",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC8L2brQ6IhE4S5\nHeoXrFS6CmR0rzSo2fulFs4aqMGP3zldiUhJcrcW8FVpkyoMxfWPZeOnQBxDGWlI\n4hs9rS7FQwRKxfwDsf4Q1zmQ/pHaRImwTZFNHedlqy+bAnx57H2fzzbdKUaG6Qsc\nJXlE2bT0w0ZZQV2HeJ2LOYWdsC+z8P/NLUdxsME/91oe11rQ32KmSrRxQhIfzFIe\nb9yXi49BgpP7Ov019evU5w4uYmrv0ga+TeeQ35B+zvD/iLQfNiVxBpRQ/jQNS3ah\nGTs5p+9LvFR+Fi6yuLab51FeD3TOwBTMIUae+Jz8l/lC0tvtQi0iw/2BUOkZkJ8M\nokrwL/MhAgMBAAECggEAFoJY/iUN3IT4KChS2tgLHmGl2GsoklXYisuqhXfQB0R9\nGRoVomttSPogTUuECRkYoTlfvJ6ngsMkW8pn1b3ETWYRulvqJAsDR8JmqVg52/C8\nw3DTw3SjO/7458KpXvARqq7fch7Ax9xSLuCwm7KquWguHvj5lf2wYnnT6KOtYQlr\nBT1qKuPL2rU6s86CMWZKQKMczEXAi7jn5GQmNanO/o1CDY2qDoh5nwgRCMDFoV2Z\nqoeY4KVbEeweQCbEmuvCxKHeSuxdwy7HxLbukwwfeKSwClwjYktQNguKGAJ6v2eG\n/bWPf/GmXSAWUSktqNsTRxGHcBmMdDDBEFN26QpD0QKBgQDpFVm9xhWuyHgtUTw/\nlbNokBfzzDsFarOUDczJICxCm5vWQIHIZ+w5nUCGJcQGkXOEhGNEIEPyac0lBtFG\ntLGZZSvxcHEtA5Vs1mkJZ0AwkGFgIHFf4rfwS4Vfz6TkE665La3OGsx0kCwouGBT\n7YZAkPI7OmmUf1kE2ygklN5yPQKBgQDOr/lwg6rJ4s5B5gbPVrf9YzErtxGrTt1i\nWpJV/sS+clwoIf6uUODFiK7sEZK4jfF3FfwpfWbipzUQHk3re676nF/IPms8znQB\nxkoQ53JGwcA8JRNcZm6d+Ho8a+D9BqCtc0Kb1b7Pu9yIbPEVeA1NMpji2S0Av0a/\nOVSNu6bGtQKBgGO2y5ahWINWpfsVJsY4//C6vFSDSbiuhjbPlI1yoxy3v3pwTFV1\nCB05xfHd1DfPH/FQRbtOZmMdmjK98Ofjw5rRKnR22yQbxWAzdeoc7twX2GCsYHRZ\n5MD7PgrYJT2hofz8qr9ivZccWpftEOC229lhaQ+nlKV/uZCXRVwpB+UtAoGAKi5x\nysukTGV0ULCgTSpWjGj0/QX0njCPL+ZqHRDMmE2Aj1Q4xNyOsuGtSVJgzjdxwysC\ndnk4SSN0yeBVaKyqTk0hox1SB2ve8wnDzeVeRiB+mge7Bs2E38p5L+GYXis/GYb/\nXgxmT8D4RgNtxELm/A1KdGl8LL3cs2QA5Jgadk0CgYBm0pxkxQMu8UwuALSJpb/N\nS7f9NnwmNOge+vX+v0KZ1IrfAnFoFZN+KxSQpDnKQnAA2HpRrxFPujhK9e/nTYR1\nBhXUfBH6FsrCqovQVMXcnaHWVq9hEWvUB9wzHkeClY2Dc9HlQ27zAJu5BnxGydp/\nn5lHNUEg9aarOn0jfYNQcw==\n-----END PRIVATE KEY-----\n",
  "client_email": "admin-497@dadoscovid.iam.gserviceaccount.com",
  "client_id": "110202682777153975666",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/admin-497%40dadoscovid.iam.gserviceaccount.com"
}]') 


bq_auth()

jsonlite::fromJSON(teste2)




use_data(df_vac)


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

usethis::use_data(populacao_df)
