### Week 4 Homework

library("tidyverse")
library("vroom")

#Read in the data
wide_spp.1 <- vroom("https://raw.githubusercontent.com/chrit88/Bioinformatics_data/master/Workshop%203/to_sort_pop_1.csv")
wide_spp.2 <- vroom("https://raw.githubusercontent.com/chrit88/Bioinformatics_data/master/Workshop%203/to_sort_pop_2.csv") 

#Reshape + merge data
#Separate names into population and date
long_spp <- full_join(wide_spp.1, wide_spp.2) %>%
  pivot_longer(cols = -c(species:tertiary_threat),
               names_to = c("population", "date"),
               names_pattern = "pop_(.*)_(.*)",
               values_drop_na = T, 
               values_to = "abundance")

long_spp
length(unique(long_spp$species)) #there are 51 unique species
length(unique(long_spp$primary_threat)) #there are 7 unique primary threats


#Homework: Visualize the time series data

#correcting the date format
long_spp$date.corrected <- as.Date(long_spp$date, "%Y-%d-%m")


###Plot 1:
abundance_plot <- ggplot(data = long_spp, aes(x = date.corrected, y = abundance)) 

#split into facets by primary threat, coloured by species
abundance_plot + geom_point(aes(col=species)) + facet_wrap(. ~ primary_threat)

###Plot 2:
threat_means <- long_spp %>% 
  # we want to calculate mean abundance for each threat on each date:
  group_by(primary_threat, date.corrected) %>% 
  ## and we want the sum of the "Death" column in these groups:
  summarise(abundance = mean(abundance, na.rm = TRUE))

threat_plot <- ggplot(data = threat_means, aes(x = date.corrected, y = abundance)) 
threat_plot + geom_line(aes(col=primary_threat)) 


###Plot 3: plot 2 faceted
threat_plot + geom_line(aes(col=primary_threat)) + 
  facet_wrap(. ~ primary_threat) + 
  theme(legend.position = "none")

###Plot 4: plot 3 rolling average
pop_threat_means <- long_spp %>% 
  group_by(primary_threat, date.corrected, population) %>% 
  summarise(abundance = mean(abundance, na.rm = TRUE))
pop_threat_means

pop_threat_plot <- ggplot(na.omit(pop_threat_means), aes(x = date.corrected, y = abundance)) 

pop_threat_plot + geom_line(aes(col=population)) + 
  facet_wrap(. ~ primary_threat)




###Plot 5: plot 4 with relative abundances

#Finding max abundance of each species
max_abundance <- long_spp %>%
  group_by(species) %>%
  summarise(max_abundance = max(abundance))
max_abundance

#Making new df containing max abundances
newdf <- full_join(long_spp, max_abundance, by = "species")

#making column of abundance / max abundance to give relative abundance
newdf$rel_abundance <- newdf$abundance / newdf$max_abundance

#finds mean relative abundance of species by primary threat over time
pop_threat_means <-newdf %>% 
  group_by(primary_threat, date.corrected, population) %>% 
  summarise(rel_abundance = mean(rel_abundance))
pop_threat_means

#plot data
pop_threat_plot <- ggplot(na.omit(pop_threat_means), aes(x = date.corrected, y = rel_abundance)) 
#plot format
pop_threat_plot + geom_line(aes(col=population)) + facet_wrap(. ~ primary_threat)



###Plot 6: plot 5 with populations averaged
pop_threat_means <-newdf %>% 
  group_by(primary_threat, date.corrected) %>% 
  summarise(rel_abundance = mean(rel_abundance))
pop_threat_means

#plot data
pop_threat_plot <- ggplot(na.omit(pop_threat_means), aes(x = date.corrected, y = rel_abundance)) 
#plot format
pop_threat_plot + geom_line() + facet_wrap(. ~ primary_threat)

