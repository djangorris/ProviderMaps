
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 4:20 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
social_workers_102 <- filter(CO_all_medical_providers, Specialty %in% "102 Licensed Clinical Social Workers")

psychology_103 <- filter(CO_all_medical_providers, Specialty %in% "103 Psychology")

# SLICE
SLICE_3_social_workers_102 <- slice(social_workers_102, 4789:n())

SLICE_1_psychology_103 <- slice(psychology_103, 1:1009)

#### CALCULATE sum SHOULD EQUAL 2500
tuesday1 <- nrow(SLICE_3_social_workers_102)
tuesday1
tuesday2<- nrow(SLICE_1_psychology_103)
tuesday2
sum(tuesday1, tuesday2)


## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_3_social_workers_102_geo <- geocode(location = SLICE_3_social_workers_102$locations, output="latlon", source="google")

SLICE_3_social_workers_102_geo <- geocode(location = SLICE_3_social_workers_102$locations, output="latlon", source="google")

SLICE_1_psychology_103_geo <- geocode(location = SLICE_1_psychology_103$locations, output="latlon", source="google")


# Bringing over the longitude and latitude data

SLICE_3_social_workers_102$lon <- SLICE_3_social_workers_102_geo$lon
SLICE_3_social_workers_102$lat <- SLICE_3_social_workers_102_geo$lat

SLICE_1_psychology_103$lon <- SLICE_1_psychology_103_geo$lon
SLICE_1_psychology_103$lat <- SLICE_1_psychology_103_geo$lat

#### WRITE TO CSV
write_csv(SLICE_3_social_workers_102, path = "Processed_CSV/Specialties/SLICE_3_social_workers_102.csv")

write_csv(SLICE_1_psychology_103, path = "Processed_CSV/Specialties/SLICE_1_psychology_103.csv")

# START TIME
clean_start_time
# FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
