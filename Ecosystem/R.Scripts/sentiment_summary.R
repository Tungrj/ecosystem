new_encoded <- encoded %>%
  distinct(`Text Content`, Sentiment, Codes) %>%  
  group_by(`Text Content`, Codes) %>%
  summarise(
    SentimentCategory = paste(sort(unique(Sentiment)), collapse = ", "),
    .groups = "drop"
  )

codes_lookup <- encoded %>%
  distinct(Codes, `Overarching Codes`, Quadrant)

presence_matrix <- encoded %>%
  distinct(ID, Codes) %>%              
  mutate(present = TRUE) %>%         
  pivot_wider(
    names_from = ID,
    values_from = present,
    values_fill = FALSE                
  ) 

sentiment_summary_by_code <- new_encoded %>%
  count(Codes, SentimentCategory, name = "count") %>%        
  group_by(Codes) %>%
  mutate(
    total_n = sum(count),      
    prop = count / total_n   
  ) %>%
  ungroup() %>%
  select(-count) %>%
  pivot_wider(
    names_from = SentimentCategory,
    values_from = prop,
    values_fill = 0
  ) %>%
  left_join(codes_lookup, by = "Codes") %>%
  left_join(presence_matrix, by = "Codes") %>%
  distinct() %>%
  )
