---
output:
  html_document: 
    css: D:/analysis/R/tistory/plotly/style.css
    keep_md: yes
    theme: cerulean
    highlight: espresso
    number_sections: yes
---





사용데이터 : <https://2stndard.tistory.com/68>

## 박스 플롯의 평균값 표현

박스플롯을 사용하다 보면 중간값을 평균값으로 오해하는 경우가 많다. 사실 우리는 중간값보다는 평균값에 더 익숙하다. 그렇기 때문에 박스플롯에 평균값을 표기하는 경우가 매우 흔히 발생한다. 박스 플롯에 평균을 표기하기 위해서는 기하 함수인 `geom_*()`에 통계 매개변수인 'stat' 매개변수를 사용하는 방법과 통계 요소 함수인 `stat_*()`을 사용하는 방법 두 가지가 있다.

### 기하 요소 함수에 통계 매개변수 사용

`ggplot2`에서 제공하는 기하 요소 함수는 'geom'으로 시작하는 함수로 데이터를 그리는 기하학적 표현 방법을 설정하는 함수를 말한다. 이 기하 요소 함수에는 어러 개의 매개변수가 사용되지만 많이 사용되지 않는 매개변수가 데이터에 대한 통계 변환을 사용할 수 있는 `stat`이다. 

`stat`을 통해 수행할 수 있는 통계 변환은 여러가지가 있지만 평균을 구하기 위해서는 'summary'를 지정해야 한다. 그리고 'summary' 통계 변환에 사용할 통계 변환 함수는 `fun`에 설정한다. 


```r
p_boxplot <- df_취업률 |> filter(졸업자_계 >= 3) |>
  ggplot() + 
  labs(x = '대계열', y = '취업률')

p_boxplot1 <- p_boxplot +
  ## X축을 대계열, Y축을 취업률_계로 매핑한 geom_boxplot 레이어 생성
  geom_boxplot(aes(x = 대계열, y = 취업률_계)) +
  labs(title = '박스 플롯')

df_취업률 |> filter(졸업자_계 >= 3) |>
  ggplot(aes(x = 대계열, y = 취업률_계)) + 
  ## X축을 대계열, Y축을 취업률_계로 매핑한 geom_boxplot 레이어 생성
  stat_boxplot(geom = 'errorbar', coef = 1.0) +
  geom_boxplot() +
    geom_point(aes(x = 대계열, y = 취업률_계), stat = 'summary', fun = 'mean', color = 'tomato3') +
  labs(title = '박스 플롯')
```

![](boxplot1_files/figure-html/unnamed-chunk-2-1.png)<!-- -->

```r
p_boxplot1
```

![](boxplot1_files/figure-html/unnamed-chunk-2-2.png)<!-- -->

만약 위의 박스 플롯에 평균값을 점으로 넣는다면 점을 넣는 기하 요소 함수인 `geom_point()`의 `stat` 매개변수를 'summary'로 설정하고 평균을 구하는 'mean'을 `fun`에 설정하면 평균값에 점이 표시된다. 


```r
p_boxplot1 +
  ## stat = summary, fun.y = mean으로 설정한 geom_point 레이어 추가
  geom_point(aes(x = 대계열, y = 취업률_계), stat = 'summary', fun = 'mean', color = 'tomato3') +
  labs(title = 'geom_point를 사용해 평균을 표시한 박스플롯')
```

![](boxplot1_files/figure-html/unnamed-chunk-3-1.png)<!-- -->

위와 같이 표시된 평균값 위치는 중앙값보다 큰지 적은지 알 수 있다. 그렇다면 평균값과 중앙값과의 관계는 어떻게 되는가?

절대적으로 그렇지는 않지만 대략적으로 평균값이 중앙값보다 크다면 데이터가 높은 쪽으로 다소 몰려있는 것으로 추론할 수 있다. 

반면 평균값이 중앙값보다 적다면 데이터가 낮은 쪽으로 다소 몰려있다고 추론할 수 있지만 절대적이지는 않다. 

그렇다면 평균과 중앙값을 확인해야 하는 이유는 무엇일까? 이는 평균의 함정에 빠지지 않기 위해서이다. 

평균은 전체 데이터의 합계를 데이터 빈도로 나눈 값인데 특정 값이 매우 크다면 평균값은 왜곡된다. 그래서 데이터의 전체적 분포상의 중간을 같이 확인해야 평균의 함정에 빠지지 않을 수 있다. 

위의 박스 플롯에 정확한 평균값을 텍스트로 표시하는 방법은 다음과 같다. 



```r
p_boxplot1 +
  ## stat = summary, fun.y = mean으로 설정한 geom_point 레이어 추가
  geom_point(aes(x = 대계열, y = 취업률_계), stat = 'summary', fun = 'mean', color = 'tomato3', shape = 4) + 
  ## stat = summary, fun.y = mean으로 설정한 geom_text 레이어 추가
  geom_text(aes(x = 대계열, y = 취업률_계, label = round(..y.., 1)), stat = 'summary', fun = 'mean', color = 'tomato3', vjust = 1.5) + 
  labs(title = 'geom_text를 사용해 평균값을 표기한 박스플롯')
```

![](boxplot1_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

위의 코드에서 지금까지 보지 못했던 하나의 키워드가 나온다. 바로 '..y..'이다. `ggplot2`에서 '..'과 '..'으로 둘러싸인 키워드는 통계 변환으로 산출된 통계값으로 매핑된다. 만약 '..count..'이라면 히스토그램에서 각각의 변량에 해당하는 카운트수, 즉 빈도수에 매핑된다.  

### 통계 요소 함수 사용

통계 요소는 `ggplot2`에서 사용할 통계 변환을 수행하는 함수로 'stat'으로 시작하는 함수를 말한다. 앞서 `stat` 매개변수에 설정된 값을 그대로 사용한 함수를 사용할 수 있는데 앞서 `stat`에 'summary'를 설정하였기 때문에 이 통계 변환과 동일한 기능을 수행하는 통계 요소 함수는 `stat_summary()`이다. 앞에서는 기하요소를 먼저 정했다면 이번에는 통계요소를 먼저 정했고 이 데이터가 표현될 기하요소는 `geom` 매개변수로 설정한다. 따라서 앞의 코드를 `stat_summary()`를 이용하면 아래와 같다. 



```r
p_boxplot1 +
  ## stat = summary, fun.y = mean으로 설정한 geom_point 레이어 추가
  stat_summary(aes(x = 대계열, y = 취업률_계), geom = 'point', fun = 'mean', color = 'tomato3', shape = 4) + 
  ## stat = summary, fun.y = mean으로 설정한 geom_text 레이어 추가
  stat_summary(aes(x = 대계열, y = 취업률_계, label = round(..y.., 1)), geom = 'text', fun.y = 'mean', color = 'tomato3', shape = 4, vjust = 1.5) +
  labs(title = 'stat_summary를 사용해 평균값을 표기한 박스플롯')
```

![](boxplot1_files/figure-html/unnamed-chunk-5-1.png)<!-- -->

이를 바이올린 플롯으로 바꾸면 다음과 같다.


```r
p_violin <- p_boxplot +
  ## X축을 대계열, Y축을 취업률_계로 매핑한 geom_violin 레이어 생성
  geom_violin(aes(x = 대계열, y = 취업률_계), scale = 'count') +
  labs(title = '바이올린플롯')

p_violin +
  ## stat = summary, fun.y = mean으로 설정한 geom_point 레이어 추가
  geom_point(aes(x = 대계열, y = 취업률_계), stat = 'summary', fun = 'mean', color = 'tomato3', shape = 4) + 
  ## stat = summary, fun.y = mean으로 설정한 geom_text 레이어 추가
  stat_summary(aes(x = 대계열, y = 취업률_계, label = round(..y.., 1)), geom = 'text', fun.y = 'mean', color = 'tomato3', shape = 4, vjust = 1.5) + 
  labs(title = '평균값을 표기한 바이올린플롯')
```

![geom_text를 사용해 평균값을 표기한 바이올린플롯](boxplot1_files/figure-html/unnamed-chunk-6-1.png)
