#Introduction
"This project will use Excel, R and SPSS.

The dataset used can be found in Kaggle:
https://www.kaggle.com/tomasdrietomsky/life-expectancy-gdp-per-capita-food-security

The dataset chosen for this case study is GDP & Life Expectancy. The data was retrieved from an open source dataset found in Kaggle, 
and it is made-up with two main excel sheets. The first is about life expectancy recorded over a yearly course between 2000 – 2015. 
A total of 264 countries will be available for analysis use, providing 2905 total rows. The second will be about the GDP of each country between 1960-2019. 
Each country’s life expectancy is different than another due to health development, economic stability and many more factors."



#Business Case Scenario (I created my own case):
"The business case of this study is to investigate the physical health of the population in developing and developed countries over the years, 
and whether GDP played a role in equation.
Attributes such as GDP, life expectancy, adult mortality, infant deaths are all promising attributes to analyze and find interesting predictions. 
Two countries have been chosen to narrow the focus of the study and make it more impactful and specific. The countries are first divided into two sections:"



#Business Questions:
"•	What is the future direction of GDP in the stated countries?
•	What is the future direction for life expectancy, and some of the other variable in the stated countries?
•	Which attributes are affected by the high/low GDP of the stated countries?"



#The way to a successful forecast goes through various steps:
"• Cleaning the data.
• Analyzing, visualizing & understanding the data.
• Perform Forecasting and predictive methods.
• Provide Recommendations based on results."

#I. Data and Preprocessing (cleaning, missing values, recoding)
"Cleaning and checking for missing data were done in Excel. 
The columns of years between 1960-1999 and 2016-2019 will also be removed, due to having only the years between 2000-2015 in the Life Expectancy sheet. 
Due to the lack of documentation, the following attributes were removed from both sheets: 
•	Schooling
•	Percentage Expenditure
•	Total expenditure
•	Income composition of resources
•	Hepatitis
•	Country Code
•	Indicator Name
•	Indicator Code"

"columns with missing data in rows:
- Schooling 163 ( deleted column)
- Income composition of resources 167 ( deleted column )
- Total expenditure 226 ( deleted column ) 
- Population 652 ( deleted column )
- Hepatitis 553 ( deleted column)
- GDP 448 ( Added data for years that will be analyzed )
- Alcohol 194 rows ( manually added them )
- Polio 19 ( manually added them )
- Diphtheria 19 ( manually added them ) 
- thinness 1-19 years 34 ( manually added them ) 
- thinness 5-9 years 34 ( manually added them )" 

#Libraries that will be used for this project
library(readxl)
library(readr)
library(fpp3)
library(ggplot2)
library(tsibble)
library(feasts)



#Information about the dataset
summary(Life_Expectancy_Data)
summary(GDP)
view(Life_Expectancy_Data)
view(GDP)


# ADD SCREENSHOTS!!





#Check if there are any null values
colSums(is.na(Life_Expectancy_Data))
colSums(is.na(GDP))

# ADD SCREENSHOTS!!



#Creating the variable Time to only date 
system.time(Life_Expectancy_Data$date <- as.Date(Life_Expectancy_Data$date))



#Due to a duplication in some of the values, the first function to use is Validate, 
#and the focus is on the validate function which validates that the output has all the necessary inputs before rendering. 

#validate equals to false to not check duplicated values and key = null if we dont have any keys
Life_Expectancy_Data %>% as_tsibble(key = Country,index = date, validate = FALSE)


#Next, the tsibble function is used to convert the tibble of the two countries into a time series
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


#Produce early visualization for the China and Germany’s different attributes

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



#ADD SCREENSHOTSSS !!!



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



#III. Making Predictions¶

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

