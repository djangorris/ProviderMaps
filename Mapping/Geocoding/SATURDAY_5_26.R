# start_time
# [1] "05/25/18  9:19:09"
# finish_time
#   [1] "05/25/18  9:39:25"
#   Time difference of 20.26575 mins

geocodeQueryCheck()

# START TIME - AIM FOR 9:20 PM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
orthopedic_surgery_025 <- filter(CO_all_medical_providers, Specialty %in% "025 Orthopedic Surgery")

physical_rehab_026 <- filter(CO_all_medical_providers, Specialty %in% "026 Physical Medicine & Rehabilitation")

# SLICE

SLICE_2_orthopedic_surgery_025 <- slice(orthopedic_surgery_025, 1029:n())

SLICE_1_physical_rehab_026 <- slice(physical_rehab_026, 1:322)

#### CALCULATE sum SHOULD EQUAL 2500
saturday1 <- nrow(SLICE_2_orthopedic_surgery_025)
saturday1
saturday2 <- nrow(SLICE_1_physical_rehab_026)
saturday2
sum(saturday1, saturday2)

## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_2_orthopedic_surgery_025_geo <- geocode(location = SLICE_2_orthopedic_surgery_025$locations, output="latlon", source="google")

SLICE_2_orthopedic_surgery_025_geo <- geocode(location = SLICE_2_orthopedic_surgery_025$locations, output="latlon", source="google")

SLICE_1_physical_rehab_026_geo <- geocode(location = SLICE_1_physical_rehab_026$locations, output="latlon", source="google")

# Bringing over the longitude and latitude data

SLICE_2_orthopedic_surgery_025$lon <- SLICE_2_orthopedic_surgery_025_geo$lon
SLICE_2_orthopedic_surgery_025$lat <- SLICE_2_orthopedic_surgery_025_geo$lat

SLICE_1_physical_rehab_026$lon <- SLICE_1_physical_rehab_026_geo$lon
SLICE_1_physical_rehab_026$lat <- SLICE_1_physical_rehab_026_geo$lat

#### WRITE TO CSV
write_csv(SLICE_2_orthopedic_surgery_025, path = "Processed_CSV/Specialties/SLICE_2_orthopedic_surgery_025.csv")

write_csv(SLICE_1_physical_rehab_026, path = "Processed_CSV/Specialties/SLICE_1_physical_rehab_026.csv")

clean_start_time
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
