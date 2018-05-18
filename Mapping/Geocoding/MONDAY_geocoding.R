
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 4:20 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
gynecology_016 <- filter(CO_all_medical_providers, Specialty %in% "016 Gynecology (OB/GYN)")

primary_care_NP_006 <- filter(CO_all_medical_providers, Specialty %in% "006 Primary Care - Nurse Practitioner")

# SLICE
SLICE_1_gynecology_016 <- slice(gynecology_016, 1:2017)

SLICE_2_primary_care_NP_006 <- slice(primary_care_NP_006, 623:n())

#### CALCULATE sum SHOULD EQUAL 2500
monday1<- nrow(SLICE_2_primary_care_NP_006)
monday1
monday2<- nrow(SLICE_1_gynecology_016)
monday2
sum(monday1, monday2)



## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_1_gynecology_016_geo <- geocode(location = SLICE_1_gynecology_016$locations, output="latlon", source="google")

SLICE_1_gynecology_016_geo <- geocode(location = SLICE_1_gynecology_016$locations, output="latlon", source="google")

SLICE_2_primary_care_NP_006_geo <- geocode(location = SLICE_2_primary_care_NP_006$locations, output="latlon", source="google")


# Bringing over the longitude and latitude data

SLICE_1_gynecology_016$lon <- SLICE_1_gynecology_016_geo$lon
SLICE_1_gynecology_016$lat <- SLICE_1_gynecology_016_geo$lat

SLICE_2_primary_care_NP_006$lon <- SLICE_2_primary_care_NP_006_geo$lon
SLICE_2_primary_care_NP_006$lat <- SLICE_2_primary_care_NP_006_geo$lat

#### WRITE TO CSV
write_csv(SLICE_1_gynecology_016, path = "Processed_CSV/Specialties/SLICE_1_gynecology_016.csv")

write_csv(SLICE_2_primary_care_NP_006, path = "Processed_CSV/Specialties/SLICE_2_primary_care_NP_006.csv")

# PREVIOUS START TIME
clean_start_time
# PREVIOUS FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
