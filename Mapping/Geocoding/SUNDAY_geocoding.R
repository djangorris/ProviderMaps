# # PREVIOUS START TIME
# > clean_start_time
# [1] "05/19/18  8:26:14"
#
# > # PREVIOUS FINISH TIME
#   > finish_time <- Sys.time()
#
#   > clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
#
#   > clean_finish_time
#   [1] "05/19/18  8:51:36"
#
#   > difftime(finish_time, start_time)
#   Time difference of 25.35965 mins
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 4:20 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
internal_medicine_003 <- filter(CO_all_medical_providers, Specialty %in% "003 Internal Medicine")

geriatrics_004 <- filter(CO_all_medical_providers, Specialty %in% "004 Geriatrics")

primary_care_PA_005 <- filter(CO_all_medical_providers, Specialty %in% "005 Primary Care - Physician Assistant")

primary_care_NP_006 <- filter(CO_all_medical_providers, Specialty %in% "006 Primary Care - Nurse Practitioner")

# SLICE
SLICE_3_internal_medicine_003 <- slice(internal_medicine_003, 4318:n())

SLICE_1_primary_care_NP_006 <- slice(primary_care_NP_006, 1:622)

#### CALCULATE sum SHOULD EQUAL 2500
sunday1 <- nrow(SLICE_3_internal_medicine_003)
sunday1
sunday2 <- nrow(geriatrics_004)
sunday2
sunday3 <- nrow(primary_care_PA_005)
sunday3
sunday4<- nrow(SLICE_1_primary_care_NP_006)
sunday4
sum(sunday1, sunday2, sunday3, sunday4)


## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_3_internal_medicine_003_geo <- geocode(location = SLICE_3_internal_medicine_003$locations, output="latlon", source="google")

SLICE_3_internal_medicine_003_geo <- geocode(location = SLICE_3_internal_medicine_003$locations, output="latlon", source="google")

geriatrics_004_geo <- geocode(location = geriatrics_004$locations, output="latlon", source="google")

primary_care_PA_005_geo <- geocode(location = primary_care_PA_005$locations, output="latlon", source="google")

SLICE_1_primary_care_NP_006_geo <- geocode(location = SLICE_1_primary_care_NP_006$locations, output="latlon", source="google")


# Bringing over the longitude and latitude data

SLICE_3_internal_medicine_003$lon <- SLICE_3_internal_medicine_003_geo$lon
SLICE_3_internal_medicine_003$lat <- SLICE_3_internal_medicine_003_geo$lat

geriatrics_004$lon <- geriatrics_004_geo$lon
geriatrics_004$lat <- geriatrics_004_geo$lat

primary_care_PA_005$lon <- primary_care_PA_005_geo$lon
primary_care_PA_005$lat <- primary_care_PA_005_geo$lat

SLICE_1_primary_care_NP_006$lon <- SLICE_1_primary_care_NP_006_geo$lon
SLICE_1_primary_care_NP_006$lat <- SLICE_1_primary_care_NP_006_geo$lat

#### WRITE TO CSV
write_csv(SLICE_3_internal_medicine_003, path = "Processed_CSV/Specialties/SLICE_3_internal_medicine_003.csv")

write_csv(geriatrics_004, path = "Processed_CSV/Specialties/geriatrics_004.csv")

write_csv(primary_care_PA_005, path = "Processed_CSV/Specialties/primary_care_PA_005.csv")

write_csv(SLICE_1_primary_care_NP_006, path = "Processed_CSV/Specialties/SLICE_1_primary_care_NP_006.csv")

# PREVIOUS START TIME
clean_start_time
# PREVIOUS FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
