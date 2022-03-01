library(tidyverse)

dat <- read_csv("https://raw.githubusercontent.com/brandonritchie/march_madness_2022/main/Big_Dance_CSV.csv?token=GHSAT0AAAAAABR4LKX7VAOMCSKP3OA5MWZGYRGKZLQ") %>% 
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

prob_dat <- dat1 %>% 
  left_join(dat2, by = c("Round", "Seed_1", "Seed_2")) %>% 
  mutate(prob = Seed_2_Wins / total_matchups) %>% 
  replace_na(list(prob = 0))

sample(c(0,1), size = 1, replace = TRUE, prob = c((1-0.371), 0.371))

seeds_2019 <- read_csv("school_seed_2019.csv")

seed_1 <- seeds_2019 %>% filter(School == "Duke") %>% pull(Seed)
seed_2 <- seeds_2019 %>% filter(School == "Texas Tech") %>% pull(Seed)

prob_dat %>% filter(Seed_1 == seed_1, Seed_2 == seed_2, Round == 4) %>% pull(prob)
sample(c(0,1), size = 1,replace = TRUE, prob = )
