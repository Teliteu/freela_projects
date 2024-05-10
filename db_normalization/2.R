library(dplyr)

BASE22 <- BASE22 %>%
  mutate(
    uo = substr(uo, 1, 5),
    acao = substr(acao, 1, 4),
    po = substr(po, 1, 4)
  )

BRUTO <- BRUTO %>%
  mutate(
    uo = substr(uo, 1, 5),
    acao = substr(acao, 1, 4),
    po = substr(po, 1, 4)
  )

colunas_adicionais <- setdiff(names(BASE22), names(BRUTO))

consistente1 <- BRUTO %>%
  inner_join(BASE22 %>% select(acao, po, all_of(colunas_adicionais)), by = c("acao", "po"))

consistente2 <- consistente1 %>%
  semi_join(BASE22, by = c("uo", "acao", "po"))

nova <- consistente1 %>%
  anti_join(BASE22, by = c("uo", "acao", "po")) %>%
  distinct()

areas <- c("Administração e Pessoal Ativo", "Alívio à pobreza e assistência social", "Educação", "Esporte",
           "Habitação", "Proteção dos direitos de crianças e adolescentes", "Saneamento", "Saúde", "Segurança Alimentar", "Direitos Humanso", "Cultura")

criar_subconjunto_salvar <- function(data, nome_tabela) {
  lista_subconjuntos <- list()
  for (area in areas) {
    subset <- data %>% filter(area == !!area)
    nome_variavel <- paste0(nome_tabela, "_", tolower(gsub(" ", "_", area)))
    lista_subconjuntos[[nome_variavel]] <- subset
    assign(nome_variavel, subset, envir = .GlobalEnv)
  }
  return(lista_subconjuntos)
}

subconjuntos_consistente1 <- criar_subconjunto_salvar(consistente1, "consistente1")
subconjuntos_consistente2 <- criar_subconjunto_salvar(consistente2, "consistente2")
subconjuntos_nova <- criar_subconjunto_salvar(nova, "nova")

