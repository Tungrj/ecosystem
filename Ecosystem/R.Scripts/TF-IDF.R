################################
#Text Processing and Differential Term Analysis

#We imported interview transcripts and coded stakeholder roles into binary group variables (e.g., Clinician, Medtech, Economist). Text data were cleaned and #tokenized into words using the tidytext package, removing common stop words and numeric tokens. Group membership flags were pivoted to long format to associate #each word token with relevant stakeholder groups.

#Term frequency-inverse document frequency (TF-IDF) scores were calculated per group to identify distinctive and important words, highlighting language that #uniquely characterizes each stakeholder category. The top TF-IDF words per group were filtered, excluding irrelevant terms, and visualized using faceted bar plots #with ggplot2. 

################################


## Load Required Packages
install.packages(c("tidyverse", "tidytext", "tm", "ggplot2", "stringr"))
library(tidyverse)
library(tidytext)
library(tm)
library(stringr)
library(dplyr)
library(ggplot2)
library(readxl)

## Clean and Tokenize Text
# Unnest tokens and remove stop words
data("stop_words")

tidy_transcripts <- transcripts %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words, by = "word") %>%
  filter(!str_detect(word, "\\d+"))  # remove numbers

## 5. TF-IDF for More Than 2 Groups

# Compute tf-idf
tfidf_words <- grouped_words %>%
  count(group, word) %>%
  bind_tf_idf(word, group, n) %>%
  arrange(desc(tf_idf))

#Column Meanings
#Column	What It Means
#group	The group (e.g., "Medtech") that used the word
#word	A word used by that group
#n	The number of times that word appeared in that group
#tf	Term frequency — how often the word appears relative to all words in that group
#idf	Inverse document frequency — how unique the word is across all groups (higher = more unique)
#tf_idf	The product of tf * idf, highlighting important and distinctive words for that group

top_tfidf <- tfidf_words %>%
  group_by(group) %>%
  slice_max(tf_idf, n = 10) %>%
  ungroup()


## PLOT BY AREA OF WORK

filtered_tfidf <- top_tfidf %>%
  filter(group %in% c("Clinical", "Patient","Policy","Research","Medtech")) 

ggplot(filtered_tfidf, aes(x = reorder_within(word, tf_idf, group), y = tf_idf, fill = group)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ group, scales = "free", ncol = 2) +
  scale_x_reordered() +
  coord_flip() +
  labs(
    title = "Top TF-IDF Words by Stakeholder Group",
    x = NULL,
    y = "TF-IDF Score"
  ) +
  theme_minimal()

words_plotted <- filtered_tfidf %>%
  arrange(group, desc(tf_idf)) %>%
  select(group, word, tf_idf)

print(words_plotted)

ggplot(filtered_tfidf, aes(x = reorder_within(word, tf_idf, group), y = tf_idf, fill = group)) +
  geom_col(show.legend = FALSE) +
  facet_wrap(~ group, scales = "free", ncol = 2) +
  scale_x_reordered() +
  coord_flip() +
  labs(
    title = "Top TF-IDF Words by Stakeholder Group",
    x = NULL,
    y = "TF-IDF Score"
  ) +
  theme_minimal()

words_plotted <- filtered_tfidf %>%
  arrange(group, desc(tf_idf)) %>%
  select(group, word, tf_idf)

print(words_plotted)
