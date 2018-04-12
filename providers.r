install.packages("readxl")
install.packages("tidyverse")
install.packages('ggmap')
library(readxl)
library(tidyverse)
library(ggmap)
library(DT)
library(knitr)
library(ggplot2)

providers <- read_excel("Anthem.xlsm", sheet = "IndividualProviders1", skip = 2962, 
                        col_names = c("Street", "City", "State", "Zip"), col_types = c("skip", "skip", "skip", "skip", "skip", "skip", "skip", "skip", "text", "skip", "text", "text", "skip", "text", "skip"))

providers$locations <- paste0(providers$Street, ", ", providers$City, ", ", providers$State, ", ", providers$Zip)

# This function geocodes a location (find latitude and longitude) using the Google Maps API
geo <- geocode(location = providers$locations, output="latlon", source="google")

# Bringing over the longitude and latitude data
providers$lon <- geo$lon
providers$lat <- geo$lat

col_lon <- c(-109, -102)
col_lat <- c(36.86204, 41.03)
bbox <- make_bbox(col_lon, col_lat, f=0.05)
co_map <- get_map(bbox, maptype="toner", source = "stamen")
ggmap(co_map) +
  geom_point(aes(lon, lat), color = "blue", shape = 21, data = providers)