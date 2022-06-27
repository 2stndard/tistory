---
output:
  html_document:
    css: D:/analysis/R/tistory/plotly/style.css
    keep_md: yes
---






사용데이터 : <https://2stndard.tistory.com/68>

## plotly 박스 trace

박스 trace는 박스 플롯을 생성하기 위해 사용되는 trace이다. 박스 플롯은 데이터의 전체적 분포를 4분위수(quantile)과 IQR(Inter Quartile Range)를 사용하여 표시하는 시각화로 연속형 변수와 이산형 변수의 시각화에 사용되는 방법이다. 박스 trace를 사용해 박스 플롯을 생성하기 위해서는 `add_trace(type = 'box')`를 사용하거나 `add_boxplot()`을 사용한다.

::: {.comment}
add_trace(p, type = 'box', ..., data = NULL, inherit = TRUE)\
add_boxplot(p, x = NULL, y = NULL, ..., data = NULL, inherit = TRUE)\
- p : plot_ly()로 생성한 plotly 객체\
- type : trace 타입을 'box'로 설정\
- ... : 박스 trace의 line 모드에 설정할 수 있는 속성 설정\
- data : 시각화할 데이터프레임\
- inherit : plot_ly()에 설정된 속성 type을 상속할지를 결정하는 논리값\
- x : X축에 매핑할 변수를 \~로 설정\
- y : Y축에 매핑할 변수를 \~로 설정\
:::
\



```r
p_box <- 
  ## 취업률 데이터를 사용하여 plotly 객체 생성
  df_취업률_2000 |> 
  plot_ly()

p_box |> 
  ## 박스 trace 추가
  add_trace(type = 'box', 
            ## X, Y축 변수 매핑
            x = ~대계열, y = ~취업률) |>
  ## 제목, 여백 설정
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)
```


### boxmean, boxpoints

박스 trace에서 제공하는 요약 통계중에 가장 많이 사용되지만 제공되지 않는 요약통계가 바로 평균(mean)이다. `ggplot2`에서는 평균을 표현하기 위해 다소 어려운 과정을 거쳐야 했지만 `plotly`에서는 `boxmean` 속성의 설정만으로 간단하게 평균값을 표현할 수 있다. `boxmean`은 TRUE/FALSE의 논리값에 표준편차가 추가로 표시되는 'sd'를 제공한다.


```r
p_box |> 
  ## boxmean을 TRUE로 설정한 박스 trace 추가
  add_trace(type = 'box', boxmean = TRUE, 
            x = ~대계열, y = ~취업률) |>
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)
```



```r
p_box |> 
  ## boxmean을 sd로 설정한 박스 trace 추가
  add_trace(type = 'box', boxmean = 'sd', 
            x = ~대계열, y = ~취업률) |>
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)
```


또 박스 trace에서 유용하게 사용되는 속성이 `boxpoints`이다. `boxpoints`는 이상치(outlier)로 표현되는 점의 표현을 제어할 수 있다. `boxpoints`로 설정 가능한 이상치 표시 설정은 'all', 'outliers', 'suspectedoutliers', 'FALSE'의 네 가지 방법이 제공된다. 'all'은 모든 이상치를 보여주지만 'outliers'는 수염 외부에 있는 이상치만 표시하고 'suspectedoutliers' 전체 이상치가 표시되지만 값의 범위가 IQR의 4배가 넘어가는 이상치는 다시 강조되는 방법이다. 'FALSE'는 이상치를 표시하지 않는다.


```r
p_box |> 
  ## boxpoint을 all로 설정한 박스 trace 추가
  add_trace(type = 'box', boxpoints = 'all', 
            x = ~대계열, y = ~취업률) |>
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)
```



```r
p_box |> 
  ## boxpoint을 outliers로 설정한 박스 trace 추가
  add_trace(type = 'box', boxpoints = 'outliers' 
            , x = ~대계열, y = ~취업률) |>
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)
```



```r
p_box |> 
  ## boxpoint을 suspectedoutliers로 설정한 박스 trace 추가
  add_trace(type = 'box', boxpoints = 'suspectedoutliers', 
            x = ~대계열, y = ~취업률) |>
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)
```



```r
p_box |> 
  ## boxpoint을 FALSE로 설정한 박스 trace 추가
  add_trace(type = 'box', boxpoints = FALSE, 
            x = ~대계열, y = ~취업률) |>
  layout(title = list(text = '대학 계열별 취업률 분포'), 
         margin = margins)
```

