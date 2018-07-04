# start_time
# [1] "06/03/18  8:20:16"
# finish_time
#   [1] "06/03/18  8:48:27"
#   Time difference of 28.19312 mins
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 8:40 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
social_workers_102 <- filter(CO_all_medical_providers, Specialty %in% "102 Licensed Clinical Social Workers")

# SLICE
SLICE_2_social_workers_102 <- slice(social_workers_102, 2289:4788)

#### CALCULATE sum SHOULD EQUAL 2500
sunday1 <- nrow(SLICE_2_social_workers_102)
sunday1

## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_2_social_workers_102_geo <- geocode(location = SLICE_2_social_workers_102$locations, output="latlon", source="google")

SLICE_2_social_workers_102_geo <- geocode(location = SLICE_2_social_workers_102$locations, output="latlon", source="google")

# Bringing over the longitude and latitude data

SLICE_2_social_workers_102$lon <- SLICE_2_social_workers_102_geo$lon
SLICE_2_social_workers_102$lat <- SLICE_2_social_workers_102_geo$lat

#### WRITE TO CSV
write_csv(SLICE_2_social_workers_102, path = "Processed_CSV/Specialties/SLICE_2_social_workers_102.csv")


# START TIME
clean_start_time
# FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
