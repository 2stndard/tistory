df_funnel <- 
  df_covid19_100 |> 
  filter(iso_code == 'KOR') |>
  ## date의 월 단위 열을 yearmonth에 저장
  mutate(date_by_week = lubridate::floor_date(date, "week"), 
         yearweekth =  paste0(lubridate::year(date_by_week), '년 ', 
                              lubridate::week(date_by_week), '주')) |> 
  ## iso_code, yearmonth로 그룹화
  group_by(iso_code, date_by_week, yearweekth) |>
  ## new_cases 합계 산출
  summarise(new_cases = sum(new_cases))


fig <- df_funnel |>
  plot_ly() |>
  add_trace(type = 'funnel', x = ~new_cases, y = ~date_by_week, 
            text = ~new_cases, texttemplate = '%{text:,.0f}') |>
  layout(title = '우리나라 주별 확진자수', 
         yaxis = list(title = '', 
                      tickvals = ~date_by_week, 
                      ticktext = ~yearweekth), 
         margin = margins) |>
  config(toImageButtonOptions = list(format = 'svg'))


fig <- plotly_json(fig, FALSE)
write(fig,'funnel1.json')


df_funnel_Asia <- 
  df_covid19_100 |> 
  filter(location == '아시아') |>
  ## date의 월 단위 열을 yearmonth에 저장
  mutate(date_by_week = lubridate::floor_date(date, "week"), 
         yearweekth =  paste0(lubridate::year(date_by_week), '년 ', 
                              lubridate::week(date_by_week), '주')) |> 
  ## iso_code, yearmonth로 그룹화
  group_by(iso_code, date_by_week, yearweekth) |>
  ## new_cases 합계 산출
  summarise(new_cases = sum(new_cases))

df_funnel_Europe <- 
  df_covid19_100 |> 
  filter(location == '유럽') |>
  ## date의 월 단위 열을 yearmonth에 저장
  mutate(date_by_week = lubridate::floor_date(date, "week"), 
         yearweekth =  paste0(lubridate::year(date_by_week), '년 ', 
                              lubridate::week(date_by_week), '주')) |> 
  ## iso_code, yearmonth로 그룹화
  group_by(iso_code, date_by_week, yearweekth) |>
  ## new_cases 합계 산출
  summarise(new_cases = sum(new_cases))

fig <- df_funnel_Asia |> 
  plot_ly() |>
  add_trace(type = 'funnel', name = '아시아', 
            x = ~new_cases, y = ~date_by_week, 
            text = ~new_cases, texttemplate = '%{text:,.0f}') |>
  add_trace(data = df_funnel_Europe,type = 'funnel', name = '유럽',
            x = ~new_cases, y = ~date_by_week, 
            text = ~new_cases, texttemplate = '%{text:,.0f}') |>
  layout(title = '아시아와 유럽의 주별 확진자수', 
         yaxis = list(title = '', 
                      tickvals = ~date_by_week, 
                      ticktext = ~yearweekth), 
         margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'funnel2.json')
