
## Load required packages
library(dplyr)
library(tidyr)
library(flextable)


# 1.  Import data needed  ----------------------------------------------------
## Import both csvs from the R/data folder (population and HES data)

data <- read.csv("path_to_file")
population <- read.csv("path_to_file")


# 2. View data  ---------------------------------------------------------
# -  print top five rows of data 
# - list colunm name 
# - print the distinct Org.Codes and Org.Names in the dataframe 


# 3. Tidy data ------------------------------------------------------------
# - create a new data frame with only Financial.Year, Activity.Month, Org.Code, Org.Name and columns starting All.Specialties and
# - filter data to include only nation and  NWL ICB data
# - Rename Financial.Year to year
# - Convert Activity.Month to a data formart
# - Transform the Org.name so it either England or North West London 



# 4. Reformat data --------------------------------------------------------
# - Convert the columns starting with All.specialities to long - so the data frame headings are year, date, Org.Name, activity , patient_count



# 5. Summarise  data --------------------------------------------
# - Summarise the long data so you calculate the total and mean patient count across all dates by activity type and Org.Name
# - Create a a column that identifies whether the activities that are DNA within the dataframe 
# - Calculate the total DNAs per month and Org.name and create a new dataframe


# 6. Join data ------------------------------------------------------------
# - create a new dataframe and:
  # - Join population data frame to the data
  # - calculate the rate per population on DNAs
# 


# 7. Reformat data (again) ------------------------------------------------
# - Pivot the table wider so there is a colunns: date, England, North West London with the rates as the values in the table


# 8. Create a presentation table ------------------------------------------
# - Create a nice table of the DNAs per month for England and NWL -- there are many different packages that can achieve this
# - add any formatting to the table you think would be useful


