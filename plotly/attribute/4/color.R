fig <- df_취업률_2000 |> 
  ## X, Y축의 매핑과 color를 대계열로 매핑
  plot_ly(x = ~졸업자수, y = ~취업자수, color = ~대계열) |>
  layout(title = '졸업자 대비 취업자수', margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'color.json')


fig <- df_취업률_2000 |> 
  ## plot_ly()에 color를 색 이름 설정
  plot_ly(x = ~졸업자수, y = ~취업자수, color = 'darkblue') |>
  layout(title = '졸업자 대비 취업자수', margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'color1.json')


fig <- df_취업률_2000 |> 
  ## plot_ly()에 color를 I()사용하여 색 이름 설정
  plot_ly(x = ~졸업자수, y = ~취업자수, color = I('darkblue')) |>
  layout(title = '졸업자 대비 취업자수', margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'color_I.json')


fig <- df_취업률_2000 |> 
  plot_ly(x = ~졸업자수, y = ~취업자수,
          ## color를 대계열로 매핑하고 colors를 'Accent' 팔레트로 설정
          color = ~대계열, colors = 'Blues') |>
  layout(title = '졸업자 대비 취업자수', margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'RColorbrewer.json')


color_vector <- c('red', 'blue', 'green', 'yellow', 'purple', 'black', 'pink')

fig <- df_취업률_2000 |> 
  plot_ly(x = ~졸업자수, y = ~취업자수, 
          ## color를 대계열로 매핑하고 colors를 색 이름 벡터로 설정
          color = ~대계열, colors = color_vector) |>
  layout(title = '졸업자 대비 취업자수', margin = margins)


fig <- plotly_json(fig, FALSE)
write(fig,'colorvector.json')

fig <- df_취업률_2000 |> 
  plot_ly(x = ~졸업자수, y = ~취업자수, 
          ## color를 대계열로 매핑하고 colors를 colorRamp()로 설정
          color = ~대계열, colors = colorRamp(c('red', 'yellow', 'blue'))) |>
  layout(title = '졸업자 대비 취업자수', margin = margins) |>
  config(toImageButtonOptions = list(format = 'svg'))


fig <- plotly_json(fig, FALSE)
write(fig,'colorRamp.json')
