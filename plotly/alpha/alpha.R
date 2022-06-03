df_취업률_2000 |> 
  plot_ly() |>
  add_trace(type = 'scatter', type = 'markers', x = ~졸업자수, y = ~취업자수) |>
  layout(title = list(text = '기본산점도 - plotly'), 
         xaxis = list(title = '졸업자수'), 
         yaxis = list(title = '취업자수'), 
         margin = margins) |>
  config(toImageButtonOptions = list(format = 'svg')) -> fig

fig <- plotly_json(fig, FALSE)
write(fig,'scatter.json')


df_취업률_2000 |> 
  plot_ly() |>
  add_markers(x = ~졸업자수, y = ~취업자수, alpha = 1) |> 
  layout(title = '산점도(alpha = 1)',
         margin = margins
  ) -> fig

fig <- plotly_json(fig, FALSE)
write(fig,'alpha1.json')

df_취업률_2000 |> 
  plot_ly() |>
  add_markers(x = ~졸업자수, y = ~취업자수, alpha = 0.75) |> 
  layout(title = '산점도(alpha = 0.75)',
         margin = margins
  ) -> fig

fig <- plotly_json(fig, FALSE)
write(fig,'alhpa75.json')

df_취업률_2000 |> 
  plot_ly() |>
  add_markers(x = ~졸업자수, y = ~취업자수, alpha = 0.5) |> 
  layout(title = '산점도(alpha = 0.5)',
         margin = margins
  ) -> fig

fig <- plotly_json(fig, FALSE)
write(fig,'alpha5.json')

df_취업률_2000 |> 
  plot_ly() |>
  add_markers(x = ~졸업자수, y = ~취업자수, alpha = 0.25) |> 
  layout(title = '산점도(alpha = 0.25)',
         margin = margins
  ) -> fig

fig <- plotly_json(fig, FALSE)
write(fig,'alpha25.json')



df_취업률_2000 |> 
  plot_ly() |>
  add_markers(x = ~졸업자수, y = ~취업자수, opacity = 1) |> 
  layout(title = '산점도(opacity = 1)',
         xaxis = list(title = '졸업자수'), 
         xaxis = list(title = '취업자수'), 
         margin = margins
  ) -> fig

fig <- plotly_json(fig, FALSE)
write(fig,'opacity1.json')


df_취업률_2000 |> 
  plot_ly() |>
  add_markers(x = ~졸업자수, y = ~취업자수, opacity = 0.75) |> 
  layout(title = '산점도(opacity = 0.75)',
         xaxis = list(title = '졸업자수'), 
         xaxis = list(title = '취업자수'), 
         margin = margins
  ) -> fig

fig <- plotly_json(fig, FALSE)
write(fig,'opacity75.json')


df_취업률_2000 |> 
  plot_ly() |>
  add_markers(x = ~졸업자수, y = ~취업자수, opacity = 0.5) |> 
  layout(title = '산점도(opacity = 0.5)',
         xaxis = list(title = '졸업자수'), 
         xaxis = list(title = '취업자수'), 
         margin = margins
  ) -> fig

fig <- plotly_json(fig, FALSE)
write(fig,'opacity5.json')


df_취업률_2000 |> 
  plot_ly() |>
  add_markers(x = ~졸업자수, y = ~취업자수, opacity = 0.25) |> 
  layout(title = '산점도(opacity = 0.25)',
         xaxis = list(title = '졸업자수'), 
         xaxis = list(title = '취업자수'), 
         margin = margins
  ) -> fig

fig <- plotly_json(fig, FALSE)
write(fig,'opacity25.json')

