# plot_koppen_geiger
An R script that can be used to plot köppen geiger raster layer from CHELSA


CHELSA has a high resolution (1km/30 arcsec) Köppen-Geiger raster layer that has been calculated using their high resolution climate data. It can be found here (the kg2 is used in the example of this script, found under 1981-2010/ then bio/): https://chelsa-climate.org/1-km-global-koppen-geiger-climate-classification-for-present-and-future/

Direct link to the kg2 Köppen-Geiger raster layer: https://os.zhdk.cloud.switch.ch/envicloud/chelsa/chelsa_V2/GLOBAL/climatologies/1981-2010/bio/CHELSA_kg2_1981-2010_V.2.1.tif

The color coding for the climate classifications are the same as in Peel et al 2007 (https://hess.copernicus.org/articles/11/1633/2007/hess-11-1633-2007.html), which climate definitions were used in the calculation of the layers by CHELSA.

Since the default layer includes water bodies, this script can take a layer that excludes water bodies and use that to mask the Köppen-Geiger layer. This means that only climate classification data for land bodies remain (oceans etc are set to missing data and not plotted). This script uses the elevation raster layer from WorldClim 2 to mask the Köppen-geiger layer and remove water bodies. It can be found here: https://www.worldclim.org/data/worldclim21.html

make sure you have the R package 'raster' installed, if you are uncertain whether it is installed run this command in R:

`install.packages("raster")`

it might fail at installing a subpackage called 'terra'. Most likely it is missing the GDAL library on ubuntu and needs to be installed using:

`sudo apt install libgdal-dev` 

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

and then running the script, either in R using for example: 

`source("~/PhD_Project/koppen_geiger_climate_classification/plot_koppen_geiger.R", encoding = 'UTF-8')` 

or in the terminal like this (in ubuntu): 

`Rscript plot_koppen_geiger.R`

The processing of the high resolution layers take a long time and the script may take up to 10 minutes or more to run on older computers. 
