library(tidyverse)
library(readxl)

data <- read_xlsx('D:/R/Github/tistory/count/시도별 신입생 충원율(2010_2020)_탑재용.xlsx', sheet = 'Sheet1', skip = 7, col_types = c(rep('text', 2), rep('numeric', 12)), col_names = FALSE)

names(data) <- c('연도', '시도', '전체_모집인원', '전체_신입생', '전체_충원률', '대학_모집인원', '대학_신입생', '대학_충원률', '전문대_모집인원', '전문대_신입생', '전문대_충원률', '대학원_모집인원', '대학원_신입생', '대학원_충원률')

data$시도 <- fct_relevel(data$시도, '서울', '부산', '대구', '인천', '광주', '대전', '울산', '세종', '경기', '강원', '충북', '충남', '전북', '전남', '경북', '경남', '제주')

### 전체 행, 열 count

dim(data)
nrow(data)
ncol(data)

### table을 이용한 count

table(data$전체_충원률)
data |> count(전체_충원률)

### prop.table을 이용한 백분률

as.data.frame(prop.table(table(data$전체_충원률)) * 100) |>
  ggplot(aes(x = as.factor(Var1), y = Freq)) + 
  geom_line(aes(group = 1))


### group_by를 이용한 그룹별 count
data |> 
  group_by(연도) |>
  count()

### cut()을 이용한 range 설정 - n개 그룹 
data$전체_충원률_그룹 <- cut(data$전체_충원률, breaks = 5, include.lowest = F)

paste0(1:5, '%')

data |>
  group_by(전체_충원률_그룹) |>
  count()
data |> filter(전체_충원률 == 75.5)

### cut()을 이용한 range 설정 - 구간 설정 
data$전체_충원률_그룹 <- cut(data$전체_충원률, breaks = c(-Inf, 80, 90, 100, Inf))

data |>
  group_by(전체_충원률_그룹) |>
  count()

### cut()을 이용한 range 설정 - dplyr 
data |>
  mutate(전체_충원률_그룹 = cut(전체_충원률, breaks = c(-Inf, 80, 90, 100, Inf))) |>
  count(전체_충원률_그룹)

### cut()을 이용한 range 설정 - quantile 
data |>
  mutate(전체_충원률_그룹 = cut(전체_충원률, breaks = quantile(전체_충원률, probs = seq(0, 1, 0.25)), include.lowest = T)) -> data

data |>
  count(전체_충원률_그룹)

data |> filter(is.na(전체_충원률_그룹)) |> View()

factor(data$전체_충원률_그룹)

View(data)
data |>
  mutate(전체_충원률_그룹 = cut(전체_충원률, breaks = quantile(전체_충원률, probs = c(0, 1/3, 2/3, 1), right = T))) |>
  count(전체_충원률_그룹)

### cut()을 이용한 range 설정 - ntile
data |>
  mutate(전체_충원률_그룹 = ntile(전체_충원률, 6)) |>
  count(전체_충원률_그룹)

?cut
### cut()을 이용한 range 설정 - cut_interval
data |>
  mutate(전체_충원률_그룹 = cut_interval(전체_충원률, 3)) |>
  count(전체_충원률_그룹)

?cut_interval
### cut()을 이용한 range 설정 - cut_width
data |>
  mutate(전체_충원률_그룹 = cut_width(전체_충원률, width = 3, center = 90)) |>
  ggplot(aes(x = 전체_충원률_그룹)) +
  geom_bar()
