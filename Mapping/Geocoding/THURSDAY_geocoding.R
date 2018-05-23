
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 4:20 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
neurological_surgery_020 <- filter(CO_all_medical_providers, Specialty %in% "020 Neurological Surgery")

med_surg_oncology_021 <- filter(CO_all_medical_providers, Specialty %in% "021 Medical Oncology & Surgical Oncology")

radiation_oncology_022 <- filter(CO_all_medical_providers, Specialty %in% "022 Radiation Oncology")

ophthalmology_023 <- filter(CO_all_medical_providers, Specialty %in% "023 Ophthalmology")

# SLICE
#### Next day: SATURDAY | 2018-05-12 3:56:41 MDT | READY ####

SLICE_2_neurological_surgery_020 <- slice(neurological_surgery_020, 386:n())

SLICE_1_ophthalmology_023 <- slice(ophthalmology_023, 1:276)

#### CALCULATE sum SHOULD EQUAL 2500
thursday1<- nrow(SLICE_2_neurological_surgery_020)
thursday1
thursday2<- nrow(med_surg_oncology_021)
thursday2
thursday3<- nrow(radiation_oncology_022)
thursday3
thursday4<- nrow(SLICE_1_ophthalmology_023)
thursday4
2500 - sum(thursday1, thursday2, thursday3, thursday4)

## USE THE GEOCODING API INFO IN SECRET.R
# med_surg_oncology_021_geo <- geocode(location = med_surg_oncology_021$locations, output="latlon", source="google")

SLICE_2_neurological_surgery_020_geo <- geocode(location = SLICE_2_neurological_surgery_020$locations, output="latlon", source="google")

med_surg_oncology_021_geo <- geocode(location = med_surg_oncology_021$locations, output="latlon", source="google")

radiation_oncology_022_geo <- geocode(location = radiation_oncology_022$locations, output="latlon", source="google")

SLICE_1_ophthalmology_023_geo <- geocode(location = SLICE_1_ophthalmology_023$locations, output="latlon", source="google")


# Bringing over the longitude and latitude data

SLICE_2_neurological_surgery_020$lon <- SLICE_2_neurological_surgery_020_geo$lon
SLICE_2_neurological_surgery_020$lat <- SLICE_2_neurological_surgery_020_geo$lat

med_surg_oncology_021$lon <- med_surg_oncology_021_geo$lon
med_surg_oncology_021$lat <- med_surg_oncology_021_geo$lat

radiation_oncology_022$lon <- radiation_oncology_022_geo$lon
radiation_oncology_022$lat <- radiation_oncology_022_geo$lat

SLICE_1_ophthalmology_023$lon <- SLICE_1_ophthalmology_023_geo$lon
SLICE_1_ophthalmology_023$lat <- SLICE_1_ophthalmology_023_geo$lat

#### WRITE TO CSV
write_csv(SLICE_2_neurological_surgery_020, path = "Processed_CSV/Specialties/SLICE_2_neurological_surgery_020.csv")

write_csv(med_surg_oncology_021, path = "Processed_CSV/Specialties/med_surg_oncology_021.csv")

write_csv(radiation_oncology_022, path = "Processed_CSV/Specialties/radiation_oncology_022.csv")

write_csv(SLICE_1_ophthalmology_023, path = "Processed_CSV/Specialties/SLICE_1_ophthalmology_023.csv")


# THURSDAY START TIME
clean_start_time
# THURSDAY FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
