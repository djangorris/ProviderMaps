
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 4:20 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
pulmonology_030 <- filter(CO_all_medical_providers, Specialty %in% "030 Pulmonology")

rheumatology_031 <- filter(CO_all_medical_providers, Specialty %in% "031 Rheumatology")

urology_033 <- filter(CO_all_medical_providers, Specialty %in% "033 Urology")

vascular_surgery_034 <- filter(CO_all_medical_providers, Specialty %in% "034 Vascular Surgery")

# SLICE
SLICE_2_pulmonology_030 <- slice(pulmonology_030, 322:n())

SLICE_1_vascular_surgery_034 <- slice(vascular_surgery_034, 1:189)

#### CALCULATE sum SHOULD EQUAL 2500
tuesday1 <- nrow(SLICE_2_pulmonology_030)
tuesday1
tuesday2 <- nrow(rheumatology_031)
tuesday2
tuesday3 <- nrow(urology_033)
tuesday3
tuesday4<- nrow(SLICE_1_vascular_surgery_034)
tuesday4
sum(tuesday1, tuesday2, tuesday3, tuesday4)


## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_2_pulmonology_030_geo <- geocode(location = SLICE_2_pulmonology_030$locations, output="latlon", source="google")

SLICE_2_pulmonology_030_geo <- geocode(location = SLICE_2_pulmonology_030$locations, output="latlon", source="google")

rheumatology_031_geo <- geocode(location = rheumatology_031$locations, output="latlon", source="google")

urology_033_geo <- geocode(location = urology_033$locations, output="latlon", source="google")

SLICE_1_vascular_surgery_034_geo <- geocode(location = SLICE_1_vascular_surgery_034$locations, output="latlon", source="google")


# Bringing over the longitude and latitude data

SLICE_2_pulmonology_030$lon <- SLICE_2_pulmonology_030_geo$lon
SLICE_2_pulmonology_030$lat <- SLICE_2_pulmonology_030_geo$lat

rheumatology_031$lon <- rheumatology_031_geo$lon
rheumatology_031$lat <- rheumatology_031_geo$lat

urology_033$lon <- urology_033_geo$lon
urology_033$lat <- urology_033_geo$lat

SLICE_1_vascular_surgery_034$lon <- SLICE_1_vascular_surgery_034_geo$lon
SLICE_1_vascular_surgery_034$lat <- SLICE_1_vascular_surgery_034_geo$lat

#### WRITE TO CSV
write_csv(SLICE_2_pulmonology_030, path = "Processed_CSV/Specialties/SLICE_2_pulmonology_030.csv")

write_csv(rheumatology_031, path = "Processed_CSV/Specialties/rheumatology_031.csv")

write_csv(urology_033, path = "Processed_CSV/Specialties/urology_033.csv")

write_csv(SLICE_1_vascular_surgery_034, path = "Processed_CSV/Specialties/SLICE_1_vascular_surgery_034.csv")

# PREVIOUS START TIME
clean_start_time
# PREVIOUS FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
