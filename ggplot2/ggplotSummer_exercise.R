## ---- eval = FALSE, echo = FALSE-----------------------------------------
## ls()

## ------------------------------------------------------------------------
data(Cars93, package = "MASS")

## ---- fig.align="center", fig.width=9------------------------------------
require("ggplot2")  
g <- ggplot(Cars93, aes(x=MPG.city, y=Weight))
g <- g + geom_point(color="blue"); g

## ---- fig.align="center", fig.width=9------------------------------------
g + geom_point(aes(color=Origin))

## ---- fig.align="center", fig.width=9------------------------------------
g <- ggplot(Cars93,aes(x=Type,y=MPG.city))
g <- g + geom_boxplot()
g + geom_point(aes(color=Origin)) 

## ---- fig.align="center", fig.width=9------------------------------------
g <- ggplot(Cars93,aes(x=Weight,y=Horsepower))
g <- g + geom_point()
g + geom_smooth() 

## ---- fig.align="center", fig.width=9------------------------------------
g <- g + geom_smooth(method="lm") 
g

## ---- fig.align="center", fig.width=9------------------------------------
g <- g + facet_wrap(~ Origin) 
g

## ---- fig.align="center", fig.width=9------------------------------------
g <- g + theme_bw()
g

## ---- fig.align="center", fig.width=9------------------------------------
g <- g + geom_point(aes(size = Max.Price), alpha =0.4)
g

## ---- fig.align="center", fig.width=9------------------------------------
g <- g + theme(text = element_text(size=20))
g

## ---- fig.align="center", fig.width=9------------------------------------
g <- g + theme(text = element_text(family="Times"))
g

## ---- fig.align="center", fig.width=9------------------------------------
g <- g + geom_hline(yintercept = 90, colour="red")
g

## ---- fig.align="center", fig.width=9------------------------------------
g <- g + scale_y_continuous(breaks = c(50, 90, 150, 200, 300))
g

## ----new-----------------------------------------------------------------
olddata_wide <- read.table(header=TRUE, text='
 time sex control cond1 cond2
       1   M     7.9  12.3  10.7
       2   F     6.3  10.6  11.1
       3   F     9.5  13.1  13.8
       4   M    11.5  13.4  12.9
')

## ----gr1, echo=FALSE, fig.align='center'---------------------------------
library(tidyr)
library(ggplot2)
data_long <- gather(olddata_wide, condition, measurement, control:cond2, factor_key=TRUE)
ggplot(data_long, aes(x = time, y = measurement, group=condition, color=condition)) + geom_line()

## ----gr11, echo=TRUE, fig.keep='none'------------------------------------
library(tidyr)
## ggplot2 needs tidy data!
## use e.g. reshape2::melt or
## tidy::gather
data_long <- gather(olddata_wide, condition, measurement, control:cond2, factor_key=TRUE)
ggplot(data_long, aes(x = time, y = measurement, group=condition, color=condition)) + geom_line()

## ---- eval=FALSE---------------------------------------------------------
## install.packages("extrafont")
## install.packages("xkcd")
## ## look at
## vignette("xkcd-intro")

