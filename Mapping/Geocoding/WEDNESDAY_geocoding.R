# start_time
# [1] "05/22/18  8:59:45"
# finish_time
#   [1] "05/22/18  9:18:29"
#   Time difference of 18.74828 mins
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 9:09 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
nephrology_018 <- filter(CO_all_medical_providers, Specialty %in% "018 Nephrology")

infectious_diseases_017 <- filter(CO_all_medical_providers, Specialty %in% "017 Infectious Diseases")

neurology_019 <- filter(CO_all_medical_providers, Specialty %in% "019 Neurology")

neurological_surgery_020 <- filter(CO_all_medical_providers, Specialty %in% "020 Neurological Surgery")

# SLICE
SLICE_2_infectious_diseases_017 <- slice(infectious_diseases_017, 479:n())

SLICE_1_neurological_surgery_020 <- slice(neurological_surgery_020, 1:385)

#### CALCULATE sum SHOULD EQUAL 2500
wednesday1<- nrow(SLICE_2_infectious_diseases_017)
wednesday1
wednesday2<- nrow(nephrology_018)
wednesday2
wednesday3<- nrow(neurology_019)
wednesday3
wednesday4<- nrow(SLICE_1_neurological_surgery_020)
wednesday4
sum(wednesday1, wednesday2, wednesday3, wednesday4)



## USE THE GEOCODING API INFO IN SECRET.R
# nephrology_018_geo <- geocode(location = nephrology_018$locations, output="latlon", source="google")

nephrology_018_geo <- geocode(location = nephrology_018$locations, output="latlon", source="google")

SLICE_2_infectious_diseases_017_geo <- geocode(location = SLICE_2_infectious_diseases_017$locations, output="latlon", source="google")

neurology_019_geo <- geocode(location = neurology_019$locations, output="latlon", source="google")

SLICE_1_neurological_surgery_020_geo <- geocode(location = SLICE_1_neurological_surgery_020$locations, output="latlon", source="google")


# Bringing over the longitude and latitude data

nephrology_018$lon <- nephrology_018_geo$lon
nephrology_018$lat <- nephrology_018_geo$lat

SLICE_2_infectious_diseases_017$lon <- SLICE_2_infectious_diseases_017_geo$lon
SLICE_2_infectious_diseases_017$lat <- SLICE_2_infectious_diseases_017_geo$lat

neurology_019$lon <- neurology_019_geo$lon
neurology_019$lat <- neurology_019_geo$lat

SLICE_1_neurological_surgery_020$lon <- SLICE_1_neurological_surgery_020_geo$lon
SLICE_1_neurological_surgery_020$lat <- SLICE_1_neurological_surgery_020_geo$lat

#### WRITE TO CSV
write_csv(nephrology_018, path = "Processed_CSV/Specialties/nephrology_018.csv")

write_csv(SLICE_2_infectious_diseases_017, path = "Processed_CSV/Specialties/SLICE_2_infectious_diseases_017.csv")

write_csv(neurology_019, path = "Processed_CSV/Specialties/neurology_019.csv")

write_csv(SLICE_1_neurological_surgery_020, path = "Processed_CSV/Specialties/SLICE_1_neurological_surgery_020.csv")


# PREVIOUS START TIME
clean_start_time
# PREVIOUS FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
