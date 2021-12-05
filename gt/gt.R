library(readxl)
library(gt)
library(tidyverse)

df <- read_excel('./trans/21년 고등 학과별 입학정원 입학 지원 재적 재학 휴학 외국인유학생 졸업 교원_211119.xlsx', skip = 12, na = '-', sheet = '학과별 주요 현황', col_names = T, col_types = c(rep('text', 8), rep('numeric', 56)))

df$학제 <- fct_relevel(df$학제, '대학교', '교육대학', '산업대학', '기술대학', '방송통신대학', '사내대학(대학)', '원격대학(대학)', '사이버대학(대학)', '각종대학(대학)', '전문대학(2년제)', '전문대학(3년제)', '전문대학(4년제)', '기능대학', '원격대학(전문)', '사이버대학(전문)', '사내대학(전문)', '전공대학',  '일반대학원', '특수대학원', '전문대학원')

df.gt <- df |>
  group_by(학제, 학위과정) |>
  summarise_at(vars(학과수_전체, 지원자_전체_계, 입학자_전체_계, 재적생_전체_계, 재학생_전체_계,  휴학생_전체_계, 외국인유학생_총계_계, 졸업자_전체, 전임교원_계, 비전임교원_계, 시간강사_계), 
               funs(sum, mean)
               ) |>
  ungroup() |>
  arrange(학제)




## gt를 이용해 테이블 보기

df.gt |> 
  gt()

## 행이름 설정
df.gt |>
  arrange(학제) |>
  gt(rowname_col = '학제')

## 그룹 설정
df.gt |>
  arrange(학제) |>
  gt(rowname_col = '학제', 
     groupname_col = '학위과정')


## 표 제목, 부제목 설정

gt.table1 <- df.gt |>
  arrange(학제) |>
  gt(rowname_col = '학제', 
     groupname_col = '학위과정') |>
  tab_header(title = '고등교육기관 데이터', subtitle = '2021년 전체 고등교육기관 대상')

gt.table1

# gt.table.style <- function(data) {
#   gt(data) |>
#     tab_header(title = '고등교육기관 데이터', subtitle = '2021년 전체 고등교육기관 대상')
# }

# df.gt |> gt.table.style()

## 각 셀의 포맷 설정
gt.table2 <- gt.table1 |>
  fmt_number(columns = 3:13, decimals = 0, use_seps = TRUE) |>
  fmt_number(columns = 14:24, decimals = 1, use_seps = TRUE)
  
gt.table2

## 헤더 설정
gt.table3 <- gt.table2 |>
  tab_spanner(columns = 3:14, label = '합계') |>
  tab_spanner(columns = 14:24, label = '평균')

gt.table3
  
## 컬럼명 설정  
gt.table4 <- gt.table3 |>
  cols_label(학제 = '학교종류', 
               학과수_전체_sum = '학과수', 
               지원자_전체_계_sum = '지원자',
               입학자_전체_계_sum = '입학자', 
               재적생_전체_계_sum = '재적생', 
               재학생_전체_계_sum = '재학생',
               휴학생_전체_계_sum = '휴학생', 
               외국인유학생_총계_계_sum = '외국인학생', 
               졸업자_전체_sum = '졸업자', 
               전임교원_계_sum = '전임교원', 
               비전임교원_계_sum = '비전임교원', 
               시간강사_계_sum = '시간강사', 
               학과수_전체_mean = '학과수', 
               지원자_전체_계_mean = '지원자',
               입학자_전체_계_mean = '입학자', 
               재적생_전체_계_mean = '재적생', 
               재학생_전체_계_mean = '재학생',
               휴학생_전체_계_mean = '휴학생', 
               외국인유학생_총계_계_mean = '외국인학생', 
               졸업자_전체_mean = '졸업자', 
               전임교원_계_mean = '전임교원', 
               비전임교원_계_mean = '비전임교원', 
               시간강사_계_mean = '시간강사'
  )

gt.table4

## row 그룹 순서 설정
gt.table5 <-gt.table4 |>
  row_group_order(
    groups = c('전문대학과정', '대학과정', '대학원과정')
  )

gt.table5

## 그룹 서머리 열 삽입
gt.table6 <- gt.table5 |>
  summary_rows(
    groups = T,
    columns = 3:14,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)),
    formatter = fmt_number, 
    decimals = 0,
    use_seps = TRUE
  ) |>
  summary_rows(
    groups = T,
    columns = 15:24,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)),
    formatter = fmt_number, 
    decimals = 1,
    use_seps = TRUE
  )


## 전체 서머리 열
gt.table7 <- gt.table6 |>
  grand_summary_rows(
    columns = 3:14,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)), 
    decimals = 0,
    use_seps = TRUE
  ) |>
  grand_summary_rows(
    columns = 15:24,
    fns = list(
      합계 = ~sum(.),
      평균값 = ~mean(.)), 
    decimals = 1,
    use_seps = TRUE
  )


## 표 꾸미기
gt.table8 <- gt.table7 |>
  tab_options(
    summary_row.background.color = "lightblue",
    grand_summary_row.background.color = "lightgreen", 
    stub.border.style = 'solid', 
    stub.background.color = '#edf8fb',
    row_group.background.color = '#ffffcc', 
    heading.background.color = '#c6dbef', 
    table_body.hlines.style = 'dashed', 
    table_body.vlines.color = 'blue', 
    table_body.vlines.style = 'dashed'
  )

## 표 꾸미기
gt.table8 |>
  data_color(
    columns = 15,
    colors = scales::col_numeric(
      palette = paletteer::paletteer_d(
        palette = "nord::snowstorm"
      ) %>% as.character(),
      domain = NULL
    )
  )

