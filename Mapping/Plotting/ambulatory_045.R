# REPLACE:
# ambulatory_045 (target geocoded variable name)
# 045 Surgical Services (Ambulatory Surgical Centers and Outpatient Hospital) (copy/paste from TOTAL_Specialty_Count spreadsheet on Desktop)

# GET COUNT FOR EACH CARRIER
selected_specialty <- "045 Surgical Services (Ambulatory Surgical Centers and Outpatient Hospital)"
clean_selected_specialty <- str_replace_all(selected_specialty, " ", "_")
statewide_count_ambulatory_045 <- ALL_statewide_specialty_count %>%
  filter(Specialty == selected_specialty)
# DEFINING THE MAP
col_lon <- c(-109, -102)
col_lat <- c(36.86204, 41.03)
bbox <- make_bbox(col_lon, col_lat, f=0.05)
co_map <- get_map(bbox, maptype="toner-lite", source = "stamen")
# DISPLAY MAP AND ADD DATA POINTS
ggmap(co_map, extent = "device") +
  geom_point(aes(lon, lat),
             shape = 21,
             stroke = 5,
             size = 1,
             color = "green",
             fill = "green4",
             alpha = 0.2,
             data = ambulatory_045,
             position = position_jitter(w = 0.002, h = 0.002)) +
  facet_wrap(~Carrier, ncol = 4) +
  xlab(" ") +
  ylab(NULL) +
  ggtitle(paste0('2018 ', '"', selected_specialty, '"', ' Providers')) +
  geom_text(data = statewide_count_ambulatory_045, aes(x = -107, y = 41, label = str_c(count, " Providers"))) +
  labs(caption = "\n\n  Graphic by Colorado Health Insurance Insider | @lukkyjay                                                                                          Source: SERFF") +
  theme_provider_maps +
  ggsave(filename = "Plots/ambulatory_045.png", width = 9, height = 5, dpi = 1200)
