## ----eval=FALSE, echo=FALSE----------------------------------------------
## ls()

## ------------------------------------------------------------------------
data(mtcars)
head(mtcars)

## ---- eval=TRUE----------------------------------------------------------
library(data.table)
data(mtcars) # ?mtcars
head(mtcars)

## ---- eval=TRUE----------------------------------------------------------
mtcars <- as.data.table(mtcars); head(mtcars)

## ---- eval=FALSE, echo=FALSE---------------------------------------------
## # http://www.r-bloggers.com/using-r-for-introductory-statistics-chapter-4/

## ---- eval=FALSE, echo=TRUE----------------------------------------------
## f <- rep("domestic", nrow(mtcars))
## f[c(1:3, 8:14, 18:21, 26:28, 30:32)] <- "import"
## f <- factor(f, levels=c('import', 'domestic'))

## ---- eval=TRUE----------------------------------------------------------
tables()

## ---- eval=TRUE----------------------------------------------------------
f <- rep("domestic", nrow(mtcars))
f[c(1:3, 8:14, 18:21, 26:28, 30:32)] <- "import"
f <- factor(f, levels=c('import', 'domestic'))

# variante 1
mtcars[,origin := f]

# analog
# mtcars$origin <- f

# Check:
head(mtcars)

## ---- eval=TRUE----------------------------------------------------------
mtcars[, c("hp","drat") := NULL]
head(mtcars)

# alternative
# mtcars$hp <- mtcars$drat <- NULL

## ---- eval=TRUE----------------------------------------------------------
mtcars[i=1:5] # mtcars[i=1:5,]

## ---- eval=TRUE----------------------------------------------------------
mtcars[i=1:5, .(names,mpg,cyl,origin)]

## ---- eval=TRUE----------------------------------------------------------
mtcars[, mean(mpg),by=cyl]
mtcars[, mpgmean:=mean(mpg),by=cyl]

## ---- eval=TRUE----------------------------------------------------------
setkey(mtcars, mpg) # alternativ: setkeyv(mtcars, "mpg")
tables()

## ---- eval=TRUE----------------------------------------------------------
mtcars[.(30.4)] # equals mtcars[.(30.4), mult="all"]
mtcars[.(30.4), mult="first"] # mtcars[.(30.4), mult="last"]

## ---- eval=TRUE----------------------------------------------------------
setkey(mtcars, origin, mpg) # alternative: setkeyv(mtcars, c("origin","mpg"))
tables()

## ---- eval=TRUE----------------------------------------------------------
mtcars[.("domestic",19.2)]

## ---- eval=TRUE----------------------------------------------------------
setkey(mtcars, origin)

## ---- eval=TRUE----------------------------------------------------------
mtcars[,.(mittel.mpg=mean(mpg), min.qsec=min(qsec), max.qsec=max(qsec))]

## ---- eval=TRUE----------------------------------------------------------
mtcars[,.(mittel.mpg=mean(mpg), min.qsec=min(qsec), max.qsec=max(qsec)), by=key(mtcars)]

## ---- eval=TRUE----------------------------------------------------------
agg <- mtcars[,.(mittel.mpg=mean(mpg)), by="origin"]
is.data.table(agg)


## ---- eval=TRUE----------------------------------------------------------
setkey(agg, origin); setkey(mtcars, origin)
mtcars <- merge(mtcars, agg)

## ---- eval=TRUE----------------------------------------------------------
head(mtcars)

## ---- eval=TRUE----------------------------------------------------------
trans <- function(x,cylinder){
  fun <- mean
  if(cylinder==6)
    fun <- median
  else if(cylinder==8)
    fun <- max
  return(fun(x))
}

## ---- eval=TRUE----------------------------------------------------------
mtcars[,trans(mpg,.BY),by=cyl]
mtcars[,V1:=trans(mpg,.BY),by=cyl]

## ---- eval=TRUE----------------------------------------------------------
longCars <- melt(mtcars[,.(mpg,cyl)])
head(longCars)

