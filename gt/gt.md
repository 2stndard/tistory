---
output: html_document
---



## `gt` 패키지로 데이터 테이블 만들기 - 1

### 표도 데이터 시각화의 방법

데이터 시각화를 한다고 하면 대부분 떠올리는 작업이 그래프를 그리는 작업이다. 데이터 시각화를 시작할 때는 먼저 데이터를 대상으로 할지, 어떤 그래프를 써서 데이터를 예쁘고 직관적으로 표현할지를 고민하게 된다. 하지만 데이터 시각화 결과가 들어갈 보고문서에는 대부분 그래프와 함c께 작성하는 것이 표이다. 데이터 시각화라고 할 때 많은 사람들은 표까지 생각하지는 않는 듯하다. 인터넷 상의 표의 정의[^1]를 보면 '시각적 의사소통과 자료의 정렬 양식'으로 나와 있다. 결국 표도 데이터 시각화의 일부인 것이다.

[^1]: <https://ko.wikipedia.org/wiki/%ED%91%9C>

표는 데이터를 직접적으로 표현한다는 점에서 그래프나 플롯과는 다르다. 데이터를 직접 표현하기 때문에 데이터를 정확하게 표현하지만 데이터의 전체적인 흐름이나 분포를 알아보기에는 적절치 않다. 하지만 그래프나 플롯은 정확한 데이터를 알아보기 힘들다는 점에서 표와 그래프, 플롯은 상호 보완적으로 사용되어야 한다.

보통 표는 행과 열로 이루어진 데이터의 모음이다. 행은 각각의 개별 사례[^2]나 개별 사례를 적절히 그루핑한 요약된 데이터가 표현된다. 열은 각각의 사례를 설명하기 위해 필요한 속성이 나열된다. 행과 열은 이 만나는 곳이 사용자가 알고 싶어하는 데이터가 위치하고 이 곳을 칸, 혹은 셀이라고 한다.

[^2]: 데이터베이스에서는 튜플, 레코드 등으로 불린다.

표는 그 구성 방법에 따라 1차원 표와 다차원 표로 구성된다. 1차원 표는 단순히 데이터의 나열인 경우를 말한다. 이런 테이블을 '단순 표(simple table)'이라고도 한다. 다차원 표는 1차원 표를 적절한 변환(추상화)하여 표에서 제공하는 몇가지 차원의 정보를 모두 가져야 데이터를 해석할 수 있는 표를 말한다. 다차원 표 중에서 가장 흔하게 보이는 표가 2차원 표, 교차표(cross table)이다. 2차원 표는 행(X축)과 열(Y축)의 정보를 가지고 해당 칸(셀)의 정보를 해석할 수 있다.

아래의 그림은 1차원 표와 2차원 표의 예를 보이고 있다.

![출처 : <https://docs.tibco.com/pub/spotfire/6.5.2/doc/html/images/cross_example_table.png>](https://docs.tibco.com/pub/spotfire/6.5.2/doc/html/images/cross_example_table.png "1차원 표의 예")

![출처 : <https://docs.tibco.com/pub/spotfire/6.5.2/doc/html/images/cross_example_cross_table.png>](https://docs.tibco.com/pub/spotfire/6.5.2/doc/html/images/cross_example_cross_table.png "2차원 표의 예")

위의 예에서 보면 1차원 표의 경우는 데이터를 설명하는 속성이 위쪽에만 설정되어 있다. 하지만 2차원 표의 경우는 데이터를 설명하는 속성이 위쪽과 왼쪽에 모두 설정되어 있다. 특정 칸의 데이터를 해석하기 위해서는 행과 열의 속성 정보를 모두 알아야 한다는 것이다.

1차원 표의 장점은 데이터를 원본 차원에서 확인 할 수 있다는 점이다. 반면 데이터의 행이 길어질 수 있어 보고서에 수록하는 것인 적절치 않을 때가 있다. 하지만 다차원 표의 가장 큰 장점은 데이터를 요약하고 구조화하였기 때문에 대량의 데이터의 특성을 간략히 표현했다는 점이다. 하지만 데이터를 요약하는 방식에 따라 전달되는 정보가 제한적일 수 있다는 단점이 있다.

표의 구성 방법과 요소는 사용자가 표현하고 싶은 데이터와 형태에 따라 표현방식이 매우 다르기 때문에 어느 하나로 정의하기가 어렵다. 다음 그림은 논문의 작성에서 대표적으로 사용되는 미국 심리학회의 표 구성 가이드라인이다.

![출처 : <https://libapps.s3.amazonaws.com/customers/836/qu/e1d262992c7ea1e2aa109305faf24d59.png>](https://libapps.s3.amazonaws.com/customers/836/qu/e1d262992c7ea1e2aa109305faf24d59.png)

모든 표를 APA 가이드라인에 맞춰 그릴 수는 없겠지만 APA 가이드라인을 보면 표에 꼭 들어가야 할 몇가지 요소들을 알 수 있다.

-   표 제목(Title) : 표에서 표현하고 있는 데이터를 대표하는 제목이 반드시 필요하다.

-   표 헤드(Heading) : 표에서 제시하고 있는 사례들의 속성값들에 대한 이름이 표현된 표 가로축의 맨 위줄을 말한다.

-   표 스텁(Stub) : 표에서 표현되는 다양한 사례를 구분하기 위해 필요한 세로축의 가장 왼쪽 줄을 말한다.

-   표 몸체(Body) : 표의 헤드와 스텁으로 감싸고 있는 데이터가 표현된 셀들이 표현된 부분을 말한다.

![출처 : <https://cdn1.byjus.com/wp-content/uploads/2019/06/word-image1.jpeg>](https://cdn1.byjus.com/wp-content/uploads/2019/06/word-image1.jpeg)

실무에서 표를 그릴 때 가장 많이 사용하는 툴은 아마도 MS-Excel일 것이다. SpreadSheet로 거의 유일하게(?) 살아남은 이 툴은 표를 그리는 WYSYWYG(What You See IS Wat You Get) 툴로 거의 모든 Spreadsheet를 없애버렸다고 해도 과언이 아닐 듯 하다. 어쨌던 엑셀은 표를 그리는데 매우 특화된 툴임에는 틀림없고 초보자들도 쉽게 사용할 수 있지만 사용하다보면 몇가지 단점을 만날 수 있다.

가장 큰 단점이 반복된 작업을 하기가 어렵다는 점이다. 이는 WYSIWIG 툴들이 가지는 공통된 단점이다. 표를 쉽게 만들 수 있지만 유사한 표를 다시 만들어야 하는 경우 반복된 작업을 수행해야하고 반복된 작업을 꼼꼼히 기록해두지 않으면 동일한 표를 만들기 어렵다. 두번째 단점이 기초 데이터의 구조가 업데이트 되면 표를 다시 그려야 하는 경우가 발생한다는 점이다. 기초 데이터의 열 이름이 바뀌거나 열이 추가, 삭제되면 이 데이터로부터 파생된 표가 정상적으로 표현되지 않는다는 것이다. 이러한 문제는 엑셀을 사용해 본 사용자라면 한번쯤, 아니 자주 겪는 문제일 것이다.

이제 엑셀에서 탈피해서 R에서 표를 그려보자. R에서도 아주 훌륭한, 그리고 예쁘게 표를 그릴 수 있는 다양한 방법을 제공한다. R로 표를 그려보면 반복된 작업을 할 필요가 없다는 점에서, 기초 데이터의 업데이트가 발생해도 바로 반영할 수 있다는 점, 표를 세세하게 다룰 수 있다는 점에서 엑셀로 다시 돌아갈 수 없을 수도 있다.

### `gt` 패키지

R에서 표를 만들기 위해 사용되는 패키지 중에 하나가 `gt` 패키지이다. `gt` 패키지는 표의 세부 구성들을 상세히 구분하고 이들을 구조적으로 조화롭게 구성시켜서 표를 만드는 다양한 함수와 매개 변수들을 제공한다. `gt` 패키지에서 사용하는 표의 세부 파트는 다음의 그림과 같다.

![출처 : [https://gt.rstudio.com/reference/figures/gt_parts_of_a\\\_table.svg](https://gt.rstudio.com/reference/figures/gt_parts_of_a_table.svg){.uri}](https://gt.rstudio.com/reference/figures/gt_parts_of_a_table.svg)

표의 구성을 보면 앞에서 살펴보았던 APA 가이드라인상의 표와 유사한 형태를 보인다. 이와 같이 표를 세부적인 파트로 구분하고 이들을 각각 설정함으로써 표를 만들 수 있다.

`gt` 패키지에서 권장하는 표 생성 방식은 다음의 그림과 같다.

![출처 : <https://gt.rstudio.com/reference/figures/gt_workflow_diagram.svg>](https://gt.rstudio.com/reference/figures/gt_workflow_diagram.svg)

우선 표를 만들기 위한 기초 데이터를 생성해야 한다. `gt` 패키지로 생성되는 표는 `tidyverse` 방식을 준용하여 생성하는 것이 편하다. 따라서 `gt` 표를 생성하기 위해 만드는 기초 데이터도 `tidyverse` 의 `tibble` 이나 R의 기초 데이터 셋인 `data.frame` 으로 생성한다. 이렇게 생성된 기초 데이터 셋은 `gt` 객체로 변환되고 `gt` 패키지에서 제공되는 다양한 함수와 매개변수를 설정하여 사용자가 원하는 형태의 표로 만들게 된다. 마지막으로 이 표를 다른 문서에서 활용하기 위해 html, pdf 등의 문서로 변환하여 활용한다.

### Data Import

이번 포스트에서는 각각의 학제에 소속된 학과들에 대한 정보를 표현하기 위한 표를 그려보도록 하겠다. 표에서는 각각의 열을 학제로 구분(Stub)하고, 특성으로 표현되는 열은 크게 합계와 평균 으로 묶어주고(span), 학위과정 데이터를 사용하여 행을 그룹핑한 후 그룹별, 전체 합계와 평균 행을 추가하는 표를 그리겠다.

`gt` 패키지를 사용하여 표를 만들어 보기 위해 사용하는 데이터는 [한국교육개발원 교육통계서비스 홈페이지](https://kess.kedi.re.kr)의 [학교/학과별 데이터셋 - 대학 - 학과별(상반기) - 2021](https://kess.kedi.re.kr/contents/dataset?itemCode=04&menuId=m_02_04_03_02&tabId=m2)를 활용하겠다.


```r
library(readxl)
library(tidyverse)

df <- read_excel('./21년 고등 학과별 입학정원 입학 지원 재적 재학 휴학 외국인유학생 졸업 교원_211119.xlsx', skip = 12, na = '-', sheet = '학과별 주요 현황', col_names = T, col_types = c(rep('text', 8), rep('numeric', 56)))

## 학제 열을 팩터로 변환하고 레벨을 적절히 설정해 줌
df$학제 <- fct_relevel(df$학제, '대학교', '교육대학', '산업대학', '기술대학', '방송통신대학', '사내대학(대학)', '원격대학(대학)', '사이버대학(대학)', '각종대학(대학)', '전문대학(2년제)', '전문대학(3년제)', '전문대학(4년제)', '기능대학', '원격대학(전문)', '사이버대학(전문)', '사내대학(전문)', '전공대학',  '일반대학원', '특수대학원', '전문대학원')
```

#### 1. 표로 그릴 데이터 셋 만들기

우선 데이터를 정제하기 위해 필요한 데이터만 필터링과 서브세팅하도록 하겠다. 여기서 필요한 데이터는 각각의 데이터 중 '합계'에 해당하는 열이고 이 데이터들을 학제와 학위과정으로 그룹핑하여 합계와 평균을 낸 데이터이다. 다음과 같이 산출한다.


```r
df.gt <- df |>
  group_by(학제, 학위과정) |>
  summarise_at(vars(학과수_전체, 지원자_전체_계, 입학자_전체_계, 재적생_전체_계, 재학생_전체_계, 휴학생_전체_계, 외국인유학생_총계_계, 졸업자_전체, 전임교원_계, 비전임교원_계, 시간강사_계), funs(sum, mean)) |>
  ungroup() |>
  filter(학과수_전체_sum > 100) |>
  arrange(학제)

head(df.gt)
```

```
## # A tibble: 6 x 24
##   학제   학위과정 학과수_전체_sum 지원자_전체_계_~ 입학자_전체_계_~ 재적생_전체_계_~ 재학생_전체_계_~
##   <fct>  <chr>              <dbl>            <dbl>            <dbl>            <dbl>            <dbl>
## 1 대학교 대학과정           12028          2635154           329306          1938254          1415162
## 2 교육~  대학과정             140            15805             3864            15409            15045
## 3 산업~  대학과정             251            22128             2379            14539            11076
## 4 사이~  대학과정             357            51840            34279           135155           119995
## 5 전문~  전문대~             2546           473154            70200           238266           162729
## 6 전문~  전문대~             3095           603197            87333           304435           213105
## # ... with 17 more variables: 휴학생_전체_계_sum <dbl>, 외국인유학생_총계_계_sum <dbl>,
## #   졸업자_전체_sum <dbl>, 전임교원_계_sum <dbl>, 비전임교원_계_sum <dbl>, 시간강사_계_sum <dbl>,
## #   학과수_전체_mean <dbl>, 지원자_전체_계_mean <dbl>, 입학자_전체_계_mean <dbl>,
## #   재적생_전체_계_mean <dbl>, 재학생_전체_계_mean <dbl>, 휴학생_전체_계_mean <dbl>,
## #   외국인유학생_총계_계_mean <dbl>, 졸업자_전체_mean <dbl>, 전임교원_계_mean <dbl>,
## #   비전임교원_계_mean <dbl>, 시간강사_계_mean <dbl>
```

여기서 하나 주목해아하는 부분이 중간의 `ungroup()`이다. `group_by()`를 통해 생성된 data.frame이나 tibble은 최종적으로 `grouped_df` 클래스로 생성된다. 이 클래스도 data.frame과 tibble에서 상속된 클래스이기 때문에 이들과 유사하게 다룰 수 있다. 하지만 몇가지 예상치 않게 사용할 수 없는 함수가 있기 때문에 가급적 `ungroup()`으로 `grouped_df` 클래스를 해제시켜준 것이다.

#### 2. `gt` 객체 생성하기

`gt` 패키지를 사용하여 표를 그리려면 먼저 `gt` 패키지의 `gt()` 함수를 사용하여 `gt` 객체를 생성한다.(아래의 실행결과는 표의 일부만 표현하였다)


```r
library(gt)
df.gt |> 
  gt()
```

<!--html_preserve--><div id="juaceawoqb" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#juaceawoqb .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 10px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#juaceawoqb .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#juaceawoqb .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#juaceawoqb .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#juaceawoqb .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#juaceawoqb .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#juaceawoqb .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#juaceawoqb .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#juaceawoqb .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#juaceawoqb .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#juaceawoqb .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#juaceawoqb .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#juaceawoqb .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#juaceawoqb .gt_from_md > :first-child {
  margin-top: 0;
}

#juaceawoqb .gt_from_md > :last-child {
  margin-bottom: 0;
}

#juaceawoqb .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#juaceawoqb .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#juaceawoqb .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#juaceawoqb .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#juaceawoqb .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#juaceawoqb .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#juaceawoqb .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#juaceawoqb .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#juaceawoqb .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#juaceawoqb .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#juaceawoqb .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#juaceawoqb .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#juaceawoqb .gt_left {
  text-align: left;
}

#juaceawoqb .gt_center {
  text-align: center;
}

#juaceawoqb .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#juaceawoqb .gt_font_normal {
  font-weight: normal;
}

#juaceawoqb .gt_font_bold {
  font-weight: bold;
}

#juaceawoqb .gt_font_italic {
  font-style: italic;
}

#juaceawoqb .gt_super {
  font-size: 65%;
}

#juaceawoqb .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 65%;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1">학제</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1">학위과정</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">학과수_전체_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">지원자_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">입학자_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재적생_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재학생_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">휴학생_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">외국인유학생_총계_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">졸업자_전체_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">전임교원_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">비전임교원_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">시간강사_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">학과수_전체_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">지원자_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">입학자_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재적생_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재학생_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">휴학생_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">외국인유학생_총계_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">졸업자_전체_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">전임교원_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">비전임교원_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">시간강사_계_mean</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td class="gt_row gt_center">대학교</td>
<td class="gt_row gt_left">대학과정</td>
<td class="gt_row gt_right">12028</td>
<td class="gt_row gt_right">2635154</td>
<td class="gt_row gt_right">329306</td>
<td class="gt_row gt_right">1938254</td>
<td class="gt_row gt_right">1415162</td>
<td class="gt_row gt_right">504165</td>
<td class="gt_row gt_right">69888</td>
<td class="gt_row gt_right">325432</td>
<td class="gt_row gt_right">67473</td>
<td class="gt_row gt_right">86857</td>
<td class="gt_row gt_right">79</td>
<td class="gt_row gt_right">1.4895356</td>
<td class="gt_row gt_right">326.33486</td>
<td class="gt_row gt_right">40.780929</td>
<td class="gt_row gt_right">240.03146</td>
<td class="gt_row gt_right">175.25226</td>
<td class="gt_row gt_right">62.435294</td>
<td class="gt_row gt_right">8.65486068</td>
<td class="gt_row gt_right">40.30118</td>
<td class="gt_row gt_right">8.3557895</td>
<td class="gt_row gt_right">10.7562848</td>
<td class="gt_row gt_right">0.009783282</td></tr>
    <tr><td class="gt_row gt_center">교육대학</td>
<td class="gt_row gt_left">대학과정</td>
<td class="gt_row gt_right">140</td>
<td class="gt_row gt_right">15805</td>
<td class="gt_row gt_right">3864</td>
<td class="gt_row gt_right">15409</td>
<td class="gt_row gt_right">15045</td>
<td class="gt_row gt_right">364</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">3818</td>
<td class="gt_row gt_right">833</td>
<td class="gt_row gt_right">1481</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">2.3333333</td>
<td class="gt_row gt_right">263.41667</td>
<td class="gt_row gt_right">64.400000</td>
<td class="gt_row gt_right">256.81667</td>
<td class="gt_row gt_right">250.75000</td>
<td class="gt_row gt_right">6.066667</td>
<td class="gt_row gt_right">0.00000000</td>
<td class="gt_row gt_right">63.63333</td>
<td class="gt_row gt_right">13.8833333</td>
<td class="gt_row gt_right">24.6833333</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_center">산업대학</td>
<td class="gt_row gt_left">대학과정</td>
<td class="gt_row gt_right">251</td>
<td class="gt_row gt_right">22128</td>
<td class="gt_row gt_right">2379</td>
<td class="gt_row gt_right">14539</td>
<td class="gt_row gt_right">11076</td>
<td class="gt_row gt_right">3374</td>
<td class="gt_row gt_right">180</td>
<td class="gt_row gt_right">2704</td>
<td class="gt_row gt_right">350</td>
<td class="gt_row gt_right">707</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.0244898</td>
<td class="gt_row gt_right">90.31837</td>
<td class="gt_row gt_right">9.710204</td>
<td class="gt_row gt_right">59.34286</td>
<td class="gt_row gt_right">45.20816</td>
<td class="gt_row gt_right">13.771429</td>
<td class="gt_row gt_right">0.73469388</td>
<td class="gt_row gt_right">11.03673</td>
<td class="gt_row gt_right">1.4285714</td>
<td class="gt_row gt_right">2.8857143</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_center">사이버대학(대학)</td>
<td class="gt_row gt_left">대학과정</td>
<td class="gt_row gt_right">357</td>
<td class="gt_row gt_right">51840</td>
<td class="gt_row gt_right">34279</td>
<td class="gt_row gt_right">135155</td>
<td class="gt_row gt_right">119995</td>
<td class="gt_row gt_right">15160</td>
<td class="gt_row gt_right">886</td>
<td class="gt_row gt_right">27215</td>
<td class="gt_row gt_right">569</td>
<td class="gt_row gt_right">3377</td>
<td class="gt_row gt_right">2</td>
<td class="gt_row gt_right">0.8321678</td>
<td class="gt_row gt_right">120.83916</td>
<td class="gt_row gt_right">79.904429</td>
<td class="gt_row gt_right">315.04662</td>
<td class="gt_row gt_right">279.70862</td>
<td class="gt_row gt_right">35.337995</td>
<td class="gt_row gt_right">2.06526807</td>
<td class="gt_row gt_right">63.43823</td>
<td class="gt_row gt_right">1.3263403</td>
<td class="gt_row gt_right">7.8717949</td>
<td class="gt_row gt_right">0.004662005</td></tr>
    <tr><td class="gt_row gt_center">전문대학(2년제)</td>
<td class="gt_row gt_left">전문대학과정</td>
<td class="gt_row gt_right">2546</td>
<td class="gt_row gt_right">473154</td>
<td class="gt_row gt_right">70200</td>
<td class="gt_row gt_right">238266</td>
<td class="gt_row gt_right">162729</td>
<td class="gt_row gt_right">75386</td>
<td class="gt_row gt_right">4242</td>
<td class="gt_row gt_right">70278</td>
<td class="gt_row gt_right">4950</td>
<td class="gt_row gt_right">11103</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.3874659</td>
<td class="gt_row gt_right">257.84959</td>
<td class="gt_row gt_right">38.256131</td>
<td class="gt_row gt_right">129.84523</td>
<td class="gt_row gt_right">88.68065</td>
<td class="gt_row gt_right">41.082289</td>
<td class="gt_row gt_right">2.31171662</td>
<td class="gt_row gt_right">38.29864</td>
<td class="gt_row gt_right">2.6975477</td>
<td class="gt_row gt_right">6.0506812</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_center">전문대학(3년제)</td>
<td class="gt_row gt_left">전문대학과정</td>
<td class="gt_row gt_right">3095</td>
<td class="gt_row gt_right">603197</td>
<td class="gt_row gt_right">87333</td>
<td class="gt_row gt_right">304435</td>
<td class="gt_row gt_right">213105</td>
<td class="gt_row gt_right">91162</td>
<td class="gt_row gt_right">4495</td>
<td class="gt_row gt_right">83819</td>
<td class="gt_row gt_right">6298</td>
<td class="gt_row gt_right">12866</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.6775068</td>
<td class="gt_row gt_right">326.93604</td>
<td class="gt_row gt_right">47.334959</td>
<td class="gt_row gt_right">165.00542</td>
<td class="gt_row gt_right">115.50407</td>
<td class="gt_row gt_right">49.410298</td>
<td class="gt_row gt_right">2.43631436</td>
<td class="gt_row gt_right">45.43035</td>
<td class="gt_row gt_right">3.4135501</td>
<td class="gt_row gt_right">6.9734417</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_center">전문대학(4년제)</td>
<td class="gt_row gt_left">전문대학과정</td>
<td class="gt_row gt_right">317</td>
<td class="gt_row gt_right">63559</td>
<td class="gt_row gt_right">9174</td>
<td class="gt_row gt_right">33340</td>
<td class="gt_row gt_right">24242</td>
<td class="gt_row gt_right">9077</td>
<td class="gt_row gt_right">280</td>
<td class="gt_row gt_right">9375</td>
<td class="gt_row gt_right">780</td>
<td class="gt_row gt_right">1541</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.1362007</td>
<td class="gt_row gt_right">227.81004</td>
<td class="gt_row gt_right">32.881720</td>
<td class="gt_row gt_right">119.49821</td>
<td class="gt_row gt_right">86.88889</td>
<td class="gt_row gt_right">32.534050</td>
<td class="gt_row gt_right">1.00358423</td>
<td class="gt_row gt_right">33.60215</td>
<td class="gt_row gt_right">2.7956989</td>
<td class="gt_row gt_right">5.5232975</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_center">기능대학</td>
<td class="gt_row gt_left">전문대학과정</td>
<td class="gt_row gt_right">263</td>
<td class="gt_row gt_right">19102</td>
<td class="gt_row gt_right">7565</td>
<td class="gt_row gt_right">23910</td>
<td class="gt_row gt_right">14860</td>
<td class="gt_row gt_right">9050</td>
<td class="gt_row gt_right">9</td>
<td class="gt_row gt_right">7284</td>
<td class="gt_row gt_right">863</td>
<td class="gt_row gt_right">844</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.4858757</td>
<td class="gt_row gt_right">107.92090</td>
<td class="gt_row gt_right">42.740113</td>
<td class="gt_row gt_right">135.08475</td>
<td class="gt_row gt_right">83.95480</td>
<td class="gt_row gt_right">51.129944</td>
<td class="gt_row gt_right">0.05084746</td>
<td class="gt_row gt_right">41.15254</td>
<td class="gt_row gt_right">4.8757062</td>
<td class="gt_row gt_right">4.7683616</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_center">일반대학원</td>
<td class="gt_row gt_left">대학원과정</td>
<td class="gt_row gt_right">10076</td>
<td class="gt_row gt_right">121226</td>
<td class="gt_row gt_right">69928</td>
<td class="gt_row gt_right">161987</td>
<td class="gt_row gt_right">143965</td>
<td class="gt_row gt_right">18022</td>
<td class="gt_row gt_right">28099</td>
<td class="gt_row gt_right">45978</td>
<td class="gt_row gt_right">2420</td>
<td class="gt_row gt_right">3703</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">2.6501841</td>
<td class="gt_row gt_right">31.88480</td>
<td class="gt_row gt_right">18.392425</td>
<td class="gt_row gt_right">42.60573</td>
<td class="gt_row gt_right">37.86560</td>
<td class="gt_row gt_right">4.740137</td>
<td class="gt_row gt_right">7.39058390</td>
<td class="gt_row gt_right">12.09311</td>
<td class="gt_row gt_right">0.6365071</td>
<td class="gt_row gt_right">0.9739611</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_center">특수대학원</td>
<td class="gt_row gt_left">대학원과정</td>
<td class="gt_row gt_right">4351</td>
<td class="gt_row gt_right">84377</td>
<td class="gt_row gt_right">45448</td>
<td class="gt_row gt_right">124912</td>
<td class="gt_row gt_right">107537</td>
<td class="gt_row gt_right">17375</td>
<td class="gt_row gt_right">6220</td>
<td class="gt_row gt_right">38435</td>
<td class="gt_row gt_right">978</td>
<td class="gt_row gt_right">7421</td>
<td class="gt_row gt_right">4</td>
<td class="gt_row gt_right">1.6550019</td>
<td class="gt_row gt_right">32.09471</td>
<td class="gt_row gt_right">17.287181</td>
<td class="gt_row gt_right">47.51312</td>
<td class="gt_row gt_right">40.90415</td>
<td class="gt_row gt_right">6.608977</td>
<td class="gt_row gt_right">2.36591860</td>
<td class="gt_row gt_right">14.61963</td>
<td class="gt_row gt_right">0.3720046</td>
<td class="gt_row gt_right">2.8227463</td>
<td class="gt_row gt_right">0.001521491</td></tr>
    <tr><td class="gt_row gt_center">전문대학원</td>
<td class="gt_row gt_left">대학원과정</td>
<td class="gt_row gt_right">1088</td>
<td class="gt_row gt_right">39141</td>
<td class="gt_row gt_right">15556</td>
<td class="gt_row gt_right">40516</td>
<td class="gt_row gt_right">36108</td>
<td class="gt_row gt_right">4408</td>
<td class="gt_row gt_right">5102</td>
<td class="gt_row gt_right">12037</td>
<td class="gt_row gt_right">4320</td>
<td class="gt_row gt_right">4095</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.5432624</td>
<td class="gt_row gt_right">55.51915</td>
<td class="gt_row gt_right">22.065248</td>
<td class="gt_row gt_right">57.46950</td>
<td class="gt_row gt_right">51.21702</td>
<td class="gt_row gt_right">6.252482</td>
<td class="gt_row gt_right">7.23687943</td>
<td class="gt_row gt_right">17.07376</td>
<td class="gt_row gt_right">6.1276596</td>
<td class="gt_row gt_right">5.8085106</td>
<td class="gt_row gt_right">0.000000000</td></tr>
  </tbody>
  
  
</table>
</div><!--/html_preserve-->

앞서 설명한 바와 같이 각각의 행을 구분할 수 있는 구분열(Stub)을 설정해야 한다. 또 목표로 설정한 표는 학위과정별로 소계와 평균을 구해야하기 때문에 학위과정별로 그룹핑해야 한다. 행 구분을 위한 구분 열은 `rowname_col`로 설정하고 행을 그루핑하기 위한 열은 `groupname_col`로 설정한다.


```r
library(gt)
gt.table1 <- df.gt |> 
  gt(rowname_col = '학제', 
     groupname_col = '학위과정')
```

<!--html_preserve--><div id="yfynipccjp" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#yfynipccjp .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 10px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#yfynipccjp .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#yfynipccjp .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#yfynipccjp .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#yfynipccjp .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yfynipccjp .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#yfynipccjp .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#yfynipccjp .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#yfynipccjp .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#yfynipccjp .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#yfynipccjp .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#yfynipccjp .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#yfynipccjp .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#yfynipccjp .gt_from_md > :first-child {
  margin-top: 0;
}

#yfynipccjp .gt_from_md > :last-child {
  margin-bottom: 0;
}

#yfynipccjp .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#yfynipccjp .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#yfynipccjp .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yfynipccjp .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#yfynipccjp .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#yfynipccjp .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#yfynipccjp .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#yfynipccjp .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#yfynipccjp .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#yfynipccjp .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#yfynipccjp .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#yfynipccjp .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#yfynipccjp .gt_left {
  text-align: left;
}

#yfynipccjp .gt_center {
  text-align: center;
}

#yfynipccjp .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#yfynipccjp .gt_font_normal {
  font-weight: normal;
}

#yfynipccjp .gt_font_bold {
  font-weight: bold;
}

#yfynipccjp .gt_font_italic {
  font-style: italic;
}

#yfynipccjp .gt_super {
  font-size: 65%;
}

#yfynipccjp .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 65%;
}
</style>
<table class="gt_table">
  
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1"></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">학과수_전체_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">지원자_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">입학자_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재적생_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재학생_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">휴학생_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">외국인유학생_총계_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">졸업자_전체_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">전임교원_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">비전임교원_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">시간강사_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">학과수_전체_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">지원자_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">입학자_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재적생_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재학생_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">휴학생_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">외국인유학생_총계_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">졸업자_전체_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">전임교원_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">비전임교원_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">시간강사_계_mean</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">대학과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">대학교</td>
<td class="gt_row gt_right">12028</td>
<td class="gt_row gt_right">2635154</td>
<td class="gt_row gt_right">329306</td>
<td class="gt_row gt_right">1938254</td>
<td class="gt_row gt_right">1415162</td>
<td class="gt_row gt_right">504165</td>
<td class="gt_row gt_right">69888</td>
<td class="gt_row gt_right">325432</td>
<td class="gt_row gt_right">67473</td>
<td class="gt_row gt_right">86857</td>
<td class="gt_row gt_right">79</td>
<td class="gt_row gt_right">1.4895356</td>
<td class="gt_row gt_right">326.33486</td>
<td class="gt_row gt_right">40.780929</td>
<td class="gt_row gt_right">240.03146</td>
<td class="gt_row gt_right">175.25226</td>
<td class="gt_row gt_right">62.435294</td>
<td class="gt_row gt_right">8.65486068</td>
<td class="gt_row gt_right">40.30118</td>
<td class="gt_row gt_right">8.3557895</td>
<td class="gt_row gt_right">10.7562848</td>
<td class="gt_row gt_right">0.009783282</td></tr>
    <tr><td class="gt_row gt_left gt_stub">교육대학</td>
<td class="gt_row gt_right">140</td>
<td class="gt_row gt_right">15805</td>
<td class="gt_row gt_right">3864</td>
<td class="gt_row gt_right">15409</td>
<td class="gt_row gt_right">15045</td>
<td class="gt_row gt_right">364</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">3818</td>
<td class="gt_row gt_right">833</td>
<td class="gt_row gt_right">1481</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">2.3333333</td>
<td class="gt_row gt_right">263.41667</td>
<td class="gt_row gt_right">64.400000</td>
<td class="gt_row gt_right">256.81667</td>
<td class="gt_row gt_right">250.75000</td>
<td class="gt_row gt_right">6.066667</td>
<td class="gt_row gt_right">0.00000000</td>
<td class="gt_row gt_right">63.63333</td>
<td class="gt_row gt_right">13.8833333</td>
<td class="gt_row gt_right">24.6833333</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_left gt_stub">산업대학</td>
<td class="gt_row gt_right">251</td>
<td class="gt_row gt_right">22128</td>
<td class="gt_row gt_right">2379</td>
<td class="gt_row gt_right">14539</td>
<td class="gt_row gt_right">11076</td>
<td class="gt_row gt_right">3374</td>
<td class="gt_row gt_right">180</td>
<td class="gt_row gt_right">2704</td>
<td class="gt_row gt_right">350</td>
<td class="gt_row gt_right">707</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.0244898</td>
<td class="gt_row gt_right">90.31837</td>
<td class="gt_row gt_right">9.710204</td>
<td class="gt_row gt_right">59.34286</td>
<td class="gt_row gt_right">45.20816</td>
<td class="gt_row gt_right">13.771429</td>
<td class="gt_row gt_right">0.73469388</td>
<td class="gt_row gt_right">11.03673</td>
<td class="gt_row gt_right">1.4285714</td>
<td class="gt_row gt_right">2.8857143</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_left gt_stub">사이버대학(대학)</td>
<td class="gt_row gt_right">357</td>
<td class="gt_row gt_right">51840</td>
<td class="gt_row gt_right">34279</td>
<td class="gt_row gt_right">135155</td>
<td class="gt_row gt_right">119995</td>
<td class="gt_row gt_right">15160</td>
<td class="gt_row gt_right">886</td>
<td class="gt_row gt_right">27215</td>
<td class="gt_row gt_right">569</td>
<td class="gt_row gt_right">3377</td>
<td class="gt_row gt_right">2</td>
<td class="gt_row gt_right">0.8321678</td>
<td class="gt_row gt_right">120.83916</td>
<td class="gt_row gt_right">79.904429</td>
<td class="gt_row gt_right">315.04662</td>
<td class="gt_row gt_right">279.70862</td>
<td class="gt_row gt_right">35.337995</td>
<td class="gt_row gt_right">2.06526807</td>
<td class="gt_row gt_right">63.43823</td>
<td class="gt_row gt_right">1.3263403</td>
<td class="gt_row gt_right">7.8717949</td>
<td class="gt_row gt_right">0.004662005</td></tr>
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">전문대학과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(2년제)</td>
<td class="gt_row gt_right">2546</td>
<td class="gt_row gt_right">473154</td>
<td class="gt_row gt_right">70200</td>
<td class="gt_row gt_right">238266</td>
<td class="gt_row gt_right">162729</td>
<td class="gt_row gt_right">75386</td>
<td class="gt_row gt_right">4242</td>
<td class="gt_row gt_right">70278</td>
<td class="gt_row gt_right">4950</td>
<td class="gt_row gt_right">11103</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.3874659</td>
<td class="gt_row gt_right">257.84959</td>
<td class="gt_row gt_right">38.256131</td>
<td class="gt_row gt_right">129.84523</td>
<td class="gt_row gt_right">88.68065</td>
<td class="gt_row gt_right">41.082289</td>
<td class="gt_row gt_right">2.31171662</td>
<td class="gt_row gt_right">38.29864</td>
<td class="gt_row gt_right">2.6975477</td>
<td class="gt_row gt_right">6.0506812</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(3년제)</td>
<td class="gt_row gt_right">3095</td>
<td class="gt_row gt_right">603197</td>
<td class="gt_row gt_right">87333</td>
<td class="gt_row gt_right">304435</td>
<td class="gt_row gt_right">213105</td>
<td class="gt_row gt_right">91162</td>
<td class="gt_row gt_right">4495</td>
<td class="gt_row gt_right">83819</td>
<td class="gt_row gt_right">6298</td>
<td class="gt_row gt_right">12866</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.6775068</td>
<td class="gt_row gt_right">326.93604</td>
<td class="gt_row gt_right">47.334959</td>
<td class="gt_row gt_right">165.00542</td>
<td class="gt_row gt_right">115.50407</td>
<td class="gt_row gt_right">49.410298</td>
<td class="gt_row gt_right">2.43631436</td>
<td class="gt_row gt_right">45.43035</td>
<td class="gt_row gt_right">3.4135501</td>
<td class="gt_row gt_right">6.9734417</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(4년제)</td>
<td class="gt_row gt_right">317</td>
<td class="gt_row gt_right">63559</td>
<td class="gt_row gt_right">9174</td>
<td class="gt_row gt_right">33340</td>
<td class="gt_row gt_right">24242</td>
<td class="gt_row gt_right">9077</td>
<td class="gt_row gt_right">280</td>
<td class="gt_row gt_right">9375</td>
<td class="gt_row gt_right">780</td>
<td class="gt_row gt_right">1541</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.1362007</td>
<td class="gt_row gt_right">227.81004</td>
<td class="gt_row gt_right">32.881720</td>
<td class="gt_row gt_right">119.49821</td>
<td class="gt_row gt_right">86.88889</td>
<td class="gt_row gt_right">32.534050</td>
<td class="gt_row gt_right">1.00358423</td>
<td class="gt_row gt_right">33.60215</td>
<td class="gt_row gt_right">2.7956989</td>
<td class="gt_row gt_right">5.5232975</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_left gt_stub">기능대학</td>
<td class="gt_row gt_right">263</td>
<td class="gt_row gt_right">19102</td>
<td class="gt_row gt_right">7565</td>
<td class="gt_row gt_right">23910</td>
<td class="gt_row gt_right">14860</td>
<td class="gt_row gt_right">9050</td>
<td class="gt_row gt_right">9</td>
<td class="gt_row gt_right">7284</td>
<td class="gt_row gt_right">863</td>
<td class="gt_row gt_right">844</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.4858757</td>
<td class="gt_row gt_right">107.92090</td>
<td class="gt_row gt_right">42.740113</td>
<td class="gt_row gt_right">135.08475</td>
<td class="gt_row gt_right">83.95480</td>
<td class="gt_row gt_right">51.129944</td>
<td class="gt_row gt_right">0.05084746</td>
<td class="gt_row gt_right">41.15254</td>
<td class="gt_row gt_right">4.8757062</td>
<td class="gt_row gt_right">4.7683616</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">대학원과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">일반대학원</td>
<td class="gt_row gt_right">10076</td>
<td class="gt_row gt_right">121226</td>
<td class="gt_row gt_right">69928</td>
<td class="gt_row gt_right">161987</td>
<td class="gt_row gt_right">143965</td>
<td class="gt_row gt_right">18022</td>
<td class="gt_row gt_right">28099</td>
<td class="gt_row gt_right">45978</td>
<td class="gt_row gt_right">2420</td>
<td class="gt_row gt_right">3703</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">2.6501841</td>
<td class="gt_row gt_right">31.88480</td>
<td class="gt_row gt_right">18.392425</td>
<td class="gt_row gt_right">42.60573</td>
<td class="gt_row gt_right">37.86560</td>
<td class="gt_row gt_right">4.740137</td>
<td class="gt_row gt_right">7.39058390</td>
<td class="gt_row gt_right">12.09311</td>
<td class="gt_row gt_right">0.6365071</td>
<td class="gt_row gt_right">0.9739611</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_left gt_stub">특수대학원</td>
<td class="gt_row gt_right">4351</td>
<td class="gt_row gt_right">84377</td>
<td class="gt_row gt_right">45448</td>
<td class="gt_row gt_right">124912</td>
<td class="gt_row gt_right">107537</td>
<td class="gt_row gt_right">17375</td>
<td class="gt_row gt_right">6220</td>
<td class="gt_row gt_right">38435</td>
<td class="gt_row gt_right">978</td>
<td class="gt_row gt_right">7421</td>
<td class="gt_row gt_right">4</td>
<td class="gt_row gt_right">1.6550019</td>
<td class="gt_row gt_right">32.09471</td>
<td class="gt_row gt_right">17.287181</td>
<td class="gt_row gt_right">47.51312</td>
<td class="gt_row gt_right">40.90415</td>
<td class="gt_row gt_right">6.608977</td>
<td class="gt_row gt_right">2.36591860</td>
<td class="gt_row gt_right">14.61963</td>
<td class="gt_row gt_right">0.3720046</td>
<td class="gt_row gt_right">2.8227463</td>
<td class="gt_row gt_right">0.001521491</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학원</td>
<td class="gt_row gt_right">1088</td>
<td class="gt_row gt_right">39141</td>
<td class="gt_row gt_right">15556</td>
<td class="gt_row gt_right">40516</td>
<td class="gt_row gt_right">36108</td>
<td class="gt_row gt_right">4408</td>
<td class="gt_row gt_right">5102</td>
<td class="gt_row gt_right">12037</td>
<td class="gt_row gt_right">4320</td>
<td class="gt_row gt_right">4095</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.5432624</td>
<td class="gt_row gt_right">55.51915</td>
<td class="gt_row gt_right">22.065248</td>
<td class="gt_row gt_right">57.46950</td>
<td class="gt_row gt_right">51.21702</td>
<td class="gt_row gt_right">6.252482</td>
<td class="gt_row gt_right">7.23687943</td>
<td class="gt_row gt_right">17.07376</td>
<td class="gt_row gt_right">6.1276596</td>
<td class="gt_row gt_right">5.8085106</td>
<td class="gt_row gt_right">0.000000000</td></tr>
  </tbody>
  
  
</table>
</div><!--/html_preserve-->

이제 표의 각 부분을 설정한다. 먼저 표의 제목부터 설정한다. `tab_header()`를 사용하여 `title` 매개변수로 표 제목을 설정하고 `subtitle`을 사용하여 표 부제목을 설정할 수 있다.


```r
gt.table2 <- gt.table1 |> 
  tab_header(title = '고등교육기관 데이터', subtitle = '2021년 전체 고등교육기관 대상')
```

<!--html_preserve--><div id="rmoiffgdls" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#rmoiffgdls .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 10px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#rmoiffgdls .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#rmoiffgdls .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#rmoiffgdls .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#rmoiffgdls .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rmoiffgdls .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#rmoiffgdls .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#rmoiffgdls .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#rmoiffgdls .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#rmoiffgdls .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#rmoiffgdls .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#rmoiffgdls .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#rmoiffgdls .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#rmoiffgdls .gt_from_md > :first-child {
  margin-top: 0;
}

#rmoiffgdls .gt_from_md > :last-child {
  margin-bottom: 0;
}

#rmoiffgdls .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#rmoiffgdls .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#rmoiffgdls .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rmoiffgdls .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#rmoiffgdls .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#rmoiffgdls .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#rmoiffgdls .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#rmoiffgdls .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#rmoiffgdls .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#rmoiffgdls .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#rmoiffgdls .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#rmoiffgdls .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#rmoiffgdls .gt_left {
  text-align: left;
}

#rmoiffgdls .gt_center {
  text-align: center;
}

#rmoiffgdls .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#rmoiffgdls .gt_font_normal {
  font-weight: normal;
}

#rmoiffgdls .gt_font_bold {
  font-weight: bold;
}

#rmoiffgdls .gt_font_italic {
  font-style: italic;
}

#rmoiffgdls .gt_super {
  font-size: 65%;
}

#rmoiffgdls .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 65%;
}
</style>
<table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="23" class="gt_heading gt_title gt_font_normal" style>고등교육기관 데이터</th>
    </tr>
    <tr>
      <th colspan="23" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style>2021년 전체 고등교육기관 대상</th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1"></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">학과수_전체_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">지원자_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">입학자_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재적생_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재학생_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">휴학생_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">외국인유학생_총계_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">졸업자_전체_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">전임교원_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">비전임교원_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">시간강사_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">학과수_전체_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">지원자_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">입학자_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재적생_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재학생_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">휴학생_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">외국인유학생_총계_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">졸업자_전체_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">전임교원_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">비전임교원_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">시간강사_계_mean</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">대학과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">대학교</td>
<td class="gt_row gt_right">12028</td>
<td class="gt_row gt_right">2635154</td>
<td class="gt_row gt_right">329306</td>
<td class="gt_row gt_right">1938254</td>
<td class="gt_row gt_right">1415162</td>
<td class="gt_row gt_right">504165</td>
<td class="gt_row gt_right">69888</td>
<td class="gt_row gt_right">325432</td>
<td class="gt_row gt_right">67473</td>
<td class="gt_row gt_right">86857</td>
<td class="gt_row gt_right">79</td>
<td class="gt_row gt_right">1.4895356</td>
<td class="gt_row gt_right">326.33486</td>
<td class="gt_row gt_right">40.780929</td>
<td class="gt_row gt_right">240.03146</td>
<td class="gt_row gt_right">175.25226</td>
<td class="gt_row gt_right">62.435294</td>
<td class="gt_row gt_right">8.65486068</td>
<td class="gt_row gt_right">40.30118</td>
<td class="gt_row gt_right">8.3557895</td>
<td class="gt_row gt_right">10.7562848</td>
<td class="gt_row gt_right">0.009783282</td></tr>
    <tr><td class="gt_row gt_left gt_stub">교육대학</td>
<td class="gt_row gt_right">140</td>
<td class="gt_row gt_right">15805</td>
<td class="gt_row gt_right">3864</td>
<td class="gt_row gt_right">15409</td>
<td class="gt_row gt_right">15045</td>
<td class="gt_row gt_right">364</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">3818</td>
<td class="gt_row gt_right">833</td>
<td class="gt_row gt_right">1481</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">2.3333333</td>
<td class="gt_row gt_right">263.41667</td>
<td class="gt_row gt_right">64.400000</td>
<td class="gt_row gt_right">256.81667</td>
<td class="gt_row gt_right">250.75000</td>
<td class="gt_row gt_right">6.066667</td>
<td class="gt_row gt_right">0.00000000</td>
<td class="gt_row gt_right">63.63333</td>
<td class="gt_row gt_right">13.8833333</td>
<td class="gt_row gt_right">24.6833333</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_left gt_stub">산업대학</td>
<td class="gt_row gt_right">251</td>
<td class="gt_row gt_right">22128</td>
<td class="gt_row gt_right">2379</td>
<td class="gt_row gt_right">14539</td>
<td class="gt_row gt_right">11076</td>
<td class="gt_row gt_right">3374</td>
<td class="gt_row gt_right">180</td>
<td class="gt_row gt_right">2704</td>
<td class="gt_row gt_right">350</td>
<td class="gt_row gt_right">707</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.0244898</td>
<td class="gt_row gt_right">90.31837</td>
<td class="gt_row gt_right">9.710204</td>
<td class="gt_row gt_right">59.34286</td>
<td class="gt_row gt_right">45.20816</td>
<td class="gt_row gt_right">13.771429</td>
<td class="gt_row gt_right">0.73469388</td>
<td class="gt_row gt_right">11.03673</td>
<td class="gt_row gt_right">1.4285714</td>
<td class="gt_row gt_right">2.8857143</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_left gt_stub">사이버대학(대학)</td>
<td class="gt_row gt_right">357</td>
<td class="gt_row gt_right">51840</td>
<td class="gt_row gt_right">34279</td>
<td class="gt_row gt_right">135155</td>
<td class="gt_row gt_right">119995</td>
<td class="gt_row gt_right">15160</td>
<td class="gt_row gt_right">886</td>
<td class="gt_row gt_right">27215</td>
<td class="gt_row gt_right">569</td>
<td class="gt_row gt_right">3377</td>
<td class="gt_row gt_right">2</td>
<td class="gt_row gt_right">0.8321678</td>
<td class="gt_row gt_right">120.83916</td>
<td class="gt_row gt_right">79.904429</td>
<td class="gt_row gt_right">315.04662</td>
<td class="gt_row gt_right">279.70862</td>
<td class="gt_row gt_right">35.337995</td>
<td class="gt_row gt_right">2.06526807</td>
<td class="gt_row gt_right">63.43823</td>
<td class="gt_row gt_right">1.3263403</td>
<td class="gt_row gt_right">7.8717949</td>
<td class="gt_row gt_right">0.004662005</td></tr>
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">전문대학과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(2년제)</td>
<td class="gt_row gt_right">2546</td>
<td class="gt_row gt_right">473154</td>
<td class="gt_row gt_right">70200</td>
<td class="gt_row gt_right">238266</td>
<td class="gt_row gt_right">162729</td>
<td class="gt_row gt_right">75386</td>
<td class="gt_row gt_right">4242</td>
<td class="gt_row gt_right">70278</td>
<td class="gt_row gt_right">4950</td>
<td class="gt_row gt_right">11103</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.3874659</td>
<td class="gt_row gt_right">257.84959</td>
<td class="gt_row gt_right">38.256131</td>
<td class="gt_row gt_right">129.84523</td>
<td class="gt_row gt_right">88.68065</td>
<td class="gt_row gt_right">41.082289</td>
<td class="gt_row gt_right">2.31171662</td>
<td class="gt_row gt_right">38.29864</td>
<td class="gt_row gt_right">2.6975477</td>
<td class="gt_row gt_right">6.0506812</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(3년제)</td>
<td class="gt_row gt_right">3095</td>
<td class="gt_row gt_right">603197</td>
<td class="gt_row gt_right">87333</td>
<td class="gt_row gt_right">304435</td>
<td class="gt_row gt_right">213105</td>
<td class="gt_row gt_right">91162</td>
<td class="gt_row gt_right">4495</td>
<td class="gt_row gt_right">83819</td>
<td class="gt_row gt_right">6298</td>
<td class="gt_row gt_right">12866</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.6775068</td>
<td class="gt_row gt_right">326.93604</td>
<td class="gt_row gt_right">47.334959</td>
<td class="gt_row gt_right">165.00542</td>
<td class="gt_row gt_right">115.50407</td>
<td class="gt_row gt_right">49.410298</td>
<td class="gt_row gt_right">2.43631436</td>
<td class="gt_row gt_right">45.43035</td>
<td class="gt_row gt_right">3.4135501</td>
<td class="gt_row gt_right">6.9734417</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(4년제)</td>
<td class="gt_row gt_right">317</td>
<td class="gt_row gt_right">63559</td>
<td class="gt_row gt_right">9174</td>
<td class="gt_row gt_right">33340</td>
<td class="gt_row gt_right">24242</td>
<td class="gt_row gt_right">9077</td>
<td class="gt_row gt_right">280</td>
<td class="gt_row gt_right">9375</td>
<td class="gt_row gt_right">780</td>
<td class="gt_row gt_right">1541</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.1362007</td>
<td class="gt_row gt_right">227.81004</td>
<td class="gt_row gt_right">32.881720</td>
<td class="gt_row gt_right">119.49821</td>
<td class="gt_row gt_right">86.88889</td>
<td class="gt_row gt_right">32.534050</td>
<td class="gt_row gt_right">1.00358423</td>
<td class="gt_row gt_right">33.60215</td>
<td class="gt_row gt_right">2.7956989</td>
<td class="gt_row gt_right">5.5232975</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_left gt_stub">기능대학</td>
<td class="gt_row gt_right">263</td>
<td class="gt_row gt_right">19102</td>
<td class="gt_row gt_right">7565</td>
<td class="gt_row gt_right">23910</td>
<td class="gt_row gt_right">14860</td>
<td class="gt_row gt_right">9050</td>
<td class="gt_row gt_right">9</td>
<td class="gt_row gt_right">7284</td>
<td class="gt_row gt_right">863</td>
<td class="gt_row gt_right">844</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.4858757</td>
<td class="gt_row gt_right">107.92090</td>
<td class="gt_row gt_right">42.740113</td>
<td class="gt_row gt_right">135.08475</td>
<td class="gt_row gt_right">83.95480</td>
<td class="gt_row gt_right">51.129944</td>
<td class="gt_row gt_right">0.05084746</td>
<td class="gt_row gt_right">41.15254</td>
<td class="gt_row gt_right">4.8757062</td>
<td class="gt_row gt_right">4.7683616</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">대학원과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">일반대학원</td>
<td class="gt_row gt_right">10076</td>
<td class="gt_row gt_right">121226</td>
<td class="gt_row gt_right">69928</td>
<td class="gt_row gt_right">161987</td>
<td class="gt_row gt_right">143965</td>
<td class="gt_row gt_right">18022</td>
<td class="gt_row gt_right">28099</td>
<td class="gt_row gt_right">45978</td>
<td class="gt_row gt_right">2420</td>
<td class="gt_row gt_right">3703</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">2.6501841</td>
<td class="gt_row gt_right">31.88480</td>
<td class="gt_row gt_right">18.392425</td>
<td class="gt_row gt_right">42.60573</td>
<td class="gt_row gt_right">37.86560</td>
<td class="gt_row gt_right">4.740137</td>
<td class="gt_row gt_right">7.39058390</td>
<td class="gt_row gt_right">12.09311</td>
<td class="gt_row gt_right">0.6365071</td>
<td class="gt_row gt_right">0.9739611</td>
<td class="gt_row gt_right">0.000000000</td></tr>
    <tr><td class="gt_row gt_left gt_stub">특수대학원</td>
<td class="gt_row gt_right">4351</td>
<td class="gt_row gt_right">84377</td>
<td class="gt_row gt_right">45448</td>
<td class="gt_row gt_right">124912</td>
<td class="gt_row gt_right">107537</td>
<td class="gt_row gt_right">17375</td>
<td class="gt_row gt_right">6220</td>
<td class="gt_row gt_right">38435</td>
<td class="gt_row gt_right">978</td>
<td class="gt_row gt_right">7421</td>
<td class="gt_row gt_right">4</td>
<td class="gt_row gt_right">1.6550019</td>
<td class="gt_row gt_right">32.09471</td>
<td class="gt_row gt_right">17.287181</td>
<td class="gt_row gt_right">47.51312</td>
<td class="gt_row gt_right">40.90415</td>
<td class="gt_row gt_right">6.608977</td>
<td class="gt_row gt_right">2.36591860</td>
<td class="gt_row gt_right">14.61963</td>
<td class="gt_row gt_right">0.3720046</td>
<td class="gt_row gt_right">2.8227463</td>
<td class="gt_row gt_right">0.001521491</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학원</td>
<td class="gt_row gt_right">1088</td>
<td class="gt_row gt_right">39141</td>
<td class="gt_row gt_right">15556</td>
<td class="gt_row gt_right">40516</td>
<td class="gt_row gt_right">36108</td>
<td class="gt_row gt_right">4408</td>
<td class="gt_row gt_right">5102</td>
<td class="gt_row gt_right">12037</td>
<td class="gt_row gt_right">4320</td>
<td class="gt_row gt_right">4095</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.5432624</td>
<td class="gt_row gt_right">55.51915</td>
<td class="gt_row gt_right">22.065248</td>
<td class="gt_row gt_right">57.46950</td>
<td class="gt_row gt_right">51.21702</td>
<td class="gt_row gt_right">6.252482</td>
<td class="gt_row gt_right">7.23687943</td>
<td class="gt_row gt_right">17.07376</td>
<td class="gt_row gt_right">6.1276596</td>
<td class="gt_row gt_right">5.8085106</td>
<td class="gt_row gt_right">0.000000000</td></tr>
  </tbody>
  
  
</table>
</div><!--/html_preserve-->

다음으로 각각의 셀에 표현되는 수치값의 형태를 설정한다. 합계값은 모두 소수점이하가 필요없고 평균값도 사실 소수점 한자리 이상 표현될 필요는 없을 듯 하다. `gt` 표 각 셀의 숫자 형태는 `fmt_number()`를 사용한다.


```r
gt.table3 <- gt.table2 |> 
  fmt_number(columns = 3:13, decimals = 0, use_seps = TRUE) |>
  fmt_number(columns = 14:24, decimals = 1, use_seps = TRUE)
```

<!--html_preserve--><div id="ispasximdf" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#ispasximdf .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 10px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#ispasximdf .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#ispasximdf .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#ispasximdf .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#ispasximdf .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ispasximdf .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#ispasximdf .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#ispasximdf .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#ispasximdf .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#ispasximdf .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#ispasximdf .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#ispasximdf .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#ispasximdf .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#ispasximdf .gt_from_md > :first-child {
  margin-top: 0;
}

#ispasximdf .gt_from_md > :last-child {
  margin-bottom: 0;
}

#ispasximdf .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#ispasximdf .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#ispasximdf .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ispasximdf .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#ispasximdf .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#ispasximdf .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#ispasximdf .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#ispasximdf .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#ispasximdf .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#ispasximdf .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#ispasximdf .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#ispasximdf .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#ispasximdf .gt_left {
  text-align: left;
}

#ispasximdf .gt_center {
  text-align: center;
}

#ispasximdf .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#ispasximdf .gt_font_normal {
  font-weight: normal;
}

#ispasximdf .gt_font_bold {
  font-weight: bold;
}

#ispasximdf .gt_font_italic {
  font-style: italic;
}

#ispasximdf .gt_super {
  font-size: 65%;
}

#ispasximdf .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 65%;
}
</style>
<table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="23" class="gt_heading gt_title gt_font_normal" style>고등교육기관 데이터</th>
    </tr>
    <tr>
      <th colspan="23" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style>2021년 전체 고등교육기관 대상</th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1"></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">학과수_전체_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">지원자_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">입학자_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재적생_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재학생_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">휴학생_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">외국인유학생_총계_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">졸업자_전체_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">전임교원_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">비전임교원_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">시간강사_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">학과수_전체_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">지원자_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">입학자_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재적생_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재학생_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">휴학생_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">외국인유학생_총계_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">졸업자_전체_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">전임교원_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">비전임교원_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">시간강사_계_mean</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">대학과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">대학교</td>
<td class="gt_row gt_right">12,028</td>
<td class="gt_row gt_right">2,635,154</td>
<td class="gt_row gt_right">329,306</td>
<td class="gt_row gt_right">1,938,254</td>
<td class="gt_row gt_right">1,415,162</td>
<td class="gt_row gt_right">504,165</td>
<td class="gt_row gt_right">69,888</td>
<td class="gt_row gt_right">325,432</td>
<td class="gt_row gt_right">67,473</td>
<td class="gt_row gt_right">86,857</td>
<td class="gt_row gt_right">79</td>
<td class="gt_row gt_right">1.5</td>
<td class="gt_row gt_right">326.3</td>
<td class="gt_row gt_right">40.8</td>
<td class="gt_row gt_right">240.0</td>
<td class="gt_row gt_right">175.3</td>
<td class="gt_row gt_right">62.4</td>
<td class="gt_row gt_right">8.7</td>
<td class="gt_row gt_right">40.3</td>
<td class="gt_row gt_right">8.4</td>
<td class="gt_row gt_right">10.8</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">교육대학</td>
<td class="gt_row gt_right">140</td>
<td class="gt_row gt_right">15,805</td>
<td class="gt_row gt_right">3,864</td>
<td class="gt_row gt_right">15,409</td>
<td class="gt_row gt_right">15,045</td>
<td class="gt_row gt_right">364</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">3,818</td>
<td class="gt_row gt_right">833</td>
<td class="gt_row gt_right">1,481</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">2.3</td>
<td class="gt_row gt_right">263.4</td>
<td class="gt_row gt_right">64.4</td>
<td class="gt_row gt_right">256.8</td>
<td class="gt_row gt_right">250.8</td>
<td class="gt_row gt_right">6.1</td>
<td class="gt_row gt_right">0.0</td>
<td class="gt_row gt_right">63.6</td>
<td class="gt_row gt_right">13.9</td>
<td class="gt_row gt_right">24.7</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">산업대학</td>
<td class="gt_row gt_right">251</td>
<td class="gt_row gt_right">22,128</td>
<td class="gt_row gt_right">2,379</td>
<td class="gt_row gt_right">14,539</td>
<td class="gt_row gt_right">11,076</td>
<td class="gt_row gt_right">3,374</td>
<td class="gt_row gt_right">180</td>
<td class="gt_row gt_right">2,704</td>
<td class="gt_row gt_right">350</td>
<td class="gt_row gt_right">707</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.0</td>
<td class="gt_row gt_right">90.3</td>
<td class="gt_row gt_right">9.7</td>
<td class="gt_row gt_right">59.3</td>
<td class="gt_row gt_right">45.2</td>
<td class="gt_row gt_right">13.8</td>
<td class="gt_row gt_right">0.7</td>
<td class="gt_row gt_right">11.0</td>
<td class="gt_row gt_right">1.4</td>
<td class="gt_row gt_right">2.9</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">사이버대학(대학)</td>
<td class="gt_row gt_right">357</td>
<td class="gt_row gt_right">51,840</td>
<td class="gt_row gt_right">34,279</td>
<td class="gt_row gt_right">135,155</td>
<td class="gt_row gt_right">119,995</td>
<td class="gt_row gt_right">15,160</td>
<td class="gt_row gt_right">886</td>
<td class="gt_row gt_right">27,215</td>
<td class="gt_row gt_right">569</td>
<td class="gt_row gt_right">3,377</td>
<td class="gt_row gt_right">2</td>
<td class="gt_row gt_right">0.8</td>
<td class="gt_row gt_right">120.8</td>
<td class="gt_row gt_right">79.9</td>
<td class="gt_row gt_right">315.0</td>
<td class="gt_row gt_right">279.7</td>
<td class="gt_row gt_right">35.3</td>
<td class="gt_row gt_right">2.1</td>
<td class="gt_row gt_right">63.4</td>
<td class="gt_row gt_right">1.3</td>
<td class="gt_row gt_right">7.9</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">전문대학과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(2년제)</td>
<td class="gt_row gt_right">2,546</td>
<td class="gt_row gt_right">473,154</td>
<td class="gt_row gt_right">70,200</td>
<td class="gt_row gt_right">238,266</td>
<td class="gt_row gt_right">162,729</td>
<td class="gt_row gt_right">75,386</td>
<td class="gt_row gt_right">4,242</td>
<td class="gt_row gt_right">70,278</td>
<td class="gt_row gt_right">4,950</td>
<td class="gt_row gt_right">11,103</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.4</td>
<td class="gt_row gt_right">257.8</td>
<td class="gt_row gt_right">38.3</td>
<td class="gt_row gt_right">129.8</td>
<td class="gt_row gt_right">88.7</td>
<td class="gt_row gt_right">41.1</td>
<td class="gt_row gt_right">2.3</td>
<td class="gt_row gt_right">38.3</td>
<td class="gt_row gt_right">2.7</td>
<td class="gt_row gt_right">6.1</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(3년제)</td>
<td class="gt_row gt_right">3,095</td>
<td class="gt_row gt_right">603,197</td>
<td class="gt_row gt_right">87,333</td>
<td class="gt_row gt_right">304,435</td>
<td class="gt_row gt_right">213,105</td>
<td class="gt_row gt_right">91,162</td>
<td class="gt_row gt_right">4,495</td>
<td class="gt_row gt_right">83,819</td>
<td class="gt_row gt_right">6,298</td>
<td class="gt_row gt_right">12,866</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.7</td>
<td class="gt_row gt_right">326.9</td>
<td class="gt_row gt_right">47.3</td>
<td class="gt_row gt_right">165.0</td>
<td class="gt_row gt_right">115.5</td>
<td class="gt_row gt_right">49.4</td>
<td class="gt_row gt_right">2.4</td>
<td class="gt_row gt_right">45.4</td>
<td class="gt_row gt_right">3.4</td>
<td class="gt_row gt_right">7.0</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(4년제)</td>
<td class="gt_row gt_right">317</td>
<td class="gt_row gt_right">63,559</td>
<td class="gt_row gt_right">9,174</td>
<td class="gt_row gt_right">33,340</td>
<td class="gt_row gt_right">24,242</td>
<td class="gt_row gt_right">9,077</td>
<td class="gt_row gt_right">280</td>
<td class="gt_row gt_right">9,375</td>
<td class="gt_row gt_right">780</td>
<td class="gt_row gt_right">1,541</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.1</td>
<td class="gt_row gt_right">227.8</td>
<td class="gt_row gt_right">32.9</td>
<td class="gt_row gt_right">119.5</td>
<td class="gt_row gt_right">86.9</td>
<td class="gt_row gt_right">32.5</td>
<td class="gt_row gt_right">1.0</td>
<td class="gt_row gt_right">33.6</td>
<td class="gt_row gt_right">2.8</td>
<td class="gt_row gt_right">5.5</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">기능대학</td>
<td class="gt_row gt_right">263</td>
<td class="gt_row gt_right">19,102</td>
<td class="gt_row gt_right">7,565</td>
<td class="gt_row gt_right">23,910</td>
<td class="gt_row gt_right">14,860</td>
<td class="gt_row gt_right">9,050</td>
<td class="gt_row gt_right">9</td>
<td class="gt_row gt_right">7,284</td>
<td class="gt_row gt_right">863</td>
<td class="gt_row gt_right">844</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.5</td>
<td class="gt_row gt_right">107.9</td>
<td class="gt_row gt_right">42.7</td>
<td class="gt_row gt_right">135.1</td>
<td class="gt_row gt_right">84.0</td>
<td class="gt_row gt_right">51.1</td>
<td class="gt_row gt_right">0.1</td>
<td class="gt_row gt_right">41.2</td>
<td class="gt_row gt_right">4.9</td>
<td class="gt_row gt_right">4.8</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">대학원과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">일반대학원</td>
<td class="gt_row gt_right">10,076</td>
<td class="gt_row gt_right">121,226</td>
<td class="gt_row gt_right">69,928</td>
<td class="gt_row gt_right">161,987</td>
<td class="gt_row gt_right">143,965</td>
<td class="gt_row gt_right">18,022</td>
<td class="gt_row gt_right">28,099</td>
<td class="gt_row gt_right">45,978</td>
<td class="gt_row gt_right">2,420</td>
<td class="gt_row gt_right">3,703</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">2.7</td>
<td class="gt_row gt_right">31.9</td>
<td class="gt_row gt_right">18.4</td>
<td class="gt_row gt_right">42.6</td>
<td class="gt_row gt_right">37.9</td>
<td class="gt_row gt_right">4.7</td>
<td class="gt_row gt_right">7.4</td>
<td class="gt_row gt_right">12.1</td>
<td class="gt_row gt_right">0.6</td>
<td class="gt_row gt_right">1.0</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">특수대학원</td>
<td class="gt_row gt_right">4,351</td>
<td class="gt_row gt_right">84,377</td>
<td class="gt_row gt_right">45,448</td>
<td class="gt_row gt_right">124,912</td>
<td class="gt_row gt_right">107,537</td>
<td class="gt_row gt_right">17,375</td>
<td class="gt_row gt_right">6,220</td>
<td class="gt_row gt_right">38,435</td>
<td class="gt_row gt_right">978</td>
<td class="gt_row gt_right">7,421</td>
<td class="gt_row gt_right">4</td>
<td class="gt_row gt_right">1.7</td>
<td class="gt_row gt_right">32.1</td>
<td class="gt_row gt_right">17.3</td>
<td class="gt_row gt_right">47.5</td>
<td class="gt_row gt_right">40.9</td>
<td class="gt_row gt_right">6.6</td>
<td class="gt_row gt_right">2.4</td>
<td class="gt_row gt_right">14.6</td>
<td class="gt_row gt_right">0.4</td>
<td class="gt_row gt_right">2.8</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학원</td>
<td class="gt_row gt_right">1,088</td>
<td class="gt_row gt_right">39,141</td>
<td class="gt_row gt_right">15,556</td>
<td class="gt_row gt_right">40,516</td>
<td class="gt_row gt_right">36,108</td>
<td class="gt_row gt_right">4,408</td>
<td class="gt_row gt_right">5,102</td>
<td class="gt_row gt_right">12,037</td>
<td class="gt_row gt_right">4,320</td>
<td class="gt_row gt_right">4,095</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.5</td>
<td class="gt_row gt_right">55.5</td>
<td class="gt_row gt_right">22.1</td>
<td class="gt_row gt_right">57.5</td>
<td class="gt_row gt_right">51.2</td>
<td class="gt_row gt_right">6.3</td>
<td class="gt_row gt_right">7.2</td>
<td class="gt_row gt_right">17.1</td>
<td class="gt_row gt_right">6.1</td>
<td class="gt_row gt_right">5.8</td>
<td class="gt_row gt_right">0.0</td></tr>
  </tbody>
  
  
</table>
</div><!--/html_preserve-->

표의 몸체(Body)는 적절히 보기좋게 설정된 듯 하다. 그런데 헤더의 열 이름이 사용자 친화적이지 않은 느낌이다. 열의 절반은 합계값이고 절반은 평균값이다. 이를 매 열마다 반복하면 열 이름이 쓸데없이 길어진다. 합계와 평균을 나타내는 열들 묶어(Span) 표기해주는 함수는 `tab_spanner()`이다.


```r
gt.table4 <- gt.table3 |> 
  tab_spanner(columns = 3:14, label = '합계') |>
  tab_spanner(columns = 14:24, label = '평균')
```

<!--html_preserve--><div id="lvpwwpxyia" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#lvpwwpxyia .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 10px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#lvpwwpxyia .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#lvpwwpxyia .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#lvpwwpxyia .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#lvpwwpxyia .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#lvpwwpxyia .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#lvpwwpxyia .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#lvpwwpxyia .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#lvpwwpxyia .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#lvpwwpxyia .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#lvpwwpxyia .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#lvpwwpxyia .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#lvpwwpxyia .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#lvpwwpxyia .gt_from_md > :first-child {
  margin-top: 0;
}

#lvpwwpxyia .gt_from_md > :last-child {
  margin-bottom: 0;
}

#lvpwwpxyia .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#lvpwwpxyia .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#lvpwwpxyia .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#lvpwwpxyia .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#lvpwwpxyia .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#lvpwwpxyia .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#lvpwwpxyia .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#lvpwwpxyia .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#lvpwwpxyia .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#lvpwwpxyia .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#lvpwwpxyia .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#lvpwwpxyia .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#lvpwwpxyia .gt_left {
  text-align: left;
}

#lvpwwpxyia .gt_center {
  text-align: center;
}

#lvpwwpxyia .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#lvpwwpxyia .gt_font_normal {
  font-weight: normal;
}

#lvpwwpxyia .gt_font_bold {
  font-weight: bold;
}

#lvpwwpxyia .gt_font_italic {
  font-style: italic;
}

#lvpwwpxyia .gt_super {
  font-size: 65%;
}

#lvpwwpxyia .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 65%;
}
</style>
<table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="23" class="gt_heading gt_title gt_font_normal" style>고등교육기관 데이터</th>
    </tr>
    <tr>
      <th colspan="23" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style>2021년 전체 고등교육기관 대상</th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1"></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="11">
        <span class="gt_column_spanner">합계</span>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="11">
        <span class="gt_column_spanner">평균</span>
      </th>
    </tr>
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">학과수_전체_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">지원자_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">입학자_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재적생_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재학생_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">휴학생_전체_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">외국인유학생_총계_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">졸업자_전체_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">전임교원_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">비전임교원_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">시간강사_계_sum</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">학과수_전체_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">지원자_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">입학자_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재적생_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재학생_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">휴학생_전체_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">외국인유학생_총계_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">졸업자_전체_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">전임교원_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">비전임교원_계_mean</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">시간강사_계_mean</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">대학과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">대학교</td>
<td class="gt_row gt_right">12,028</td>
<td class="gt_row gt_right">2,635,154</td>
<td class="gt_row gt_right">329,306</td>
<td class="gt_row gt_right">1,938,254</td>
<td class="gt_row gt_right">1,415,162</td>
<td class="gt_row gt_right">504,165</td>
<td class="gt_row gt_right">69,888</td>
<td class="gt_row gt_right">325,432</td>
<td class="gt_row gt_right">67,473</td>
<td class="gt_row gt_right">86,857</td>
<td class="gt_row gt_right">79</td>
<td class="gt_row gt_right">1.5</td>
<td class="gt_row gt_right">326.3</td>
<td class="gt_row gt_right">40.8</td>
<td class="gt_row gt_right">240.0</td>
<td class="gt_row gt_right">175.3</td>
<td class="gt_row gt_right">62.4</td>
<td class="gt_row gt_right">8.7</td>
<td class="gt_row gt_right">40.3</td>
<td class="gt_row gt_right">8.4</td>
<td class="gt_row gt_right">10.8</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">교육대학</td>
<td class="gt_row gt_right">140</td>
<td class="gt_row gt_right">15,805</td>
<td class="gt_row gt_right">3,864</td>
<td class="gt_row gt_right">15,409</td>
<td class="gt_row gt_right">15,045</td>
<td class="gt_row gt_right">364</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">3,818</td>
<td class="gt_row gt_right">833</td>
<td class="gt_row gt_right">1,481</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">2.3</td>
<td class="gt_row gt_right">263.4</td>
<td class="gt_row gt_right">64.4</td>
<td class="gt_row gt_right">256.8</td>
<td class="gt_row gt_right">250.8</td>
<td class="gt_row gt_right">6.1</td>
<td class="gt_row gt_right">0.0</td>
<td class="gt_row gt_right">63.6</td>
<td class="gt_row gt_right">13.9</td>
<td class="gt_row gt_right">24.7</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">산업대학</td>
<td class="gt_row gt_right">251</td>
<td class="gt_row gt_right">22,128</td>
<td class="gt_row gt_right">2,379</td>
<td class="gt_row gt_right">14,539</td>
<td class="gt_row gt_right">11,076</td>
<td class="gt_row gt_right">3,374</td>
<td class="gt_row gt_right">180</td>
<td class="gt_row gt_right">2,704</td>
<td class="gt_row gt_right">350</td>
<td class="gt_row gt_right">707</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.0</td>
<td class="gt_row gt_right">90.3</td>
<td class="gt_row gt_right">9.7</td>
<td class="gt_row gt_right">59.3</td>
<td class="gt_row gt_right">45.2</td>
<td class="gt_row gt_right">13.8</td>
<td class="gt_row gt_right">0.7</td>
<td class="gt_row gt_right">11.0</td>
<td class="gt_row gt_right">1.4</td>
<td class="gt_row gt_right">2.9</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">사이버대학(대학)</td>
<td class="gt_row gt_right">357</td>
<td class="gt_row gt_right">51,840</td>
<td class="gt_row gt_right">34,279</td>
<td class="gt_row gt_right">135,155</td>
<td class="gt_row gt_right">119,995</td>
<td class="gt_row gt_right">15,160</td>
<td class="gt_row gt_right">886</td>
<td class="gt_row gt_right">27,215</td>
<td class="gt_row gt_right">569</td>
<td class="gt_row gt_right">3,377</td>
<td class="gt_row gt_right">2</td>
<td class="gt_row gt_right">0.8</td>
<td class="gt_row gt_right">120.8</td>
<td class="gt_row gt_right">79.9</td>
<td class="gt_row gt_right">315.0</td>
<td class="gt_row gt_right">279.7</td>
<td class="gt_row gt_right">35.3</td>
<td class="gt_row gt_right">2.1</td>
<td class="gt_row gt_right">63.4</td>
<td class="gt_row gt_right">1.3</td>
<td class="gt_row gt_right">7.9</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">전문대학과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(2년제)</td>
<td class="gt_row gt_right">2,546</td>
<td class="gt_row gt_right">473,154</td>
<td class="gt_row gt_right">70,200</td>
<td class="gt_row gt_right">238,266</td>
<td class="gt_row gt_right">162,729</td>
<td class="gt_row gt_right">75,386</td>
<td class="gt_row gt_right">4,242</td>
<td class="gt_row gt_right">70,278</td>
<td class="gt_row gt_right">4,950</td>
<td class="gt_row gt_right">11,103</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.4</td>
<td class="gt_row gt_right">257.8</td>
<td class="gt_row gt_right">38.3</td>
<td class="gt_row gt_right">129.8</td>
<td class="gt_row gt_right">88.7</td>
<td class="gt_row gt_right">41.1</td>
<td class="gt_row gt_right">2.3</td>
<td class="gt_row gt_right">38.3</td>
<td class="gt_row gt_right">2.7</td>
<td class="gt_row gt_right">6.1</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(3년제)</td>
<td class="gt_row gt_right">3,095</td>
<td class="gt_row gt_right">603,197</td>
<td class="gt_row gt_right">87,333</td>
<td class="gt_row gt_right">304,435</td>
<td class="gt_row gt_right">213,105</td>
<td class="gt_row gt_right">91,162</td>
<td class="gt_row gt_right">4,495</td>
<td class="gt_row gt_right">83,819</td>
<td class="gt_row gt_right">6,298</td>
<td class="gt_row gt_right">12,866</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.7</td>
<td class="gt_row gt_right">326.9</td>
<td class="gt_row gt_right">47.3</td>
<td class="gt_row gt_right">165.0</td>
<td class="gt_row gt_right">115.5</td>
<td class="gt_row gt_right">49.4</td>
<td class="gt_row gt_right">2.4</td>
<td class="gt_row gt_right">45.4</td>
<td class="gt_row gt_right">3.4</td>
<td class="gt_row gt_right">7.0</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(4년제)</td>
<td class="gt_row gt_right">317</td>
<td class="gt_row gt_right">63,559</td>
<td class="gt_row gt_right">9,174</td>
<td class="gt_row gt_right">33,340</td>
<td class="gt_row gt_right">24,242</td>
<td class="gt_row gt_right">9,077</td>
<td class="gt_row gt_right">280</td>
<td class="gt_row gt_right">9,375</td>
<td class="gt_row gt_right">780</td>
<td class="gt_row gt_right">1,541</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.1</td>
<td class="gt_row gt_right">227.8</td>
<td class="gt_row gt_right">32.9</td>
<td class="gt_row gt_right">119.5</td>
<td class="gt_row gt_right">86.9</td>
<td class="gt_row gt_right">32.5</td>
<td class="gt_row gt_right">1.0</td>
<td class="gt_row gt_right">33.6</td>
<td class="gt_row gt_right">2.8</td>
<td class="gt_row gt_right">5.5</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">기능대학</td>
<td class="gt_row gt_right">263</td>
<td class="gt_row gt_right">19,102</td>
<td class="gt_row gt_right">7,565</td>
<td class="gt_row gt_right">23,910</td>
<td class="gt_row gt_right">14,860</td>
<td class="gt_row gt_right">9,050</td>
<td class="gt_row gt_right">9</td>
<td class="gt_row gt_right">7,284</td>
<td class="gt_row gt_right">863</td>
<td class="gt_row gt_right">844</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.5</td>
<td class="gt_row gt_right">107.9</td>
<td class="gt_row gt_right">42.7</td>
<td class="gt_row gt_right">135.1</td>
<td class="gt_row gt_right">84.0</td>
<td class="gt_row gt_right">51.1</td>
<td class="gt_row gt_right">0.1</td>
<td class="gt_row gt_right">41.2</td>
<td class="gt_row gt_right">4.9</td>
<td class="gt_row gt_right">4.8</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">대학원과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">일반대학원</td>
<td class="gt_row gt_right">10,076</td>
<td class="gt_row gt_right">121,226</td>
<td class="gt_row gt_right">69,928</td>
<td class="gt_row gt_right">161,987</td>
<td class="gt_row gt_right">143,965</td>
<td class="gt_row gt_right">18,022</td>
<td class="gt_row gt_right">28,099</td>
<td class="gt_row gt_right">45,978</td>
<td class="gt_row gt_right">2,420</td>
<td class="gt_row gt_right">3,703</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">2.7</td>
<td class="gt_row gt_right">31.9</td>
<td class="gt_row gt_right">18.4</td>
<td class="gt_row gt_right">42.6</td>
<td class="gt_row gt_right">37.9</td>
<td class="gt_row gt_right">4.7</td>
<td class="gt_row gt_right">7.4</td>
<td class="gt_row gt_right">12.1</td>
<td class="gt_row gt_right">0.6</td>
<td class="gt_row gt_right">1.0</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">특수대학원</td>
<td class="gt_row gt_right">4,351</td>
<td class="gt_row gt_right">84,377</td>
<td class="gt_row gt_right">45,448</td>
<td class="gt_row gt_right">124,912</td>
<td class="gt_row gt_right">107,537</td>
<td class="gt_row gt_right">17,375</td>
<td class="gt_row gt_right">6,220</td>
<td class="gt_row gt_right">38,435</td>
<td class="gt_row gt_right">978</td>
<td class="gt_row gt_right">7,421</td>
<td class="gt_row gt_right">4</td>
<td class="gt_row gt_right">1.7</td>
<td class="gt_row gt_right">32.1</td>
<td class="gt_row gt_right">17.3</td>
<td class="gt_row gt_right">47.5</td>
<td class="gt_row gt_right">40.9</td>
<td class="gt_row gt_right">6.6</td>
<td class="gt_row gt_right">2.4</td>
<td class="gt_row gt_right">14.6</td>
<td class="gt_row gt_right">0.4</td>
<td class="gt_row gt_right">2.8</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학원</td>
<td class="gt_row gt_right">1,088</td>
<td class="gt_row gt_right">39,141</td>
<td class="gt_row gt_right">15,556</td>
<td class="gt_row gt_right">40,516</td>
<td class="gt_row gt_right">36,108</td>
<td class="gt_row gt_right">4,408</td>
<td class="gt_row gt_right">5,102</td>
<td class="gt_row gt_right">12,037</td>
<td class="gt_row gt_right">4,320</td>
<td class="gt_row gt_right">4,095</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.5</td>
<td class="gt_row gt_right">55.5</td>
<td class="gt_row gt_right">22.1</td>
<td class="gt_row gt_right">57.5</td>
<td class="gt_row gt_right">51.2</td>
<td class="gt_row gt_right">6.3</td>
<td class="gt_row gt_right">7.2</td>
<td class="gt_row gt_right">17.1</td>
<td class="gt_row gt_right">6.1</td>
<td class="gt_row gt_right">5.8</td>
<td class="gt_row gt_right">0.0</td></tr>
  </tbody>
  
  
</table>
</div><!--/html_preserve-->

이번에는 열 이름을 사용자가 알아보기 쉽게 바꾸어 준다. 열이름을 바꾸는 함수는 `cols_label()`이다.


```r
gt.table5 <- gt.table4 |> 
  cols_label(학제 = '학교종류', 
               학과수_전체_sum = '학과수', 
               지원자_전체_계_sum = '지원자',
               입학자_전체_계_sum = '입학자', 
               재적생_전체_계_sum = '재적생', 
               재학생_전체_계_sum = '재학생',
               휴학생_전체_계_sum = '휴학생', 
               외국인유학생_총계_계_sum = '외국인학생', 
               졸업자_전체_sum = '졸업자', 
               전임교원_계_sum = '전임교원', 
               비전임교원_계_sum = '비전임교원', 
               시간강사_계_sum = '시간강사', 
               학과수_전체_mean = '학과수', 
               지원자_전체_계_mean = '지원자',
               입학자_전체_계_mean = '입학자', 
               재적생_전체_계_mean = '재적생', 
               재학생_전체_계_mean = '재학생',
               휴학생_전체_계_mean = '휴학생', 
               외국인유학생_총계_계_mean = '외국인학생', 
               졸업자_전체_mean = '졸업자', 
               전임교원_계_mean = '전임교원', 
               비전임교원_계_mean = '비전임교원', 
               시간강사_계_mean = '시간강사'
  )
```

<!--html_preserve--><div id="kciygvdxmg" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#kciygvdxmg .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 10px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#kciygvdxmg .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#kciygvdxmg .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#kciygvdxmg .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#kciygvdxmg .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kciygvdxmg .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#kciygvdxmg .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#kciygvdxmg .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#kciygvdxmg .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#kciygvdxmg .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#kciygvdxmg .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#kciygvdxmg .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#kciygvdxmg .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#kciygvdxmg .gt_from_md > :first-child {
  margin-top: 0;
}

#kciygvdxmg .gt_from_md > :last-child {
  margin-bottom: 0;
}

#kciygvdxmg .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#kciygvdxmg .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#kciygvdxmg .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kciygvdxmg .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#kciygvdxmg .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kciygvdxmg .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#kciygvdxmg .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#kciygvdxmg .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kciygvdxmg .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#kciygvdxmg .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#kciygvdxmg .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#kciygvdxmg .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#kciygvdxmg .gt_left {
  text-align: left;
}

#kciygvdxmg .gt_center {
  text-align: center;
}

#kciygvdxmg .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#kciygvdxmg .gt_font_normal {
  font-weight: normal;
}

#kciygvdxmg .gt_font_bold {
  font-weight: bold;
}

#kciygvdxmg .gt_font_italic {
  font-style: italic;
}

#kciygvdxmg .gt_super {
  font-size: 65%;
}

#kciygvdxmg .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 65%;
}
</style>
<table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="23" class="gt_heading gt_title gt_font_normal" style>고등교육기관 데이터</th>
    </tr>
    <tr>
      <th colspan="23" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style>2021년 전체 고등교육기관 대상</th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1"></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="11">
        <span class="gt_column_spanner">합계</span>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="11">
        <span class="gt_column_spanner">평균</span>
      </th>
    </tr>
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">학과수</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">지원자</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">입학자</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재적생</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재학생</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">휴학생</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">외국인학생</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">졸업자</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">전임교원</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">비전임교원</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">시간강사</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">학과수</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">지원자</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">입학자</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재적생</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재학생</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">휴학생</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">외국인학생</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">졸업자</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">전임교원</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">비전임교원</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">시간강사</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">대학과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">대학교</td>
<td class="gt_row gt_right">12,028</td>
<td class="gt_row gt_right">2,635,154</td>
<td class="gt_row gt_right">329,306</td>
<td class="gt_row gt_right">1,938,254</td>
<td class="gt_row gt_right">1,415,162</td>
<td class="gt_row gt_right">504,165</td>
<td class="gt_row gt_right">69,888</td>
<td class="gt_row gt_right">325,432</td>
<td class="gt_row gt_right">67,473</td>
<td class="gt_row gt_right">86,857</td>
<td class="gt_row gt_right">79</td>
<td class="gt_row gt_right">1.5</td>
<td class="gt_row gt_right">326.3</td>
<td class="gt_row gt_right">40.8</td>
<td class="gt_row gt_right">240.0</td>
<td class="gt_row gt_right">175.3</td>
<td class="gt_row gt_right">62.4</td>
<td class="gt_row gt_right">8.7</td>
<td class="gt_row gt_right">40.3</td>
<td class="gt_row gt_right">8.4</td>
<td class="gt_row gt_right">10.8</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">교육대학</td>
<td class="gt_row gt_right">140</td>
<td class="gt_row gt_right">15,805</td>
<td class="gt_row gt_right">3,864</td>
<td class="gt_row gt_right">15,409</td>
<td class="gt_row gt_right">15,045</td>
<td class="gt_row gt_right">364</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">3,818</td>
<td class="gt_row gt_right">833</td>
<td class="gt_row gt_right">1,481</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">2.3</td>
<td class="gt_row gt_right">263.4</td>
<td class="gt_row gt_right">64.4</td>
<td class="gt_row gt_right">256.8</td>
<td class="gt_row gt_right">250.8</td>
<td class="gt_row gt_right">6.1</td>
<td class="gt_row gt_right">0.0</td>
<td class="gt_row gt_right">63.6</td>
<td class="gt_row gt_right">13.9</td>
<td class="gt_row gt_right">24.7</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">산업대학</td>
<td class="gt_row gt_right">251</td>
<td class="gt_row gt_right">22,128</td>
<td class="gt_row gt_right">2,379</td>
<td class="gt_row gt_right">14,539</td>
<td class="gt_row gt_right">11,076</td>
<td class="gt_row gt_right">3,374</td>
<td class="gt_row gt_right">180</td>
<td class="gt_row gt_right">2,704</td>
<td class="gt_row gt_right">350</td>
<td class="gt_row gt_right">707</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.0</td>
<td class="gt_row gt_right">90.3</td>
<td class="gt_row gt_right">9.7</td>
<td class="gt_row gt_right">59.3</td>
<td class="gt_row gt_right">45.2</td>
<td class="gt_row gt_right">13.8</td>
<td class="gt_row gt_right">0.7</td>
<td class="gt_row gt_right">11.0</td>
<td class="gt_row gt_right">1.4</td>
<td class="gt_row gt_right">2.9</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">사이버대학(대학)</td>
<td class="gt_row gt_right">357</td>
<td class="gt_row gt_right">51,840</td>
<td class="gt_row gt_right">34,279</td>
<td class="gt_row gt_right">135,155</td>
<td class="gt_row gt_right">119,995</td>
<td class="gt_row gt_right">15,160</td>
<td class="gt_row gt_right">886</td>
<td class="gt_row gt_right">27,215</td>
<td class="gt_row gt_right">569</td>
<td class="gt_row gt_right">3,377</td>
<td class="gt_row gt_right">2</td>
<td class="gt_row gt_right">0.8</td>
<td class="gt_row gt_right">120.8</td>
<td class="gt_row gt_right">79.9</td>
<td class="gt_row gt_right">315.0</td>
<td class="gt_row gt_right">279.7</td>
<td class="gt_row gt_right">35.3</td>
<td class="gt_row gt_right">2.1</td>
<td class="gt_row gt_right">63.4</td>
<td class="gt_row gt_right">1.3</td>
<td class="gt_row gt_right">7.9</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">전문대학과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(2년제)</td>
<td class="gt_row gt_right">2,546</td>
<td class="gt_row gt_right">473,154</td>
<td class="gt_row gt_right">70,200</td>
<td class="gt_row gt_right">238,266</td>
<td class="gt_row gt_right">162,729</td>
<td class="gt_row gt_right">75,386</td>
<td class="gt_row gt_right">4,242</td>
<td class="gt_row gt_right">70,278</td>
<td class="gt_row gt_right">4,950</td>
<td class="gt_row gt_right">11,103</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.4</td>
<td class="gt_row gt_right">257.8</td>
<td class="gt_row gt_right">38.3</td>
<td class="gt_row gt_right">129.8</td>
<td class="gt_row gt_right">88.7</td>
<td class="gt_row gt_right">41.1</td>
<td class="gt_row gt_right">2.3</td>
<td class="gt_row gt_right">38.3</td>
<td class="gt_row gt_right">2.7</td>
<td class="gt_row gt_right">6.1</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(3년제)</td>
<td class="gt_row gt_right">3,095</td>
<td class="gt_row gt_right">603,197</td>
<td class="gt_row gt_right">87,333</td>
<td class="gt_row gt_right">304,435</td>
<td class="gt_row gt_right">213,105</td>
<td class="gt_row gt_right">91,162</td>
<td class="gt_row gt_right">4,495</td>
<td class="gt_row gt_right">83,819</td>
<td class="gt_row gt_right">6,298</td>
<td class="gt_row gt_right">12,866</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.7</td>
<td class="gt_row gt_right">326.9</td>
<td class="gt_row gt_right">47.3</td>
<td class="gt_row gt_right">165.0</td>
<td class="gt_row gt_right">115.5</td>
<td class="gt_row gt_right">49.4</td>
<td class="gt_row gt_right">2.4</td>
<td class="gt_row gt_right">45.4</td>
<td class="gt_row gt_right">3.4</td>
<td class="gt_row gt_right">7.0</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(4년제)</td>
<td class="gt_row gt_right">317</td>
<td class="gt_row gt_right">63,559</td>
<td class="gt_row gt_right">9,174</td>
<td class="gt_row gt_right">33,340</td>
<td class="gt_row gt_right">24,242</td>
<td class="gt_row gt_right">9,077</td>
<td class="gt_row gt_right">280</td>
<td class="gt_row gt_right">9,375</td>
<td class="gt_row gt_right">780</td>
<td class="gt_row gt_right">1,541</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.1</td>
<td class="gt_row gt_right">227.8</td>
<td class="gt_row gt_right">32.9</td>
<td class="gt_row gt_right">119.5</td>
<td class="gt_row gt_right">86.9</td>
<td class="gt_row gt_right">32.5</td>
<td class="gt_row gt_right">1.0</td>
<td class="gt_row gt_right">33.6</td>
<td class="gt_row gt_right">2.8</td>
<td class="gt_row gt_right">5.5</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">기능대학</td>
<td class="gt_row gt_right">263</td>
<td class="gt_row gt_right">19,102</td>
<td class="gt_row gt_right">7,565</td>
<td class="gt_row gt_right">23,910</td>
<td class="gt_row gt_right">14,860</td>
<td class="gt_row gt_right">9,050</td>
<td class="gt_row gt_right">9</td>
<td class="gt_row gt_right">7,284</td>
<td class="gt_row gt_right">863</td>
<td class="gt_row gt_right">844</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.5</td>
<td class="gt_row gt_right">107.9</td>
<td class="gt_row gt_right">42.7</td>
<td class="gt_row gt_right">135.1</td>
<td class="gt_row gt_right">84.0</td>
<td class="gt_row gt_right">51.1</td>
<td class="gt_row gt_right">0.1</td>
<td class="gt_row gt_right">41.2</td>
<td class="gt_row gt_right">4.9</td>
<td class="gt_row gt_right">4.8</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">대학원과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">일반대학원</td>
<td class="gt_row gt_right">10,076</td>
<td class="gt_row gt_right">121,226</td>
<td class="gt_row gt_right">69,928</td>
<td class="gt_row gt_right">161,987</td>
<td class="gt_row gt_right">143,965</td>
<td class="gt_row gt_right">18,022</td>
<td class="gt_row gt_right">28,099</td>
<td class="gt_row gt_right">45,978</td>
<td class="gt_row gt_right">2,420</td>
<td class="gt_row gt_right">3,703</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">2.7</td>
<td class="gt_row gt_right">31.9</td>
<td class="gt_row gt_right">18.4</td>
<td class="gt_row gt_right">42.6</td>
<td class="gt_row gt_right">37.9</td>
<td class="gt_row gt_right">4.7</td>
<td class="gt_row gt_right">7.4</td>
<td class="gt_row gt_right">12.1</td>
<td class="gt_row gt_right">0.6</td>
<td class="gt_row gt_right">1.0</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">특수대학원</td>
<td class="gt_row gt_right">4,351</td>
<td class="gt_row gt_right">84,377</td>
<td class="gt_row gt_right">45,448</td>
<td class="gt_row gt_right">124,912</td>
<td class="gt_row gt_right">107,537</td>
<td class="gt_row gt_right">17,375</td>
<td class="gt_row gt_right">6,220</td>
<td class="gt_row gt_right">38,435</td>
<td class="gt_row gt_right">978</td>
<td class="gt_row gt_right">7,421</td>
<td class="gt_row gt_right">4</td>
<td class="gt_row gt_right">1.7</td>
<td class="gt_row gt_right">32.1</td>
<td class="gt_row gt_right">17.3</td>
<td class="gt_row gt_right">47.5</td>
<td class="gt_row gt_right">40.9</td>
<td class="gt_row gt_right">6.6</td>
<td class="gt_row gt_right">2.4</td>
<td class="gt_row gt_right">14.6</td>
<td class="gt_row gt_right">0.4</td>
<td class="gt_row gt_right">2.8</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학원</td>
<td class="gt_row gt_right">1,088</td>
<td class="gt_row gt_right">39,141</td>
<td class="gt_row gt_right">15,556</td>
<td class="gt_row gt_right">40,516</td>
<td class="gt_row gt_right">36,108</td>
<td class="gt_row gt_right">4,408</td>
<td class="gt_row gt_right">5,102</td>
<td class="gt_row gt_right">12,037</td>
<td class="gt_row gt_right">4,320</td>
<td class="gt_row gt_right">4,095</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.5</td>
<td class="gt_row gt_right">55.5</td>
<td class="gt_row gt_right">22.1</td>
<td class="gt_row gt_right">57.5</td>
<td class="gt_row gt_right">51.2</td>
<td class="gt_row gt_right">6.3</td>
<td class="gt_row gt_right">7.2</td>
<td class="gt_row gt_right">17.1</td>
<td class="gt_row gt_right">6.1</td>
<td class="gt_row gt_right">5.8</td>
<td class="gt_row gt_right">0.0</td></tr>
  </tbody>
  
  
</table>
</div><!--/html_preserve-->

표 안의 데이터를 잘 살펴보면 행 그룹의 순서가 대학->전문대학->대학원의 순서로 설정되어 있다. 보통 전문대학->대학->대학원으로 표현되는 것이 일반적이다. 이렇게 행 그룹의 순서를 바꾸는 함수는 `row_group_order()`이다.


```r
gt.table6 <- gt.table5 |> 
  row_group_order(
    groups = c('전문대학과정', '대학과정', '대학원과정')
  )
```

<!--html_preserve--><div id="iabivcjaed" style="overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>html {
  font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Helvetica Neue', 'Fira Sans', 'Droid Sans', Arial, sans-serif;
}

#iabivcjaed .gt_table {
  display: table;
  border-collapse: collapse;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 10px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#iabivcjaed .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#iabivcjaed .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#iabivcjaed .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 0;
  padding-bottom: 4px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#iabivcjaed .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#iabivcjaed .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#iabivcjaed .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#iabivcjaed .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#iabivcjaed .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#iabivcjaed .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#iabivcjaed .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#iabivcjaed .gt_group_heading {
  padding: 8px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
}

#iabivcjaed .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#iabivcjaed .gt_from_md > :first-child {
  margin-top: 0;
}

#iabivcjaed .gt_from_md > :last-child {
  margin-bottom: 0;
}

#iabivcjaed .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#iabivcjaed .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 12px;
}

#iabivcjaed .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#iabivcjaed .gt_first_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
}

#iabivcjaed .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#iabivcjaed .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#iabivcjaed .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#iabivcjaed .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#iabivcjaed .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#iabivcjaed .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding: 4px;
}

#iabivcjaed .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#iabivcjaed .gt_sourcenote {
  font-size: 90%;
  padding: 4px;
}

#iabivcjaed .gt_left {
  text-align: left;
}

#iabivcjaed .gt_center {
  text-align: center;
}

#iabivcjaed .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#iabivcjaed .gt_font_normal {
  font-weight: normal;
}

#iabivcjaed .gt_font_bold {
  font-weight: bold;
}

#iabivcjaed .gt_font_italic {
  font-style: italic;
}

#iabivcjaed .gt_super {
  font-size: 65%;
}

#iabivcjaed .gt_footnote_marks {
  font-style: italic;
  font-weight: normal;
  font-size: 65%;
}
</style>
<table class="gt_table">
  <thead class="gt_header">
    <tr>
      <th colspan="23" class="gt_heading gt_title gt_font_normal" style>고등교육기관 데이터</th>
    </tr>
    <tr>
      <th colspan="23" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style>2021년 전체 고등교육기관 대상</th>
    </tr>
  </thead>
  <thead class="gt_col_headings">
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="2" colspan="1"></th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="11">
        <span class="gt_column_spanner">합계</span>
      </th>
      <th class="gt_center gt_columns_top_border gt_column_spanner_outer" rowspan="1" colspan="11">
        <span class="gt_column_spanner">평균</span>
      </th>
    </tr>
    <tr>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">학과수</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">지원자</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">입학자</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재적생</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재학생</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">휴학생</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">외국인학생</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">졸업자</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">전임교원</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">비전임교원</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">시간강사</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">학과수</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">지원자</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">입학자</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재적생</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">재학생</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">휴학생</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">외국인학생</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">졸업자</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">전임교원</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">비전임교원</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1">시간강사</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">전문대학과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(2년제)</td>
<td class="gt_row gt_right">2,546</td>
<td class="gt_row gt_right">473,154</td>
<td class="gt_row gt_right">70,200</td>
<td class="gt_row gt_right">238,266</td>
<td class="gt_row gt_right">162,729</td>
<td class="gt_row gt_right">75,386</td>
<td class="gt_row gt_right">4,242</td>
<td class="gt_row gt_right">70,278</td>
<td class="gt_row gt_right">4,950</td>
<td class="gt_row gt_right">11,103</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.4</td>
<td class="gt_row gt_right">257.8</td>
<td class="gt_row gt_right">38.3</td>
<td class="gt_row gt_right">129.8</td>
<td class="gt_row gt_right">88.7</td>
<td class="gt_row gt_right">41.1</td>
<td class="gt_row gt_right">2.3</td>
<td class="gt_row gt_right">38.3</td>
<td class="gt_row gt_right">2.7</td>
<td class="gt_row gt_right">6.1</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(3년제)</td>
<td class="gt_row gt_right">3,095</td>
<td class="gt_row gt_right">603,197</td>
<td class="gt_row gt_right">87,333</td>
<td class="gt_row gt_right">304,435</td>
<td class="gt_row gt_right">213,105</td>
<td class="gt_row gt_right">91,162</td>
<td class="gt_row gt_right">4,495</td>
<td class="gt_row gt_right">83,819</td>
<td class="gt_row gt_right">6,298</td>
<td class="gt_row gt_right">12,866</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.7</td>
<td class="gt_row gt_right">326.9</td>
<td class="gt_row gt_right">47.3</td>
<td class="gt_row gt_right">165.0</td>
<td class="gt_row gt_right">115.5</td>
<td class="gt_row gt_right">49.4</td>
<td class="gt_row gt_right">2.4</td>
<td class="gt_row gt_right">45.4</td>
<td class="gt_row gt_right">3.4</td>
<td class="gt_row gt_right">7.0</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학(4년제)</td>
<td class="gt_row gt_right">317</td>
<td class="gt_row gt_right">63,559</td>
<td class="gt_row gt_right">9,174</td>
<td class="gt_row gt_right">33,340</td>
<td class="gt_row gt_right">24,242</td>
<td class="gt_row gt_right">9,077</td>
<td class="gt_row gt_right">280</td>
<td class="gt_row gt_right">9,375</td>
<td class="gt_row gt_right">780</td>
<td class="gt_row gt_right">1,541</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.1</td>
<td class="gt_row gt_right">227.8</td>
<td class="gt_row gt_right">32.9</td>
<td class="gt_row gt_right">119.5</td>
<td class="gt_row gt_right">86.9</td>
<td class="gt_row gt_right">32.5</td>
<td class="gt_row gt_right">1.0</td>
<td class="gt_row gt_right">33.6</td>
<td class="gt_row gt_right">2.8</td>
<td class="gt_row gt_right">5.5</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">기능대학</td>
<td class="gt_row gt_right">263</td>
<td class="gt_row gt_right">19,102</td>
<td class="gt_row gt_right">7,565</td>
<td class="gt_row gt_right">23,910</td>
<td class="gt_row gt_right">14,860</td>
<td class="gt_row gt_right">9,050</td>
<td class="gt_row gt_right">9</td>
<td class="gt_row gt_right">7,284</td>
<td class="gt_row gt_right">863</td>
<td class="gt_row gt_right">844</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.5</td>
<td class="gt_row gt_right">107.9</td>
<td class="gt_row gt_right">42.7</td>
<td class="gt_row gt_right">135.1</td>
<td class="gt_row gt_right">84.0</td>
<td class="gt_row gt_right">51.1</td>
<td class="gt_row gt_right">0.1</td>
<td class="gt_row gt_right">41.2</td>
<td class="gt_row gt_right">4.9</td>
<td class="gt_row gt_right">4.8</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">대학과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">대학교</td>
<td class="gt_row gt_right">12,028</td>
<td class="gt_row gt_right">2,635,154</td>
<td class="gt_row gt_right">329,306</td>
<td class="gt_row gt_right">1,938,254</td>
<td class="gt_row gt_right">1,415,162</td>
<td class="gt_row gt_right">504,165</td>
<td class="gt_row gt_right">69,888</td>
<td class="gt_row gt_right">325,432</td>
<td class="gt_row gt_right">67,473</td>
<td class="gt_row gt_right">86,857</td>
<td class="gt_row gt_right">79</td>
<td class="gt_row gt_right">1.5</td>
<td class="gt_row gt_right">326.3</td>
<td class="gt_row gt_right">40.8</td>
<td class="gt_row gt_right">240.0</td>
<td class="gt_row gt_right">175.3</td>
<td class="gt_row gt_right">62.4</td>
<td class="gt_row gt_right">8.7</td>
<td class="gt_row gt_right">40.3</td>
<td class="gt_row gt_right">8.4</td>
<td class="gt_row gt_right">10.8</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">교육대학</td>
<td class="gt_row gt_right">140</td>
<td class="gt_row gt_right">15,805</td>
<td class="gt_row gt_right">3,864</td>
<td class="gt_row gt_right">15,409</td>
<td class="gt_row gt_right">15,045</td>
<td class="gt_row gt_right">364</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">3,818</td>
<td class="gt_row gt_right">833</td>
<td class="gt_row gt_right">1,481</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">2.3</td>
<td class="gt_row gt_right">263.4</td>
<td class="gt_row gt_right">64.4</td>
<td class="gt_row gt_right">256.8</td>
<td class="gt_row gt_right">250.8</td>
<td class="gt_row gt_right">6.1</td>
<td class="gt_row gt_right">0.0</td>
<td class="gt_row gt_right">63.6</td>
<td class="gt_row gt_right">13.9</td>
<td class="gt_row gt_right">24.7</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">산업대학</td>
<td class="gt_row gt_right">251</td>
<td class="gt_row gt_right">22,128</td>
<td class="gt_row gt_right">2,379</td>
<td class="gt_row gt_right">14,539</td>
<td class="gt_row gt_right">11,076</td>
<td class="gt_row gt_right">3,374</td>
<td class="gt_row gt_right">180</td>
<td class="gt_row gt_right">2,704</td>
<td class="gt_row gt_right">350</td>
<td class="gt_row gt_right">707</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.0</td>
<td class="gt_row gt_right">90.3</td>
<td class="gt_row gt_right">9.7</td>
<td class="gt_row gt_right">59.3</td>
<td class="gt_row gt_right">45.2</td>
<td class="gt_row gt_right">13.8</td>
<td class="gt_row gt_right">0.7</td>
<td class="gt_row gt_right">11.0</td>
<td class="gt_row gt_right">1.4</td>
<td class="gt_row gt_right">2.9</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">사이버대학(대학)</td>
<td class="gt_row gt_right">357</td>
<td class="gt_row gt_right">51,840</td>
<td class="gt_row gt_right">34,279</td>
<td class="gt_row gt_right">135,155</td>
<td class="gt_row gt_right">119,995</td>
<td class="gt_row gt_right">15,160</td>
<td class="gt_row gt_right">886</td>
<td class="gt_row gt_right">27,215</td>
<td class="gt_row gt_right">569</td>
<td class="gt_row gt_right">3,377</td>
<td class="gt_row gt_right">2</td>
<td class="gt_row gt_right">0.8</td>
<td class="gt_row gt_right">120.8</td>
<td class="gt_row gt_right">79.9</td>
<td class="gt_row gt_right">315.0</td>
<td class="gt_row gt_right">279.7</td>
<td class="gt_row gt_right">35.3</td>
<td class="gt_row gt_right">2.1</td>
<td class="gt_row gt_right">63.4</td>
<td class="gt_row gt_right">1.3</td>
<td class="gt_row gt_right">7.9</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr class="gt_group_heading_row">
      <td colspan="23" class="gt_group_heading">대학원과정</td>
    </tr>
    <tr><td class="gt_row gt_left gt_stub">일반대학원</td>
<td class="gt_row gt_right">10,076</td>
<td class="gt_row gt_right">121,226</td>
<td class="gt_row gt_right">69,928</td>
<td class="gt_row gt_right">161,987</td>
<td class="gt_row gt_right">143,965</td>
<td class="gt_row gt_right">18,022</td>
<td class="gt_row gt_right">28,099</td>
<td class="gt_row gt_right">45,978</td>
<td class="gt_row gt_right">2,420</td>
<td class="gt_row gt_right">3,703</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">2.7</td>
<td class="gt_row gt_right">31.9</td>
<td class="gt_row gt_right">18.4</td>
<td class="gt_row gt_right">42.6</td>
<td class="gt_row gt_right">37.9</td>
<td class="gt_row gt_right">4.7</td>
<td class="gt_row gt_right">7.4</td>
<td class="gt_row gt_right">12.1</td>
<td class="gt_row gt_right">0.6</td>
<td class="gt_row gt_right">1.0</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">특수대학원</td>
<td class="gt_row gt_right">4,351</td>
<td class="gt_row gt_right">84,377</td>
<td class="gt_row gt_right">45,448</td>
<td class="gt_row gt_right">124,912</td>
<td class="gt_row gt_right">107,537</td>
<td class="gt_row gt_right">17,375</td>
<td class="gt_row gt_right">6,220</td>
<td class="gt_row gt_right">38,435</td>
<td class="gt_row gt_right">978</td>
<td class="gt_row gt_right">7,421</td>
<td class="gt_row gt_right">4</td>
<td class="gt_row gt_right">1.7</td>
<td class="gt_row gt_right">32.1</td>
<td class="gt_row gt_right">17.3</td>
<td class="gt_row gt_right">47.5</td>
<td class="gt_row gt_right">40.9</td>
<td class="gt_row gt_right">6.6</td>
<td class="gt_row gt_right">2.4</td>
<td class="gt_row gt_right">14.6</td>
<td class="gt_row gt_right">0.4</td>
<td class="gt_row gt_right">2.8</td>
<td class="gt_row gt_right">0.0</td></tr>
    <tr><td class="gt_row gt_left gt_stub">전문대학원</td>
<td class="gt_row gt_right">1,088</td>
<td class="gt_row gt_right">39,141</td>
<td class="gt_row gt_right">15,556</td>
<td class="gt_row gt_right">40,516</td>
<td class="gt_row gt_right">36,108</td>
<td class="gt_row gt_right">4,408</td>
<td class="gt_row gt_right">5,102</td>
<td class="gt_row gt_right">12,037</td>
<td class="gt_row gt_right">4,320</td>
<td class="gt_row gt_right">4,095</td>
<td class="gt_row gt_right">0</td>
<td class="gt_row gt_right">1.5</td>
<td class="gt_row gt_right">55.5</td>
<td class="gt_row gt_right">22.1</td>
<td class="gt_row gt_right">57.5</td>
<td class="gt_row gt_right">51.2</td>
<td class="gt_row gt_right">6.3</td>
<td class="gt_row gt_right">7.2</td>
<td class="gt_row gt_right">17.1</td>
<td class="gt_row gt_right">6.1</td>
<td class="gt_row gt_right">5.8</td>
<td class="gt_row gt_right">0.0</td></tr>
  </tbody>
  
  
</table>
</div><!--/html_preserve-->

다음 포스트에서는 `gt` 표를 예쁘게 꾸며보는 방법을 알아보도록 하겠다..

Coming Soon..
