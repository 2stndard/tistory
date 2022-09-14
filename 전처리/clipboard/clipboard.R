install.packages('clipr')
install.packages('gapminder')
install.packages('psych')
library(tidyverse)
library(readxl)
library(gapminder)
library(psych)

gapminder

write.csv(gapminder, 'gapminder.csv')

clipboard <- read.csv('clipboard', sep = '\t')

write.csv(gapminder, 'clipboard-128')

clipboard1 <- read.clipboard()
?readClipboard

clipboard1 <- clipr::read_clip_tbl()

?read.table

gapminder |> write_clip()

df <- read.csv('clipboard', sep = '\t')

?read_clip
