#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
#### MAKE SURE TO NOTE PREVIOUS DAY RUN TIME: ?????
# FILTER SPECIALTY
cardiovascular_dis_008 <- filter(CO_all_medical_providers, Specialty %in% "008 Cardiovascular Disease")

dermatology_011 <- filter(CO_all_medical_providers, Specialty %in% "011 Dermatology")

endocrinology_012 <- filter(CO_all_medical_providers, Specialty %in% "012 Endocrinology")
# SLICE
## DONE ## SLICE_1_cardiovascular_dis_008 <- cardiovascular_dis_008[1:2498, , drop = FALSE]

#### Next day: SATURDAY | 2018-05-12 3:56:41 MDT | READY ####
SLICE_2_cardiovascular_dis_008 <- slice(cardiovascular_dis_008, 2499:n()) # slice middle to end of df

SLICE_1_endocrinology_012 <- slice(endocrinology_012, 1:471)

## USE THE GEOCODING API INFO IN SECRET.R
SLICE_2_cardiovascular_dis_008_geo <- geocode(location = SLICE_2_cardiovascular_dis_008$locations, output="latlon", source="google")

dermatology_011_geo <- geocode(location = dermatology_011$locations, output="latlon", source="google")

SLICE_1_endocrinology_012_geo <- geocode(location = SLICE_1_endocrinology_012$locations, output="latlon", source="google")

# Bringing over the longitude and latitude data
SLICE_2_cardiovascular_dis_008$lon <- SLICE_2_cardiovascular_dis_008_geo$lon
SLICE_2_cardiovascular_dis_008$lat <- SLICE_2_cardiovascular_dis_008_geo$lat

dermatology_011$lon <- dermatology_011_geo$lon
dermatology_011$lat <- dermatology_011_geo$lat

SLICE_1_endocrinology_012$lon <- SLICE_1_endocrinology_012_geo$lon
SLICE_1_endocrinology_012$lat <- SLICE_1_endocrinology_012_geo$lat

#### WRITE TO CSV
write_csv(SLICE_2_cardiovascular_dis_008, path = "Processed_CSV/Specialties/SLICE_2_cardiovascular_dis_008.csv")

write_csv(dermatology_011, path = "Processed_CSV/Specialties/dermatology_011.csv")

write_csv(SLICE_1_endocrinology_012, path = "Processed_CSV/Specialties/SLICE_1_endocrinology_012.csv")

Sys.time()
