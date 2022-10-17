#Introduction
"This project will use Excel and R.

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



#Time Series Decomposition

#In this study, seasonality will not be captured as the data is on a yearly basis and only the trend will be investigated. 
#The objective of using this method is to capture how trend is changing in the two countries, and the attributes GDP, Life Expectancy, Alcohol, Polio, Diphtheria. 

#decompose method for China (Life Expectancy, GDP, ALcohol, Polio, Diphtheria)
China %>% model(stl=STL(GDP))
China_dcmp <- China %>% model(stl=STL(GDP))
components(China_dcmp)
China %>% autoplot(GDP,color='gray')+
  autolayer(components(China_dcmp),trend,color='red')
components(China_dcmp) %>% autoplot()+ xlab("Year")

China %>% model(stl=STL(Life_Expectancy))
China_dcmp <- China %>% model(stl=STL(Life_Expectancy))
components(China_dcmp)
China %>% autoplot(Life_Expectancy,color='gray')+
  autolayer(components(China_dcmp),trend,color='red')
components(China_dcmp) %>% autoplot()+ xlab("Year")

China %>% model(stl=STL(ALcohol))
China_dcmp <- China %>% model(stl=STL(ALcohol))
components(China_dcmp)
China %>% autoplot(ALcohol,color='gray')+
  autolayer(components(China_dcmp),trend,color='red')
components(China_dcmp) %>% autoplot()+ xlab("Year")

China %>% model(stl=STL(Polio))
China_dcmp <- China %>% model(stl=STL(Polio))
components(China_dcmp)
China %>% autoplot(Polio,color='gray')+
  autolayer(components(China_dcmp),trend,color='red')
components(China_dcmp) %>% autoplot()+ xlab("Year")

China %>% model(stl=STL(Diphtheria))
China_dcmp <- China %>% model(stl=STL(Diphtheria))
components(China_dcmp)
China %>% autoplot(Diphtheria,color='gray')+
  autolayer(components(China_dcmp),trend,color='red')
components(China_dcmp) %>% autoplot()+ xlab("Year")

#decompose method for Germany (Life Expectancy, GDP, ALcohol, Polio, Diphtheria)
Germany %>% model(stl=STL(GDP))
Germany_dcmp <- Germany %>% model(stl=STL(GDP))
components(Germany_dcmp)
Germany %>% autoplot(GDP,color='gray')+
  autolayer(components(Germany_dcmp),trend,color='red')
components(Germany_dcmp) %>% autoplot()+ xlab("Year")

Germany %>% model(stl=STL(Life Expectancy))
Germany_dcmp <- Germany %>% model(stl=STL(Life Expectancy))
components(Germany_dcmp)
Germany %>% autoplot(Life Expectancy,color='gray')+
  autolayer(components(Germany_dcmp),trend,color='red')
components(Germany_dcmp) %>% autoplot()+ xlab("Year")

Germany %>% model(stl=STL(ALcohol))
Germany_dcmp <- Germany %>% model(stl=STL(ALcohol))
components(Germany_dcmp)
Germany %>% autoplot(ALcohol,color='gray')+
  autolayer(components(Germany_dcmp),trend,color='red')
components(Germany_dcmp) %>% autoplot()+ xlab("Year")

Germany %>% model(stl=STL(Polio))
Germany_dcmp <- Germany %>% model(stl=STL(Polio))
components(Germany_dcmp)
Germany %>% autoplot(Polio,color='gray')+
  autolayer(components(Germany_dcmp),trend,color='red')
components(Germany_dcmp) %>% autoplot()+ xlab("Year")

Germany %>% model(stl=STL(Diphtheria))
Germany_dcmp <- Germany %>% model(stl=STL(Diphtheria))
components(Germany_dcmp)
Germany %>% autoplot(Diphtheria,color='gray')+
  autolayer(components(Germany_dcmp),trend,color='red')
components(Germany_dcmp) %>% autoplot()+ xlab("Year")


# ADD SCREENSHOTTTTT



#III. Making Predictions¶


#the use of complex forecasting methods increases the chances of errors occurring, resulting in a lower accuracy of the model built. 
"Following the previous step, few simple forecasting methods were used due to their simplicity in application, and their effectiveness. 
Specifically,the Average, Naïve, and Drift methods. The Seasonal Naïve Method will not be applied due to the lack of seasonality in this data. 
The process of applying these methods after preparing the data, is to visualise it to have an idea and some knowledge about of the data."

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




# ADD SCREENSHOTTT of the foreaste table + visuals






#Classification: K-NN 


#In this study the groups are China and Germany, while the attributes the model will be populated with are GDP, Life Expectancy, Alcohol Consumption,
#Polio and Diphtheria rates. Based on the attributes, the model will classify the data accordingly.



#Check the column types, and general information about the data
str(Life_Expectancy_Data)
summary(Life_Expectancy_Data)
view(Life_Expectancy_Data)


#Change format of the columns
Life_Expectancy_Data$Life.Expectancy        <- as.numeric(Life_Expectancy_Data$Life.Expectancy)
Life_Expectancy_Data$Alcohol                <- as.numeric(Life_Expectancy_Data$Alcohol)
Life_Expectancy_Data$Polio                  <- as.numeric(Life_Expectancy_Data$Polio)
Life_Expectancy_Data$Diphtheria             <- as.numeric(Life_Expectancy_Data$Diphtheria)
Life_Expectancy_Data$GDP                    <- as.numeric(Life_Expectancy_Data$GDP)





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






#Conclusion
"Through the use of different business analytical tools and applying statistical methods, forecasting and predictive models, as well as a classification method 
I was able to investigate the GDP and life expectancy data, and other variables that could have been impacted due to GDP."





- First Objective
"The analysis showed China’s GDP rate, from the perspective of developing country, growing 
between 2000 and 2015 with a forecast of the rate to continue to increase for the following three 
years."

"On the other hand, the analysis also showed Germany’s GDP rate, as a developed country, 
showed a fluctuation over the years but with an overall increase in the rate. The forecast also showed the country a positive incline on the long term."




- Second & Third Objective
"The results of the analysis in China on life expectancy showed an increase by 4 years between 
2000-2015 and is forecasting to continue growing for the next three years. 
Polio and Diphtheria rate both showed a rise in the years between 2000-2005 but has been the same rate until 2015. 
Lastly, the alcohol consumption rate has been increasing from around 3.1 litres to 5.8 litres."



"Moreover, the analysis in Germany for life expectancy showed an overall increase of around 5 
years during the same tested period and is expected to continue to rise slowly over the following three years. 
Polio and Diphtheria rate both showed the same results as China, where the two variables’ rates 
increased in the first 5 years of the analysis, then maintained the same rate until 2015. 
Finally, the alcohol consumption rate over the 15 years and is expected to decrease from 
around 12.8 litres to 11.2 litres."



#Overall, referring to the statistical methods applied showed a significant relationship between GDP 
#and the variables tested but the rate of infection for the illnesses did not change overtime as seen in the forecasting analysis

#Limitation:
-  The possibility of external factors affecting the life expectancy of the population.
- The variables investigated in this project were limited, and more important alternative variables could have changed the direction of the project and its findings.
