library(ggplot2)
library(viridis)
library(RColorBrewer)
library(plotrix)
library(dplyr)

# load dataset
mydata <- read.csv("data/Miscanthus_sinensis_yield.csv")

# plot height vs. yield by genetic group
par(mfrow = c(4, 3), mar = c(3.1, 3.1, 3.1, 1.1), 
    mgp = c(2, 0.5, 0))
mygrp <- unique(mydata$Genetic.group)
for(g in mygrp){
  gsubset <- which(mydata$Genetic.group == g)
  plot(mydata$Plant.height[gsubset], 
       mydata$Biomass.yield[gsubset],
       xlab = "Plant height", ylab = "Yield",
       main = g)
}

# same plot with ggplot
filter(mydata, Stem.diameter > 4) %>% # filter by stem diameter
ggplot(aes(x = Plant.height, y = Biomass.yield)) +
  geom_point() +
  facet_wrap(~ Genetic.group)

# color by stem diam
ggplot(mydata, aes(x = Plant.height, y = Biomass.yield,
                   color = Stem.diameter)) +
  geom_point() +
  facet_wrap(~ Genetic.group)

# color all points red
ggplot(mydata, aes(x = Plant.height, y = Biomass.yield)) +
  geom_point(color = "red", size = 3, alpha = 0.2) +
  facet_wrap(~ Genetic.group)

# add trendline
ggplot(mydata, aes(x = Plant.height, y = Biomass.yield,
                   color = Stem.diameter)) +
  geom_point() +
  geom_density2d(color = "yellow") +
  geom_smooth(se = FALSE, color = "green")# + 
  #facet_wrap(~ Genetic.group)

filter(mydata, Genetic.group %in% c("S Japan", "N Japan")) %>%
ggplot(aes(x = Plant.height, y = Biomass.yield,
                   color = Stem.diameter)) +
  geom_point() +
  geom_density2d(color = "yellow") +
  geom_smooth(se = FALSE, color = "green") +
  facet_grid(Number.of.stems > 100 ~ Genetic.group)

# transformations
ggplot(mydata, aes(x = Plant.height, y = Biomass.yield,
                   color = Stem.diameter)) +
  geom_point() +
  coord_trans(y = "log")

# boxplot
filter(mydata, Genetic.group %in% c("S Japan", "N Japan")) %>%
ggplot(aes(x = Genetic.group, y = Number.of.stems,
                   fill = Genetic.group)) +
  geom_boxplot() +
  coord_flip() +
  scale_fill_manual(~ Genetic.group,
                    values = c(`N Japan` = "blue",
                      `S Japan` = "yellow"))

# plot with base system, change color
par(mfrow = c(1, 1))
plot(mydata$Plant.height, mydata$Biomass.yield,
     col = c("darkolivegreen", "firebrick"))

col2rgb("firebrick")
microsoft_blue <- rgb(46, 117, 182, 50, maxColorValue = 255)

plot(mydata$Plant.height, mydata$Biomass.yield, # blah
#     col = microsoft_blue)
     col = "red")

Illini_colors <- rgb(c(19,232), c(41, 74),
                     c(75, 39), maxColorValue = 255)

plot(mydata$Plant.height, mydata$Biomass.yield,
     col = ifelse(mydata$Stem.diam > 4, Illini_colors[1],
                  Illini_colors[2]))

# palettes
rainbow(10)
plot(1:10, 1:10, col = viridis(10), pch = 16)

# viridis in ggplot
ggplot(mydata, aes(x = Plant.height, y = Biomass.yield,
                   color = Stem.diameter)) +
  geom_point() +
  scale_color_viridis(option = "inferno")

# color by number
color_by_number <- function(input_num, 
                            scale = viridis(100)){
  mymin <- min(input_num , na.rm = TRUE)
  mymax <- max(input_num , na.rm = TRUE)
  
  # scale from 0 to 1
  zero_to_one <- (input_num - mymin)/(mymax - mymin)
  # scale from 1 to 100
  one_to_scale <- zero_to_one * (length(scale) - 1) + 1
  # round to integer
  one_to_scale <- round(one_to_scale)
  # index color vector by these numbers
  return(scale[one_to_scale])
}

# now color by stem diameter
plot(mydata$Plant.height, mydata$Biomass.yield,
     col = color_by_number(mydata$Stem.diameter,
                           rainbow(50)))

# color brewer
display.brewer.all()

brewer.pal(6, "Set2")

plot(mydata$Plant.height, mydata$Biomass.yield,
     col = brewer.pal(6, "Set2"))

ggplot(mydata, aes(x = Genetic.group, y = Number.of.stems,
           fill = Genetic.group)) +
  geom_boxplot() +
  coord_flip() +
  scale_fill_brewer(type = "qual", palette = "Paired")

# shapes
plot(mydata$Plant.height, mydata$Biomass.yield, pch = 22,
     bg = "firebrick", col = "blue")

ggplot(mydata, aes(x = Plant.height, y = Number.of.stems,
                   shape = Genetic.group)) +
  geom_point()

ggplot(mydata, aes(x = Plant.height, y = Number.of.stems)) +
  geom_point(shape = 0)

# par
par("mar")  # show current value
par(mar = c(3.1, 3.1, 3.1, 1.1)) # change

# many par parameters are accessible in plot and other fns
plot(mydata$Plant.height, mydata$Biomass.yield, pch = 22,
     bg = "firebrick",  cex = 0.5)
axis(1, labels = FALSE, lwd = 2, col = "green")
# points
legend(100, 20000, legend = c("good", "bad"), pch = 16,
       col = c("blue", "green"))
# boxes
legend(100, 20000, legend = c("good", "bad"),
       fill = c("blue", "green"))
# lines
legend(100, 20000, legend = c("good", "bad"), lty = 1,
       col = c("blue", "green"))
# horizontal dotted line
abline(h = 10000, lty = 3)
# trendline
abline(lm(mydata$Biomass.yield ~ mydata$Plant.height),
       col = "green")

# find xycoords
locator(3)

draw_arrow <- function(){
  mypoints <- locator(2)
  arrows(mypoints$x[1], mypoints$y[1],
         mypoints$x[2], mypoints$y[2])
}

draw_arrow()

# expressions
plot(mydata$Plant.height, mydata$Biomass.yield, pch = 22,
     bg = "firebrick",  cex = 0.5,
     main = expression(paste("Yield in ", 
                             italic("M. sinensis"))))
text(150, 12000, expression(x != y))

# plot to file
pdf("figure_1.pdf", width = 7, height = 3.5, pointsize = 16)
plot(mydata$Plant.height, mydata$Biomass.yield, pch = 22,
     bg = "firebrick",  cex = 0.5,
     main = expression(paste("Yield in ", 
                             italic("M. sinensis"))))
plot(1:10, 1:10)
dev.off()
