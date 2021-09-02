rm(list=ls())

# Install a package
# install.packages("openair") # we deactivate when a library was installed


# Call necessary libraries
library(openair)

# Import data ------------------------------------------
au <- read.csv("03_output/au_df_example.csv",
               sep = ",",
               dec = ".",
               header = T,
               na.strings = -9999)

head(au, 5)

str(au)

# Datetime format
au$date <- as.POSIXct(
  strptime(au$date,
           format = "%Y-%m-%dT%H:%M:%S+10:00"), 
  tz = "Etc/GMT+10"
)

str(au)

# Plots --------------------------------------------------
# EDA
summaryPlot(au)

# Ozone from mg/m3 to ug/m3
au$o3 <- au$o3 * 1000
summaryPlot(au, period = 'months')

# TimePlot()
timePlot(au, pollutant="pm10")
timePlot(au, pollutant=c('pm10', 'pm25', 'o3'))

# Using other data collected in Sao Paulo ---------------------

ibi <- readRDS("02_data/ibi_30_year_df.RDS")

# Save as pdf file (works)
pdf("03_output/fig/eda_ibi_2.pdf", width = 12, height = 7)
summaryPlot(ibi)
dev.off()

pdf("03_output/fig/ozone_time.pdf", width = 8, height = 4)
timePlot(ibi, pol = 'o3')
dev.off()

timePlot(ibi, pol = 'o3', avg.time = 'month')

pdf("03_output/fig/pm_day.pdf", width = 8, height = 4)
timePlot(ibi, pol = c('pm10', 'pm25'), avg.time = 'day')
dev.off()

pdf("03_output/fig/o3_time_var.pdf", width = 9, height = 6)
timeVariation(ibi, pol = 'o3')
dev.off()

covid <- selectByDate(ibi,
                      start='15/3/2020',
                      end='28/3/2020')
timePlot(covid, pol='o3')

# Particular matter
ibi19 <- selectByDate(ibi, year = 2019)
timePlot(covid, pol = 'pm25')

# WindRose

