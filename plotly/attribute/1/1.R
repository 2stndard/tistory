## df_취업률_2000에서 
fig <- df_취업률_2000 |> 
  ## X축은 졸업자수, Y축은 취업자수로 매핑한 plotly 객체 생성
  plot_ly(x = ~졸업자수, y = ~취업자수) |>
  ## 제목과 여백 설정
  layout(title = '졸업자 대비 취업자수', margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'xyz.json')


fig <- df_취업률_2000 |>
  ## X축은 졸업자수, Y축은 취업자수, Z축은 대계열로 매핑된 plotly 객체 생성
  plot_ly(x = ~졸업자수, y = ~취업자수, z = ~대계열)


fig <- plotly_json(fig, FALSE)
write(fig,'3d.json')


fig <- df_취업률_2000 |>
  ## X축은 졸업자수, Y축은 취업자수, name은 대계열로 매핑한 plotly 객체 생성
  plot_ly(x = ~졸업자수, y = ~취업자수, name = ~대계열) |>
  layout(title = '졸업자 대비 취업자수', margin = margins)

fig <- plotly_json(fig, FALSE)
write(fig,'name.json')


legend_items <- df_covid19_100 |> 
  mutate(legend_name = case_when(
    iso_code == 'KOR' ~ '한국', 
    iso_code == 'OWID_ASI' ~ '아시아지역',
    iso_code == 'OWID_EUR' ~ '유럽지역',
    iso_code == 'OWID_NAM' ~ '북미지역',
    iso_code == 'OWID_OCE' ~ '오세아니아지역',
    iso_code == 'OWID_SAM' ~ '남미지역', 
    iso_code == 'OWID_AFR' ~ '아프리카지역')) |>
  select(legend_name) |>
  pull()

## 범례 순서 설정을 위한 팩터 설정
legend_items <- fct_relevel(legend_items, '한국', '아시아지역', '유럽지역', '북미지역', '남미지역', '오세아니아지역', '아프리카지역')

fig <- df_covid19_100 |>
  ## X축을 date, Y축을 new_cases, 범례 이름을 앞서 생성한 문자열 벡터로 매핑 
  plot_ly(x = ~date, y = ~new_cases, name = ~legend_items) |>
  layout(title = '최근 100일간 코로나19 확진자수', 
         ## X축 이름을 제거
         xaxis = list(title = list(text = '')),
         ## Y축 이름을 설정
         yaxis = list(title = list(text = '확진자수')),
         ## 여백 설정
         margin = margins) |>
  config(toImageButtonOptions = list(format = 'svg'))

fig <- plotly_json(fig, FALSE)
write(fig,'name1.json')



figdf_취업률_2000 |>
  plot_ly(x = ~졸업자수, y = ~취업자수, name = ~대계열,
          ## hovertext를 학과명으로 매핑
          hovertext = ~학과명) |>
  ## 제목과 여백의 설정
  layout(title = '졸업자 대비 취업자수', margin = margins)
