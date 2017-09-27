## ----eval=FALSE, echo=FALSE----------------------------------------------
## ls()

## ----eval=TRUE, echo=TRUE------------------------------------------------
library(data.table)

## ----eval=TRUE, echo=TRUE------------------------------------------------
df <- data.frame(x=rep(c("a","b","c"),each=3), y=c(1,3,6), v=1:9)
c(is.data.frame(df), is.data.table(df))

## ----eval=TRUE, echo=TRUE------------------------------------------------
dt <- data.table(x=rep(c("a","b","c"),each=3), y=c(1,3,6), v=1:9)
c(is.data.frame(dt), is.data.table(dt))

## ----eval=TRUE, echo=TRUE------------------------------------------------
df
dim(df)
is.list(df)

## ----eval=TRUE, echo=TRUE------------------------------------------------
dt
dim(dt)
is.list(dt)

## ----eval=TRUE, echo=TRUE------------------------------------------------
dt2 <- as.data.table(df)
is.data.table(dt2)

## ----eval=TRUE, echo=TRUE------------------------------------------------
as.data.table(diag(3))

## ----eval=TRUE, echo=TRUE------------------------------------------------
dt2 <- as.data.table(df)
is.data.table(dt2)

## ----eval=TRUE, echo=TRUE------------------------------------------------
as.data.table(diag(3))

## ----eval=TRUE, echo=TRUE------------------------------------------------
x <- list(1:3,4:6)
setDT(x)
x

## ----eval=TRUE, echo=FALSE-----------------------------------------------
f <- "daten/testdaten_datatable.csv"
if ( !file.exists(f) ) {
  N <- 100

  dat <- data.frame(x=sample(LETTERS[1:5], N, replace=TRUE), y=rpois(N, 5), z=rpois(N, 10))
  write.table(dat, file=f, sep=";", col.names=TRUE, row.names=FALSE)
  rm(dat)
}

## ----eval=TRUE, echo=TRUE------------------------------------------------
f.in <- "daten/testdaten_datatable.csv"
dat1 <- read.table(file=f.in, sep=";", header=T)
head(dat1, 5)
class(dat1)

## ----eval=TRUE, echo=TRUE, cache=TRUE------------------------------------
f.in <- "daten/testdaten_datatable.csv"
dat2 <- fread(input=f.in)
head(dat2, 5)
class(dat2)

## ----eval=TRUE, echo=FALSE-----------------------------------------------
rm(dat1, dat2)

## ----eval=TRUE, echo=TRUE------------------------------------------------
tables()

## ----eval=TRUE, echo=TRUE------------------------------------------------
dt$tmp1 <- rnorm(nrow(dt)) # can be used like with lists and data frames

## ----eval=TRUE, echo=TRUE------------------------------------------------
dt[,tmp2:=v-1] # direct generation in data.table like syntax

## ----eval=TRUE, echo=TRUE------------------------------------------------
fun <- function(a,b) {
  list(r1=a+b, r2=a-b)
}
dt[,c("v1","v2"):=fun(y,v)]

## ----eval=TRUE, echo=TRUE------------------------------------------------
dt[,tmp1:=NULL]
dt$tmp2 <- NULL; dt

## ----eval=TRUE, echo=TRUE------------------------------------------------
dt[ ,c("v1","v2") := NULL]

## ----eval=TRUE, echo=TRUE------------------------------------------------
dt[i=2] # second row (all columns)
dt[i=c(1,5)] # first and fifth row (all columns)
dt[i=-c(1:5)] # first to fifth row (all columns)

## ----eval=TRUE, echo=TRUE------------------------------------------------
dt[i=1:2,j=3] #Third column ("v") as data.table
dt[i=1:2,j="v"] # Result is data.table
dt[i=1:2,j=v] # Result ist Vektor
z <- "v"
#dt[i=1:3, j=z] # Error, z is not in the data.table, but will be evaluated
dt[i=1:3, j=z, with=FALSE] # j will be evaluated as character result=data.table

## ----eval=TRUE, echo=TRUE------------------------------------------------
dt[[3]] # Third column (data.table are lists)
dt[["v"]] # Second column (data.table are lists)
dt[1:3,list(x,y,v,z=y+v)] # Rows 1-3, all columns + new computed variable
dt[1:3,.(x,y,v,z=y+v)] #.() short for list() in a data.table call

## ----eval=TRUE, echo=TRUE------------------------------------------------
dt[,list(sum.v=sum(v), mean.v=mean(v))] # Sum and mean of variable "v"
dt[,list(x=x, y=y, v=v, sum.v=sum(v), mean.v=mean(v))]

## ----eval=TRUE, echo=TRUE------------------------------------------------
setkey(dt, x) # analog setkeyv(dt, "x")
tables()

## ----eval=TRUE, echo=TRUE------------------------------------------------
setkey(dt, x,y); dt

## ----eval=TRUE, echo=TRUE------------------------------------------------
key(dt)

## ----eval=TRUE, echo=TRUE------------------------------------------------
setkey(dt, x); dt["b"] # all rows with x=="b"

## ----eval=TRUE, echo=TRUE------------------------------------------------
dt["b", mult="first"] # first row with x=="b"

## ----eval=TRUE, echo=TRUE------------------------------------------------
# all rows with x "a" or "c" and y==3
setkey(dt, x, y); dt[list(c("a","c"),3)]

## ----eval=TRUE, echo=TRUE, cache=TRUE------------------------------------
library(microbenchmark)
N <- 1e6
dat<- data.table(
  x=sample(LETTERS[1:20], N, replace=TRUE),
  y=sample(letters[1:5], N, replace=TRUE))
setkey(dat, x,y)

microbenchmark(
  binsearch=dat[list(c("B","D"),c("b","d"))],
  vecsearch=dat[x%in%c("B","D") & y%in%c("b","d")]
)

## ----eval=TRUE, echo=TRUE, cache=TRUE------------------------------------
dt[,list(sum.v=sum(v)), by=y]

## ----eval=TRUE, echo=TRUE, cache=TRUE------------------------------------
# verwenden des aktuellen keys
setkey(dt, x)
dt[,list(sum.v=sum(v)), by=key(dt)]

## ----eval=TRUE, echo=TRUE, cache=TRUE------------------------------------
rows <- 1000; cols <- 10
dat <- data.table(matrix(round(runif(rows*cols)*100), ncol=cols))
dat[,key:=sample(LETTERS[1:5], rows, replace=TRUE)] # hinzufügen einer Variable

## ----eval=TRUE, echo=TRUE, cache=TRUE------------------------------------
setkey(dat, key)
dat[,lapply(.SD, mean), by=key]
dat[,lapply(.SD, mean), by=key, .SDcols=c("V1","V5","V6")]

## ----eval=TRUE, echo=TRUE, cache=TRUE------------------------------------
setkey(dt, x)
key(dt)
dt[,list(N=.N), by=key(dt)]

## ----eval=TRUE, echo=TRUE, cache=TRUE------------------------------------
A <- data.table(x=c("A","A","A","B","B"), y=sample(1:5))
setkey(A, x)[] # [] = gleichzeitige Ausgabe
B <- data.table(x=c("B","C"), z=c(10, 20), key="x") # direkte Angabe eines Keys
B

## ----eval=TRUE, echo=TRUE, cache=TRUE------------------------------------
merge(A,B) # inner join, only values in A and B
merge(A,B, all=TRUE) # full outer join, all values of A and B

## ----eval=TRUE, echo=TRUE, cache=TRUE------------------------------------
merge(A,B, all.x=TRUE) # all obs from A
merge(A,B, all.y=TRUE) # all obs from B

## ----eval=TRUE, echo=TRUE, cache=TRUE------------------------------------
A[B,nomatch=0]# by default keys are used to match
A[B,nomatch=0,on=.(x)] # with .on matching variables can be defined
A[B,nomatch=NA] # nomatch=0 removes these rows, nomatch=NA returns the NA

## ----eval=TRUE, echo=TRUE, cache=TRUE------------------------------------
getDTthreads()# Default: Maximum number of available threads
setDTthreads(1)# can be manually set to a value, 1 => no parallelization

## ------------------------------------------------------------------------
dt1 <- data.table(v1=1:3)
dt2 <- dt1 # no copying, just a new reference
print(dt1)

## ------------------------------------------------------------------------
print(dt2)

## ------------------------------------------------------------------------
dt1[,v2:=LETTERS[1:3]]
print(dt1)

## ------------------------------------------------------------------------
print(dt2)

## ------------------------------------------------------------------------
dt3 <- copy(dt1) # variables v1, v2
dt1[,v3:=rnorm(3)] # v3 is now in dt1, but not in dt2
print(dt1)

## ------------------------------------------------------------------------
print(dt3)

## ----eval=FALSE, echo=TRUE-----------------------------------------------
## dt[,vneu:=valt+1] # neue Variable erstellen
## dt[,vneu:=NULL]

## ----eval=FALSE, echo=TRUE-----------------------------------------------
## dt[,list(summe=sum(v)), by="x"] # Summe von "v" gruppiert nach Variable 'x'

## ------------------------------------------------------------------------
dt <- data.table(x=rnorm(8e6),y=rnorm(8e6),a=sample(LETTERS[1:10],8e6,rep=TRUE))
print(dt)

## ------------------------------------------------------------------------
dt[x%between%c(-.5,.5)]

## ------------------------------------------------------------------------
dt <- data.table(x=rnorm(8e6),y=rnorm(8e6),a=sample(LETTERS[1:10],8e6,rep=TRUE))
print(dt)

## ------------------------------------------------------------------------
dt[a%chin%LETTERS[1:3]]

## ------------------------------------------------------------------------
DT = data.table(Name=c("Mary","George","Martha"), Salary=c(2,3,4))
DT[Name %like% "^Mar"]

## ------------------------------------------------------------------------
Y <- data.table(a=c(8,3,10,7,-10), val=runif(5))
range <- data.table(start = 1:5, end = 6:10)
range
Y[a %inrange% range]

## ----eval=TRUE,print=FALSE,echo=FALSE------------------------------------
DT <- data.table(
      i_1 = c(1:5, NA),
      i_2 = c(NA,6,7,8,9,10),
      f_1 = factor(sample(c(letters[1:3], NA), 6, TRUE)),
      f_2 = factor(c("z", "a", "x", "c", "x", "x"), ordered=TRUE),
      c_1 = sample(c(letters[1:3], NA), 6, TRUE),
      d_1 = as.Date(c(1:3,NA,4:5), origin="2013-09-01"),
      d_2 = as.Date(6:1, origin="2012-01-01"))
# add a couple of list cols
DT[, l_1 := DT[, list(c=list(rep(i_1, sample(5,1)))), by = i_1]$c]
DT[, l_2 := DT[, list(c=list(rep(c_1, sample(5,1)))), by = i_1]$c]

## ------------------------------------------------------------------------
head(DT)

## ------------------------------------------------------------------------
melt(DT, id=1:2, measure="f_1")

## ------------------------------------------------------------------------
DT <- data.table(v1 = c(1.1, 1.1, 1.1, 2.2, 2.2, 2.2),
                 v2 = factor(c(1L, 1L, 1L, 3L, 3L, 3L), levels=1:3),
                 v3 = factor(c(2L, 3L, 5L, 1L, 2L, 6L), levels=1:6),
   v4 = c(3L, 2L, 2L, 5L, 4L, 3L))
head(DT)
dcast(DT, v1 + v2 ~ v3)

