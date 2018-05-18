# # THURSDAY START TIME
# [1] "05/17/18  4:41:50"
#   finish_time
#   [1] "05/17/18  5:08:16"
#   Time difference of 26.44651 mins
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 4:56 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
family_medicine_002 <- filter(CO_all_medical_providers, Specialty %in% "002 Family Medicine")

internal_medicine_003 <- filter(CO_all_medical_providers, Specialty %in% "003 Internal Medicine")

# SLICE
#### Next day: SATURDAY | 2018-05-12 3:56:41 MDT | READY ####

SLICE_4_family_medicine_002 <- slice(family_medicine_002, 6739:n())

SLICE_1_internal_medicine_003 <- slice(internal_medicine_003, 1:1817)

#### CALCULATE sum SHOULD EQUAL 2500
friday1<- nrow(SLICE_4_family_medicine_002)
friday1
friday2<- nrow(SLICE_1_internal_medicine_003)
friday2
sum(friday1, friday2)

## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_4_family_medicine_002_geo <- geocode(location = SLICE_4_family_medicine_002$locations, output="latlon", source="google")

SLICE_4_family_medicine_002_geo <- geocode(location = SLICE_4_family_medicine_002$locations, output="latlon", source="google")

SLICE_1_internal_medicine_003_geo <- geocode(location = SLICE_1_internal_medicine_003$locations, output="latlon", source="google")

# Bringing over the longitude and latitude data

SLICE_4_family_medicine_002$lon <- SLICE_4_family_medicine_002_geo$lon
SLICE_4_family_medicine_002$lat <- SLICE_4_family_medicine_002_geo$lat

SLICE_1_internal_medicine_003$lon <- SLICE_1_internal_medicine_003_geo$lon
SLICE_1_internal_medicine_003$lat <- SLICE_1_internal_medicine_003_geo$lat

#### WRITE TO CSV
write_csv(SLICE_1_internal_medicine_003, path = "Processed_CSV/Specialties/SLICE_1_internal_medicine_003.csv")

write_csv(SLICE_4_family_medicine_002, path = "Processed_CSV/Specialties/SLICE_4_family_medicine_002.csv")

# FRIDAY START TIME
clean_start_time
# FRIDAY FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
