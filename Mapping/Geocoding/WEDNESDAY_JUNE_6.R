# start_time
# [1] "06/05/18 10:16:18"
# finish_time
#   [1] "06/05/18 10:41:09"
#   Time difference of 24.86085 mins
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 10:30 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
psychology_103 <- filter(CO_all_medical_providers, Specialty %in% "103 Psychology")

# SLICE
SLICE_2_psychology_103 <- slice(psychology_103, 1010:3509)

#### CALCULATE sum SHOULD EQUAL 2500
wednesday1 <- nrow(SLICE_2_psychology_103)
wednesday1

## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_2_psychology_103_geo <- geocode(location = SLICE_2_psychology_103$locations, output="latlon", source="google")

SLICE_2_psychology_103_geo <- geocode(location = SLICE_2_psychology_103$locations, output="latlon", source="google")

# Bringing over the longitude and latitude data

SLICE_2_psychology_103$lon <- SLICE_2_psychology_103_geo$lon
SLICE_2_psychology_103$lat <- SLICE_2_psychology_103_geo$lat

#### WRITE TO CSV
write_csv(SLICE_2_psychology_103, path = "Processed_CSV/Specialties/SLICE_2_psychology_103.csv")

# START TIME
clean_start_time
# FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
