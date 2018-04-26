##### SINGLE COUNTY TOTAL  #####
selected_county <- "Summit"
SINGLE_COUNTY <- ALL_county_specialty_count %>%
  filter(County == county_selected) %>%
  summarise(Total = sum(nproviders, na.rm = TRUE))
cols <- c("Anthem BCBS" = "blue",
          "Bright" = "deeppink3",
          "Cigna" = "forestgreen",
          "Denver Health" = "navyblue",
          "Kaiser" = "deepskyblue2",
          "RMHP" = "darkorange")
ggplot(SINGLE_COUNTY, aes(x = Carrier, y = Total, fill = Carrier)) +
  geom_bar(position="dodge", stat="identity") +
  xlab("Insurance Carrier") +
  ylab("Number of Providers") +
  ggtitle(str_c(selected_county, " County Medical Providers")) +
  scale_fill_manual(values = cols) +
  labs(caption = "  Graphic by Jay Norris / @lukkyjay  |  Source: SERFF") +
  theme(plot.margin = margin(5, 5, 5, 5),
        plot.caption = element_text(size = 8, color = "grey", hjust = 0)) +
  ggsave(filename = paste0(here("/"), "Plots/", selected_county, ".png"),
         width = 12, height = 8, dpi = 1200)
