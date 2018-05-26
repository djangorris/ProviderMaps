
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 4:20 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
pulmonology_030 <- filter(CO_all_medical_providers, Specialty %in% "030 Pulmonology")

psychiatry_029 <- filter(CO_all_medical_providers, Specialty %in% "029 Psychiatry")

# SLICE
SLICE_2_psychiatry_029 <- slice(psychiatry_029, 440:n())

SLICE_1_pulmonology_030 <- slice(pulmonology_030, 1:321)

#### CALCULATE sum SHOULD EQUAL 2500
monday1<- nrow(SLICE_2_psychiatry_029)
monday1
monday2 <- nrow(SLICE_1_pulmonology_030)
monday2
sum(monday1, monday2)


## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_1_pulmonology_030_geo <- geocode(location = SLICE_1_pulmonology_030$locations, output="latlon", source="google")

SLICE_1_pulmonology_030_geo <- geocode(location = SLICE_1_pulmonology_030$locations, output="latlon", source="google")

SLICE_2_psychiatry_029_geo <- geocode(location = SLICE_2_psychiatry_029$locations, output="latlon", source="google")


# Bringing over the longitude and latitude data

SLICE_1_pulmonology_030$lon <- SLICE_1_pulmonology_030_geo$lon
SLICE_1_pulmonology_030$lat <- SLICE_1_pulmonology_030_geo$lat

SLICE_2_psychiatry_029$lon <- SLICE_2_psychiatry_029_geo$lon
SLICE_2_psychiatry_029$lat <- SLICE_2_psychiatry_029_geo$lat

#### WRITE TO CSV
write_csv(SLICE_1_pulmonology_030, path = "Processed_CSV/Specialties/SLICE_1_pulmonology_030.csv")

write_csv(SLICE_2_psychiatry_029, path = "Processed_CSV/Specialties/SLICE_2_psychiatry_029.csv")

# PREVIOUS START TIME
clean_start_time
# PREVIOUS FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
