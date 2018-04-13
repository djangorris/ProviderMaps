install.packages("readxl")
install.packages("tidyverse")
install.packages('ggmap')
install.packages('purrr')
library(readxl)
library(tidyverse)
library(ggmap)
library(purrr)
library(DT)
library(knitr)
library(ggplot2)

providers1 <- read_excel("Anthem.xlsm", sheet = "IndividualProviders1", skip = 2, 
                        col_names = c("NPI", "Specialty", "Street", "City", "State", "Zip"), 
                        col_types = c("text", "skip", "skip", "skip", "skip", "skip", "skip", 
                                      "text", "text", "skip", "text", "text", "skip", "text", "skip"))

providers2 <- read_excel("Anthem.xlsm", sheet = "IndividualProviders2", skip = 2, 
                         col_names = c("NPI", "Specialty", "Street", "City", "State", "Zip"), 
                         col_types = c("text", "skip", "skip", "skip", "skip", "skip", "skip", 
                                       "text", "text", "skip", "text", "text", "skip", "text", "skip"))

# COMBINE THE TWO SHEETS
providers_bind <- bind_rows(providers1, providers2)

# NEED TO REMOVE DUPLICATES
providers = providers_bind[!duplicated(providers_bind$NPI),]

# PROVIDER TYPE TO FACTOR

# ADD CONCATENATED LOCATIONS COLUMN
providers$locations <- paste0(providers$Street, ", ", providers$City, ", ", providers$State, ", ", providers$Zip)

# geocodes a location (find latitude and longitude) using the Google Maps API
geo <- geocode(location = providers$locations, output="latlon", source="google")

# Bringing over the longitude and latitude data
providers$lon <- geo$lon
providers$lat <- geo$lat

# DEFINING THE MAP
col_lon <- c(-109, -102)
col_lat <- c(36.86204, 41.03)
bbox <- make_bbox(col_lon, col_lat, f=0.05)
co_map <- get_map(bbox, maptype="toner-lite", source = "stamen")
# DISPLAY MAP AND ADD DATA POINTS
ggmap(co_map) +
  geom_point(aes(lon, lat), color = "blue", shape = 21, data = providers)