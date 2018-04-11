install.packages("readxl")
install.packages("tidyverse")
install.packages('ggmap')
library(readxl)
library(tidyverse)
library(ggmap)
library(DT)
library(knitr)

providers <- read_excel("Anthem.xlsm", sheet = "IndividualProviders1", skip = 2962, 
                        col_names = c("Street", "City", "State", "Zip"), col_types = c("skip", "skip", "skip", "skip", "skip", "skip", "skip", "skip", "text", "skip", "text", "text", "skip", "text", "skip"))

providers$locations <- paste0(providers$Street, ", ", providers$City, ", ", providers$State, ", ", providers$Zip)

# This function geocodes a location (find latitude and longitude) using the Google Maps API
geo <- geocode(location = providers$locations, output="latlon", source="google")