library(readxl)
library(readr)
library(ggOceanMaps)
library(tidyverse)

#raw data files
rawFiles <- list.files("data/raw", full.names = TRUE)
#omit the unneeded spreadsheet in data/raw
rawFiles <- rawFiles[-1]
#sheets needed in each file
rawSheets <- c(1,1)
#lookup table with probability of porpocide for every case
lookup <- read_csv(file="data/derived/Porpicide_Lookup.csv")
#vars wanted (note these vary nominally in each spreadsheet)
varsWanted <- c("TMMC_ID","Age_Class","Sex","Strand_Date","Strand_County", "County", "Latitude", "Longitude")

getData <- function(raw, vars) {
  result <- raw %>% 
    select(any_of(vars)) %>% 
    left_join(lookup, by = "TMMC_ID") %>%
    mutate(year = year(Strand_Date)) %>%
    mutate(Latitude = as.numeric(Latitude)) %>%
    mutate(Longitude = as.numeric(Longitude))
  names(result) <- c("id", "age", "sex", "date", "county", "lat", "lon", "prob", "year")
  return(result)
}

myData <- map2(rawFiles, rawSheets, function(x,y) read_excel(path=x, sheet=1))
myData <- map(myData, function(x) getData(x, vars=varsWanted))
myData <- list_rbind(myData)

myData %>% 
  group_by(year, prob) %>% 
  tally %>%
  # filter(prob != "NA" & prob != "UNLIKELY") %>% 
  ggplot(aes(x=year,y=n, color=prob)) +
  geom_line()

# ---- MAKE MAP

myStrandings <- drop_na(myData, lat, lon)
maps <- myStrandings %>%
  nest(data=-prob) %>%
  mutate(plot = map2(data, prob, function(x, y) qmap(x, color=year)+ggtitle(y))) %>% 
  pull(plot, name = prob)

maps
