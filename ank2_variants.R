library(readr)
library(tidyverse)

setwd("~/GitHub/ANK2_variants_ASD")
ank2_varicarta <- read_delim("ank2_varicarta.txt", "\t", escape_double = FALSE, trim_ws = TRUE)

ank2_varicarta %>% mutate(HGVS_split = str_split(HGVS, pattern = ";")) %>% View()

ank2_sfari <- read_delim("ank2_sfari.txt","\t", escape_double = FALSE, trim_ws = TRUE)

aa_code <- read_delim("aa_code.txt", "\t", escape_double = FALSE, trim_ws = TRUE)

colnames(ank2_sfari) <- make.names(colnames(ank2_sfari))

colnames(aa_code) <- make.names(colnames(aa_code))
aa_code <- aa_code[-24,]

ank2_sfari$RESIDUE.CHANGE <- str_replace_all(ank2_sfari$RESIDUE.CHANGE, "Ter", "*")

# code3 <- c("Ala", "Arg", "Asn", "Asp", "Cys", "Glu", "Gln", "Gly", "His", 
#            "Ile", "Leu", "Lys", "Met", "Phe", "Pro", "Ser", "Thr", "Trp", 
#            "Tyr", "Val")
# code1 <- c("A", "R", "N", "D", "C", "E", "Q", "G", "H", "I", "L", "K", 
#            "M", "F", "P", "S", "T", "W", "Y", "V")
# 
# for (i in 1:length(code3))
# {
#   ank2_sfari$RESIDUE.CHANGE <- gsub(code3[i],code1[i],ank2_sfari$RESIDUE.CHANGE,ignore.case=TRUE)
# }

for (i in 1:length(aa_code$Three.letter.code))
{
  ank2_sfari$RESIDUE.CHANGE <- gsub(aa_code$Three.letter.code[i],aa_code$One.letter.code[i],ank2_sfari$RESIDUE.CHANGE,ignore.case=TRUE)
}

# ank2_sfari$RESIDUE.CHANGE <- str_replace(ank2_sfari$RESIDUE.CHANGE, "Pfs*40", "fs")

ank2_sfari$RESIDUE.CHANGE[68] <- "p.S2933fs"

ank2_sfari %>% filter(VARIANT.TYPE != "synonymous_variant", VARIANT.TYPE != "splice_site_variant", RESIDUE.CHANGE != "-") %>% View()
