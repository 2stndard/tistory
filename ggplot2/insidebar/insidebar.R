theme_set( theme_bw() +
             theme(text = element_text(size = 10))
)

df_univ <- read_xlsx('D:/R/data/2021년 고등 학교별 학과별 입학정원 입학 지원 재적 재학 휴학 유학생 졸업 교원_220603y.xlsx', 
          sheet= '학교별 학과별 주요 현황', 
          skip = 13, col_names = T) 

df_univ$대계열 <- fct_relevel(df_univ$대계열, '인문계열', '사회계열', '교육계열', '자연계열', '공학계열', '의약계열', '예체능계열')


quota_sum <- df_univ |> 
  filter(학제 == '대학교') |> 
  group_by(대계열) |>
  summarise(입학정원 = sum(입학정원)) |>
  drop_na()


quota_central <- df_univ |> 
  filter(학제 == '대학교', 시도 %in% c('서울', '인천', '경기')) |> 
  group_by(대계열) |>
  summarise(입학정원 = sum(입학정원)) |>
  drop_na()


quota_central$rate <- quota_central$입학정원 / quota_sum$입학정원



quota_sum |>
  ggplot() +
  geom_col(aes(x = 대계열, y = 입학정원, fill = '전체'), width = 0.85) + 
  geom_text(aes(x = 대계열, y = 입학정원, label = scales::comma(입학정원)), color = 'black', vjust = -0.5) +
  geom_col(data = quota_central, aes(x = 대계열, y = 입학정원, fill = '수도권'), width = 0.5) +
  geom_text(data = quota_central, aes(x = 대계열, y = 입학정원, 
                                      label = paste0(scales::comma(입학정원), '\n', scales::percent(rate))), 
            color = 'white', vjust = -0.5, lineheight = 0.8) +
  scale_fill_manual(name = '', values = c('전체' = '#b40059', '수도권' = '#da80ac')) +
  theme_bw()


quota_sum_all <- df_univ |> 
  group_by(학위과정, 대계열) |>
  summarise(입학자 = sum(입학자_전체_계)) |>
  bind_rows(df_univ |> group_by(대계열) |> summarise(입학자 = sum(입학자_전체_계)) |> 
              mutate(학위과정 = '전체', .before = '대계열')) |>
  drop_na()

quota_central_all <- df_univ |>
  filter(시도 %in% c('서울', '인천', '경기')) |>
  group_by(학위과정, 대계열) |>
  summarise(입학자 = sum(입학자_전체_계)) |>
  bind_rows(df_univ |> group_by(대계열) |> summarise(입학자 = sum(입학자_전체_계)) |> 
              mutate(학위과정 = '전체', .before = '대계열')) |>
  drop_na()

quota_central_all$rate <- quota_central_all$입학자 / quota_sum_all$입학자

quota_sum_all |>
  ggplot(aes(x = 대계열, y = 입학자)) +
  geom_col(aes(fill = '전체'), width = 0.85) + 
  geom_text(aes(label = scales::comma(입학자)), color = 'black', vjust = -0.5) +
  geom_col(data = quota_central_all, aes(fill = '수도권'), width = 0.5) +
  geom_text(data = quota_central_all, aes(label = paste0(scales::comma(입학자), '\n', scales::percent(rate, scale= 0.1))), 
            color = 'white', vjust = -0.5, lineheight = 0.8) +
  scale_fill_manual(name = '', values = c('전체' = '#b40059', '수도권' = '#da80ac')) +
  facet_wrap(~학위과정) + 
  theme_bw()

