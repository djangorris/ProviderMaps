# start_time
# [1] "05/30/18  9:14:31"
# finish_time
#   [1] "05/30/18  9:34:31"
#   Time difference of 20.00409 mins
#### FIRST MAKE SURE THERE ARE QUERIES AVAILABLE ###
geocodeQueryCheck()
# START TIME - AIM FOR 9:15 AM
start_time <- Sys.time()
clean_start_time <- format(start_time, "%m/%d/%y %l:%M:%S")
# FILTER SPECIALTY
vascular_surgery_034 <- filter(CO_all_medical_providers, Specialty %in% "034 Vascular Surgery")

cardiothoracic_surgery_035 <- filter(CO_all_medical_providers, Specialty %in% "035 Cardiothoracic Surgery")

cardiac_surgery_041 <- filter(CO_all_medical_providers, Specialty %in% "041 Cardiac Surgery Program")

ICU_043 <- filter(CO_all_medical_providers, Specialty %in% "043 Critical Care Services - Intensive Care Units (ICU)")

ambulatory_045 <- filter(CO_all_medical_providers, Specialty %in% "045 Surgical Services (Ambulatory Surgical Centers and Outpatient Hospital)")

diagnostic_radiology_047 <- filter(CO_all_medical_providers, Specialty %in% "047 Diagnostic Radiology (free-standing; hospital outpatient; ambulatory health facilities with Dx Radiology)")

physical_therapy_049 <- filter(CO_all_medical_providers, Specialty %in% "049 Physical Therapy (individual physical therapists providing care in Free-standing; hospital outpatient and ambulatory health care facilities)")

occupational_therapist_050 <- filter(CO_all_medical_providers, Specialty %in% "050 Occupational Therapist")

speech_therapy_051 <- filter(CO_all_medical_providers, Specialty %in% "051 Speech Therapy")

ambulatory_057 <- filter(CO_all_medical_providers, Specialty %in% "057 Ambulatory Health Care Facilities - Infusion Therapy/Oncology/Radiology")

pediatrics_101 <- filter(CO_all_medical_providers, Specialty %in% "101 Pediatrics - Routine/Primary Care")

# SLICE
SLICE_2_vascular_surgery_034 <- slice(vascular_surgery_034, 190:n())

SLICE_1_pediatrics_101 <- slice(pediatrics_101, 1:1755)

#### CALCULATE sum SHOULD EQUAL 2500
wednesday_5_30_1 <- nrow(SLICE_2_vascular_surgery_034)
wednesday_5_30_1
wednesday_5_30_2 <- nrow(cardiothoracic_surgery_035)
wednesday_5_30_2
wednesday_5_30_3 <- nrow(cardiac_surgery_041)
wednesday_5_30_3
wednesday_5_30_4 <- nrow(ICU_043)
wednesday_5_30_4
wednesday_5_30_5 <- nrow(ambulatory_045)
wednesday_5_30_5
wednesday_5_30_6 <- nrow(diagnostic_radiology_047)
wednesday_5_30_6
wednesday_5_30_7 <- nrow(physical_therapy_049)
wednesday_5_30_7
wednesday_5_30_8 <- nrow(occupational_therapist_050)
wednesday_5_30_8
wednesday_5_30_9 <- nrow(speech_therapy_051)
wednesday_5_30_9
wednesday_5_30_10 <- nrow(ambulatory_057)
wednesday_5_30_10
wednesday_5_30_11<- nrow(SLICE_1_pediatrics_101)
wednesday_5_30_11

sum(wednesday_5_30_1,
    wednesday_5_30_2,
    wednesday_5_30_3,
    wednesday_5_30_4,
    wednesday_5_30_5,
    wednesday_5_30_6,
    wednesday_5_30_7,
    wednesday_5_30_8,
    wednesday_5_30_9,
    wednesday_5_30_10,
    wednesday_5_30_11)


## USE THE GEOCODING API INFO IN SECRET.R
# SLICE_2_vascular_surgery_034_geo <- geocode(location = SLICE_2_vascular_surgery_034$locations, output="latlon", source="google")

SLICE_2_vascular_surgery_034_geo <- geocode(location = SLICE_2_vascular_surgery_034$locations, output="latlon", source="google")

cardiothoracic_surgery_035_geo <- geocode(location = cardiothoracic_surgery_035$locations, output="latlon", source="google")

cardiac_surgery_041_geo <- geocode(location = cardiac_surgery_041$locations, output="latlon", source="google")

ICU_043_geo <- geocode(location = ICU_043$locations, output="latlon", source="google")

ambulatory_045_geo <- geocode(location = ambulatory_045$locations, output="latlon", source="google")

diagnostic_radiology_047_geo <- geocode(location = diagnostic_radiology_047$locations, output="latlon", source="google")

physical_therapy_049_geo <- geocode(location = physical_therapy_049$locations, output="latlon", source="google")

occupational_therapist_050_geo <- geocode(location = occupational_therapist_050$locations, output="latlon", source="google")

speech_therapy_051_geo <- geocode(location = speech_therapy_051$locations, output="latlon", source="google")

ambulatory_057_geo <- geocode(location = ambulatory_057$locations, output="latlon", source="google")

SLICE_1_pediatrics_101_geo <- geocode(location = SLICE_1_pediatrics_101$locations, output="latlon", source="google")


# Bringing over the longitude and latitude data

SLICE_2_vascular_surgery_034$lon <- SLICE_2_vascular_surgery_034_geo$lon
SLICE_2_vascular_surgery_034$lat <- SLICE_2_vascular_surgery_034_geo$lat

cardiothoracic_surgery_035$lon <- cardiothoracic_surgery_035_geo$lon
cardiothoracic_surgery_035$lat <- cardiothoracic_surgery_035_geo$lat

cardiac_surgery_041$lon <- cardiac_surgery_041_geo$lon
cardiac_surgery_041$lat <- cardiac_surgery_041_geo$lat

ICU_043$lon <- ICU_043_geo$lon
ICU_043$lat <- ICU_043_geo$lat

ambulatory_045$lon <- ambulatory_045_geo$lon
ambulatory_045$lat <- ambulatory_045_geo$lat

diagnostic_radiology_047$lon <- diagnostic_radiology_047_geo$lon
diagnostic_radiology_047$lat <- diagnostic_radiology_047_geo$lat

physical_therapy_049$lon <- physical_therapy_049_geo$lon
physical_therapy_049$lat <- physical_therapy_049_geo$lat

occupational_therapist_050$lon <- occupational_therapist_050_geo$lon
occupational_therapist_050$lat <- occupational_therapist_050_geo$lat

speech_therapy_051$lon <- speech_therapy_051_geo$lon
speech_therapy_051$lat <- speech_therapy_051_geo$lat

ambulatory_057$lon <- ambulatory_057_geo$lon
ambulatory_057$lat <- ambulatory_057_geo$lat

SLICE_1_pediatrics_101$lon <- SLICE_1_pediatrics_101_geo$lon
SLICE_1_pediatrics_101$lat <- SLICE_1_pediatrics_101_geo$lat

#### WRITE TO CSV
write_csv(SLICE_2_vascular_surgery_034, path = "Processed_CSV/Specialties/SLICE_2_vascular_surgery_034.csv")

write_csv(cardiothoracic_surgery_035, path = "Processed_CSV/Specialties/cardiothoracic_surgery_035.csv")

write_csv(cardiac_surgery_041, path = "Processed_CSV/Specialties/cardiac_surgery_041.csv")

write_csv(ICU_043, path = "Processed_CSV/Specialties/ICU_043.csv")

write_csv(ambulatory_045, path = "Processed_CSV/Specialties/ambulatory_045.csv")

write_csv(diagnostic_radiology_047, path = "Processed_CSV/Specialties/diagnostic_radiology_047.csv")

write_csv(physical_therapy_049, path = "Processed_CSV/Specialties/physical_therapy_049.csv")

write_csv(occupational_therapist_050, path = "Processed_CSV/Specialties/occupational_therapist_050.csv")

write_csv(speech_therapy_051, path = "Processed_CSV/Specialties/speech_therapy_051.csv")

write_csv(ambulatory_057, path = "Processed_CSV/Specialties/ambulatory_057.csv")

write_csv(SLICE_1_pediatrics_101, path = "Processed_CSV/Specialties/SLICE_1_pediatrics_101.csv")

# START TIME
clean_start_time
# FINISH TIME
finish_time <- Sys.time()
clean_finish_time <- format(finish_time, "%m/%d/%y %l:%M:%S")
clean_finish_time
difftime(finish_time, start_time)
