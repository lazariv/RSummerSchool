## ---- eval = TRUE, echo = FALSE, results='hide'--------------------------
ls()
library("knitr")
library("ggplot2")
theme_set(theme_grey(base_size = 22))

## ---- fig.align="center"-------------------------------------------------
data("Cars93", package="MASS")
plot(MPG.city ~ Horsepower, data=Cars93) 

## ---- fig.align="center"-------------------------------------------------
require("ggplot2") 
ggplot(Cars93, aes(x=Horsepower, y=MPG.city)) + geom_point()      

## ---- fig.align="center", results="asis", echo=TRUE, eval=FALSE----------
## require("ggvis")
## Cars93 %>% ggvis(x = ~Horsepower, y = ~MPG.city) %>% layer_points()

## ---- fig.align="center"-------------------------------------------------
hist(Cars93$MPG.city)

## ---- fig.align="center"-------------------------------------------------
ggplot(Cars93, aes(x=MPG.city))+
  geom_histogram(binwidth=5)

## ---- fig.align="center"-------------------------------------------------
par(mar=c(4,4,.1,.1))
plot(MPG.city ~ Horsepower, data=Cars93, 
     col=Cars93$Origin, pch=c(1,2))  
legend("topright", c("USA", "non-USA"), 
     title="Origin", pch=c(1,2),  
     col=c("black", "red")) 

## ---- fig.align="center", fig.width=10-----------------------------------
ggplot(Cars93, aes(x=Horsepower, y=MPG.city, color=Origin)) + geom_point()   

## ---- fig.align="center", fig.width=9------------------------------------
ggplot(Cars93, aes(x=Horsepower, y=MPG.city, color=Origin)) + geom_point() + facet_wrap(~Cylinders)   

## ---- fig.align="center", fig.height=5-----------------------------------
ggplot(Cars93, aes(x = Horsepower, y = MPG.city)) + geom_point(aes(color = Cylinders))

## ---- fig.align="center", fig.height=6-----------------------------------
g1 <- ggplot(Cars93, aes(x=Horsepower, y=MPG.city))
g2 <- g1 + geom_point(aes(color=Weight)) + geom_smooth()  
g2 

## ---- fig.align="center", fig.height=6-----------------------------------
g1 + geom_text(aes(label=substr(Manufacturer,1,3), size=EngineSize)) + geom_smooth() 

## ---- fig.align="center", fig.height=6-----------------------------------
## value outside aes() -- assignment
g1 + geom_point(color="red", size=3) + geom_smooth()  

## ---- fig.align="center", fig.height=6-----------------------------------
## variable inside aes() -- aesthetic mapping d
g1 + geom_point(aes(color=Weight, shape=Origin)) + geom_smooth()   

## ---- fig.align="center", fig.height=6-----------------------------------
g <- ggplot(Cars93, aes(x = Type, y = MPG.city))
g + geom_boxplot() + geom_point()

## ---- fig.align="center", fig.height=6-----------------------------------
g <- ggplot(Cars93, aes(x = Type, y = MPG.city))
g + stat_boxplot() + geom_point()

## ---- fig.align="center", fig.height=4-----------------------------------
ggplot(Cars93, aes(x = MPG.city)) + geom_histogram(binwidth=3)

## ------------------------------------------------------------------------
g <- ggplot(Cars93, aes(x = MPG.city, y = Horsepower)) 

## ---- fig.align="center", fig.height=4-----------------------------------
g + geom_point()

## ---- fig.align="center", fig.height=4-----------------------------------
g + geom_line()

## ---- fig.align="center"-------------------------------------------------
ggplot(Cars93, aes(MPG.city, Horsepower, shape = Cylinders))+
  geom_point() + stat_smooth(method = "lm")

## ---- fig.align="center", fig.width=8------------------------------------
g <- ggplot(Cars93, aes(x = Type, y = MPG.city))
g <- g + geom_point(aes(color = Weight))   
g 

## ---- fig.align="center", fig.width=10-----------------------------------
g <- g + scale_x_discrete("Cylinders", labels = c("three","four","five","six","eight","rotary"))
g

## ---- fig.align="center"-------------------------------------------------
m <- max(Cars93$MPG.city)
g <- g + scale_y_continuous(breaks=c(10,20,30,m), labels=c("ten (10)", "twenty (20)", "thirty (30)", paste("max (",m,")"))); g 

## ---- echo=FALSE---------------------------------------------------------
titanic <- read.csv(paste("http://biostat.mc.vanderbilt.edu/",
        "wiki/pub/Main/", 
        "DataSets/titanic3.csv", sep = ""))
library(plyr)
titanic$age.g <- as.integer(cut(titanic$age, 10))
td <- ddply(titanic, c("pclass", "age.g", "sex"),
    summarize,
    ps = length(survived[survived == 1])/length(survived))

## ---- fig.align="center"-------------------------------------------------
data(td)
str(td)
head(td,12)
## note: ps = ratio of people survived

## ---- fig.align="center"-------------------------------------------------
tdg <- ggplot(td, aes(x = age.g, y = ps))  
tdg + geom_point()

## ---- fig.align="center"-------------------------------------------------
tdg + geom_point(aes(color = pclass, shape = sex)) 

## ---- fig.align="center", fig.width=10-----------------------------------
tdg + geom_point(aes(shape = sex)) + facet_wrap( ~ pclass)  

## ---- fig.align="center", fig.width=10-----------------------------------
tdg <- tdg + geom_point() + facet_grid(sex ~ pclass)
tdg  

## ---- fig.align="center", fig.height=4-----------------------------------
tdg + theme_bw() 

## ---- fig.align="center", fig.height=6-----------------------------------
library(ggthemes) 
tdg + theme_wsj()  

## ---- fig.align="center"-------------------------------------------------
gg <- ggplot(Cars93, aes(x = Type, y = MPG.city)) 
gg <- gg + geom_point(aes(color = Weight)) 
gg + theme(plot.background = element_rect(fill = 'green', colour = 'red')) +  theme(panel.grid.major = element_line(colour = "blue"))

## ---- fig.align="center", fig.height=4-----------------------------------
theme_new <- function(base_size = 12, base_family = "Helvetica"){
  theme_bw(base_size = base_size, base_family = base_family) %+replace%
    theme(
      axis.title = element_text(size = 16),
      legend.key=element_rect(colour=NA, fill =NA),
      panel.grid = element_blank(),   
      panel.border = element_rect(fill = NA, colour = "blue", size=2),
      panel.background = element_rect(fill = "red", colour = "black"), 
      strip.background = element_rect(fill = NA)
      )
}

## ---- fig.align="center", fig.height=4-----------------------------------
gg  

## ---- fig.align="center", fig.height=4-----------------------------------
gg + theme_new() 

