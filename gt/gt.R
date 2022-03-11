library(readxl)
library(gt)
library(tidyverse)
getwd()
setwd('./gt/')
df <- read.xlsx(xlsxFile = './21년 고등 학과별 입학정원 입학 지원 재적 재학 휴학 외국인유학생 졸업 교원_211119.xlsx', sheet = '학과별 주요 현황',  startRow = 13, na.string = '-', colNames = T)


df$학제 <- fct_relevel(df$학제, '대학교', '교육대학', '산업대학', '기술대학', '방송통신대학', '사내대학(대학)', '원격대학(대학)', '사이버대학(대학)', '각종대학(대학)', '전문대학(2년제)', '전문대학(3년제)', '전문대학(4년제)', '기능대학', '원격대학(전문)', '사이버대학(전문)', '사내대학(전문)', '전공대학',  '일반대학원', '특수대학원', '전문대학원')

df.gt <- df |>
  group_by(학제, 학위과정) |>
  summarise_at(vars(학과수_전체, 지원자_전체_계, 입학자_전체_계, 재적생_전체_계, 재학생_전체_계, 휴학생_전체_계), funs(sum, mean)) |>
  ungroup() |>
  filter(학과수_전체_sum > 100) |>
  arrange(학제)

class(df |>
  group_by(학제, 학위과정))

gt.table <- df.gt |> 
  gt(rowname_col = '학제', 
     groupname_col = '학위과정') |> 
  tab_header(title = '고등교육기관 데이터', subtitle = '2021년 전체 고등교육기관 대상') |> 
  fmt_number(columns = 3:8, decimals = 0, use_seps = TRUE) |>
  fmt_number(columns = 9:14, decimals = 1, use_seps = TRUE) |> 
  tab_spanner(columns = 3:8, label = '합계') |>
  tab_spanner(columns = 9:14, label = '평균') |> 
  cols_label(학제 = '학교종류', 
               학과수_전체_sum = '학과수', 
               지원자_전체_계_sum = '지원자',
               입학자_전체_계_sum = '입학자', 
               재적생_전체_계_sum = '재적생', 
               재학생_전체_계_sum = '재학생',
               휴학생_전체_계_sum = '휴학생', 
               학과수_전체_mean = '학과수', 
               지원자_전체_계_mean = '지원자',
               입학자_전체_계_mean = '입학자', 
               재적생_전체_계_mean = '재적생', 
               재학생_전체_계_mean = '재학생',
               휴학생_전체_계_mean = '휴학생'
  ) |> 
  row_group_order(
    groups = c('전문대학과정', '대학과정', '대학원과정')
  ) |> 
  summary_rows(
    groups = T,
    columns = 3:8,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)),
    formatter = fmt_number, 
    decimals = 0,
    use_seps = TRUE
  ) |>
  summary_rows(
    groups = T,
    columns = 9:14,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)),
    formatter = fmt_number, 
    decimals = 1,
    use_seps = TRUE
  ) |>
  grand_summary_rows(
    columns = 3:8,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)), 
    decimals = 0,
    use_seps = TRUE
  ) |>
  grand_summary_rows(
    columns = 9:14,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)), 
    decimals = 1,
    use_seps = TRUE
  ) |>
  tab_options(
    ## 행 그룹 요약 행의 배경색 설정
    summary_row.background.color = "lightblue",
    ## 전체 요약 행의 배경색 설정
    grand_summary_row.background.color = "lightgreen",
    ## 구분(Stub) 행의 헤더 외곽선 스타일 설정
    stub.border.style = 'solid', 
    ## 구분(Stub) 행의 배경색 설정
    stub.background.color = '#edf8fb',
    ## 행 그룹 이름 표현 셀 배경색 설정
    row_group.background.color = '#ffffcc',
    ## 열 제목(Heading) 배경색 설정
    heading.background.color = '#c6dbef',
    ## 표 몸체(Body) 수평선 스타일 설정
    table_body.hlines.style = 'dashed', 
    ## 표 몸체(Body) 수직선 색깔 설정 
    table_body.vlines.color = 'blue',
    ## 표 몸체(BOdy) 수직선 스타일 설정
    table_body.vlines.style = 'dashed'
  ) |>
  tab_style(
    locations = cells_title(groups = "title"),
    style     = list(
      cell_text(weight = "bold", size = px(20))
    )
  )  |>
  tab_style(
    locations = cells_column_spanners(spanners = "합계"),
    style     = list(
      cell_text(weight = "bold", size = px(12), color = 'blue')
    )
  ) %>% 
  tab_style(
    locations = cells_column_spanners(spanners = "평균"),
    style     = list(
      cell_text(weight = "bold",color = "red", size = px(12))
    )
  )  |> 
  tab_style(
    locations = cells_column_labels(columns = everything()),
    style     = list(
      cell_text(color = "white"), 
      cell_fill(color = 'grey50')
    )
  )  |> 
  tab_style(
    locations = cells_row_groups(groups = everything()),
    style     = list(
      cell_text(color = "grey25", size = 24, align = 'center'), 
      cell_fill(color = 'grey75')
    )
  )  |> 
  tab_style(
    locations = cells_stub(rows = everything()),
    style     = list(
      cell_text(align = 'center', weight = 'bold')
    )
  ) |>
  tab_style(
    locations = cells_stub_summary(rows = everything()),
    style     = list(
      cell_text(align = 'center', weight = 'bold')
    )
  ) |>
  tab_style(
    locations = cells_stub_grand_summary(rows = everything()),
    style     = list(
      cell_text(align = 'center', weight = 'bold')
    )
  )  |>
  tab_style(
    locations = cells_body(rows = everything(), columns = c(9:14)),
    style     = list(
      cell_borders(color = 'red', style = 'dotted')
    )
  ) |>
  tab_style(
    locations = cells_body(rows = everything(), columns = c(3:8)),
    style     = list(
      cell_borders(color = 'blue', style = 'dotted')
    )
  ) |> 
  tab_style(
    style     = list(
      cell_borders(color = 'blue', style = 'dotted'), 
      cell_text(color = 'blue')
    ), 
    locations = cells_summary(rows = 1, 
                              columns = c(3:8), 
                              group = everything()
    )
  ) |> 
  tab_style(
    style     = list(
      cell_borders(color = 'blue', style = 'dotted'), 
      cell_text(color = 'blue')
    ), 
    locations = cells_summary(rows = 2, 
                              columns = c(3:8), 
                              group = everything()
    )
  ) |> 
  tab_style(
    style     = list(
      cell_borders(color = 'red', style = 'dotted'), 
      cell_text(color = 'red')
    ), 
    locations = cells_summary(rows = 1, 
                              columns = c(9:14), 
                              group = everything()
    )
  ) |> 
  tab_style(
    style     = list(
      cell_borders(color = 'red', style = 'dotted'), 
      cell_text(color = 'red')
    ), 
    locations = cells_summary(rows = 2, 
                              columns = c(9:14), 
                              group = everything()
    )
  ) |> 
  tab_style(
    style     = list(
      cell_text(color = 'white', weight = 'bold'), 
      cell_fill(color = 'blue', alpha = 0.5)
    ), 
    locations = cells_grand_summary(rows = 1, 
                                    columns = c(3:8)
    )
  ) |> 
  tab_style(
    style     = list(
      cell_text(color = 'white', weight = 'bold'), 
      cell_fill(color = 'blue', alpha = 0.5)
    ), 
    locations = cells_grand_summary(rows = 2, 
                                    columns = c(3:8)
    )
  ) |> 
  tab_style(
    style     = list(
      cell_text(color = 'white', weight = 'bold'), 
      cell_fill(color = 'red', alpha = 0.5)
    ), 
    locations = cells_grand_summary(rows = 1, 
                                    columns = c(9:14)
    )
  ) |> 
  tab_style(
    style     = list(
      cell_text(color = 'white', weight = 'bold'), 
      cell_fill(color = 'red', alpha = 0.5)
    ), 
    locations = cells_grand_summary(rows = 2, 
                                    columns = c(9:14)
    )
  ) |>
  tab_options(table.font.size = 10)

install.packages('gtExtras')
remotes::install_github("jthomasmock/gtExtras")

library(gtExtras)

df.gt |> 
  gt(rowname_col = '학제', 
     groupname_col = '학위과정') |> 
  tab_header(title = '고등교육기관 데이터', subtitle = '2021년 전체 고등교육기관 대상') |> 
  fmt_number(columns = 3:8, decimals = 0, use_seps = TRUE) |>
  fmt_number(columns = 9:14, decimals = 1, use_seps = TRUE) |> 
  tab_spanner(columns = 3:8, label = '합계') |>
  tab_spanner(columns = 9:14, label = '평균') |> 
  cols_label(학제 = '학교종류', 
               학과수_전체_sum = '학과수', 
               지원자_전체_계_sum = '지원자',
               입학자_전체_계_sum = '입학자', 
               재적생_전체_계_sum = '재적생', 
               재학생_전체_계_sum = '재학생',
               휴학생_전체_계_sum = '휴학생', 
               학과수_전체_mean = '학과수', 
               지원자_전체_계_mean = '지원자',
               입학자_전체_계_mean = '입학자', 
               재적생_전체_계_mean = '재적생', 
               재학생_전체_계_mean = '재학생',
               휴학생_전체_계_mean = '휴학생'
  ) |> 
  row_group_order(
    groups = c('전문대학과정', '대학과정', '대학원과정')
  ) |> 
  summary_rows(
    groups = T,
    columns = 3:8,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)),
    formatter = fmt_number, 
    decimals = 0,
    use_seps = TRUE
  ) |>
  summary_rows(
    groups = T,
    columns = 9:14,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)),
    formatter = fmt_number, 
    decimals = 1,
    use_seps = TRUE
  ) |>
  grand_summary_rows(
    columns = 3:8,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)), 
    decimals = 0,
    use_seps = TRUE
  ) |>
  grand_summary_rows(
    columns = 9:14,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)), 
    decimals = 1,
    use_seps = TRUE
  ) |>
  gt_sparkline(학과수_전체_sum)


## 표 꾸미기
gt.table |>
  data_color(
    columns = 3,
    colors = scales::col_numeric(
      palette = c(
        "white", "red"),
      domain = c(10, 10000)
    )
  )

gt.table |>
  data_color(
    columns = c(3:8),
    colors = scales::col_numeric(
      palette = paletteer::paletteer_d(
        palette = "ggsci::blue_material"
      ) %>% as.character(),
      domain = NULL
    )
  ) |>
  data_color(
    columns = c(9:14),
    colors = scales::col_numeric(
      palette = paletteer::paletteer_d(
        palette = "ggsci::red_material"
      ) %>% as.character(),
      domain = NULL
    )
  ) |>
  gt_duplicate_column(재적생_전체_계_sum, dupe_name = '재적생 그래프') |>
  gt_plt_bar(column = '재적생 그래프', keep_column = FALSE)


df.gt |>
  group_by(학위과정) |>
  mutate(재적생_rate = 재적생_전체_계_sum/sum(재적생_전체_계_sum)*100) |>
  ungroup() |>
gt(rowname_col = '학제', 
   groupname_col = '학위과정') |> 
  tab_header(title = '고등교육기관 데이터', subtitle = '2021년 전체 고등교육기관 대상') |> 
  fmt_number(columns = 3:8, decimals = 0, use_seps = TRUE) |>
  fmt_number(columns = 9:14, decimals = 1, use_seps = TRUE) |> 
  tab_spanner(columns = 3:8, label = '합계') |>
  tab_spanner(columns = 9:14, label = '평균') |> 
  cols_label(학제 = '학교종류', 
               학과수_전체_sum = '학과수', 
               지원자_전체_계_sum = '지원자',
               입학자_전체_계_sum = '입학자', 
               재적생_전체_계_sum = '재적생', 
               재학생_전체_계_sum = '재학생',
               휴학생_전체_계_sum = '휴학생', 
               학과수_전체_mean = '학과수', 
               지원자_전체_계_mean = '지원자',
               입학자_전체_계_mean = '입학자', 
               재적생_전체_계_mean = '재적생', 
               재학생_전체_계_mean = '재학생',
               휴학생_전체_계_mean = '휴학생'
  ) |> 
  row_group_order(
    groups = c('전문대학과정', '대학과정', '대학원과정')
  ) |> 
  summary_rows(
    groups = T,
    columns = 3:8,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)),
    formatter = fmt_number, 
    decimals = 0,
    use_seps = TRUE
  ) |>
  summary_rows(
    groups = T,
    columns = 9:14,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)),
    formatter = fmt_number, 
    decimals = 1,
    use_seps = TRUE
  ) |>
  grand_summary_rows(
    columns = 3:8,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)), 
    decimals = 0,
    use_seps = TRUE
  ) |>
  grand_summary_rows(
    columns = 9:14,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)), 
    decimals = 1,
    use_seps = TRUE
  ) |>
  tab_options(
    ## 행 그룹 요약 행의 배경색 설정
    summary_row.background.color = "lightblue",
    ## 전체 요약 행의 배경색 설정
    grand_summary_row.background.color = "lightgreen",
    ## 구분(Stub) 행의 헤더 외곽선 스타일 설정
    stub.border.style = 'solid', 
    ## 구분(Stub) 행의 배경색 설정
    stub.background.color = '#edf8fb',
    ## 행 그룹 이름 표현 셀 배경색 설정
    row_group.background.color = '#ffffcc',
    ## 열 제목(Heading) 배경색 설정
    heading.background.color = '#c6dbef',
    ## 표 몸체(Body) 수평선 스타일 설정
    table_body.hlines.style = 'dashed', 
    ## 표 몸체(Body) 수직선 색깔 설정 
    table_body.vlines.color = 'blue',
    ## 표 몸체(BOdy) 수직선 스타일 설정
    table_body.vlines.style = 'dashed'
  ) |>
  tab_style(
    locations = cells_title(groups = "title"),
    style     = list(
      cell_text(weight = "bold", size = px(20))
    )
  )  |>
  tab_style(
    locations = cells_column_spanners(spanners = "합계"),
    style     = list(
      cell_text(weight = "bold", size = px(12), color = 'blue')
    )
  ) %>% 
  tab_style(
    locations = cells_column_spanners(spanners = "평균"),
    style     = list(
      cell_text(weight = "bold",color = "red", size = px(12))
    )
  )  |> 
  tab_style(
    locations = cells_column_labels(columns = everything()),
    style     = list(
      cell_text(color = "white"), 
      cell_fill(color = 'grey50')
    )
  )  |> 
  tab_style(
    locations = cells_row_groups(groups = everything()),
    style     = list(
      cell_text(color = "grey25", size = 24, align = 'center'), 
      cell_fill(color = 'grey75')
    )
  )  |> 
  tab_style(
    locations = cells_stub(rows = everything()),
    style     = list(
      cell_text(align = 'center', weight = 'bold')
    )
  ) |>
  tab_style(
    locations = cells_stub_summary(rows = everything()),
    style     = list(
      cell_text(align = 'center', weight = 'bold')
    )
  ) |>
  tab_style(
    locations = cells_stub_grand_summary(rows = everything()),
    style     = list(
      cell_text(align = 'center', weight = 'bold')
    )
  )  |>
  tab_style(
    locations = cells_body(rows = everything(), columns = c(9:14)),
    style     = list(
      cell_borders(color = 'red', style = 'dotted')
    )
  ) |>
  tab_style(
    locations = cells_body(rows = everything(), columns = c(3:8)),
    style     = list(
      cell_borders(color = 'blue', style = 'dotted')
    )
  ) |> 
  tab_style(
    style     = list(
      cell_borders(color = 'blue', style = 'dotted'), 
      cell_text(color = 'blue')
    ), 
    locations = cells_summary(rows = 1, 
                              columns = c(3:8), 
                              group = everything()
    )
  ) |> 
  tab_style(
    style     = list(
      cell_borders(color = 'blue', style = 'dotted'), 
      cell_text(color = 'blue')
    ), 
    locations = cells_summary(rows = 2, 
                              columns = c(3:8), 
                              group = everything()
    )
  ) |> 
  tab_style(
    style     = list(
      cell_borders(color = 'red', style = 'dotted'), 
      cell_text(color = 'red')
    ), 
    locations = cells_summary(rows = 1, 
                              columns = c(9:14), 
                              group = everything()
    )
  ) |> 
  tab_style(
    style     = list(
      cell_borders(color = 'red', style = 'dotted'), 
      cell_text(color = 'red')
    ), 
    locations = cells_summary(rows = 2, 
                              columns = c(9:14), 
                              group = everything()
    )
  ) |> 
  tab_style(
    style     = list(
      cell_text(color = 'white', weight = 'bold'), 
      cell_fill(color = 'blue', alpha = 0.5)
    ), 
    locations = cells_grand_summary(rows = 1, 
                                    columns = c(3:8)
    )
  ) |> 
  tab_style(
    style     = list(
      cell_text(color = 'white', weight = 'bold'), 
      cell_fill(color = 'blue', alpha = 0.5)
    ), 
    locations = cells_grand_summary(rows = 2, 
                                    columns = c(3:8)
    )
  ) |> 
  tab_style(
    style     = list(
      cell_text(color = 'white', weight = 'bold'), 
      cell_fill(color = 'red', alpha = 0.5)
    ), 
    locations = cells_grand_summary(rows = 1, 
                                    columns = c(9:14)
    )
  ) |> 
  tab_style(
    style     = list(
      cell_text(color = 'white', weight = 'bold'), 
      cell_fill(color = 'red', alpha = 0.5)
    ), 
    locations = cells_grand_summary(rows = 2, 
                                    columns = c(9:14)
    )
  ) |>
  tab_options(table.font.size = 10) -> gtextras.table




df.gt |>
  group_by(학위과정) |>
  mutate(재적생_rate = 재적생_전체_계_sum/sum(재적생_전체_계_sum)*100) |>
  ungroup() |>
  gt()  |>
  gt_merge_stack(col1 = '학제', col2 = '학위과정')
  

gtextras.table |>
  gt_theme_nytimes() |>
  gt_duplicate_column(재적생_전체_계_sum, dupe_name = '재적생_막대그래프') |>
  gt_plt_bar(column = '재적생_막대그래프', keep_column = FALSE, width = 30) |>
  gt_duplicate_column(재적생_전체_계_sum, dupe_name = '재적생_컬러박스') |>
  gt_color_box(columns = '재적생_컬러박스', domain = c(min(df.gt$재적생_전체_계_sum), max(df.gt$재적생_전체_계_sum)), palette = "ggsci::blue_material", width = 100) |>
  gt_plt_percentile(column = 재적생_rate, scale = TRUE) |>
  cols_hide(columns = 9:14) |>
  tab_spanner(columns = 15:17, label = 'gtExtras') |>
  cols_label(재적생_rate = '재적생 비율') |>
  tab_style(
    locations = cells_column_labels(columns = c(15:17)),
    style     = list(
      cell_text(color = "white", align = 'center'), 
      cell_fill(color = 'grey50')
    )
  ) |>
  gt_highlight_rows(rows = row_number(max(df.gt$재적생_전체_계_sum)), font_weight = "bold", fill = 'lightgreen') |>
  gt_merge_stack(col1 = '학제', col2 = '학위과정')


               






gt.style <- list(
  
)
  
  
  
    cols_label(학제 = '학교종류', 
               학과수_전체_sum = '학과수', 
               

|>
  tab_style(
    locations = cells_column_labels(columns = 15),
    style     = list(
      cell_text(color = "white"), 
      cell_fill(color = 'grey50')
    )
  )


  gt_duplicate_column(재적생_전체_계_sum, dupe_name = '재적생_dup') |>
  gt_plt_percentile(column = 재적생_dup, scale = TRUE) 
  
  

df


|>   
  gt_color_box(columns = 학과수_전체_sum, domain = c(0, 13000), palette = "ggsci::blue_material")

  

gtsave('data_color.pdf')



webshot::install_phantomjs()

install.packages('openxlsx')

df <- read_excel('./trans/21년 고등 학과별 입학정원 입학 지원 재적 재학 휴학 외국인유학생 졸업 교원_211119.xlsx', skip = 12, na = '-', sheet = '학과별 주요 현황', col_names = T, col_types = c(rep('text', 8), rep('numeric', 56)))
