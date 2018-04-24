###### SINGLE COUNTY BY SPECIALTY #####
selected_county <- "Larimer"
selected_specialty <- "003 Internal Medicine"
COUNTY_ALL <- ALL_county_specialty_count %>% 
  group_by(Specialty, County) %>% 
  filter(Specialty == selected_specialty, County == selected_county)
# plot
cols <- c("Anthem BCBS" = "blue", 
          "Bright" = "deeppink3", 
          "Cigna" = "forestgreen",
          "Denver Health" = "navyblue",
          "Kaiser" = "deepskyblue2",
          "RMHP" = "darkorange")
ggplot(COUNTY_ALL, aes(x = Carrier, y = nproviders, fill = Carrier)) +
  geom_bar(position="dodge", stat="identity") +
  xlab("Insurance Carrier") +
  ylab("Number of Providers") +
  ggtitle(str_c(selected_county, " County ", selected_specialty, " Providers") +
            scale_fill_manual(values = cols)
          
          
          
          
          ### STATEWIDE BY COUNTY ###
          selected_specialty <- c("001 General Practice", 
                                  "002 Family Medicine", 
                                  "003 Internal Medicine")
          STATEWIDE_ALL <- ALL_statewide_specialty_count %>% 
            filter(Specialty %in% selected_specialty) %>% 
            group_by(Carrier) %>% 
            summarise(Total = sum(count, na.rm = TRUE))
          cols <- c("Anthem BCBS" = "blue", 
                    "Bright" = "deeppink3", 
                    "Cigna" = "forestgreen",
                    "Denver Health" = "navyblue",
                    "Kaiser" = "deepskyblue2",
                    "RMHP" = "darkorange")
          ggplot(STATEWIDE_ALL, aes(x = Carrier, y = Total, fill = Carrier)) +
            geom_bar(position="dodge", stat="identity") +
            xlab("Insurance Carrier") +
            ylab("Number of Providers") +
            ggtitle("Colorado Statewide Medical Providers") +
            scale_fill_manual(values = cols)
          