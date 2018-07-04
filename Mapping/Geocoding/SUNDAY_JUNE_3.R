# start_time
# [1] "06/02/18  9:39:34"
# finish_time
#   [1] "06/02/18  9:58:59"
#   Time difference of 19.42112 mins
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 4:20 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
pediatrics_101 <- filter(CO_all_medical_providers, Specialty %in% "101 Pediatrics - Routine/Primary Care")

social_workers_102 <- filter(CO_all_medical_providers, Specialty %in% "102 Licensed Clinical Social Workers")

# SLICE
SLICE_3_pediatrics_101 <- slice(pediatrics_101, 4256:n())

SLICE_1_social_workers_102 <- slice(social_workers_102, 1:2288)

#### CALCULATE sum SHOULD EQUAL 2500
saturday1 <- nrow(SLICE_3_pediatrics_101)
saturday1
saturday4<- nrow(SLICE_1_social_workers_102)
saturday4
sum(saturday1, saturday4)


## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_3_pediatrics_101_geo <- geocode(location = SLICE_3_pediatrics_101$locations, output="latlon", source="google")

SLICE_3_pediatrics_101_geo <- geocode(location = SLICE_3_pediatrics_101$locations, output="latlon", source="google")

SLICE_1_social_workers_102_geo <- geocode(location = SLICE_1_social_workers_102$locations, output="latlon", source="google")


# Bringing over the longitude and latitude data

SLICE_3_pediatrics_101$lon <- SLICE_3_pediatrics_101_geo$lon
SLICE_3_pediatrics_101$lat <- SLICE_3_pediatrics_101_geo$lat

SLICE_1_social_workers_102$lon <- SLICE_1_social_workers_102_geo$lon
SLICE_1_social_workers_102$lat <- SLICE_1_social_workers_102_geo$lat

#### WRITE TO CSV
write_csv(SLICE_3_pediatrics_101, path = "Processed_CSV/Specialties/SLICE_3_pediatrics_101.csv")

write_csv(SLICE_1_social_workers_102, path = "Processed_CSV/Specialties/SLICE_1_social_workers_102.csv")

# START TIME
clean_start_time
# FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
