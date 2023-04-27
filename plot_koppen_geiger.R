library(raster)

workdir <- "C:/Users/denni/Documents/PhD_Project/koppen_geiger_climate_classification/"
# Where files should be output

output.name <- "mexico"
# Name of the output file to suffix the output file name

koppen.geiger.raster <- "C:/Users/denni/Documents/PhD_Project/koppen_geiger_climate_classification/CHELSA_kg2_1981-2010_V.2.1.tif"
# The raster containing the köppen geiger raster

land.raster <- raster("C:/Users/denni/Documents/PhD_Project/ENMs/elev_map/wc2.1_30s_elev.tif")
# Raster with water bodies set as missing data to be used as a mask to delimit köppen geiger raster to only land

#extent.raster <- raster("C:/Users/denni/Documents/PhD_Project/Porbiculare/ENM/cropped_now/bio1.tif")
# if one wants to use the extent of another raster, the path to the raster can be given here and uncommented
plot.extent.coords <- c(-120.1, -84, 13, 36)

overwrite.tiff = TRUE

setwd(workdir)

koppen.geiger <- raster(koppen.geiger.raster)

color.class <- c(
  #1
  rgb(0,0,255,maxColorValue=255),
  #2
  rgb(0,120,255,maxColorValue=255),
  #3
  #rgb(70,170,250,maxColorValue=255),
  #4
  rgb(35,145,255,maxColorValue=255),
  #5
  rgb(255,150,150,maxColorValue=255),
  #6
  rgb(255,0,0,maxColorValue=255),
  #7
  rgb(255,220,100,maxColorValue=255),
  #8
  rgb(245,165,0,maxColorValue=255),
  #9
  rgb(200,255,80,maxColorValue=255),
  #10
  rgb(100,255,50,maxColorValue=255),
  #11
  rgb(50,200,0,maxColorValue=255),
  #12
  rgb(255,255,0,maxColorValue=255),
  #13
  rgb(200,200,0,maxColorValue=255),
  #14
  rgb(150,150,0,maxColorValue=255),
  #15
  rgb(150,255,150,maxColorValue=255),
  #16
  rgb(100,200,100,maxColorValue=255),
  #17
  rgb(50,150,50,maxColorValue=255),
  #18
  rgb(0,255,255,maxColorValue=255),
  #19
  rgb(55,200,255,maxColorValue=255),
  #20
  rgb(0,125,125,maxColorValue=255),
  #21
  rgb(0,70,95,maxColorValue=255),
  #22
  rgb(255,0,255,maxColorValue=255),
  #23
  rgb(200,0,200,maxColorValue=255),
  #24
  rgb(150,50,150,maxColorValue=255),
  #25
  rgb(150,100,150,maxColorValue=255),
  #26
  rgb(170,175,255,maxColorValue=255),
  #27
  rgb(90,120,220,maxColorValue=255),
  #28
  rgb(75,80,180,maxColorValue=255),
  #29
  rgb(50,0,135,maxColorValue=255),
  #ET 30
  "grey70",
  #EF 31
  "grey40"
)

legend.labels <- c("Af - Tropical - equatorial fully humid ",
                   "Am - Tropical - equatorial monsoonal ",
                   #"As - Tropical - equatorial summer dry ",
                   "Aw - Tropical - equatorial winter dry ",
                   "BWk - Arid - cold desert ",
                   "BWh - Arid - hot desert ",
                   "BSk - Arid - cold steppe ",
                   "BSh - Arid - hot steppe ",
                   "Cfa - Temperate - fully humid hot summer ",
                   "Cfb - Temperate - fully humid warm summer ",
                   "Cfc - Temperate - fully humid cool summer ",
                   "Csa - Temperate - summer dry hot summer ",
                   "Csb - Temperate - summer dry warm summer ",
                   "Csc - Temperate - summer dry cool summer ",
                   "Cwa - Temperate - winter dry hot summer ",
                   "Cwb - Temperate - winter dry warm summer ",
                   "Cwc - Temperate - winter dry cool summer ",
                   "Dfa - Cold - fully humid hot summer ",
                   "Dfb - Cold - fully humid warm summer ",
                   "Dfc - Cold - fully humid cool summer ",
                   "Dfd - Cold - fully humid extremely continental ",
                   "Dsa - Cold - summer dry hot summer ",
                   "Dsb - Cold - summer dry warm summer ",
                   "Dsc - Cold - summer dry cool summer ",
                   "Dsd - Cold - summer dry extremely continental ",
                   "Dwa - Cold - winter dry hot summer ",
                   "Dwb - Cold - winter dry warm summer ",
                   "Dwc - Cold - winter dry cool summer ",
                   "Dwd - Cold - winter dry extremely continental ",
                   "ET - Polar - tundra ",
                   "EF - Polar - frost ")

extent.world <- extent(c(-180, 179.9999, -90, 83.99986))

koppen.geiger.world <- crop(koppen.geiger, extent.world)
land.raster.world <- crop(land.raster, extent.world)

koppen.geiger.land.raster.mask <- mask(koppen.geiger.world, land.raster.world)

crs.kg <- crs(koppen.geiger.land.raster.mask)

if (exists("extent.raster")) {
  extent.plot <- extent(extent.raster)
  print("extent.plot varible set via raster")
} else {
  extent.plot <- extent(plot.extent.coords)
  print("extent.plot varible set via given coords")
}


koppen.geiger.land.raster.mask.plot <- crop(koppen.geiger.land.raster.mask, extent.plot)

writeRaster(koppen.geiger.land.raster.mask.plot, 
            filename = paste(workdir,"/koppen.geiger_", output.name, ".tif", sep=""), 
            format = "GTiff",
            overwrite = overwrite.tiff)

koppen.geiger.plot <- raster(paste("koppen.geiger_", output.name, ".tif", sep=""))
koppen.geiger.plot.adj <- koppen.geiger.plot-1
col.vec <- as.vector(sort(unique(values(koppen.geiger.plot.adj))))

png(filename = paste("koppen.geiger_", output.name, ".png", sep=""), width = 1450, height = 800)
par(xpd = FALSE, mar = c(2.5, 2.5, 1, 20))
#c(5, 4, 4, 2) + 0.1.
plot(koppen.geiger.plot, col = color.class[col.vec], breaks = c(col.vec,31), legend = F)

par(xpd = TRUE)

legend(x = "left", legend = legend.labels[col.vec], fill = color.class[col.vec], 
       cex = 0.85, inset = 1.01)
dev.off()

#points(25,44, pch = 20, col = color.class[30])

#extract(koppen.geiger.plot, matrix(c(25,44), ncol = 2))

png(filename = paste("koppen.geiger_", output.name, "_small.png", sep=""), width = 600, height = 539)
par(xpd = FALSE, mar = c(13, 2.5, 1, 0))
#c(5, 4, 4, 2) + 0.1.
plot(koppen.geiger.plot, col = color.class[col.vec], breaks = c(col.vec,31), legend = F)

par(xpd = TRUE)

legend(x = "bottom", legend = legend.labels[col.vec], fill = color.class[col.vec], 
       cex = 0.85, inset = -0.5, ncol = 2)
dev.off()
