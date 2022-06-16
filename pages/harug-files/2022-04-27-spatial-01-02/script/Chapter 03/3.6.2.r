# This continues from the file 3.6.1.r

# Check that IDs match 
library(sf)
thsn.geom.sf <- st_as_sf(thsn.sp)
str(thsn.geom.sf)
thsn.sf <- st_as_sf(thsn.spdf)
str(thsn.sf)
thsn.sf$ID
all.equal(1:length(thsn.sf$ID), thsn.sf$ID)

# Check that IDs match by plotting both
plot(thsn.spdf, pch = 1, cex = 0.1)
text(coordinates(thsn.spdf),
     labels=as.character(thsn.spdf@data$ID))
plot(thsn.spdf, pch = 1, cex = 0.1)
text(coordinates(thsn.spdf),
     labels=lapply(thsn.spdf@polygons, slot, "ID"))

