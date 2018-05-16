# # monday START TIME
# > start_time
# [1] "05/14/18  4:06:50"
#
# > # monday FINISH TIME - API STARTS OVER IN 24 HOURS
#   > format(Sys.time(), "%m/%d/%y %l:%M:%S")
# [1] "05/14/18  4:30:13"
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# tuesday START TIME - AIM FOR AFTER 4:01 PM
start_time <- format(Sys.time(), "%m/%d/%y %l:%M:%S")
#### MAKE SURE TO NOTE PREVIOUS DAY RUN TIME: ?????
# FILTER SPECIALTY
general_surgery_015 <- filter(CO_all_medical_providers, Specialty %in% "015 General Surgery")

general_practice_001 <- filter(CO_all_medical_providers, Specialty %in% "001 General Practice")

family_medicine_002 <- filter(CO_all_medical_providers, Specialty %in% "002 Family Medicine")

# SLICE
#### Next day: SATURDAY | 2018-05-12 3:56:41 MDT | READY ####
SLICE_2_general_surgery_015 <- slice(general_surgery_015, 1686:n()) # slice middle to end of df

SLICE_1_family_medicine_002 <- slice(family_medicine_002, 1:1738)

#### CALCULATE sum SHOULD EQUAL 2500
tuesday1 <- nrow(SLICE_2_general_surgery_015)
tuesday1
tuesday2 <- nrow(general_practice_001)
tuesday2
tuesday3 <- nrow(SLICE_1_family_medicine_002)
tuesday3
sum(tuesday1, tuesday2, tuesday3)

## USE THE GEOCODING API INFO IN SECRET.R
# general_practice_001_geo <- geocode(location = general_practice_001$locations, output="latlon", source="google")
SLICE_2_general_surgery_015_geo <- geocode(location = SLICE_2_general_surgery_015$locations, output="latlon", source="google")

general_practice_001_geo <- geocode(location = general_practice_001$locations, output="latlon", source="google")

SLICE_1_family_medicine_002_geo <- geocode(location = SLICE_1_family_medicine_002$locations, output="latlon", source="google")


# Bringing over the longitude and latitude data
SLICE_2_general_surgery_015$lon <- SLICE_2_general_surgery_015_geo$lon
SLICE_2_general_surgery_015$lat <- SLICE_2_general_surgery_015_geo$lat

general_practice_001$lon <- general_practice_001_geo$lon
general_practice_001$lat <- general_practice_001_geo$lat

SLICE_1_family_medicine_002$lon <- SLICE_1_family_medicine_002_geo$lon
SLICE_1_family_medicine_002$lat <- SLICE_1_family_medicine_002_geo$lat

#### WRITE TO CSV
write_csv(general_practice_001, path = "Processed_CSV/Specialties/general_practice_001.csv")

write_csv(SLICE_2_general_surgery_015, path = "Processed_CSV/Specialties/SLICE_2_general_surgery_015.csv")

write_csv(SLICE_1_family_medicine_002, path = "Processed_CSV/Specialties/SLICE_1_family_medicine_002.csv")


# tuesday START TIME
start_time
# tuesday FINISH TIME - API STARTS OVER IN 24 HOURS
format(Sys.time(), "%m/%d/%y %l:%M:%S")
