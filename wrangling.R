### BINDING CARRIERS ###
CO_all_medical_providers <- bind_rows(ANTHEM_medical_providers,
                                     BRIGHT_medical_providers,
                                     CIGNA_medical_providers,
                                     DENVER_HEALTH_medical_providers,
                                     KAISER_medical_providers,
                                     RMHP_medical_providers)
CO_all_dental_providers <- bind_rows(ANTHEM_dental_providers,
                                     BRIGHT_dental_providers,
                                     CIGNA_dental_providers,
                                     DENVER_HEALTH_dental_providers,
                                     KAISER_dental_providers,
                                     RMHP_dental_providers)
ALL_county_specialty_count <- bind_rows(ANTHEM_county_specialty_count,
                                        BRIGHT_county_specialty_count,
                                        CIGNA_county_specialty_count,
                                        DENVER_HEALTH_county_specialty_count,
                                        KAISER_county_specialty_count,
                                        RMHP_county_specialty_count)
ALL_statewide_specialty_count <- bind_rows(ANTHEM_statewide_specialty_count,
                                           BRIGHT_statewide_specialty_count,
                                           CIGNA_statewide_specialty_count,
                                           DENVER_HEALTH_statewide_specialty_count,
                                           KAISER_statewide_specialty_count,
                                           RMHP_statewide_specialty_count)
# Carrier TO FACTOR
CO_all_medical_providers$Carrier <- as.factor(CO_all_medical_providers$Carrier)
CO_all_dental_providers$Carrier <- as.factor(CO_all_dental_providers$Carrier)
ALL_county_specialty_count$Carrier <- as.factor(ALL_county_specialty_count$Carrier)
ALL_statewide_specialty_count$Carrier <- as.factor(ALL_statewide_specialty_count$Carrier)
# Specialty TO FACTOR
CO_all_medical_providers$Specialty <- as.factor(CO_all_medical_providers$Specialty)
CO_all_dental_providers$Specialty <- as.factor(CO_all_dental_providers$Specialty)
ALL_county_specialty_count$Specialty <- as.factor(ALL_county_specialty_count$Specialty)
ALL_statewide_specialty_count$Specialty <- as.factor(ALL_statewide_specialty_count$Specialty)
# COUNTY TO FACTOR
CO_all_medical_providers$County <- as.factor(CO_all_medical_providers$County)
CO_all_dental_providers$County <- as.factor(CO_all_dental_providers$County)
ALL_county_specialty_count$County <- as.factor(ALL_county_specialty_count$County)
### EXPORTING ###
write_csv(CO_all_medical_providers, path = "Processed_CSV/CO_all_medical_providers.csv")
write_csv(CO_all_dental_providers, path = "Processed_CSV/CO_all_dental_providers.csv")
write_csv(ALL_county_specialty_count, path = "Processed_CSV/ALL_county_specialty_count.csv")
write_csv(ALL_statewide_specialty_count, path = "Processed_CSV/ALL_statewide_specialty_count.csv")

CO_all_medical_providers$Specialty <- str_trim(CO_all_medical_providers$Specialty)
CO_all_medical_providers$Specialty <- as.factor(CO_all_medical_providers$Specialty)

# FIND TOTAL COUNT OF PROVIDERS PER SPECIALTY FOR GEOCODING API QUOTA
TOTAL_Specialty_Count <- FINAL_CO_all_medical_providers %>%
  group_by(Specialty) %>%
  summarise(n = n())

### BINDING SLICES TOGETHER
ophthalmology_023 <- bind_rows(SLICE_1_ophthalmology_023, SLICE_2_ophthalmology_023)
write_csv(ophthalmology_023, path = "Processed_CSV/Specialties/ophthalmology_023.csv")
