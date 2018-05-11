### ALL MEDICAL DOCTORS STATEWIDE ###
STATEWIDE_ALL <- ALL_statewide_specialty_count %>%
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
  scale_y_continuous(labels = comma) +
  geom_text(aes(label= format(Total, big.mark=",", trim=TRUE)), vjust = -0.5) +
  xlab(" ") +
  ylab(NULL) +
  ggtitle("2018 Colorado Statewide Individual Market Medical Providers") +
  scale_fill_manual(values = cols) +
  labs(caption = "\n  Graphic by Colorado Health Insurance Insider | @lukkyjay                                                                                                                                                           Source: SERFF") +
  theme_provider_maps +
  ggsave(filename = "Plots/statewide_all.png",
         width = 12, height = 8, dpi = 1200)
