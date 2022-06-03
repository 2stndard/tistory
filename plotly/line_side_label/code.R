total_deaths_5_nations_by_day <- df_covid19 |> 
  filter((iso_code %in% c('KOR', 'USA', 'JPN', 'GBR', 'FRA'))) |>
  filter(!is.na(total_deaths_per_million))

fig <- total_deaths_5_nations_by_day |>
  ## plotly 객체 생성
  plot_ly() |>
  add_trace(type = 'scatter', mode = 'lines', 
            x = ~date, y = ~total_deaths_per_million , linetype = ~location, connectgaps = T) |>
  layout(title = '코로나 19 사망자수 추세', 
         xaxis = list(title = ''), 
         yaxis = list(title = '10만명당 사망자수 누계'), 
         margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'side.json')



fig <- total_deaths_5_nations_by_day |>
  ## plotly 객체 생성
  plot_ly() |>
  add_trace(type = 'scatter', mode = 'lines+text', 
            x = ~date, y = ~total_deaths_per_million , linetype = ~location, connectgaps = T) |>
  add_annotations(text = '프랑스', 
                  ## 프랑스 trace의 마지막 위치에 주석 추가
                  x = total_deaths_5_nations_by_day |> filter(location == 'France', date == max(date)) |>
                    select(date) |> pull(), 
                  y = total_deaths_5_nations_by_day |> filter(location == 'France', date == max(date)) |>
                    select(total_deaths_per_million) |> pull(),
                  xanchor = 'left', showarrow = FALSE
  ) |>
  add_annotations(text = '일본', 
                  ## 일본 trace의 마지막 위치에 주석 추가
                  x = total_deaths_5_nations_by_day |> filter(location == 'Japan', date == max(date)) |>
                    select(date) |> pull(), 
                  y = total_deaths_5_nations_by_day |> filter(location == 'Japan', date == max(date)) |>
                    select(total_deaths_per_million) |> pull(),
                  xanchor = 'left', yanchor = 'top', showarrow = FALSE
  ) |>
  add_annotations(text = '영국', 
                  ## 영국 trace의 마지막 위치에 주석 추가
                  x = total_deaths_5_nations_by_day |> filter(location == 'United Kingdom', date == max(date)) |>
                    select(date) |> pull(), 
                  y = total_deaths_5_nations_by_day |> filter(location == 'United Kingdom', date == max(date)) |>
                    select(total_deaths_per_million) |> pull(),
                  xanchor = 'left', showarrow = FALSE
  ) |>
  add_annotations(text = '미국', 
                  ## 미국 trace의 마지막 위치에 주석 추가
                  x = total_deaths_5_nations_by_day |> filter(location == 'United States', date == max(date)) |>
                    select(date) |> pull(), 
                  y = total_deaths_5_nations_by_day |> filter(location == 'United States', date == max(date)) |>
                    select(total_deaths_per_million) |> pull(),
                  xanchor = 'left', showarrow = FALSE
  ) |>
  add_annotations(text = '한국', 
                  ## 한국 trace의 마지막 위치에 주석 추가
                  x = total_deaths_5_nations_by_day |> filter(location == 'South Korea', date == max(date)) |>
                    select(date) |> pull(), 
                  y = total_deaths_5_nations_by_day |> filter(location == 'South Korea', date == max(date)) |>
                    select(total_deaths_per_million) |> pull(),
                  xanchor = 'left', yanchor = 'bottom', showarrow = FALSE
  ) |>
  layout(title = '코로나 19 사망자수 추세', 
         xaxis = list(title = ''), 
         yaxis = list(title = '10만명당 사망자수 누계'), 
         margin = margins,
         showlegend = FALSE) |>
  config(toImageButtonOptions = list(format = 'svg'))


fig <- plotly_json(fig, FALSE)
write(fig,'side1.json')
