library(dplyr)

BASE <- BASE %>%
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

colunas_adicionais <- setdiff(names(BASE), names(BRUTO))

consistente1 <- BRUTO %>%
  inner_join(BASE %>% select(acao, po, all_of(colunas_adicionais)), by = c("acao", "po"))

consistente2 <- consistente1 %>%
  semi_join(BASE, by = c("uo", "acao", "po"))

nova <- consistente1 %>%
  anti_join(BASE, by = c("uo", "acao", "po")) %>%
  distinct()

areas <- c("Administração e Pessoal Ativo", "Direitos Humanos", "Proteção das Crianças e Adolescentes", "Educação", "Saúde", "Esporte", "Saneamento", "Habitação")


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


library(dplyr)

nova_proteção_das_crianças_e_adolescentes$Pago <- gsub(",", ".", gsub("[^0-9,]", "", nova_proteção_das_crianças_e_adolescentes$Pago))

nova_proteção_das_crianças_e_adolescentes$Pago <- as.numeric(nova_proteção_das_crianças_e_adolescentes$Pago)

soma_pago <- sum(nova_proteção_das_crianças_e_adolescentes$Pago, na.rm = TRUE)

soma_pago
