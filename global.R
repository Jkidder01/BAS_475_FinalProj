library(fpp3)
library(shiny)
library(dplyr)
library(readr)
library(shinydashboard)
library(lubridate)
library(seasonal)
library(zoo)
 
 Milk <- read.table("Milk.txt",header = TRUE,sep = ",")
 
 Milk$Date <- paste(Milk$Year, Milk$Month, sep = "-")

 keep_cols <- c(
   "Date", "Cotagecheese.Prod",
   "Icecream.Prod", "Milk.Prod", "N.CA.Fat.Price"
 )
 
 Milk$Date <- yearmonth(Milk$Date)
 
 Milk <- Milk[,keep_cols]
 
 Milk_ts <- tsibble(Milk, index = Date, key = NULL)

