library(openxlsx)
library(knitr)
library(kableExtra)
library(tidyverse)
library(gtExtras)
library(gt)
##install.packages("svglite")
getwd()
setwd('./kable')

df <-read.xlsx(xlsxFile = './gt/21년 고등 학과별 입학정원 입학 지원 재적 재학 휴학 외국인유학생 졸업 교원_211119.xlsx', sheet = '학과별 주요 현황',  startRow = 13, na.string = '-', colNames = T)
remotes::install_github("jthomasmock/gtExtras", force = T)

##df <- read_excel('./trans/21년 고등 학과별 입학정원 입학 지원 재적 재학 휴학 외국인유학생 졸업 교원_211119.xlsx', skip = 12, na = '-', sheet = '학과별 주요 현황', col_names = T, col_types = c(rep('text', 8), rep('numeric', 56)))

df$학위과정 <- fct_relevel(df$학위과정, '전문대학과정', '대학과정', '대학원과정')

df.extragt <- df |>
  group_by(학위과정, 대계열) |>
  filter(sum(학과수_전체) > 100) |>
  summarise_at(vars(학과수_전체, 지원자_전체_계, 입학자_전체_계, 재적생_전체_계), funs(sum, mean)) |>
  ungroup() |>
  group_by(학위과정) |>
  mutate(rate = round(학과수_전체_sum/sum(학과수_전체_sum)*100, 2)) |>
  ungroup() |>
  group_by(대계열) |>
  mutate(lists = list(재적생_전체_계_sum)) |>
  ungroup()

#  filter(학과수_전체_sum > 100) |>
  arrange(학제)


gtextras.table <- df.extragt |> 
#  select(1, 2, 4, 11) |>
  gt(rowname_col = '대계열', groupname_col = '학위과정') |>
  tab_header(title = '고등교육기관 계열별 데이터', subtitle = '2021년 전체 고등교육기관 대상') |> 
  fmt_number(columns = 3:6, decimals = 0, use_seps = TRUE) |>
  fmt_number(columns = 7:10, decimals = 1, use_seps = TRUE) |> 
  tab_spanner(columns = 3:6, label = '합계') |>
  tab_spanner(columns = 7:10, label = '평균') |> 
  cols_label(대계열 = '대계열', 
               학과수_전체_sum = '학과수', 
               지원자_전체_계_sum = '지원자',
               입학자_전체_계_sum = '입학자', 
               재적생_전체_계_sum = '재적생', 
               학과수_전체_mean = '학과수', 
               지원자_전체_계_mean = '지원자',
               입학자_전체_계_mean = '입학자', 
               재적생_전체_계_mean = '재적생'
  ) |>  
  summary_rows(
    groups = T,
    columns = 3:6,
    fns = list(
      합계 = ~sum(.)
    ),
    formatter = fmt_number, 
    decimals = 0,
    use_seps = TRUE
  ) |>
  summary_rows(
    groups = T,
    columns = 7:10,
    fns = list(
      합계 = ~sum(.)
    ),
    formatter = fmt_number, 
    decimals = 1,
    use_seps = TRUE
  )  |>
  grand_summary_rows(
    columns = 3:6,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)), 
    decimals = 0,
    use_seps = TRUE
  ) |>
  grand_summary_rows(
    columns = 7:10,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)), 
    decimals = 1,
    use_seps = TRUE
  ) |>
  cols_hide(column = 7)

setwd('./gtextras')

gtextras.table |>
  gt_theme_excel() |>
  gtsave('excel.png')



gtextras.table |>
  gt_theme_espn() |>
  gt_duplicate_column(재적생_전체_계_sum, dupe_name = '재적생_막대그래프') |>
  gt_plt_bar(column = '재적생_막대그래프', keep_column = FALSE, width = 30)
  


gtextras.table |>
  gt_theme_espn() |>
  gt_duplicate_column(재적생_전체_계_sum, dupe_name = '재적생_막대그래프') |>
  gt_plt_bar(column = '재적생_막대그래프', keep_column = FALSE, width = 30) |>
  gt_duplicate_column(재적생_전체_계_sum, dupe_name = '재적생_컬러박스') |>
  gt_color_box(columns = '재적생_컬러박스', domain = c(min(df.extragt$재적생_전체_계_sum), max(df.extragt$재적생_전체_계_sum)), palette = "ggsci::blue_material", width = 100) 




gtextras.table |>
  gt_theme_espn() |>
  gt_duplicate_column(재적생_전체_계_sum, dupe_name = '재적생_막대그래프') |>
  gt_plt_bar(column = '재적생_막대그래프', keep_column = FALSE, width = 30) |>
  gt_duplicate_column(재적생_전체_계_sum, dupe_name = '재적생_컬러박스') |>
  gt_color_box(columns = '재적생_컬러박스', domain = c(min(df.extragt$재적생_전체_계_sum), max(df.extragt$재적생_전체_계_sum)), palette = "ggsci::blue_material", width = 100) |>
  gt_duplicate_column(rate, dupe_name = '재적생비율_pct') |>
  gt_plt_bar_pct(column = '재적생비율_pct', scale = TRUE)





gtextras.table |>
  gt_theme_espn() |>
  gt_duplicate_column(재적생_전체_계_sum, dupe_name = '재적생_막대그래프') |>
  gt_plt_bar(column = '재적생_막대그래프', keep_column = FALSE, width = 30) |>
  gt_duplicate_column(재적생_전체_계_sum, dupe_name = '재적생_컬러박스') |>
  gt_color_box(columns = '재적생_컬러박스', domain = c(min(df.extragt$재적생_전체_계_sum), max(df.extragt$재적생_전체_계_sum)), palette = "ggsci::blue_material", width = 100) |>
  gt_duplicate_column(rate, dupe_name = '재적생비율_pct') |>
  gt_plt_bar_pct(column = '재적생비율_pct', scale = TRUE) |>
  gt_plt_percentile(column = rate, scale = TRUE) |>
  cols_label(rate = '재적생 비율')
  


gtextras.table |>
  gt_theme_espn() |>
  gt_duplicate_column(재적생_전체_계_sum, dupe_name = '재적생_막대그래프') |>
  gt_plt_bar(column = '재적생_막대그래프', keep_column = FALSE, width = 30) |>
  gt_duplicate_column(재적생_전체_계_sum, dupe_name = '재적생_컬러박스') |>
  gt_color_box(columns = '재적생_컬러박스', domain = c(min(df.extragt$재적생_전체_계_sum), max(df.extragt$재적생_전체_계_sum)), palette = "ggsci::blue_material", width = 100) |>
  gt_duplicate_column(rate, dupe_name = '재적생비율_pct') |>
  gt_plt_bar_pct(column = '재적생비율_pct', scale = TRUE) |>
  gt_plt_percentile(column = rate, scale = TRUE) |>
  cols_label(rate = '재적생 비율') |>
  gt_plt_bar_stack(column = lists, palette = c('red', 'darkgreen', 'darkblue'), labels = c('전문대학과정', '대학과정', '대학원과정')) |>
  cols_hide(column = 3:10)
