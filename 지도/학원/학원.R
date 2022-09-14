library(showtext)
showtext_auto()
library(tidyverse)
library(readxl)
library(patchwork)
library(plotly)
library(sf)
library(ggspatial)
library(RColorBrewer)

spdf_shp <- st_read('C:/R/git/datavisualization/chap10/TL_SCCO_CTPRVN.shp', options = 'ENCODING=CP949')

df_hakwon <- read_xlsx('D:/R/data/주요-10 (유초)사설학원 현황_시도별_행정구별(2013-2021).xlsx', sheet = '시도별', 
                       skip = 3, col_names = T, col_type = c(rep('text', 4), rep('numeric', 8)))

df_hakwon_summary <- df_hakwon |> filter(분야 == '소계', 종류 == '학교교과교습학원', 시도 != '전국')

df_hakwon_summary <- df_hakwon_summary |>
  mutate(CTPRVN_CD = case_when(
    시도 == '강원' ~ '42', 
    시도 == '경기' ~ '41', 
    시도 == '경남' ~ '48', 
    시도 == '경북' ~ '47', 
    시도 == '광주' ~ '29', 
    시도 == '대구' ~ '27', 
    시도 == '대전' ~ '30', 
    시도 == '부산' ~ '26', 
    시도 == '서울' ~ '11', 
    시도 == '세종' ~ '36', 
    시도 == '울산' ~ '31', 
    시도 == '인천' ~ '28', 
    시도 == '전남' ~ '46', 
    시도 == '전북' ~ '45', 
    시도 == '제주' ~ '50', 
    시도 == '충남' ~ '44', 
    시도 == '충북' ~ '43'
  ))

df_central <- as.data.frame(cbind(st_centroid(spdf_shp), st_coordinates(st_centroid(spdf_shp)))) |> select(CTPRVN_CD, X, Y)

df_joined <- left_join(spdf_shp,df_hakwon_summary |> filter(조사연도 == '2021'), by = 'CTPRVN_CD')

left_join(df_joined, df_central, by = 'CTPRVN_CD') |> 
  ggplot() + 
  geom_sf(aes(fill = 학원수), color = 'gray80') +
  geom_text(aes(x = X, y = Y, label = paste0(시도, '\n', scales::comma(학원수))), color = ifelse(df_joined$시도 == '인천', 'black', 'white'), lineheight = 0.8) + 
  labs(x = '위도', y = '경도') +
  annotation_scale(location = "br") +
  annotation_north_arrow(location = "br", pad_y = unit(0.05, 'npc'),
                         style = north_arrow_nautical) +
  scale_fill_continuous(trans = 'reverse') +
  theme_bw()

###################################################

df_hakwon_metro <- read_xlsx('D:/R/data/주요-10 (유초)사설학원 현황_시도별_행정구별(2013-2021).xlsx', sheet = '행정구역별', 
                       skip = 3, col_names = T, col_type = c(rep('text', 5), rep('numeric', 6)))

df_hakwon_metro_summary <- df_hakwon_metro |> filter(분야 == '소계', 종류 == '학교교과교습학원', 시도 %in% c('서울', '경기'))

df_hakwon_metro_summary <- df_hakwon_metro_summary |>
  filter(연도 %in% c('2021', '2016')) |>
  select(연도, 시도, 행정구역, 학원수) |>
  pivot_wider(names_from = 연도, values_from = '학원수') |>
  mutate(rate = (`2021` - `2016`)/`2016`) |>
  pivot_longer(3:5, names_to = '연도', values_to = '학원수')

df_hakwon_metro_summary <- df_hakwon_metro_summary |>
  mutate(CTPRVN_CD = case_when(
    시도 == '강원' ~ '42', 
    시도 == '경기' ~ '41', 
    시도 == '경남' ~ '48', 
    시도 == '경북' ~ '47', 
    시도 == '광주' ~ '29', 
    시도 == '대구' ~ '27', 
    시도 == '대전' ~ '30', 
    시도 == '부산' ~ '26', 
    시도 == '서울' ~ '11', 
    시도 == '세종' ~ '36', 
    시도 == '울산' ~ '31', 
    시도 == '인천' ~ '28', 
    시도 == '전남' ~ '46', 
    시도 == '전북' ~ '45', 
    시도 == '제주' ~ '50', 
    시도 == '충남' ~ '44', 
    시도 == '충북' ~ '43'
  ))


spdf_shp_metro <- st_read('D:/R/data/map/TL_SCCO_SIG.shp', options = 'ENCODING=CP949')

spdf_shp_metro <- spdf_shp_metro |> filter(substr(SIG_CD, 1, 2) %in% c('41', '11')) |> 
  mutate(name = ifelse(str_detect(SIG_KOR_NM, '시'), 
                       substr(SIG_KOR_NM, 1, str_locate(SIG_KOR_NM, '시')[1,1]), 
                       SIG_KOR_NM)
    ) |> 
  mutate(name = case_when(
    name == '의정부' ~ '의정부시', 
    name == '동두천' ~ '동두천시', 
    name == '남양주' ~ '남양주시', 
    TRUE ~ name    
  ))

df_central_metro <- as.data.frame(cbind(st_centroid(spdf_shp_metro), st_coordinates(st_centroid(spdf_shp_metro)))) 


df_joined <- left_join(spdf_shp_metro, df_hakwon_metro_summary |> filter(연도 != '2016', 행정구역 != '소계'), 
                       by = c('name' = '행정구역'))

df_joined_central_metro <- left_join(df_hakwon_metro_summary |> filter(연도 != '2016', 행정구역 != '소계'), df_central_metro, 
                                     by = c('행정구역' = 'name'))

df_joined |> filter(시도 == '서울', 연도 == 'rate') |> 
  ggplot() + 
  geom_sf(aes(fill = 학원수), color = 'gray50') +
  geom_text(data = df_joined_central_metro |> filter(시도 == '서울', 연도 == 'rate'), 
            aes(x = X, y = Y, label = paste0(행정구역, '\n', scales::percent(학원수, accuracy = 0.1))), 
            color = ifelse(df_joined_central_metro |> filter(시도 == '서울', 연도 == 'rate') |> select(학원수) |> pull() > -0.2,
                           'black', 'white'), 
            lineheight = 0.8) + 
  labs(x = '위도', y = '경도') +
  annotation_scale(location = "br") +
  annotation_north_arrow(location = "br", pad_y = unit(0.05, 'npc'),
                         style = north_arrow_nautical) +
  scale_fill_gradient2(low = 'blue', high = 'red', mid = 'white', labels = scales::percent) +
#  facet_wrap(~연도) +
  theme_bw()


df_joined_central_metro |> filter(시도 == '서울') |> View()

df_joined_central_metro |> filter(시도 == '서울', 연도 == 'rate') |> select(학원수) |> pull()


library(ggrepel)


df_joined |> 
  ggplot() + 
  geom_sf(aes(fill = 학원수), color = 'gray80') +
  geom_text_repel(data = df_central, aes(x = X, y = Y, label = paste0(시도, '\n', scales::comma(학원수))), color = ifelse(df_central$시도 %in% c('인천', '부산', '울산', '제주'), 'black', 'white'), lineheight = 0.8, size = 5, direction = 'x') + 
  labs(x = '위도', y = '경도') +
  annotation_scale(location = "br") +
  annotation_north_arrow(location = "br", pad_y = unit(0.05, 'npc'),
                         style = north_arrow_nautical) +
  scale_fill_continuous(trans = 'reverse') + 
  theme_bw()
