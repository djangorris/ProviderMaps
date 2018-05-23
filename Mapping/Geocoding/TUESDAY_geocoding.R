# PREVIOUS START TIME
# > start_time
# [1] "05/21/18  8:45:46"
# finish_time
#   [1] "05/21/18  9:13:55"
#   Time difference of 28.14743 mins
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 9:00 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
gynecology_016 <- filter(CO_all_medical_providers, Specialty %in% "016 Gynecology (OB/GYN)")

infectious_diseases_017 <- filter(CO_all_medical_providers, Specialty %in% "017 Infectious Diseases")

# SLICE
SLICE_2_gynecology_016 <- slice(gynecology_016, 2018:n())

SLICE_1_infectious_diseases_017 <- slice(infectious_diseases_017, 1:478)

#### CALCULATE sum SHOULD EQUAL 2500
tuesday2<- nrow(SLICE_1_infectious_diseases_017)
tuesday2
tuesday1<- nrow(SLICE_2_gynecology_016)
tuesday1
sum(tuesday1, tuesday2)



## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_2_gynecology_016_geo <- geocode(location = SLICE_2_gynecology_016$locations, output="latlon", source="google")

SLICE_2_gynecology_016_geo <- geocode(location = SLICE_2_gynecology_016$locations, output="latlon", source="google")

SLICE_1_infectious_diseases_017_geo <- geocode(location = SLICE_1_infectious_diseases_017$locations, output="latlon", source="google")


# Bringing over the longitude and latitude data

SLICE_2_gynecology_016$lon <- SLICE_2_gynecology_016_geo$lon
SLICE_2_gynecology_016$lat <- SLICE_2_gynecology_016_geo$lat

SLICE_1_infectious_diseases_017$lon <- SLICE_1_infectious_diseases_017_geo$lon
SLICE_1_infectious_diseases_017$lat <- SLICE_1_infectious_diseases_017_geo$lat

#### WRITE TO CSV
write_csv(SLICE_2_gynecology_016, path = "Processed_CSV/Specialties/SLICE_2_gynecology_016.csv")

write_csv(SLICE_1_infectious_diseases_017, path = "Processed_CSV/Specialties/SLICE_1_infectious_diseases_017.csv")

# PREVIOUS START TIME
clean_start_time
# PREVIOUS FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
