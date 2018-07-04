# REPLACE:
# general_practice_001 (target geocoded variable name)
# 001 General Practice (copy/paste from TOTAL_Specialty_Count spreadsheet on Desktop)

# GET COUNT FOR EACH CARRIER
selected_specialty <- "001 General Practice"
clean_selected_specialty <- str_replace_all(selected_specialty, " ", "_")
statewide_count_general_practice_001 <- ALL_statewide_specialty_count %>%
  filter(Specialty == selected_specialty)
# DEFINING THE MAP
col_lon <- c(-109, -102)
col_lat <- c(36.86204, 41.03)
bbox <- make_bbox(col_lon, col_lat, f=0.05)
co_map <- get_map(bbox, maptype="toner-lite", source = "stamen")
# DISPLAY MAP AND ADD DATA POINTS
ggmap(co_map, extent = "device") +
  # geom_density2d(data = general_practice_001,
  #                aes(x = lon, y = lat),
  #                size = 0.3) +
  # stat_density2d(data = general_practice_001,
  #                aes(x = lon, y = lat, fill = ..level.., alpha = ..level..),
  #                size = 0.01,
  #                bins = 10,
  #                geom = "polygon") +
  # scale_fill_gradient(low = "tomato", high = "green4") +
  # scale_alpha(range=c(0,1), limits=c(0,200)) +
  geom_point(aes(lon, lat),
             shape = 21,
             stroke = 5,
             size = 1,
             color = "green",
             fill = "green4",
             alpha = 0.2,
             data = general_practice_001,
             position = position_jitter(w = 0.002, h = 0.002)) +
  facet_wrap(~Carrier, ncol = 4) +
  xlab(" ") +
  ylab(NULL) +
  ggtitle(paste0('2018 ', '"', selected_specialty, '"', ' Providers')) +
  geom_text(data = statewide_count_general_practice_001, aes(x = -107, y = 41, label = str_c(count, " Providers"))) +
  labs(caption = "\n\n  Graphic by Colorado Health Insurance Insider | @lukkyjay                                                                                          Source: SERFF") +
  theme_provider_maps +
  ggsave(filename = "Plots/general_practice_001.png", width = 9, height = 5, dpi = 1200)
