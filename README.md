
<!-- README.md is generated from README.Rmd. Please edit that file -->

# vacinacaodf

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

O dashboard vacinacaodf apresenta dados atualizados do cenário da
vacinação no Distrito Federal a partir de fontes públicas. O aplicativo
não existiria sem o grande trabalho da [Base dos
Dados](basedosdados.org), que disponibiliza de maneira extremamente
didática e organizada dados abertos.

Através da API da [Base dos Dados](basedosdados.org), o aplicativo faz
uso dos dados mais atualizados de vacinação disponibilizados pelo
Ministério da Saúde, restringindo o escopo da análise para o Distrito
Federal. O aplicativo também utiliza referências populacionais do IBGE,
igualmente a partir da API da [Base dos Dados](basedosdados.org), e
cruza essas informações para formular estimativas e prazos para a
conclusão da vacinação no DF.

(Dados referentes às faixas etárias, contudo, foram adquiridos de
maneira um pouco menos elegante: na ausência de dados atualizados
disponíveis na API, não me sobrou outra opção senão buscar esses dados à
mão
[aqui](https://www.ibge.gov.br/apps/populacao/projecao/box_piramideplay.php?ag=53).
Que atire a primeira pedra quem nunca labutou dessa maneira!!!)

Este aplicativo é um exercício de análise básica a partir dos dados de
vacinação disponibilizados pelo governo federal. Por motivos óbvios,
apesar de usar fontes públicas, este aplicativo não apresenta qualquer
previsão efetiva a respeito dos prazos e calendário de vacinação. O
calendário das vacinas tem sofrido constantes alterações ao longo dos
meses, a depender do estoque de vacinas disponíveis no âmbito do SUS.
