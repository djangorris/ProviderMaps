
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 4:20 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
internal_medicine_003 <- filter(CO_all_medical_providers, Specialty %in% "003 Internal Medicine")

# SLICE
#### Next day: SATURDAY | 2018-05-12 3:56:41 MDT | READY ####

SLICE_2_internal_medicine_003 <- slice(internal_medicine_003, 1818:4317)

#### CALCULATE sum SHOULD EQUAL 2500
saturday1 <- nrow(SLICE_2_internal_medicine_003)
saturday1

## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_2_internal_medicine_003_geo <- geocode(location = SLICE_2_internal_medicine_003$locations, output="latlon", source="google")

SLICE_2_internal_medicine_003_geo <- geocode(location = SLICE_2_internal_medicine_003$locations, output="latlon", source="google")

# Bringing over the longitude and latitude data

SLICE_2_internal_medicine_003$lon <- SLICE_2_internal_medicine_003_geo$lon
SLICE_2_internal_medicine_003$lat <- SLICE_2_internal_medicine_003_geo$lat

#### WRITE TO CSV
write_csv(SLICE_2_internal_medicine_003, path = "Processed_CSV/Specialties/SLICE_2_internal_medicine_003.csv")

# PREVIOUS START TIME
clean_start_time
# PREVIOUS FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
