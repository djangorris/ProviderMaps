# start_time
# [1] "05/24/18  9:12:57"
# finish_time
#   [1] "05/24/18  9:30:58"
#   Time difference of 18.01936 mins
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 9:20 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
ophthalmology_023 <- filter(CO_all_medical_providers, Specialty %in% "023 Ophthalmology")

orthopedic_surgery_025 <- filter(CO_all_medical_providers, Specialty %in% "025 Orthopedic Surgery")

# SLICE
#### Next day: SATURDAY | 2018-05-12 3:56:41 MDT | READY ####

SLICE_2_ophthalmology_023 <- slice(ophthalmology_023, 277:n())

SLICE_1_orthopedic_surgery_025 <- slice(orthopedic_surgery_025, 1:1028)

#### CALCULATE sum SHOULD EQUAL 2500
friday1<- nrow(SLICE_2_ophthalmology_023)
friday1
friday2<- nrow(SLICE_1_orthopedic_surgery_025)
friday2
sum(friday1, friday2)

## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_2_ophthalmology_023_geo <- geocode(location = SLICE_2_ophthalmology_023$locations, output="latlon", source="google")

SLICE_2_ophthalmology_023_geo <- geocode(location = SLICE_2_ophthalmology_023$locations, output="latlon", source="google")

SLICE_1_orthopedic_surgery_025_geo <- geocode(location = SLICE_1_orthopedic_surgery_025$locations, output="latlon", source="google")

# Bringing over the longitude and latitude data

SLICE_2_ophthalmology_023$lon <- SLICE_2_ophthalmology_023_geo$lon
SLICE_2_ophthalmology_023$lat <- SLICE_2_ophthalmology_023_geo$lat

SLICE_1_orthopedic_surgery_025$lon <- SLICE_1_orthopedic_surgery_025_geo$lon
SLICE_1_orthopedic_surgery_025$lat <- SLICE_1_orthopedic_surgery_025_geo$lat

#### WRITE TO CSV
write_csv(SLICE_1_orthopedic_surgery_025, path = "Processed_CSV/Specialties/SLICE_1_orthopedic_surgery_025.csv")

write_csv(SLICE_2_ophthalmology_023, path = "Processed_CSV/Specialties/SLICE_2_ophthalmology_023.csv")

# FRIDAY START TIME
clean_start_time
# FRIDAY FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
