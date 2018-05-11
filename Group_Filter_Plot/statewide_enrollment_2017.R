################################################
## ENROLLMENT DATA
################################################
members <- c(55860, 16666, 21728, 675, 110000, 3611)
carrier <- c("Anthem BCBS", "Bright", "Cigna", "Denver Health", "Kaiser", "RMHP")
ind_enrollment_2017 <- data.frame("Carrier" = carrier, "Members" = members)
# Plot
cols <- c("Anthem BCBS" = "blue",
          "Bright" = "deeppink3",
          "Cigna" = "forestgreen",
          "Denver Health" = "navyblue",
          "Kaiser" = "deepskyblue2",
          "RMHP" = "darkorange")
ggplot(ind_enrollment_2017, aes(x = Carrier, y = Members, fill = Carrier)) +
  geom_bar(position="dodge", stat="identity") +
  scale_y_continuous(labels = comma) +
  geom_text(aes(label= format(Members, big.mark=",", trim=TRUE)), vjust = -0.5) +
  xlab(" ") +
  ylab(NULL) +
  ggtitle("2017 Colorado Statewide Individual Market Medical Enrollment") +
  scale_fill_manual(values = cols) +
  labs(caption = "\n  Graphic by Colorado Health Insurance Insider | @lukkyjay                                                                                                                                                               Source: SERFF") +
  theme_provider_maps +
  ggsave(filename = "Plots/statewide_enrollment.png",
         width = 12, height = 8, dpi = 1200)
