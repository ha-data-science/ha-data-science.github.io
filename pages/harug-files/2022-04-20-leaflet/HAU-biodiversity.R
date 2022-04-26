## HEADER ####
## who: Ed Harris
## what: HAU biodiversity map, eventual shiny app
## when: 2022-03-27


## CONTENTS ####
## 00 Setup
## 01 Map


## 00 Setup ####
library(leaflet) # Leaflet
library(openxlsx)
library(rgdal)
library(sf)

### Data sources & EDA ####
# NBN Atlas
# https://species.nbnatlas.org/species/NBNSYS0000006064

# GBIF
# https://www.gbif.org/species/1861510

# data
occurrence <- <your data here!>

# how many records per year?
length(table(occurrence$Start.date.year))
sort(unique(occurrence$Start.date.year))

# peek at 'shape' of the data
table(occurrence$Class)

# how many bird species?
length(table(occurrence$Common.name[birds]))
length(table(occurrence$Family[birds]))

# Farm Bird Indicators
fbi

# all occurrence !=
x <- table(occurrence$Start.date.year)
plot(y = as.numeric(x),
     x = sort(unique(occurrence$Start.date.year)),
     type='b',
     xlim = c(1980, 2022))

# bird occurrence
x <- table(occurrence$Start.date.year[birds])
plot(y = as.numeric(x),
     x = sort(unique(occurrence$Start.date.year[birds])),
     type='b',
     xlim = c(1980, 2022))


# Dist of families
length(table(occurrence$Family[birds]))

par(mar=c(5,8,4,2)+.1)
barplot(sort(table(occurrence$Family[birds])), horiz = T, las = 1, 
        cex.names = 1)
par(mar=c(5,4,4,2)+.1)



# 01 Map ####

fbi


rad <- 2
opacity <- .5
pallette <- RColorBrewer::brewer.pal(n=9,name='Set1')
longdisp <- 100
latdisp <- 50


  
sub <- leps

# version 2
map <- leaflet(occurrence[sub,]) %>%
  addTiles() %>%  # Add default OpenStreetMap map tiles
  setView(lng=hauloc[2], lat=hauloc[1], zoom = 13) %>%
  addCircleMarkers(lng = occurrence[sub,]$long, 
                   lat = occurrence[sub,]$lat,
                   stroke = F,
                   clusterOptions = markerClusterOptions())  
addScaleBar(
  map, position = c("topright")
)

# for image background
map %>% addProviderTiles(providers$Esri.WorldImagery)





# map %>% addProviderTiles(providers$Esri.WorldTopoMap) # Good background
# 
# map %>% addMarkers(lng=aves[lapwing,]$long, 
#                    lat=aves[lapwing,]$lat)
# good one
# map %>% addProviderTiles(providers$Esri.WorldImagery)
# map %>% addProviderTiles(providers$Stamen.Toner) %>%
# map %>% addProviderTiles(providers$Esri.CartoDB.Positron)
# map %>% addProviderTiles(providers$CartoDB.Positron)
# map %>% addProviderTiles(providers$OpenTopoMap)
# map %>% addProviderTiles(providers$Stamen.Terrain)
# map %>% addProviderTiles(providers$MtbMap)

## Sources ####

# https://rstudio.github.io/leaflet/markers.html
# https://www.r-bloggers.com/2021/03/downloading-and-cleaning-gbif-data-with-r/
# https://rpubs.com/mattdray/basic-leaflet-maps
# https://bookdown.org/nicohahn/making_maps_with_r5/docs/introduction.html
# https://r-spatial.org/r/2018/10/25/ggplot2-sf.html

# https://www.molecularecologist.com/2012/09/18/making-maps-with-r/


# version 1
map <- leaflet(occurrence[focal,]) %>%
  addTiles()  %>% # Add default OpenStreetMap map tiles
  setView(lng=hauloc[2], lat=hauloc[1], zoom = 13) 

map %>%
  addCircleMarkers(lng = jitter(occurrence[focal,]$long, longdisp), 
                   lat = jitter(occurrence[focal,]$lat, latdisp),
                   stroke = F,
                   radius = rad,
                   fillColor = pallette[6],
                   fillOpacity = opacity) 

map %>%
  addCircleMarkers(lng = jitter(occurrence[focal2,]$long, longdisp), 
                   lat = jitter(occurrence[focal2,]$lat, latdisp),
                   stroke = F,
                   radius = rad,
                   fillColor = pallette[2],
                   fillOpacity = opacity) %>%
  addCircleMarkers(lng = jitter(occurrence[focal3,]$long, longdisp), 
                   lat = jitter(occurrence[focal3,]$lat, latdisp),
                   stroke = F,
                   radius = rad,
                   fillColor = pallette[3],
                   fillOpacity = opacity) %>% 
  addCircleMarkers(lng = jitter(occurrence[focal4,]$long, longdisp), 
                   lat = jitter(occurrence[focal4,]$lat, latdisp),
                   stroke = F,
                   radius = rad,
                   fillColor = pallette[4],
                   fillOpacity = opacity) %>% 
  
  addCircleMarkers(lng = jitter(occurrence[focal5,]$long, longdisp), 
                   lat = jitter(occurrence[focal5,]$lat, latdisp),
                   stroke = F,
                   radius = rad,
                   fillColor = pallette[5],
                   fillOpacity = opacity) %>% 
  addCircleMarkers(lng = jitter(occurrence[focal6,]$long, longdisp), 
                   lat = jitter(occurrence[focal6,]$lat, latdisp),
                   stroke = F,
                   radius = rad,
                   fillColor = pallette[1],
                   fillOpacity = opacity) 
addLegend(map, 
          position = "bottomright",
          colors = pallette[1:6],
          labels = fbi[c(1,2,8, 9, 12, 14)], opacity = 1,
          title = "species"
)

addScaleBar(
  map, position = c("topright")
) 