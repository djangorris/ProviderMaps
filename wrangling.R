### BINDING CARRIERS ###
ALL_county_specialty_count <- bind_rows(ANTHEM_county_specialty_count, 
                                        BRIGHT_county_specialty_count, 
                                        CIGNA_county_specialty_count, 
                                        DENVER_HEALTH_county_specialty_count, 
                                        KAISER_county_specialty_count, 
                                        RMHP_county_specialty_count)

ALL_statewide_specialty_count <- bind_rows(ANTHEM_statewide_specialty_count, 
                                           BRIGHT_statewide_specialty_count, 
                                           CIGNA_statewide_specialty_count, 
                                           DENVER_HEALTH_statewide_specialty_count, 
                                           KAISER_statewide_specialty_count, 
                                           RMHP_statewide_specialty_count)
ALL_county_specialty_count$Carrier <- as.factor(ALL_county_specialty_count$Carrier)
ALL_statewide_specialty_count$Carrier <- as.factor(ALL_statewide_specialty_count$Carrier)
ALL_county_specialty_count$County <- str_to_title(ALL_county_specialty_count$County)
### EXPORTING ###
write_csv(ALL_county_specialty_count, path = "Indiv/ALL_county_specialty_count.csv")
write_csv(ALL_statewide_specialty_count, path = "Indiv/ALL_statewide_specialty_count.csv")

### GROUPING ###
################
##### TOTALS #####









###########
###########
###########
# < **need to research geocoding options** >
# geocodes a location (find latitude and longitude) using the Google Maps API
# geo <- geocode(location = medical_providers$locations, output="latlon", source="google")
##############

# Bringing over the longitude and latitude data
medical_providers$lon <- geo$lon
medical_providers$lat <- geo$lat

# DEFINING THE MAP
col_lon <- c(-109, -102)
col_lat <- c(36.86204, 41.03)
bbox <- make_bbox(col_lon, col_lat, f=0.05)
co_map <- get_map(bbox, maptype="toner-lite", source = "stamen")
# DISPLAY MAP AND ADD DATA POINTS
ggmap(co_map) +
  geom_point(aes(lon, lat), color = "blue", shape = 21, data = medical_providers)