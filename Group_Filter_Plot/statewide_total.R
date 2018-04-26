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
  xlab("Insurance Carrier") +
  ylab("Number of Providers") +
  ggtitle("Colorado Statewide Medical Providers") +
  scale_fill_manual(values = cols) +
  labs(caption = "  Graphic by Jay Norris / @lukkyjay  |  Source: SERFF") +
  theme(plot.margin = margin(5, 5, 5, 5),
        plot.caption = element_text(size = 8, color = "grey", hjust = 0)) + 
  ggsave(filename = paste0(here("/"), "statewide_all.png"),
         width = 12, height = 8, dpi = 1200)
