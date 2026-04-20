# Assignment 1 Day 1

# Starting by saving the R script in the correct subfolder and 
# installing and loading all necessary libraries.

dir.create("/Assignment1_NicoleKleebauer/")
# This gave an error "Read-only file system"?
# Created folder manually

install.packages("renv")
install.packages("GGally")

library(renv)
library(tidyverse)
library(GGally)
library(ggplot2)

# Save state of packages and library with renv:
renv::snapshot()

# Load the data set
data("iris")

# Exploring the data
view(iris)
head(iris)
summary(iris)
str(iris)

# Clean the data with tidyverse, following https://rpubs.com/analystben/chapter-2
# Start by converting iris into a tibble object
iris_tibble <- as_tibble(iris)
print(iris_tibble, n = 3, width = Inf)

iris_tibble %>% summarize_if(is.numeric, mean)

# GGally is an extension of the 
# ggplot2 library for R. It provides a set of functions that can be used to 
# create various types of plots and graphs. The library contains functions for 
# creating scatterplots, barplots, boxplots, lineplots, and correlation plots, 
# as well as functions for creating parallel coordinates, correlation matrices, 
# cluster plots e.t.c

#library(GGally)

ggpairs(iris_tibble, aes(color = Species))

# Now the data is cleaned up, all rows with missing values are removed with 
# drop_na(). Then unique() removes any duplicate rows. 
clean.data <- iris %>% drop_na() %>% unique()
summary(clean.data)

# Visualize the data with ggplot2
#library(ggplot2)

#Basic scatter plot:
ggplot(clean.data, aes(Sepal.Length, Sepal.Width, colour = Species)) +
  geom_point()

# Add some improvments and aesthetics.
prettier_plot <- ggplot(clean.data, 
                        aes(Sepal.Length, Sepal.Width, colour = Species)) +
  geom_point(size = 2.5) + 
  labs(title = "Sepal comparison of legth and width by Species",
       x = "Sepal Length",
       y = "Sepal Width") +
  facet_wrap(~ Species) +
  scale_color_manual(values = c(
    "setosa" = "#CC79A7",     # orange
    "versicolor" = "#E69F00", # soft pink
    "virginica" = "#7B61FF"   # purple
  )) +
  theme_light() + 
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold")
  )
  
print(prettier_plot)

#Save the plot in a new subfolder
dir.create("Assignment1_NicoleKleebauer/figures")

ggsave(
  filename = "Assignment1_NicoleKleebauer/figures/cleanIrisPlot.png",
  plot = prettier_plot,
  width = 10,
  height = 6
)

