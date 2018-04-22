### BINDING CARRIERS ###
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

### EXPORTING ###
write_csv(ALL_county_specialty_count, path = "Indiv/ALL_county_specialty_count.csv")
write_csv(ALL_statewide_specialty_count, path = "Indiv/ALL_statewide_specialty_count.csv")

### GROUPING ###
# General docs
STATEWIDE_ALL_General_Family_Internal <- ALL_statewide_specialty_count %>% 
  filter(Specialty %in% c("001 General Practice", 
                        "002 Family Medicine", 
                        "003 Internal Medicine")) %>% 
  group_by(Carrier) %>% 
  summarise(Total = sum(count, na.rm = TRUE))
# Contains Psychology specialty
STATEWIDE_ALL_Psychology <- ALL_statewide_specialty_count %>% 
  filter(Specialty %in% c("103 Psychology", 
                          "019 Neurology, 103 Psychology", 
                          "029 Psychiatry, 103 Psychology",
                          "102 Licensed Clinical Social Workers, 103 Psychology", 
                          "005 Primary Care - Physician Assistant, 103 Psychology",
                          "010 Chiropracty, 103 Psychology", 
                          "006 Primary Care - Nurse Practitioner, 102 Licensed Clinical Social Workers, 103 Psychology",
                          "006 Primary Care - Nurse Practitioner, 103 Psychology")) %>% 
  group_by(Carrier) %>% 
  summarise(Total = sum(count, na.rm = TRUE))
# Contains Psychiatry in specialty
STATEWIDE_ALL_Psychiatry <- ALL_statewide_specialty_count %>% 
  filter(Specialty %in% c("029 Psychiatry", 
                          "019 Neurology, 029 Psychiatry", 
                          "029 Psychiatry, 103 Psychology",
                          "012 Endocrinology, 029 Psychiatry", 
                          "026 Physical Medicine & Rehabilitation, 029 Psychiatry")) %>% 
  group_by(Carrier) %>% 
  summarise(Total = sum(count, na.rm = TRUE))

# VISUALIZING
data <- bind_rows("General Practice + 
                  Family Medicine + 
                  Internal Medicine" = STATEWIDE_ALL_General_Family_Internal, 
                  "Contains Psychology" = STATEWIDE_ALL_Psychology, 
                  "Contains Psychiatry" = STATEWIDE_ALL_Psychiatry,
                  .id = "Specialty")
data$Carrier <- as.factor(data$Carrier)
cols <- c("Anthem BCBS" = "blue2", 
          "Bright" = "deeppink3", 
          "Cigna" = "forestgreen",
          "Denver Health" = "darkorange",
          "Kaiser" = "deepskyblue2",
          "RMHP" = "tan1")
ggplot(data, aes(fill = Carrier, y = Total, x = Specialty, color = Carrier)) + 
  geom_bar(position="dodge", stat="identity") +
  xlab("Specialty Group") +
  ylab("Number of Providers") +
  ggtitle("Providers Grouped by Similar Specialty") +
  scale_colour_manual(values = cols)


