library(tidyverse)
library(bench)

# Calculate square root for each element in loop
sqrt_loop <- function(x) {
  out <- numeric(length(x))
  for (i in x) {
    out[i] <- sqrt(x[i])
  }
  out
}

# Example
sqrt_loop(1:4) # 1.000000 1.414214 1.732051 2.000000
sqrt_loop(100000)

# Compare its performance with two alternatives
speed_check <- function(n) {
#  x <- runif(n)
  mark(
    vectorized = sqrt(n),
    loop = sqrt_loop(n),
    apply = sapply(n, sqrt)
  )
}

speed_check(1:1000)

rexp(100)

seq_along(1000)

mark <- list()
for(i in 1:5) {
mark[[i]] <- mark(apply = vapply(1:10^i, sqrt, FUN.VALUE = 0.0), loop = sqrt_loop(1:10^i), vectorize = sqrt(1:10^i))
}
View(mark)

vapply = sapply(1:10^3, sqrt)


mark[[5]]
  # relative = TRUE
mark(vectorized = sqrt(seq(10^3, 10^6, 10^0.25)), loop = sqrt_loop(seq(10^3, 10^6, 10^0.25)))




# Combine results of multiple benchmarks and plot results
multiple_benchmarks <- function(one_bench, N) {
  res <- vector("list", length(N))
  for (i in seq_along(N)) {
    res[[i]] <- one_bench(N[i]) %>% 
      mutate(n = N[i], expression = names(expression))
  }
  
  ggplot(bind_rows(res), aes(n, median, color = expression)) +
    geom_point(size = 3) +
    geom_line(size = 1) +
    scale_x_log10() +
    ggtitle(deparse1(substitute(one_bench))) +
    theme(legend.position = c(0.8, 0.15))
}

# Apply simulation
multiple_benchmarks(sqrt_benchmark, N = 10^seq(3, 6, 0.25))