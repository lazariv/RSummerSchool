library(ggplot2)
data(Cars93, package = "MASS")

### Exercise 1
ggplot(data=Cars93, aes(x=Weight,y=MPG.city)) +
  geom_point(aes(color=Origin))

### Exercise 2
ggplot(data=Cars93, aes(x=Type,y=MPG.city)) +
  geom_boxplot() + geom_point(aes(color=Origin))
#ggplot(data=Cars93, aes(x=1,y=MPG.city)) +
#  geom_boxplot()

g2 = ggplot(data=Cars93, aes(y=Horsepower, x=Weight)) +
  geom_point() + geom_smooth(method = "lm") + facet_wrap(~Origin)

### Exercise 3
g2 + theme_bw() + geom_point(aes(size=Max.Price), alpha=0.3) +
  theme(text=element_text(size=14, family = "Times")) +
  geom_abline(slope=0,intercept=90,color="red") +
  scale_y_continuous(breaks=c(50,90,150,200,300))

### Exercise 4
olddata_wide <- read.table(header=TRUE, text='
 time sex control cond1 cond2
                           1   M     7.9  12.3  10.7
                           2   F     6.3  10.6  11.1
                           3   F     9.5  13.1  13.8
                           4   M    11.5  13.4  12.9
                           ')
newdata = reshape2::melt(olddata_wide, id.vars=c("time","sex"))
ggplot(data=newdata, aes(x=time,y=value, group=variable)) +
  geom_line(aes(color=variable))


