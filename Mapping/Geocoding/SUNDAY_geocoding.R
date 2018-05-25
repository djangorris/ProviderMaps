
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 4:20 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
physical_rehab_026 <- filter(CO_all_medical_providers, Specialty %in% "026 Physical Medicine & Rehabilitation")

plastic_surgery_027 <- filter(CO_all_medical_providers, Specialty %in% "027 Plastic Surgery")

podiatry_028 <- filter(CO_all_medical_providers, Specialty %in% "028 Podiatry")

psychiatry_029 <- filter(CO_all_medical_providers, Specialty %in% "029 Psychiatry")

# SLICE
SLICE_2_physical_rehab_026 <- slice(physical_rehab_026, 323:n())

SLICE_1_psychiatry_029 <- slice(psychiatry_029, 1:439)

#### CALCULATE sum SHOULD EQUAL 2500
sunday1 <- nrow(SLICE_2_physical_rehab_026)
sunday1
sunday2 <- nrow(plastic_surgery_027)
sunday2
sunday3 <- nrow(podiatry_028)
sunday3
sunday4<- nrow(SLICE_1_psychiatry_029)
sunday4
sum(sunday1, sunday2, sunday3, sunday4)


## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_2_physical_rehab_026_geo <- geocode(location = SLICE_2_physical_rehab_026$locations, output="latlon", source="google")

SLICE_2_physical_rehab_026_geo <- geocode(location = SLICE_2_physical_rehab_026$locations, output="latlon", source="google")

plastic_surgery_027_geo <- geocode(location = plastic_surgery_027$locations, output="latlon", source="google")

podiatry_028_geo <- geocode(location = podiatry_028$locations, output="latlon", source="google")

SLICE_1_psychiatry_029_geo <- geocode(location = SLICE_1_psychiatry_029$locations, output="latlon", source="google")


# Bringing over the longitude and latitude data

SLICE_2_physical_rehab_026$lon <- SLICE_2_physical_rehab_026_geo$lon
SLICE_2_physical_rehab_026$lat <- SLICE_2_physical_rehab_026_geo$lat

plastic_surgery_027$lon <- plastic_surgery_027_geo$lon
plastic_surgery_027$lat <- plastic_surgery_027_geo$lat

podiatry_028$lon <- podiatry_028_geo$lon
podiatry_028$lat <- podiatry_028_geo$lat

SLICE_1_psychiatry_029$lon <- SLICE_1_psychiatry_029_geo$lon
SLICE_1_psychiatry_029$lat <- SLICE_1_psychiatry_029_geo$lat

#### WRITE TO CSV
write_csv(SLICE_2_physical_rehab_026, path = "Processed_CSV/Specialties/SLICE_2_physical_rehab_026.csv")

write_csv(plastic_surgery_027, path = "Processed_CSV/Specialties/plastic_surgery_027.csv")

write_csv(podiatry_028, path = "Processed_CSV/Specialties/podiatry_028.csv")

write_csv(SLICE_1_psychiatry_029, path = "Processed_CSV/Specialties/SLICE_1_psychiatry_029.csv")

# PREVIOUS START TIME
clean_start_time
# PREVIOUS FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
