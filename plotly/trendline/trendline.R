library(tidyverse)
library(readxl)
library(patchwork)
library(plotly)

## trend line
df_covid19_trend_kor <- 
  df_covid19 |>
  filter(iso_code == 'KOR', !is.na(new_cases)) |>
  filter(date >= max(date) - 200) |>
  mutate(date_int = as.integer(date))

trend_linear <- lm(data = df_covid19_trend_kor, new_cases ~ date_int)

trend_Quadratic <- lm(data = df_covid19_trend_kor, new_cases ~ date_int + I(date_int^2))

trend_Cubic <- lm(data = df_covid19_trend_kor, new_cases ~ date_int + I(date_int^2) + I(date_int^3))


df_covid19_trend_kor |>
  plot_ly() |>
  add_trace(type = 'scatter', mode = 'lines', x = ~date, y = ~new_cases, name = 'Data') |>
  add_trace(type = 'scatter', mode = 'lines', x = ~date, y = fitted(trend_linear), name = 'linear') |>
  add_trace(type = 'scatter', mode = 'lines', x = ~date, y = fitted(trend_Quadratic), name = 'Quadratic') |>
  add_trace(type = 'scatter', mode = 'lines', x = ~date, y = fitted(trend_Cubic), name = 'Cubic')

### loess trend line
trend_linear_loess <- loess(data = df_covid19_trend_kor, new_cases ~ date_int, span = 0.75)
trend_linear_loess_pred = predict(trend_linear_loess, se = TRUE)

df_covid19_trend_kor |>
  plot_ly(type="scatter", mode="lines") |>
  add_trace(x = ~date, y = ~new_cases, name = 'Data') |>
  add_trace(x = ~date, y = fitted(trend_linear_loess), name = 'LOESS') |>
  add_ribbons(x=~date, 
              ymin=(trend_linear_loess_pred$fit - (1.96 * trend_linear_loess_pred$se)), 
              ymax=(trend_linear_loess_pred$fit + (1.96 * trend_linear_loess_pred$se)), 
              name="95% CI", line=list(opacity=0.4, width=0))
  


#######################################


ggplot_trend_emp <- df_취업률_2000 |>
  ggplot(aes(x = 졸업자수, y = 취업자수)) + 
  geom_point() +
  geom_smooth(method = 'loess', aes(color="loess")) +
  geom_smooth(method = 'lm', aes(color="lm")) + 
  scale_color_manual(name="추세선", values=c("blue", "red"))

fig <- ggplotly(ggplot_trend_emp)


fig <- plotly_json(fig, FALSE)
write(fig,'trend1.json')


###########################################


ggplot_trend_covid <- df_covid19 |>
  filter(iso_code == 'KOR', !is.na(new_cases)) |>
  filter(date >= max(date) - 200) |>
  ggplot(aes(x = date, y = new_cases)) +
  geom_line(aes(group = location)) +
  scale_x_date(date_breaks = "1 month", date_labels = "%Y %m") +
  scale_y_continuous(labels = scales::number) +
  labs(x = '년월', y = '신규확진자') +
  geom_smooth(method = 'loess', aes(color="loess")) +
  geom_smooth(method = 'lm', aes(color="lm")) + 
  scale_color_manual(name="추세선", values=c("blue", "red"))

fig <- ggplotly(ggplot_trend_covid)

fig <- plotly_json(fig, FALSE)
write(fig,'trend2.json')

#################################################

lm_trend_emp <- lm(data = df_취업률_2000, 취업자수 ~ 졸업자수)

fig <- df_취업률_2000 |>
  plot_ly(type = 'scatter', mode = 'markers') |>
  add_trace(x = ~졸업자수, y = ~취업자수, name = 'data') |>
  add_trace(mode = 'lines', x = ~졸업자수, y = ~fitted(lm_trend_emp), name = '선형 추세선')

fig <- plotly_json(fig, FALSE)
write(fig,'trend3.json')


################################################3

df_covid19_trend_kor <- 
  df_covid19 |>
  filter(iso_code == 'KOR', !is.na(new_cases)) |>
  filter(date >= max(date) - 200) |>
  mutate(date_int = as.integer(date))

trend_linear <- lm(data = df_covid19_trend_kor, new_cases ~ date)

fig <- df_covid19_trend_kor |>
  plot_ly() |>
  add_trace(type = 'scatter', mode = 'lines', x = ~date, y = ~new_cases, name = 'Data') |>
  add_trace(type = 'scatter', mode = 'lines', x = ~date, y = fitted(trend_linear), name = '선형 추세선')

fig <- plotly_json(fig, FALSE)
write(fig,'trend4.json')



################################################

loess_trend_emp <- loess(data = df_취업률_2000, 취업자수 ~ 졸업자수)

df_loess_trend_emp <- data.frame(X = df_취업률_2000$졸업자수, Y = fitted(loess_trend_emp)) |>
  arrange(X)

df_취업률_2000 |>
  plot_ly(type = 'scatter', mode = 'markers') |>
  add_trace(x = ~졸업자수, y = ~취업자수, name = 'data') |>
  add_trace(data = df_loess_trend_emp, mode = 'lines', x = ~X, y = ~Y, name = 'loess') -> fig

fig <- plotly_json(fig, FALSE)
write(fig,'trend5.json')




###################################################

df_covid19_trend_kor <- 
  df_covid19 |>
  filter(iso_code == 'KOR', !is.na(new_cases)) |>
  filter(date >= max(date) - 200) |>
  mutate(date_int = as.integer(date))

trend_linear_loess <- loess(data = df_covid19_trend_kor, new_cases ~ date_int, span = 0.75)

trend_linear_loess_pred = predict(trend_linear_loess, se = TRUE)

df_covid19_trend_kor |>
  plot_ly(type="scatter", mode="lines") |>
  add_trace(x = ~date, y = ~new_cases, name = 'Data') |>
  add_trace(x = ~date, y = fitted(trend_linear_loess), name = 'loess') |>
  add_ribbons(x=~date, 
              ymin=(trend_linear_loess_pred$fit - (1.96 * trend_linear_loess_pred$se)), 
              ymax=(trend_linear_loess_pred$fit + (1.96 * trend_linear_loess_pred$se)), 
              name="95% CI", line=list(opacity=0.4, width=0)) |>
  config(toImageButtonOptions = list(format = 'svg')) -> fig

fig <- plotly_json(fig, FALSE)
write(fig,'trend6.json')
