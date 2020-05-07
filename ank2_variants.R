library(readr)
library(tidyverse)

setwd("~/GitHub/ANK2_variants_ASD")
ank2_varicarta <- read_delim("ank2_varicarta.txt", "\t", escape_double = FALSE, trim_ws = TRUE)

ank2_varicarta %>% mutate(HGVS_split = str_split(HGVS, pattern = ";")) %>% View()

ank2_sfari <- read_delim("ank2_sfari.txt","\t", escape_double = FALSE, trim_ws = TRUE)

aa_code <- read_delim("aa_code.txt", "\t", escape_double = FALSE, trim_ws = TRUE)
