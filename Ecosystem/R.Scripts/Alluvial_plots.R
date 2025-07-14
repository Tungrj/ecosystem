quote_weighted <- quote %>%
  group_by(`Text Content`) %>%
  mutate(
    n_prof = n_distinct(Profession),
    n_sent = n_distinct(Sentiment),
    weight_quote = 1 / (n_prof * n_sent)
  ) %>%
  ungroup()

# Total weight per profession (sum of weights of all quotes in that profession)
profession_totals <- quote_weighted %>%
  group_by(Profession) %>%
  summarise(total_weight = sum(weight_quote), .groups = "drop")

# Sum weights by Profession and Quadrant
quote_count <- quote_weighted %>%
  group_by(Profession, Quadrant) %>%
  summarise(n = sum(weight_quote), .groups = "drop") %>%
  left_join(profession_totals, by = "Profession") %>%
  mutate(
    weight = n / total_weight,
    Quadrant = str_wrap(Quadrant, width = 12),
    Profession = str_wrap(Profession, width = 12),
    Quadrant = fct_relevel(Quadrant, "Coherence", "Cognitive", "Collective", "Reflexive")
  )

quote_count_3axis <- quote_weighted %>%
  group_by(Sentiment, Profession, Quadrant) %>%
  summarise(n = sum(weight_quote), .groups = "drop") %>%
  mutate(
    Sentiment = str_wrap(Sentiment, width = 12),
    Profession = str_wrap(Profession, width = 12),
    Quadrant = str_wrap(Quadrant, width = 12),
    Quadrant = fct_relevel(Quadrant, "Coherence", "Cognitive", "Collective", "Reflexive")
  )

library(ggalluvial)
pastel_colors <- c(
  "#A6CEE3",  # Light blue
  "#FB9A99",  # Light red/pink
  "#B2DF8A",  # Light green
  "#FDBF6F",  # Light orange
  "#CAB2D6"   # Light purple
)

ggplot(quote_count_3axis,
       aes(axis1 = Sentiment, axis2 = Profession, axis3 = Quadrant, y = n)) +
  geom_alluvium(aes(fill = Profession), width = 1/12, alpha = 0.8) +
  geom_stratum(width = 1/12, fill = "#EED7D1", color = "black") +
  geom_text(stat = "stratum", aes(label = after_stat(stratum)), size = 2.1) +
  scale_x_discrete(limits = c("Sentiment", "Profession", "Code"), expand = c(.05, .05)) +
  scale_fill_manual(values = pastel_colors) +
  labs(title = "Sentiment ← Profession → Code Themes",
       y = "Weighted Quote Proportion") +
  theme_minimal() + 
  theme(axis.text.y = element_text(size = 8),
        axis.text.x = element_text(angle = 45, hjust = 1),
        legend.key.size = unit(2, "lines"))



ggplot(quote_count,
       aes(axis1 = Profession, axis2 = Quadrant, y = n)) +
  geom_alluvium(aes(fill = Profession), width = 1/12) +
  geom_stratum(width = 1/12, fill = "#EED7D1", color = "black") +
  geom_text(stat = "stratum", aes(label = after_stat(stratum)), size = 3) +
  scale_x_discrete(limits = c("Profession", "Code"), expand = c(.05, .05)) +
  scale_fill_manual(values = pastel_colors) +
  labs(title = "Code Themes by Profession",
       y = "Weighted Quote Proportion") +
  theme_minimal() +
  theme(axis.text.y = element_text(size = 10),
        axis.text.x = element_text(angle = 45, hjust = 1),
        legend.key.size = unit(2, "lines"))

