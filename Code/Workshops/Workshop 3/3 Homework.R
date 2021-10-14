### Week 3 homework

#Loading tidyverse:
library("tidyverse")
library("vroom")

#Loading in files from GitHub
pop_1 <- vroom("https://raw.githubusercontent.com/rosiecha/Bioinformatics_data/master/Workshop%203/to_sort_pop_1.csv")
pop_2 <- vroom("https://raw.githubusercontent.com/rosiecha/Bioinformatics_data/master/Workshop%203/to_sort_pop_2.csv")

#merging pop_1 and pop_2 into one tibble
pop_merged <- left_join(pop_1,pop_2)
pop_merged

#reshaping to long format
pop_long <- pop_merged %>%
  pivot_longer(cols = -c(species:tertiary_threat),
               names_to = c("population", "date"),
               values_to = "abundance",
               names_pattern =  "pop_(.*)_(.*)")
pop_long