
# Load required packages -- will need to install these packages before loading them in your library
library(dplyr)
library(tidyr)
library(ggplot2)
library(fingertipsR)
library(PHEindicatormethods)

# 1. Import data from fingertips for NWL
## Look at fingertips profiles
profiles <-  fingertipsR::profiles(proxy_settings = "none")

## Choose the Smoking profile and get all the indicaotrs in this profile
smoking_indicators <-fingertipsR::indicators(ProfileID = XX, proxy_settings = "none")

## Get smoking at time of delivery for all Local Authorities (https://fingertips.phe.org.uk/search/delivery#page/6/gid/1/pat/6/par/E12000001/ati/501/are/E06000047/iid/93085/age/1/sex/2/cat/-1/ctp/-1/yrr/1/cid/4/tbm/1)
smoking_at_delivery <-  fingertipsR::fingertips_data(IndicatorID = XXXXX, AreaTypeID = 501, proxy_settings = "none" ) 

# 2. Clean the data 
## Filter by local authorities in the london region
## Categorise each LA into their corresponding ICB
## Summarise data by ICB and timeperiod and recalualte the rate
## Calulate the condidence intervals -- hint the PHEindicators package has a neat function for this

# LSOA11_LOC22_ICB22_LAD22_EN_LU.xlsx in the data folder might be helpful



# 3. create a bar chart for the most recent date with ICB on the x-axis and smoking at time of delivery on the y-axis 
# Incldue the confidence intervals as error bars
# Add a title and better labeled axis


# 4. Create a time series of smoking at time of delivery for each ICB
## Hint you will need to change the timeperiod value to a date or numeric value




