## 긴 형태의 100일간 코로나19 데이터 중에
fig <- df_covid19_100 |>
  ## 국가명으로 그룹화
  group_by(location) |>
  ## 확진자수의 합계를 new_cases로 산출
  summarise(new_cases = sum(new_cases)) |>
  ## X축을 location, Y축과 text를 new_case로 매핑
  plot_ly(x = ~location, y = ~new_cases, text = ~new_cases) |> 
  layout(title = list(text = "지역별 코로나19 확진자수"),
         xaxis = list(title = '지역'),
         yaxis = list(title = '확진자수'), 
         margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'text.json')


## 긴 형태의 100일간 코로나19 데이터 중에
fig <- df_covid19_100 |>
  ## 국가명으로 그룹화
  group_by(location) |>
  ## 확진자수의 합계를 new_cases로 산출
  summarise(new_cases = sum(new_cases)) |>
  ## X축을 location, Y축과 text를 new_case로 매핑
  plot_ly(x = ~location, y = ~new_cases, text = ~new_cases,
          ## textposition을 'inside'로 설정
          textposition = 'inside') |> 
  layout(title = list(text = "지역별 코로나19 확진자수 - textposition = 'inside'"),
         xaxis = list(title = '지역'),
         yaxis = list(title = '확진자수'), 
         margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'insede.json')


fig <- df_covid19_100 |>
  group_by(location) |>
  summarise(new_cases = sum(new_cases)) |>
  plot_ly(x = ~location, y = ~new_cases, text = ~new_cases, 
          ## textposition을 'outside'로 설정
          textposition = 'outside') |> 
  layout(title = list(text = "지역별 코로나19 확진자수 - textposition = 'outside'"),
         xaxis = list(title = '지역'),
         yaxis = list(title = '확진자수'), 
         margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'outside.json')


fig <- df_covid19_100 |>
  group_by(location) |>
  summarise(new_cases = sum(new_cases)) |>
  plot_ly(x = ~location, y = ~new_cases, text = ~new_cases, 
          ## textposition을 'auto'로 설정
          textposition = 'auto') |> 
  layout(title = list(text = "지역별 코로나19 확진자수 - textposition = 'auto'"),
         xaxis = list(title = '지역'),
         yaxis = list(title = '확진자수'), 
         margin = margins) |>
  config(toImageButtonOptions = list(format = 'svg'))

fig <- plotly_json(fig, FALSE)
write(fig,'auto.json')


fig <- df_covid19_100 |>
  group_by(location) |>
  summarise(new_cases = sum(new_cases)) |>
  plot_ly(x = ~location, y = ~new_cases, text = ~new_cases, 
          ## textposition을 'none'으로 설정
          textposition = 'none') |> 
  layout(title = list(text = "지역별 코로나19 확진자수 - textposition = 'none'"),
         xaxis = list(title = '지역'),
         yaxis = list(title = '확진자수'), 
         margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'none.json')



fig <- df_covid19_100 |>
  group_by(location) |>
  summarise(new_cases = sum(new_cases)) |>
  plot_ly(x = ~location, y = ~new_cases, text = ~new_cases, 
          textposition = 'auto',
          ## texttemplate를 설정
          texttemplate = '%{text:,}'
  ) |> 
  ## 제목, 축제목, 여백 설정
  layout(title = list(text = "지역별 코로나19 확진자수 - texttemplate = '%{text:,}'"),
         xaxis = list(title = '지역'),
         yaxis = list(title = '확진자수'), 
         margin = margins) |>
  config(toImageButtonOptions = list(format = 'svg'))


fig <- plotly_json(fig, FALSE)
write(fig,'template.json')
