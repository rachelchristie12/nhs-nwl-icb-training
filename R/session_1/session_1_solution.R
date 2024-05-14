
## Load required packages
library(dplyr)
library(tidyr)
library(flextable)


# 1.  Import data needed  ----------------------------------------------------
## Import both csvs from the R/data folder (population and HES data)

data <- read.csv("C:/nhs-nwl-icb-training/R/data/HES MAR 2023-24 M10.csv") %>% 
  janitor::clean_names()
population <- read.csv("C:/nhs-nwl-icb-training/R/data/population.csv")

# 2. View data  ---------------------------------------------------------
# -  print top five rows of data 
# - list colunm name 
# - print the distinct Org.Codes and Org.Names in the dataframe 
head(data)
colnames(data)
data %>%  distinct(Org.Code, Org.Name)

# 3. Tidy data ------------------------------------------------------------
# - create a new data frame with only Financial.Year, Activity.Month, Org.Code, Org.Name and columns starting All.Specialties and
# - filter data to include only nation and  NWL ICB data
# - Rename Financial.Year to year
# - Convert Activity.Month to a data formart
# - Transform the Org.name so it either England or North West London 

data_tidy <- data %>% 
  dplyr::select(Financial.Year, Activity.Month, Org.Code, Org.Name, starts_with("All.specialties")) %>% 
  dplyr::filter(Org.Name=="NHS NORTH WEST LONDON ICB - W2U3Z" | Org.Code=="All") %>% 
  dplyr::rename(year=Financial.Year) %>% 
  dplyr::mutate(date=as.Date(paste0("01-",Activity.Month), "%d-%b-%y"),
                Org.Name=dplyr::case_when(
                  Org.Name=="-" ~ "England",
                  Org.Name=="NHS NORTH WEST LONDON ICB - W2U3Z" ~ "North West London",
                  TRUE ~ NA
                )) 

# 4. Reformat data --------------------------------------------------------
# - Convert the columns starting with All.specialities to long - so the data frame headings are year, date, Org.Name, activity , patient_count

data_long <- data_tidy %>% 
  tidyr::pivot_longer(cols= starts_with("All.specialties"), names_to = "activity", values_to = "patient_count") %>% 
  dplyr::mutate(patient_count=as.numeric(patient_count))

# 5. Summarise  data --------------------------------------------
# - Summarise the long data so you calculate the total and mean patient count across all dates by activity type and Org.Name
# - Create a a column that identifies whether the activities that are DNA within the dataframe 
# - Calculate the total DNAs per month and Org.name and create a new dataframe
data_long %>% 
  dplyr::group_by(Org.Name, activity) %>% 
  dplyr::summarise(total=sum(patient_count),
                   mean=mean(patient_count))

data_long <- data_long %>% 
  dplyr::mutate(is_DNA=ifelse(grepl("DNA", activity),1,0))

DNA_per_month <- data_long %>% 
  dplyr::filter(is_DNA==1) %>% 
  dplyr::group_by(date, Org.Name) %>% 
  dplyr::summarise(total=sum(patient_count))

# 6. Join data ------------------------------------------------------------
# - create a new dataframe and:
# - Join population data frame to the data
# - calculate the rate per population on DNAs

DNA_rates <- DNA_per_month %>% 
  dplyr::left_join(population, by=c("Org.Name"="geography_name")) %>% 
  dplyr::mutate(dna_rate=total/population*100000)


# 7. Reformat data (again) ------------------------------------------------
# - Pivot the table wider so there is a colunns: date, England, North West London with the rates as the values in the tableDNA_rates_wide <- DNA_rates %>% 
DNA_rates_wide <-  tidyr::pivot_wider(id_cols = c(date), names_from = Org.Name, values_from = dna_rate)


# 8. Create a presentation table ------------------------------------------
# - Create a nice table of the DNAs per month for England and NWL -- there are many different packages that can achieve this
# - add any formatting to the table you think would be useful

flextable(DNA_rates_wide) %>% 
  set_caption("DNAs per 100,000 population") %>%
  width(width = 1.5) %>% 
  colformat_num(digits = 0) %>% 
  bold(part = "header") %>%
  align(align = "center", part = "all") %>%
  color(color = "blue", part = "header") %>%
  theme_booktabs()
  

