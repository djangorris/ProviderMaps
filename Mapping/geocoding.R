#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
#### MAKE SURE TO NOTE PREVIOUS DAY RUN TIME: ?????


# FILTER SPECIALTY
cardiovascular_dis_008 <- filter(CO_all_medical_providers, Specialty %in% "008 Cardiovascular Disease")
# SLICE IF OVER 2500 ROWS
SLICE_1_cardiovascular_dis_008 <- cardiovascular_dis_008[1:2497, , drop = FALSE]

#### Next day: FRIDAY | READY | SLICE_1_cardiovascular_dis_008 ####

## USE THE GEOCODING API INFO IN SECRET.R
SLICE_1_cardiovascular_dis_008_geo <- geocode(location = SLICE_1_cardiovascular_dis_008$locations, output="latlon", source="google")
# Bringing over the longitude and latitude data
SLICE_1_cardiovascular_dis_008$lon <- SLICE_1_cardiovascular_dis_008_geo$lon
SLICE_1_cardiovascular_dis_008$lat <- SLICE_1_cardiovascular_dis_008_geo$lat
write_csv(SLICE_1_cardiovascular_dis_008, path = "Processed_CSV/Specialties/SLICE_1_cardiovascular_dis_008.csv")
