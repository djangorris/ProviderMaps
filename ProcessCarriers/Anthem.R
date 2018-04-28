file <- "Anthem_BCBS.xlsm"
path <- paste0("Indiv/", file)
ext_removed <- tools::file_path_sans_ext(file)
carrier_name <- gsub("_", " ", ext_removed, fixed=TRUE)
providers1 <- read_excel(path, sheet = "IndividualProviders1", skip = 2,
                         col_names = c("NPI", "Prefix", "First_Name", "Last_Name", "Physician", "Specialty", "Street", "City", "State", "County", "Zip"),
                         col_types = c("text", "text", "text", "skip", "text", "skip", "text",
                                       "text", "text", "skip", "text", "text", "text", "text", "skip"))
providers2 <- read_excel(path, sheet = "IndividualProviders2", skip = 2,
                        col_names = c("NPI", "Prefix", "First_Name", "Last_Name", "Physician", "Specialty", "Street", "City", "State", "County", "Zip"),
                        col_types = c("text", "text", "text", "skip", "text", "skip", "text",
                                       "text", "text", "skip", "text", "text", "text", "text", "skip"))
# COMBINE THE TWO SHEETS
providers <- bind_rows(providers1, providers2)
# ADD CONCATENATED NAME + LOCATION COLUMN TO REMOVE DUPLICATES
providers$name_location <- paste0(providers$First_Name, " ", providers$Last_Name, ": ", providers$Street, ", ", providers$City, ", ", providers$State, ", ", providers$Zip)
# REMOVE DUPLICATES
providers = providers[!duplicated(providers$name_location),]
# ADD CONCATENATED LOCATIONS COLUMN FOR GEOCODING LATER
providers$locations <- paste0(providers$Street, ", ", providers$City, ", ", providers$State, ", ", providers$Zip)
# SEPARATE COLLAPSED CATEGORIES INTO MULTIPLE ROWS
providers <- separate_rows(providers, Specialty, sep = ",", convert = TRUE)
# PROVIDER SPECIALTY TO FACTOR
providers$Specialty <- as.factor(providers$Specialty)
# COUNTY TO FACTOR
providers$County <- as.factor(providers$County)
# ADD "CARRIER" COLUMN
providers$Carrier <- carrier_name
providers$Carrier <- as.factor(providers$Carrier)
# SEPARATE DENTAL PROVIDERS FROM MEDICAL PROVIDERS
ANTHEM_dental_providers <- filter(providers,
                           Prefix %in% c("DDS", "DMD") |
                             Specialty %in% c("Dental - General",
                                              "Dental - Periodontist",
                                              "Dental - Orthodontist",
                                              "Dental - Endodontist"))
ANTHEM_medical_providers <- filter(providers,
                            !Prefix %in% c("DDS", "DMD"),
                            !Specialty %in% c("Dental - General",
                                              "Dental - Periodontist",
                                              "Dental - Orthodontist",
                                              "Dental - Endodontist"))
# COUNT THE NUMBER OF PROVIDERS IN EACH CATEGORY STATEWIDE
ANTHEM_statewide_specialty_count <- ANTHEM_medical_providers %>%
  group_by(Carrier, Specialty) %>%
  summarise(count = n()) %>%
  arrange(-count)
# COUNT THE NUMBER OF PROVIDERS IN EACH CATEGORY IN EACH COUNTY
ANTHEM_county_specialty_count <- ANTHEM_medical_providers %>%
  group_by(Carrier, Specialty, County) %>%
  summarise(nproviders = n()) %>%
  arrange(-nproviders)
