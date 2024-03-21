
pacman::p_load("dplyr", "fingertipsR", "janitor")
wd <- getwd()
## Add the file path to NWL geography look ups 
nwl_geography_codes <- read.csv(paste0(wd,"/R/data/lsoa_msoa_lad_2011_and_2021_code_nwl.csv"))
msoa_codes_11 <-  unique(nwl_geography_codes$msoa11cd) # creates a unique list of codes

## Ingest fingertips data 
## Creates a list of all profiles
fingertips_profiles <-  profiles(proxy_settings = "none")
## Creates a list of all obesity profiles
obesity <- fingertipsR::indicators(ProfileID = 32, proxy_settings = "none")

## Makes a dataframe of childhood obesity by NWL msoa
obesity_child_msoa <- fingertipsR::fingertips_data(IndicatorID = c(93108), AreaTypeID = 3, proxy_settings = "none", AreaCode = msoa_codes_11) %>% 
  janitor::clean_names() # cleans names so all lowercase and replaces " " with "_"

# Inspect dataframe
View(obesity_child_msoa)
head(obesity_child_msoa)

# View the 8th row of data
obesity_child_msoa[8,]

# View the data time period columns
obesity_child_msoa["timeperiod"]

# Show the unique timeperiods in the data set
unique(obesity_child_msoa$timeperiod)
#or
obesity_child_msoa %>% 
  dplyr::distinct(timeperiod)

# List column names 
colnames(obesity_child_msoa)

# Summarise data frame  (obesity_child_msoa)
 summary(obesity_child_msoa)
 
# Test if timeperiod_sortable is a date value
 is.numeric.Date(obesity_child_msoa$timeperiod_sortable)
 
# Test if timeperiod_sortable is numeric
 is.numeric(obesity_child_msoa$timeperiod_sortable)
 
# change timeperiod_sortable to a date value -- hint you can only change character values into dates
 obesity_child_msoa$timeperiod_date <- as.Date(as.character(obesity_child_msoa$timeperiod_sortable), "%Y")

 
 

