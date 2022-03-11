getwd()
## http://mfviz.com/r-image-art/
install.packages('imager')
install.packages('ggvoronoi')

library(imager)    # image loading and processing
library(dplyr)     # data manipulation
library(ggplot2)   # data visualization
library(tidyr)     # data wrangling
library(ggvoronoi) # visualization

img <- load.image(file = "./그림2.png")

print(img)

plot(img)

img_df <- as.data.frame(img)

img_df %>% 
  arrange(x, y, cc) %>% # sort by columns for viewing
  filter(row_number() < 10)

img_df <- img_df %>% 
  mutate(channel = case_when(
    cc == 1 ~ "Red",
    cc == 2 ~ "Green", 
    cc == 3 ~ "Blue"
  ))

# Reshape the data frame so that each row is a point
img_wide <- img_df %>%
  select(x, y, channel, value) %>%
  spread(key = channel, value = value) %>%
  mutate(
    color = rgb(Red, Green, Blue)
  )

img_wide <- img_wide |>
  filter(color != '#000000')


ggplot(img_wide) +
  geom_point(mapping = aes(x = x, y = y, color = color)) +
  scale_color_identity() # use the actual value in the `color` column


# Take a sample of rows from the data frame
sample_size <- 5000
img_sample <- img_wide[sample(nrow(img_wide), sample_size), ]

# Plot only the sampled points
ggplot(img_sample) +
  geom_point(mapping = aes(x = x, y = y, color = color)) +
  scale_color_identity() + # use the actual value in the `color` column
  scale_y_reverse()

+ # Orient the image properly (it's upside down!)
  theme_void() # Remove axes, background


img_sample$size <- runif(sample_size)

# Plot only the sampled points
ggplot(img_sample) +
  geom_point(mapping = aes(x = x, y = y, color = color, size = size)) +
  guides(size = FALSE) + # don't show the legend
  scale_color_identity() + # use the actual value in the `color` column
  scale_y_reverse()

+ # Orient the image properly (it's upside down!)
  theme_void() # Remove axes, background


ggplot(img_sample) +
  geom_voronoi(mapping = aes(x = x, y = y, fill = color)) +
  scale_fill_identity() +
  scale_y_reverse()


edges <- cannyEdges(img)

plot(edges)


edges_df <- edges %>%  
  as.data.frame() %>% 
  select(x, y) %>% # only select columns of interest
  distinct(x, y) %>% # remove duplicates
  mutate(edge = 1) # indicate that these observations represent an edge


img_wide <- img_wide %>% 
  left_join(edges_df)

# Apply a low weight to the non-edge points
img_wide$edge[is.na(img_wide$edge)] <- .05

# Re-sample from the image, applying a higher probability to the edge points
img_edge_sample <- img_wide[sample(nrow(img_wide), sample_size, prob = img_wide$edge), ]


ggplot(img_edge_sample) +
  geom_voronoi(mapping = aes(x = x, y = y, fill = color)) +
  scale_fill_identity() +
  guides(fill = FALSE) +
  scale_y_reverse()

+
  theme_void() # Remove axes, background


ggplot(img_edge_sample) +
  geom_point(mapping = aes(x = x, y = y, color = color, size = edge * runif(sample_size))) +
  guides(fill = FALSE, size= FALSE) +
  scale_color_identity() +
  scale_y_reverse()

+
  theme_void() # Remove axes, background
