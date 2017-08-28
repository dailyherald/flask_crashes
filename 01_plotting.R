# load the libraries 
library(readr)
library(ggplot2)
library(ggthemes)
#-------------------

df <- read_csv("data/all_crashData_0809.csv")
dfsum <- data.frame(unclass(summary(df)), check.names = FALSE, stringsAsFactors = FALSE)

# select everything except Chicago
df <- df[df$town != "Chicago",]


qplot(ped_total, data=df, 
      geom="density",
      fill = factor(year),
      color = factor(year)
      #alpha=I(.5) 
) +
  facet_grid(. ~ factor(year))

qplot(cycle_total, data=df, 
      geom="density",
      fill = factor(year),
      color = factor(year)
      #alpha=I(.5) 
) +
  facet_grid(. ~ factor(year))

qplot(total_crashes, data=df, 
      geom="density",
      fill = factor(year),
      color = factor(year)
      #alpha=I(.5) 
) +
  facet_grid(. ~ factor(year))

qplot(cycle_rate, data=df, 
      geom="density",
      fill = factor(year),
      color = factor(year)
      #alpha=I(.5) 
) +
  facet_grid(. ~ factor(year))

qplot(ped_rate, data=df, 
      geom="density",
      fill = factor(year),
      color = factor(year)
      #alpha=I(.5) 
) +
  facet_grid(. ~ factor(year))

qplot(total_rate, data=df, 
      geom="density",
      fill = factor(year),
      color = factor(year)
      #alpha=I(.5) 
) +
  facet_grid(. ~ factor(year))

# select everthing with total crash rate under 3
dfa <- df[df$total_rate < 3,]

qplot(pop,cycle_rate,
      data=dfa,
      alpha=I(.25)) + 
  stat_smooth(method="lm") +
  facet_grid(. ~ factor(year))

qplot(pop,ped_rate,
      data=dfa,
      alpha=I(.25)) + 
  stat_smooth(method="lm") +
  facet_grid(. ~ factor(year))

qplot(pop,total_rate,
      data=dfa,
      alpha=I(.25)) + 
  stat_smooth(method="lm") +
  facet_grid(. ~ factor(year))

qplot(pop,cycle_total,
      data=dfa,
      alpha=I(.25)) + 
  stat_smooth(method="lm") +
  facet_grid(. ~ factor(year))

qplot(pop,ped_total,
      data=dfa,
      alpha=I(.25)) + 
  stat_smooth(method="lm") +
  facet_grid(. ~ factor(year))

qplot(pop,total_crashes,
      data=dfa,
      alpha=I(.25)) + 
  stat_smooth(method="lm") +
  facet_grid(. ~ factor(year))
