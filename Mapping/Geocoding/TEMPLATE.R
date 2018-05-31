
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 4:20 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
first_000 <- filter(CO_all_medical_providers, Specialty %in% "000_First")

second_000 <- filter(CO_all_medical_providers, Specialty %in% "000_Second")

third_000 <- filter(CO_all_medical_providers, Specialty %in% "000_Third")

fourth_000 <- filter(CO_all_medical_providers, Specialty %in% "000_Fourth")

# SLICE
SLICE_2_first_000 <- slice(first_000, 323:n())

SLICE_1_fourth_000 <- slice(fourth_000, 1:439)

#### CALCULATE sum SHOULD EQUAL 2500
sunday1 <- nrow(SLICE_2_first_000)
sunday1
sunday2 <- nrow(second_000)
sunday2
sunday3 <- nrow(third_000)
sunday3
sunday4<- nrow(SLICE_1_fourth_000)
sunday4
sum(sunday1, sunday2, sunday3, sunday4)


## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_2_first_000_geo <- geocode(location = SLICE_2_first_000$locations, output="latlon", source="google")

SLICE_2_first_000_geo <- geocode(location = SLICE_2_first_000$locations, output="latlon", source="google")

second_000_geo <- geocode(location = second_000$locations, output="latlon", source="google")

third_000_geo <- geocode(location = third_000$locations, output="latlon", source="google")

SLICE_1_fourth_000_geo <- geocode(location = SLICE_1_fourth_000$locations, output="latlon", source="google")


# Bringing over the longitude and latitude data

SLICE_2_first_000$lon <- SLICE_2_first_000_geo$lon
SLICE_2_first_000$lat <- SLICE_2_first_000_geo$lat

second_000$lon <- second_000_geo$lon
second_000$lat <- second_000_geo$lat

third_000$lon <- third_000_geo$lon
third_000$lat <- third_000_geo$lat

SLICE_1_fourth_000$lon <- SLICE_1_fourth_000_geo$lon
SLICE_1_fourth_000$lat <- SLICE_1_fourth_000_geo$lat

#### WRITE TO CSV
write_csv(SLICE_2_first_000, path = "Processed_CSV/Specialties/SLICE_2_first_000.csv")

write_csv(second_000, path = "Processed_CSV/Specialties/second_000.csv")

write_csv(third_000, path = "Processed_CSV/Specialties/third_000.csv")

write_csv(SLICE_1_fourth_000, path = "Processed_CSV/Specialties/SLICE_1_fourth_000.csv")

# START TIME
clean_start_time
# FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
