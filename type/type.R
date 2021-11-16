a1 <- as.vector(1:12)

typeof(a1)
class(a1)

a2 <- matrix(1:12, nrow = 3)

typeof(a2)
class(a2)


a3 <- array(1:12,dim=c(12))

typeof(a3)
class(a3)

?vector

?typeof

library(tidyverse)
library(iris)
install.packages('iris')
iris
summary(iris$Sepal.Length)

summary(iris$Species)

glimpse(iris)


install.packages('reticulate')
reticulate::install_miniconda(path = 'c:/Python/miniconda')
reticulate::conda_install('r-reticulate', 'python-kaleido')
reticulate::conda_install('r-reticulate', 'plotly', channel = 'plotly')
reticulate::use_miniconda('r-reticulate')
reticulate::use_condaenv('anaconda3')

reticulate::conda_remove('r-miniconda')
reticulate::conda_list()

remove_miniconda()

p <- list(name = '피카츄', type = '전기', health = 70)
class(p)
class(p) <- '포켓몬'
class(p)
p

포켓몬('잠만보', '노멀', 65)
p1 <- list(name = '잠만보', type = '노멀', health = 65)
class(p1) <- '포켓몬'
p1


# 피카츄 클래스의 생성함수 정의
포켓몬 <- function(n,t,h) {
  # we can add our own integrity checks
  if(h>100 || h<0)  stop("health는 0에서 100사이이어야 합니다.")
  value <- list(name = n, type = t, health = h)
  # class can be set using class() or attr() function
  attr(value, "class") <- "포켓몬"
  value
}

p1 <- 포켓몬('잠만보', '노멀', 60)
p1


p2 <- 포켓몬('꼬부기', '물', 105)
p1


attack1 <- function(obj) {
  cat(obj$name, '은(는) ')
  cat(obj$type, '공격을 하였습니다.')
  }

attack1(p1)


print <- function(obj) {
  UseMethod("attack")
}


print.포켓몬 <- function(obj) {
  cat(obj$name, '\n')
  cat(obj$type, '\n')
  cat(obj$health, '\n')
}

print(p1)

methods(class = '포켓몬')


print(p1)
summary(p1)


p1 <- unclass(p1)
class(p1)

removeClass('포켓몬')
removeMethod('포켓몬')
??method

method(print)


methods(print)
removeMethod('print', '포켓몬')
?removeMethod

methods(attack)
removeMethod('attack', '포켓몬')


setClass("포켓몬", slots=list(name="character", type="character", health="integer"))
removeClass('포켓몬')
removeMethods()
showMethods('포켓몬')


setMethod("print",
          "포켓몬",
          function(object) {
            # cat(object@name, "\n")
            # cat(object@type, "years old\n")
            # cat("GPA:", object@health, "\n")
          }
)

isS4(print)
require(stats)


ts(1:20)  #-- print is the "Default function" --> print.ts(.) is called
for(i in 1:3) print(1:i)
attenu$station


esoph$agegp[1:12]


install.packages('base')
update.packages('base')
updateR()


install.packages("installr")

library(installr)

updateR()
