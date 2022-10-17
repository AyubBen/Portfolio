
#Libraries that will be used for this project
library(readxl)
library(readr)
library(fpp3)
library(ggplot2)
library(tsibble)
library(feasts)



#Importing the data into R
Life_Expectancy_Data <- read.csv("Project.csv")

#Information about the dataset
summary(Life_Expectancy_Data)
summary(GDP)
view(Life_Expectancy_Data)
view(GDP)


#Check if there are any null values
colSums(is.na(Life_Expectancy_Data))
colSums(is.na(GDP))

#Creating the variable Time to only date 
system.time(Life_Expectancy_Data$date <- as.Date(Life_Expectancy_Data$date))




#validate equals to false to not check duplicated values and key = null if we dont have any keys
Life_Expectancy_Data %>% as_tsibble(key = Country,index = date, validate = FALSE)



#make a tsibble
Life_Expectancy_Data_ts <- Life_Expectancy_Data %>%  mutate(Annual = date) %>%
  as_tsibble(index = Annual, key = c(Country),validate = FALSE)




#make tsibbles by group by countries (China, Germany)
China <- Life_Expectancy_Data_ts  %>% filter(Life_Expectancy_Data_ts$Country == "China") %>%   
mutate(Annual = 2000:2015 )  %>%  
  as_tsibble(index = Annual, key = NULL)


Germany <- Life_Expectancy_Data_ts  %>% filter(Life_Expectancy_Data_ts$Country == "Germany") %>%   
  mutate(Annual = 2000:2015 )  %>%  
  as_tsibble(index = Annual, key = NULL)




# Early visualizations to learn more about the data.
China %>% autoplot(Life.Expectancy)
China %>% autoplot(Adult.Mortality)
China %>% autoplot(Infant.Deaths)
China %>% autoplot(Alcohol)
China %>% autoplot(Measles)
China %>% autoplot(BMI)
China %>% autoplot(Under.five.Deaths)
China %>% autoplot(Polio)
China %>% autoplot(HIV.AIDS)
China %>% autoplot(Diphtheria)
China %>% autoplot(GDP)
China %>% autoplot(Thinness.1.4.Years.Old)
China %>% autoplot(Thinness.5.9.Years.Old)




Germany %>% autoplot(Life.Expectancy)
Germany %>% autoplot(Adult.Mortality)
Germany %>% autoplot(Infant.Deaths)
Germany %>% autoplot(Alcohol)
Germany %>% autoplot(Measles)
Germany %>% autoplot(BMI)
Germany %>% autoplot(Under.five.Deaths)
Germany %>% autoplot(Polio)
Germany %>% autoplot(HIV.AIDS)
Germany %>% autoplot(Diphtheria)
Germany %>% autoplot(GDP)
Germany %>% autoplot(Thinness.1.4.Years.Old)
Germany %>% autoplot(Thinness.5.9.Years.Old)



#decompose method for China
China %>% model(stl=STL(GDP))
China_dcmp <- China %>% model(stl=STL(GDP))
components(China_dcmp)
China %>% autoplot(GDP,color='gray')+
  autolayer(components(China_dcmp),trend,color='red')
components(China_dcmp) %>% autoplot()+ xlab("Year")



#decompose method for Germany
Germany %>% model(stl=STL(GDP))
Germany_dcmp <- Germany %>% model(stl=STL(GDP))
components(Germany_dcmp)
Germany %>% autoplot(GDP,color='gray')+
  autolayer(components(Germany_dcmp),trend,color='red')
components(Germany_dcmp) %>% autoplot()+ xlab("Year")



#Simple Forecast Methods
Countries_fit <- Life_Expectancy_Data_ts %>% 
  filter(!is.na(GDP)) %>% 
  model(
    Naive = NAIVE(GDP),
    Drift = RW(GDP ~ drift()), 
    Mean = MEAN(GDP)
  )

Countries_fit_fc <- Countries_fit %>% 
  forecast(h = "3 years")

Countries_fit_fc %>%  autoplot(Life_Expectancy_Data_ts)




#Exponential Smoothing 
#China
China_expsmoothing <- China %>% model(AAN = ETS (Life.Expectancy ~ error("A") + trend("A") + season("N")),)
report(China_expsmoothing)
components(China_expsmoothing)
components(China_expsmoothing) %>% autoplot()
China_expfc <- China_expsmoothing %>% forecast(h="3 years")
China_expfc %>% autoplot(China)

#2Germany
Germany_expsmoothing <- Germany %>% model(AAN = ETS (Life.Expectancy ~ error("A") + trend("A") + season("N")),)
report(Germany_expsmoothing)
components(Germany_expsmoothing)
components(Germany_expsmoothing) %>% autoplot()
Germany_expfc <- Germany_expsmoothing %>% forecast(h="3 years")
Germany_expfc %>% autoplot(Germany)





#Check the column types, and general information about the data
str(Life_Expectancy_Data)
summary(Life_Expectancy_Data)
view(Life_Expectancy_Data)


#Change format of the columns
Life_Expectancy_Data$Country                <- as.factor(Life_Expectancy_Data$Country)
Life_Expectancy_Data$Life.Expectancy        <- as.numeric(Life_Expectancy_Data$Life.Expectancy)
Life_Expectancy_Data$Adult.Mortality        <- as.numeric(Life_Expectancy_Data$Adult.Mortality)
Life_Expectancy_Data$Infant.Deaths          <- as.numeric(Life_Expectancy_Data$Infant.Deaths)
Life_Expectancy_Data$Alcohol                <- as.numeric(Life_Expectancy_Data$Alcohol)
Life_Expectancy_Data$Measles                <- as.numeric(Life_Expectancy_Data$Measles)
Life_Expectancy_Data$BMI                    <- as.numeric(Life_Expectancy_Data$BMI)
Life_Expectancy_Data$Under.five.Deaths      <- as.numeric(Life_Expectancy_Data$Under.five.Deaths)
Life_Expectancy_Data$Polio                  <- as.numeric(Life_Expectancy_Data$Polio)
Life_Expectancy_Data$Diphtheria             <- as.numeric(Life_Expectancy_Data$Diphtheria)
Life_Expectancy_Data$GDP                    <- as.numeric(Life_Expectancy_Data$GDP)
Life_Expectancy_Data$Thinness.1.4.Years.Old <- as.numeric(Life_Expectancy_Data$Thinness.1.4.Years.Old)
Life_Expectancy_Data$Thinness.5.9.Years.Old <- as.numeric(Life_Expectancy_Data$Thinness.5.9.Years.Old)


#Deleted the columns
Life_Expectancy_Data$date <- NULL
Life_Expectancy_Data$Annual <- NULL
Life_Expectancy_Data$Status <- NULL
Life_Expectancy_Data$HIV.AIDS <- NULL



set.seed(123)
head(Life_Expectancy_Data)
Life_random <- runif(32)
Life_Exp_random <- Life_Expectancy_Data[order(Life_random),]
head(Life_Exp_random)

normal <- function(x) (
  return( ((x - min(x)) /(max(x)-min(x))) ))

normal(1:5)
Life_Exp_new <- as.data.frame(lapply(Life_Exp_random[,-1], normal))
summary(Life_Exp_new)

Life_train <- Life_Exp_new[1:24,]
Life_test <- Life_Exp_new[25:32,]
Life_train_sp <- Life_Exp_random[1:24,1]
Life_test_sp <- Life_Exp_random[25:32,1]


library(class)
require(class)
model <- knn(Life_train, Life_test, cl = Life_train_sp, k = 5)
table(factor(model))
table(Life_test_sp,model)



# CALCULATE THE ACCURACY FOR China & Germany
#China   100%
#Germany 100%


#try more variables ( ex. pressure)
ggplot(aes(GDP, Alcohol), data = Life_Exp_random)+
  geom_point(aes(color= factor(Country)))

