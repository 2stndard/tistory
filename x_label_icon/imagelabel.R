library(tidyverse)
library(readxl)
### 연도별 유학국가별 유학생현황(https://kess.kedi.re.kr/kessTheme/zipyo?itemCode=03&menuId=m_02_03_01#)


## data import
aboard.by.nation <- read_xlsx('D:/R/Github/tistory/x_label_icon/연도별 유학국가별 유학생 현황.xlsx', sheet = 'Sheet0', skip = 2, col_types = c('numeric', 'text', rep('numeric', 25)), col_names = TRUE)


## na 제거
aboard.by.nation <- aboard.by.nation |>
  filter(!is.na(학년도)) 


## 플롯팅할 데이터 필터링
aboard.by.nation.element <- aboard.by.nation |>
  filter(!is.na(학년도)) |>
  select(!contains(c('계', '기타', '미확인', '그외동남아'))) |>
  filter(학제 == '초등학교') |>
  select(-2) |>
  gather('국가명', '유학생수', -'학년도')


## 라인 플롯
aboard.by.nation.element|>
  ggplot(aes(x = as.factor(학년도), y = 유학생수)) +
    geom_line(aes(group = as.factor(국가명), color = as.factor(국가명))) + 
    labs(color = '국가', x = '학년도')


## 유학생수가 많은 10개국 필터링
aboard.by.nation.element.top10 <-
aboard.by.nation.element |>
  group_by(국가명) |>
  summarise(sum = sum(유학생수)) |>
  arrange(desc(sum)) |>
  top_n(10)


##colnames.aboard.by.nation.element.top10 <-
##  aboard.by.nation.element |>
##  group_by(국가명) |>
##  summarise(sum = sum(유학생수)) |>
##  arrange(desc(sum)) |>
##  top_n(10) |>
##  pull(국가명)

## 합계순으로 국가명을 factor화
aboard.by.nation.element.top10$국가명 <- fct_reorder(aboard.by.nation.element.top10$국가명, desc(aboard.by.nation.element.top10$sum))

## 기초 막대 플롯
plot.aboard.by.nation <- 
aboard.by.nation.element.top10 |>
  ggplot(aes(x = 국가명, y = sum)) +
  geom_col(fill = 'dark blue') +
  geom_text(aes(x = 국가명, y = sum, label = sum), vjust = -0.5) + 
  theme_minimal() + 
  labs(title = '국가별 유학생수 Top 10', y = '유학생수')
  
plot.aboard.by.nation

d## 국기 이미지 파일 설정
flag_usa <- 'D:/R/Github/tistory/x_label_icon/usa.png'
flag_canada <- 'D:/R/Github/tistory/x_label_icon/canada.png'
flag_china <- 'D:/R/Github/tistory/x_label_icon/china.png'
flag_nz <- 'D:/R/Github/tistory/x_label_icon/nz.png'
flag_phi <- 'D:/R/Github/tistory/x_label_icon/phi.png'
flag_aus <- 'D:/R/Github/tistory/x_label_icon/aus.png'
flag_eng <- 'D:/R/Github/tistory/x_label_icon/eng.png'
flag_jap <- 'D:/R/Github/tistory/x_label_icon/jap.png'
flag_mal <- 'D:/R/Github/tistory/x_label_icon/mal.png'
flag_sing <- 'D:/R/Github/tistory/x_label_icon/sing.png'

##국기와 국기이미지 데이터 프레임 생성
flags <- data.frame(nations = c('미국', '캐나다', '중국', '뉴질랜드', '필리핀', '호주', '영국', '일본', '말레이시아', '싱가폴'), flag_path = c(flag_usa, flag_canada, flag_china, flag_nz, flag_phi, flag_aus, flag_eng, flag_jap, flag_mal, flag_sing))

## html 문법을 국가명 이름으로 설정
##labels <- setNames(paste0("<img src='", flags$flag_path, "' width='35' />"), flags$nations)
View(labels)

labels <- setNames(
  paste0("<img src='", flags$flag_path, "' width='30'  height = '20'> <br> ", flags$nations),  flags$nations)
labels
##install.packages('ggtext')

plot.aboard.by.nation +
  scale_x_discrete(labels = labels) +
  theme(axis.text.x = ggtext::element_markdown(color = "black", size = 10))


## font 설정

library(showtext)
showtext.auto()
font_add(family = "나눔스퀘어볼드", regular = 'C:/Users/estnd/AppData/Local/Microsoft/Windows/Fonts/NANUMSQUAREB.TTF')


plot.aboard.by.nation +
  scale_x_discrete(labels = labels) + 
  theme(text = element_text(family = "나눔스퀘어")) + 
  theme(axis.text.x = ggtext::element_markdown(color = "black", size = 10))





labels <- setNames(
  paste0("<p align=center> <img src='", flags$flag_path, "' width='30'  height = '20'> <br> ", flags$nations, "</p>"),  flags$nations)



aboard.by.nation.element.final <- right_join(aboard.by.nation.element, aboard.by.nation.element.top10)

aboard.by.nation.element.final$국가명 <- fct_reorder(aboard.by.nation.element.final$국가명, desc(aboard.by.nation.element.final$sum))

end_value <- aboard.by.nation.element.final |>
  filter(학년도 == 2019) |>
  pull(유학생수)

aboard.by.nation.element.final|>
  ggplot(aes(x = as.factor(학년도), y = 유학생수)) +
  geom_line(aes(group = as.factor(국가명), color = as.factor(국가명))) +
  geom_text(data = subset(aboard.by.nation.element.final, 학년도 == 2019), aes(label = 국가명)) +
##  scale_y_continuous(sec.axis = sec_axis(~ ., breaks = end_value)) +
  labs(x = '학년도', color = '국가')




wiki <- "https://upload.wikimedia.org/wikipedia/commons/thumb/"
logos <- tibble::tribble(
  ~service, ~logo,
  "netflix", paste0(wiki, "0/08/Netflix_2015_logo.svg/340px-Netflix_2015_logo.svg.png"),
  "prime", paste0(wiki, "1/11/Amazon_Prime_Video_logo.svg/450px-Amazon_Prime_Video_logo.svg.png"),
  "hulu", paste0(wiki, "e/e4/Hulu_Logo.svg/440px-Hulu_Logo.svg.png"),
  "disney", paste0(wiki, "3/3e/Disney%2B_logo.svg/320px-Disney%2B_logo.svg.png"),
  "apple",  paste0(wiki, "2/28/Apple_TV_Plus_Logo.svg/500px-Apple_TV_Plus_Logo.svg.png"),
  "peacock", paste0(wiki, "d/d3/NBCUniversal_Peacock_Logo.svg/440px-NBCUniversal_Peacock_Logo.svg.png"),
  "hbo", paste0(wiki, "d/de/HBO_logo.svg/440px-HBO_logo.svg.png"),
  "paramount", paste0(wiki, "a/a5/Paramount_Plus.svg/440px-Paramount_Plus.svg.png"),
  "other", "other.png"
) %>% 
  mutate(path = file.path("images", paste(service, tools::file_ext(logo), sep = ".")))
labels <- setNames(paste0("<img src='", logos$path, "' width='35' />"), logos$service)
labels[["other"]] <- "other<br />streaming<br />services"