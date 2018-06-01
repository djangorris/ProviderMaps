### HIT BUFFER YESTERDAY AND SCREWED IT UP
# REDO - WAIT UNTIL 2500 AVAILABLE
# finish_time
# [1] "06/01/18  9:35:54"

#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME 9:25
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
pediatrics_101 <- filter(CO_all_medical_providers, Specialty %in% "101 Pediatrics - Routine/Primary Care")

# SLICE
SLICE_2_pediatrics_101 <- slice(pediatrics_101, 1756:4255)

#### CALCULATE sum SHOULD EQUAL 2500
friday1 <- nrow(SLICE_2_pediatrics_101)
friday1


## USE THE GEOCODING API INFO IN SECRET.R
SLICE_2_pediatrics_101_geo <- geocode(location = SLICE_2_pediatrics_101$locations, output="latlon", source="google")


# Bringing over the longitude and latitude data

SLICE_2_pediatrics_101$lon <- SLICE_2_pediatrics_101_geo$lon
SLICE_2_pediatrics_101$lat <- SLICE_2_pediatrics_101_geo$lat

#### WRITE TO CSV
write_csv(SLICE_2_pediatrics_101, path = "Processed_CSV/Specialties/SLICE_2_pediatrics_101.csv")

# START TIME
clean_start_time
# FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
