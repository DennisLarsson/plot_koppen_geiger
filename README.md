# plot_koppen_geiger
An R script that can be used to plot köppen geiger raster layer from CHELSA


CHELSA has a high resolution (1km/30 arcsec) köppengeiger raster layer that has been calculated using their high resoltion climate data. It can be found here (the kg2 is used in the example of this script, found under 1981-2010/ then bio/): https://chelsa-climate.org/1-km-global-koppen-geiger-climate-classification-for-present-and-future/

Since the default layer includes water bodies, this script can take a layer that excludes water bodies and use that to mask the köppen geiger layer. This means that only köppen geiger data for land bodies remain (oceans etc are set to missing data and not plotted). In the script the elevation data from WorldClim 2 is used and is available from here: https://www.worldclim.org/data/worldclim21.html

The script is run by first editing the variables at the beginning of the script:

```
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
```

and then running the script (either in R using for example: `source("~/PhD_Project/koppen_geiger_climate_classification/plot_koppen_geiger.R", encoding = 'UTF-8')` or in the terminal like this (in ubuntu): `Rscript plot_koppen_geiger.R`
