library(sp);library(data.table)
track <- fread("track.csv")
setnames(track,"altitude (m)","alt")
spf <- SpatialPoints(track[,.(longitude,latitude)],proj4string = CRS("+proj=longlat +datum=WGS84"))


library(ggmap);library(plotly)
qmap("Vienna", zoom = 4)
qmap("Vienna", zoom = 10)

qmap("Vorau", zoom = 10) +geom_path(
  aes(x = longitude, y = latitude),  colour = 'red', size = 1.5,
  data = track, lineend = 'round'
)

qmap("Brennerwirt, Vorau", zoom = 14) +geom_path(
  aes(x = longitude, y = latitude),  colour = 'red', size = 1.5,
  data = track, lineend = 'round'
)
qmap("Brennerwirt, Vorau", zoom = 14) +geom_path(
  aes(x = longitude, y = latitude,colour=alt), size = 1.5,
  data = track, lineend = 'round'
)

#First interactive map
plotly(qmap("Brennerwirt, Vorau", zoom = 14) +geom_path(
  aes(x = longitude, y = latitude),  colour = 'red', size = 1.5,
  data = track, lineend = 'round'
))

# Nice interactive map
library(mapview)
mapView(spf)
