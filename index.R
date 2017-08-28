# load the libraries 
library(readr)

# join census town names with towns in dataset

df1 <- read_csv("data/y2015.csv") # change year as needed
df2 <- read_csv("data/alltowns.csv")
df3 <- merge(x = df1, y = df2, by = "town", all.x = TRUE)
write_csv(df3,"data/towns2015.csv") # change year as needed

# Next, join ACA 5-year pop with year's data

df1 <- read_csv("data/towns2015.csv")
df2 <- read_csv("data/pop2015.csv")
df3 <- merge(x = df1, y = df2, by = "town", all.x = TRUE)
write_csv(df3,"data/join2015.csv")

df1 <- read_csv("data/towns2014.csv")
df2 <- read_csv("data/pop2014.csv")
df3 <- merge(x = df1, y = df2, by = "town", all.x = TRUE)
write_csv(df3,"data/join2014.csv")

df1 <- read_csv("data/towns2013.csv")
df2 <- read_csv("data/pop2013.csv")
df3 <- merge(x = df1, y = df2, by = "town", all.x = TRUE)
write_csv(df3,"data/join2013.csv")

df1 <- read_csv("data/towns2012.csv")
df2 <- read_csv("data/pop2012.csv")
df3 <- merge(x = df1, y = df2, by = "town", all.x = TRUE)
write_csv(df3,"data/join2012.csv")

# using excel to combine into all_crashData_0809
# and figure overall averages etc
#-------------------
