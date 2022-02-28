library(tidyverse)

dat <- read_csv("Big_Dance_CSV.csv") %>% 
  rename(Score_1 = Score...6,
         Score_2 = Score...9)

# Totals
dat1 <- dat %>% 
  count(Round, Seed_1, Seed_2) %>% 
  arrange(desc(n)) %>% 
  rename(total_matchups = n)

# Seed 2 wins
dat2 <- dat %>% 
  filter(Score_2 > Score_1) %>% 
  count(Round, Seed_1, Seed_2) %>% 
  arrange(desc(n)) %>% 
  rename(Seed_2_Wins = n)

dat1 %>% 
  left_join(dat2, by = c("Round", "Seed_1", "Seed_2")) %>% 
  mutate(prob = Seed_2_Wins / total_matchups)
