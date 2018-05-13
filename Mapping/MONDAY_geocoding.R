#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# MONDAY START TIME
format(Sys.time(), "%m/%d/%y %l:%M:%S")
#### MAKE SURE TO NOTE PREVIOUS DAY RUN TIME: ?????
# FILTER SPECIALTY
general_surgery_015 <- filter(CO_all_medical_providers, Specialty %in% "015 General Surgery")

gastroenterology_014 <- filter(CO_all_medical_providers, Specialty %in% "014 Gastroenterology")

# SLICE
#### Next day: SATURDAY | 2018-05-12 3:56:41 MDT | READY ####
SLICE_1_general_surgery_015 <- slice(general_surgery_015, 1:1685) # slice middle to end of df

SLICE_2_gastroenterology_014 <- slice(gastroenterology_014, 1402:n())

#### CALCULATE sum SHOULD EQUAL 2500
monday1 <- nrow(SLICE_2_gastroenterology_014)
monday1
monday2 <- nrow(SLICE_1_general_surgery_015)
monday2
sum(monday1, monday2)

## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_2_gastroenterology_014_geo <- geocode(location = SLICE_2_gastroenterology_014$locations, output="latlon", source="google")
SLICE_1_general_surgery_015_geo <- geocode(location = SLICE_1_general_surgery_015$locations, output="latlon", source="google")

SLICE_2_gastroenterology_014_geo <- geocode(location = SLICE_2_gastroenterology_014$locations, output="latlon", source="google")


# Bringing over the longitude and latitude data
SLICE_1_general_surgery_015$lon <- SLICE_1_general_surgery_015_geo$lon
SLICE_1_general_surgery_015$lat <- SLICE_1_general_surgery_015_geo$lat

SLICE_2_gastroenterology_014$lon <- SLICE_2_gastroenterology_014_geo$lon
SLICE_2_gastroenterology_014$lat <- SLICE_2_gastroenterology_014_geo$lat

#### WRITE TO CSV
write_csv(SLICE_2_gastroenterology_014, path = "Processed_CSV/Specialties/SLICE_2_gastroenterology_014.csv")

write_csv(SLICE_1_general_surgery_015, path = "Processed_CSV/Specialties/SLICE_1_general_surgery_015.csv")

# MONDAY FINISH TIME - API STARTS OVER IN 24 HOURS
format(Sys.time(), "%m/%d/%y %l:%M:%S")
