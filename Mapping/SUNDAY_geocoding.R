#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# SUNDAY START TIME
format(Sys.time(), "%m/%d/%y %l:%M:%S")
#### MAKE SURE TO NOTE PREVIOUS DAY RUN TIME: ?????
# FILTER SPECIALTY
ENT_013 <- filter(CO_all_medical_providers, Specialty %in% "013 ENT/Otolaryngology")

endocrinology_012 <- filter(CO_all_medical_providers, Specialty %in% "012 Endocrinology")

gastroenterology_014 <- filter(CO_all_medical_providers, Specialty %in% "014 Gastroenterology")

# SLICE
#### Next day: SATURDAY | 2018-05-12 3:56:41 MDT | READY ####
SLICE_2_endocrinology_012 <- slice(endocrinology_012, 472:n()) # slice middle to end of df

SLICE_1_gastroenterology_014 <- slice(gastroenterology_014, 1:1401)

#### CALCULATE TO sum SHOULD EQUAL 2500
# sunday1 <- nrow(SLICE_2_endocrinology_012)
# sunday1
# sunday2 <- nrow(ENT_013)
# sunday2
# sunday3 <- nrow(SLICE_1_gastroenterology_014)
# sunday3
# sum(sunday1, sunday2, sunday3)
## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_1_gastroenterology_014_geo <- geocode(location = SLICE_1_gastroenterology_014$locations, output="latlon", source="google")

ENT_013_geo <- geocode(location = ENT_013$locations, output="latlon", source="google")

SLICE_2_endocrinology_012_geo <- geocode(location = SLICE_2_endocrinology_012$locations, output="latlon", source="google")

SLICE_1_gastroenterology_014_geo <- geocode(location = SLICE_1_gastroenterology_014$locations, output="latlon", source="google")


# Bringing over the longitude and latitude data
# SLICE_1_gastroenterology_014$lon <- SLICE_1_gastroenterology_014_geo$lon
# SLICE_1_gastroenterology_014$lat <- SLICE_1_gastroenterology_014_geo$lat

ENT_013$lon <- ENT_013_geo$lon
ENT_013$lat <- ENT_013_geo$lat

SLICE_2_endocrinology_012$lon <- SLICE_2_endocrinology_012_geo$lon
SLICE_2_endocrinology_012$lat <- SLICE_2_endocrinology_012_geo$lat

SLICE_1_gastroenterology_014$lon <- SLICE_1_gastroenterology_014_geo$lon
SLICE_1_gastroenterology_014$lat <- SLICE_1_gastroenterology_014_geo$lat

#### WRITE TO CSV
write_csv(SLICE_1_gastroenterology_014, path = "Processed_CSV/Specialties/SLICE_1_gastroenterology_014.csv")

write_csv(ENT_013, path = "Processed_CSV/Specialties/ENT_013.csv")

write_csv(SLICE_2_endocrinology_012, path = "Processed_CSV/Specialties/SLICE_2_endocrinology_012.csv")

# SUNDAY FINISH TIME - API STARTS OVER IN 24 HOURS
format(Sys.time(), "%m/%d/%y %l:%M:%S")
