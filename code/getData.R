library(readxl)
library(readr)
library(tidyverse)

getData <- function(raw, vars, lookup) {
  result <- raw %>% 
    select(any_of(vars)) %>% 
    left_join(lookup, by = "TMMC_ID") %>%
    mutate(year = year(Strand_Date))%>%
    mutate(yearf = as.factor(year)) %>%
    mutate(month = as.factor(month(Strand_Date))) %>%
    mutate(Latitude = as.numeric(Latitude)) %>%
    mutate(Longitude = as.numeric(Longitude)) %>%
    mutate(`CONFIDENCE  OF PORPICIDE` =  fct_relevel(`CONFIDENCE  OF PORPICIDE`, c("CONFIRMED", "PROBABLE", "SUSPECT", "UNLIKELY"))) %>%
    mutate(
      agef = case_when(
        Age_Class == "Adult" ~ "Adult",
        Age_Class == "Subadult" ~ "Subadult",
        Age_Class == "Juvenile" ~ "Juvenile",
        Age_Class == "Calf" ~ "Calf",
        .default = "Other"
      )
    ) %>%
    mutate(agef = as.factor(agef))
  names(result) <- c("id", "age", "sex", "date", "county", "lat", "lon", "prob", "year", "yearf", "month", "agef")
  levels(result$month) <- c("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")
  #replacing non-trauma cases (NA because not reviewed by B.C.) with UNLIKELY
  result$prob <- replace_na(result$prob, "UNLIKELY")
  result$sex <- as.factor(replace_na(result$sex, "Unknown"))
  levels(result$agef) <- c("Adult", "Subadult", "Juvenile", "Calf", "Other")
  return(result)
}