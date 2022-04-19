library(dlstats)

#x <- cran_stats(c("ggplot2", "plotly", "rbokeh", "highcharter"))
x1 <- cran_stats(c("ggplot2", "plotly", "rbokeh", "highcharter", 'lattice', 'esquisse', 'leaflet', 'dygraphs', 'ggvis', 'colourpicker', 'patchwork', 'ggforce'))

fig <- x1 |> plot_ly() |> filter(package != 'ggplot2') |> 
  add_lines(x = ~end, y = ~downloads, color = ~package, colors = ~ifelse(package == 'plotly', 'darkblue', 'gray')) |>
  config(toImageButtonOptions = list(format = 'svg'))


plotly::export(fig, file = 'download.svg')

fig <- plotly_json(fig, FALSE)
write(fig,'ggplotly.json')


ggplotly <- covid19_df_100 |> 
  ## x축이 date, y축이 new_cases, color가 location으로 매핑된 ggplot 객체 생성
  ggplot(aes(x = date, y = new_cases, color = location )) +
  ## group과 linetype이 location으로 매핑된 geom_line 레이어 생성
  geom_line(aes(group = location, linetype = location)) +
  ## x축 스케일을 날짜형이고 1개월 단위로 눈금 설정
  scale_x_date(breaks = '1 months') +
  ## y축의 라벨에 천 단위 구분자 설정
  scale_y_continuous(labels = scales::comma) + 
  ## x축, y축, linetype, color 이름 설정
  labs(x = '날짜', y = '확진자수', linetype = '지역', color = '지역', title = '코로나19 신규확진자수')

## ggplot객체를 plotly 객체로 변환
fig <- ggplotly(ggplotly) |>
  config(toImageButtonOptions = list(format = 'svg'))
