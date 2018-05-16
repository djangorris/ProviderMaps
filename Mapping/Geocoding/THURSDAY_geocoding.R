#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 4:20 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
family_medicine_002 <- filter(CO_all_medical_providers, Specialty %in% "002 Family Medicine")

# SLICE
#### Next day: SATURDAY | 2018-05-12 3:56:41 MDT | READY ####

SLICE_3_family_medicine_002 <- slice(family_medicine_002, 4239:6738)

#### CALCULATE sum SHOULD EQUAL 2500
thursday<- nrow(SLICE_3_family_medicine_002)
thursday

## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_3_family_medicine_002_geo <- geocode(location = SLICE_3_family_medicine_002$locations, output="latlon", source="google")

SLICE_3_family_medicine_002_geo <- geocode(location = SLICE_3_family_medicine_002$locations, output="latlon", source="google")


# Bringing over the longitude and latitude data

SLICE_3_family_medicine_002$lon <- SLICE_3_family_medicine_002_geo$lon
SLICE_3_family_medicine_002$lat <- SLICE_3_family_medicine_002_geo$lat

#### WRITE TO CSV
write_csv(SLICE_3_family_medicine_002, path = "Processed_CSV/Specialties/SLICE_3_family_medicine_002.csv")

# THURSDAY START TIME
clean_start_time
# THURSDAY FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
