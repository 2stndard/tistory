fig <- df_covid19_stat |> 
  easylabel::easylabel(x = '십만명당사망자수', y = '백신접종완료률',
                       labs = 'location',
                       startLabels = pull(df_covid19_stat[df_covid19_stat$location %in% c('South Korea', 'United Kingdom', 'France', 'United States'), 'location']),
                       output_shiny = FALSE)

fig <- plotly_json(fig, FALSE)
write(fig,'easylabel.json')

