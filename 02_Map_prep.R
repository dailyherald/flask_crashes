# load the libraries 
library(readr)
library(ggplot2)
library(rgdal)
library(dplyr)
library(ggmap)
#-------------------

df <- read_csv("data/all_crashData_0809.csv")


#-------- prep data for mapping ------------

ill <- readOGR(dsn = "sixCoplaces/smaller2.shp")

head(ill@data, n = 10)
summary(ill@data)

# check the projection
ill@proj4string

plot(ill)

# let's see if we can join by county name
ill$NAME10 %in% df$town

write_csv(ill@data,"data/illdataCheck.csv")
# export out to csv and check whether any names are missing or mismatched
# Found and removed Willowbrook and Wilmington CDPs from shapefile

# But there's a problem. Our data is set up so that it works for ggplot, but not for ggmap.
# fortunately, that's fixable

df2012 <- df[df$year == 2012,]
df2013 <- df[df$year == 2013,]
df2014 <- df[df$year == 2014,]
df2015 <- df[df$year == 2015,]

# rename columns
names(df2012)
df2012 <- rename(df2012, 
       cycle_total_2012 = cycle_total,
       cycle_fatal_2012 = cycle_fatal,
       cycle_inj_2012 = cycle_inj,
       ped_total_2012 = ped_total,
       ped_fatal_2012 = ped_fatal,
       ped_inj_2012 = ped_inj,
       total_crashes_2012 = total_crashes,
       total_inj_2012 = total_inj,
       total_fatal_2012 = total_fatal,
       pop_2012 = pop,
       cycle_rate_2012 = cycle_rate,
       ped_rate_2012 = ped_rate,
       total_rate_2012 = total_rate
       )
names(df2012)
# drop some columns
df2012$town2 = NULL
df2012$year = NULL
names(df2012)

# Now we do this for the other three years
df2013 <- rename(df2013, 
                 cycle_total_2013 = cycle_total,
                 cycle_fatal_2013 = cycle_fatal,
                 cycle_inj_2013 = cycle_inj,
                 ped_total_2013 = ped_total,
                 ped_fatal_2013 = ped_fatal,
                 ped_inj_2013 = ped_inj,
                 total_crashes_2013 = total_crashes,
                 total_inj_2013 = total_inj,
                 total_fatal_2013 = total_fatal,
                 pop_2013 = pop,
                 cycle_rate_2013 = cycle_rate,
                 ped_rate_2013 = ped_rate,
                 total_rate_2013 = total_rate
)
df2013$town2 = NULL
df2013$year = NULL

df2014 <- rename(df2014, 
                 cycle_total_2014 = cycle_total,
                 cycle_fatal_2014 = cycle_fatal,
                 cycle_inj_2014 = cycle_inj,
                 ped_total_2014 = ped_total,
                 ped_fatal_2014 = ped_fatal,
                 ped_inj_2014 = ped_inj,
                 total_crashes_2014 = total_crashes,
                 total_inj_2014 = total_inj,
                 total_fatal_2014 = total_fatal,
                 pop_2014 = pop,
                 cycle_rate_2014 = cycle_rate,
                 ped_rate_2014 = ped_rate,
                 total_rate_2014 = total_rate
)
df2014$town2 = NULL
df2014$year = NULL

df2015 <- rename(df2015, 
                 cycle_total_2015 = cycle_total,
                 cycle_fatal_2015 = cycle_fatal,
                 cycle_inj_2015 = cycle_inj,
                 ped_total_2015 = ped_total,
                 ped_fatal_2015 = ped_fatal,
                 ped_inj_2015 = ped_inj,
                 total_crashes_2015 = total_crashes,
                 total_inj_2015 = total_inj,
                 total_fatal_2015 = total_fatal,
                 pop_2015 = pop,
                 cycle_rate_2015 = cycle_rate,
                 ped_rate_2015 = ped_rate,
                 total_rate_2015 = total_rate
)
df2015$town2 = NULL
df2015$year = NULL

# now let's join all these
ill@data <- left_join(ill@data, df2012, by = c('NAME10' = 'town'))
ill@data <- left_join(ill@data, df2013, by = c('NAME10' = 'town'))
ill@data <- left_join(ill@data, df2014, by = c('NAME10' = 'town'))
ill@data <- left_join(ill@data, df2015, by = c('NAME10' = 'town'))

head(ill@data)
summary(ill@data)
names(ill)
# drop some old columns from the shapefile
ill@data$POPESTIMAT <- NULL
ill@data$POPESTIM_1 <- NULL
ill@data$POPESTIM_2 <- NULL
ill@data$change2010 <- NULL
ill@data$change2014 <- NULL
ill@data$change20_1 <- NULL
names(ill)

# save it out and import back in
write_csv(ill@data,"data/illdata.csv")
cycped <- read.csv("data/illdata.csv", stringsAsFactors = FALSE)
head(cycped)

# Fortify takes each polygon in a shapefile
# and changes it to a groupable set of points
# groupable based on ID
ill_f <- fortify(ill, region="GEOID10")
summary(ill_f)

# Once we have this dataframe, we have to rejoin the 
# data associated with it.

ill_f$id <- as.numeric(as.character(ill_f$id))
class(ill_f$id)
class(cycped$GEOID10)

ill_f <- left_join(ill_f, cycped, by = c('id' = 'GEOID10'))

names(ill_f)
# write to a csv
write_csv(ill_f,"data/ill_f.csv")

# import and process six-county outlines
counties <- readOGR(dsn = "sixcounties/SixCounties.shp")
names(counties@data)
co6 <- fortify(counties, region="geoid10")
write_csv(co6,"data/counties6.csv")