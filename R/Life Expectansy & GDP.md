
# Introduction

This project will use Excel and R.



## The dataset used can be found in Kaggle:
> https://www.kaggle.com/tomasdrietomsky/life-expectancy-gdp-per-capita-food-security

The dataset chosen for this case study is GDP & Life Expectancy. The data was retrieved from an open source dataset found in Kaggle, 
and it is made-up with two main excel sheets. The first is about life expectancy recorded over a yearly course between 2000 – 2015. 
A total of 264 countries will be available for analysis use, providing 2905 total rows. The second will be about the GDP of each country between 1960-2019. 
Each country’s life expectancy is different than another due to health development, economic stability and many more factors.



## Business Case Scenario (I created my own case):
The business case of this study is to investigate the physical health of the population in developing and developed countries over the years, 
and whether GDP played a role in equation.
Attributes such as GDP, life expectancy, adult mortality, infant deaths are all promising attributes to analyze and find interesting predictions. 
Two countries have been chosen to narrow the focus of the study and make it more impactful and specific. The countries that will be used are Germany as a developed country and China as a developing country.



## Business Questions:
-	What is the future direction of GDP in the stated countries?
-	What is the future direction for life expectancy, and some of the other variable in the stated countries?
-	Which attributes are affected by the high/low GDP of the stated countries?



## The way to a successful forecast goes through various steps:
- Cleaning the data.
- Analyzing, visualizing & understanding the data.
- Perform Forecasting and predictive methods.
- Provide Recommendations based on results.



## Information about the dataset

### Life Expectancy: summary() + view()
```r
summary(Life_Expectancy_Data)
view(Life_Expectancy_Data)
```


![Summary Life Expectancy](https://github.com/AyubBen/Portfolio/blob/main/images/summay(Life_Expectancy_Data).PNG)

![View Life Expectancy](https://github.com/AyubBen/Portfolio/blob/main/images/view(Life_Expectansy_Data).PNG)



### GDP: summary() + view()
```r
summary(GDP)
view(GDP)
```



![Summary GDP](https://github.com/AyubBen/Portfolio/blob/main/images/summay(GDP).PNG)

![View GDP](https://github.com/AyubBen/Portfolio/blob/main/images/view(GDP).PNG)





## I. Data and Preprocessing (cleaning, missing values, recoding) Using Excel & R
Cleaning and checking for missing data were done in Excel. 
The columns of years between 1960-1999 and 2016-2019 will also be removed from the  GDP sheet, due to having only the years between 2000-2015 in the Life Expectancy sheet. The years columns in the GDP sheet were renamed by removing the (X) letter infront of the years.
Due to the lack of documentation, the following attributes were removed from both sheets: 
-	Schooling
-	Percentage Expenditure
-	Total expenditure
-	Income composition of resources
-	Hepatitis
-	Country Code
-	Indicator Name
-	Indicator Code

### columns with missing data in rows:
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
- thinness 5-9 years 34 ( manually added them )


### Back to R

```r
#Libraries that will be used for this project
library(readxl)
library(readr)
library(fpp3)
library(ggplot2)
library(tsibble)
library(feasts)
```



### Before proceeding with the analysis, I check one more time for any null values in the data
```r
#Check if there are any null values
colSums(is.na(Life_Expectancy_Data))
colSums(is.na(GDP))
```


![No Null- Life Expectancy](https://github.com/AyubBen/Portfolio/blob/main/images/checking%20null%20values%20Life_Expectansy_Data.PNG)

![No Null- GDP](https://github.com/AyubBen/Portfolio/blob/main/images/checking%20NEW%20null%20falues%20(GDP).PNG)



### This step enables the use of time series and forecasting

```r
#Creating the variable Time to only date 
system.time(Life_Expectancy_Data$date <- as.Date(Life_Expectancy_Data$date))
```


Due to a duplication in some of the values, the first function to use is Validate, and the focus is on the validate function which validates 
that the output has all the necessary inputs before rendering. 


```r
#validate equals to false to not check duplicated values and key = null if we dont have any keys
Life_Expectancy_Data %>% as_tsibble(key = Country,index = date, validate = FALSE)
```


###  Next, the tsibble function is used to convert the tibble of the two countries into a time series


```r
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
```


## Produce early visualization for the China and Germany’s different attributes

```r
#Early visualizations to learn more about the data.
China %>% autoplot(Life.Expectancy)
China %>% autoplot(Alcohol)
China %>% autoplot(GDP)
```


![China autoplot(Life.Expectancy)](https://github.com/AyubBen/Portfolio/blob/main/images/China%20-%20Life%20Expactancy%20Autoplot.png)

![China autoplot(Alcohol)](https://github.com/AyubBen/Portfolio/blob/main/images/China%20-%20Alcohol%20Consumption%20Autoplot.png)

![China autoplot(GDP)](https://github.com/AyubBen/Portfolio/blob/main/images/China%20-%20GDP%20Autoplot.png)


```r
Germany %>% autoplot(Life.Expectancy)
Germany %>% autoplot(Alcohol)
Germany %>% autoplot(GDP)
```


![Germany autoplot(Life.Expectancy)](https://github.com/AyubBen/Portfolio/blob/main/images/Germany%20-%20Life%20Expactancy%20Autoplot.png)

![Germany autoplot(Alcohol)](https://github.com/AyubBen/Portfolio/blob/main/images/Germany%20-%20Alcohol%20Consumption%20Autoplot.png)

![Germany autoplot(GDP)](https://github.com/AyubBen/Portfolio/blob/main/images/Germany%20-%20GDP%20Autoplot.png)



## Time Series Decomposition

In this study, seasonality will not be captured as the data is on a yearly basis and only the trend will be investigated. 
The objective of using this method is to capture how trend is changing in the two countries, and the attributes GDP, Life Expectancy, Alcohol, Polio, Diphtheria. 


### China
```r
#decompose method for China (Life Expectancy, GDP, ALcohol, Polio, Diphtheria)
#Only replace the attribute value (GDP) with a different attribute (ex. Alcohol) for the other visualizations
China %>% model(stl=STL(GDP))
China_dcmp <- China %>% model(stl=STL(GDP))
components(China_dcmp)
China %>% autoplot(GDP,color='gray')+
  autolayer(components(China_dcmp),trend,color='red')
components(China_dcmp) %>% autoplot()+ xlab("Year")
``` 


![China GDP](https://github.com/AyubBen/Portfolio/blob/main/images/China%20STL%20Decomposition%20GDP.png)

![China Life Expectancy](https://github.com/AyubBen/Portfolio/blob/main/images/China%20STL%20Decomposition%20Life%20Expectansy.png)

![China Alcohol](https://github.com/AyubBen/Portfolio/blob/main/images/China%20STL%20Decomposition%20Alcohol.png)

![China Polio](https://github.com/AyubBen/Portfolio/blob/main/images/China%20STL%20Decomposition%20Polio.png)

![China Diphtheria](https://github.com/AyubBen/Portfolio/blob/main/images/China%20STL%20Decomposition%20Diphtheria.png)


### Germany
```r
#decompose method for Germany (Life Expectancy, GDP, ALcohol, Polio, Diphtheria)
#Only replace the attribute value (GDP) with a different attribute (ex. Alcohol) for the other visualizations
Germany %>% model(stl=STL(GDP))
Germany_dcmp <- Germany %>% model(stl=STL(GDP))
components(Germany_dcmp)
Germany %>% autoplot(GDP,color='gray')+
  autolayer(components(Germany_dcmp),trend,color='red')
components(Germany_dcmp) %>% autoplot()+ xlab("Year")
```


![Germany GDP](https://github.com/AyubBen/Portfolio/blob/main/images/Germany%20STL%20decomposition%20GDP.png)

![Germany Life Expectancy](https://github.com/AyubBen/Portfolio/blob/main/images/Germany%20STL%20decomposition%20Life%20Exp.png)

![Germany Alcohol](https://github.com/AyubBen/Portfolio/blob/main/images/Germany%20STL%20decomposition%20Alcohol.png)

![Germany Polio](https://github.com/AyubBen/Portfolio/blob/main/images/Germany%20STL%20decomposition%20Polio.png)

![Germany Diphtheria](https://github.com/AyubBen/Portfolio/blob/main/images/Germany%20STL%20decomposition%20Diphtheria.png)



## III. Making Predictions


the use of complex forecasting methods increases the chances of errors occurring, resulting in a lower accuracy of the model built. 
Following the previous step, few simple forecasting methods were used due to their simplicity in application, and their effectiveness. 
Specifically,the Average, Naïve, and Drift methods. The Seasonal Naïve Method will not be applied due to the lack of seasonality in this data. 
The process of applying these methods after preparing the data, is to visualise it to have an idea and some knowledge about of the data.

```r
#Simple Forecast Methods
#Only replace the attribute value (GDP) with a different attribute (ex. Alcohol) for the other forecast visualizations
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
```


### GDP

![GDP Forecaste Table](https://github.com/AyubBen/Portfolio/blob/main/images/Simple%20Forecast%20Table.PNG)

![GDP Forecaste](https://github.com/AyubBen/Portfolio/blob/main/images/GDP%20Simple%20Forecast.png)

![GDP Forecaste 2](https://github.com/AyubBen/Portfolio/blob/main/images/Countries%20Simple%20Forecast%20GDP%20222222.png)


### Life Expectancy 

![Life Expectancy Forecaste Table](https://github.com/AyubBen/Portfolio/blob/main/images/Simple%20Forecast%20Table%20Life%20exp.PNG)

![Life Expectancy Forecaste](https://github.com/AyubBen/Portfolio/blob/main/images/Countries%20Simple%20Forecast%20Life%20Exp.png)

![Life Expectancy Forecaste 2](https://github.com/AyubBen/Portfolio/blob/main/images/Countries%20Simple%20Forecast%20Life%20Exp%202222.png)


### Alcohol

![Alcohol Forecaste Table](https://github.com/AyubBen/Portfolio/blob/main/images/Simple%20Forecast%20Table%20Alcohol.PNG)

![Alcohol Forecaste](https://github.com/AyubBen/Portfolio/blob/main/images/Countries%20Simple%20Forecast%20Alcohol.png)

![Alcohol Forecaste 2](https://github.com/AyubBen/Portfolio/blob/main/images/Countries%20Simple%20Forecaste%20Alcohol%2022222.png)


### Polio

![Polio Forecaste Table](https://github.com/AyubBen/Portfolio/blob/main/images/Simple%20Forecast%20Table%20Polio.PNG)

![Polio Forecaste](https://github.com/AyubBen/Portfolio/blob/main/images/Countries%20Simple%20Forecast%20Polio.png)

![Polio Forecaste 2](https://github.com/AyubBen/Portfolio/blob/main/images/Countries%20Simple%20Forecast%20Polio%2022222.png)


#### Diphtheria

![Diphtheria Forecaste Table](https://github.com/AyubBen/Portfolio/blob/main/images/Simple%20Forecast%20Table%20Diphtheria.PNG)

![Diphtheria Forecaste](https://github.com/AyubBen/Portfolio/blob/main/images/Countries%20Simple%20Forecaste%20Diptheria.png)

![Diphtheria Forecaste 2](https://github.com/AyubBen/Portfolio/blob/main/images/Countries%20Simple%20Forecaste%20Diptheria%202222.png)



## Classification: K-NN 


In this study the groups are China and Germany, while the attributes the model will be populated with are GDP, Life Expectancy, Alcohol Consumption,
Polio and Diphtheria rates. Based on the attributes, the model will classify the data accordingly.


```r
#Change format of the columns
Life_Expectancy_Data$Life.Expectancy        <- as.numeric(Life_Expectancy_Data$Life.Expectancy)
Life_Expectancy_Data$Alcohol                <- as.numeric(Life_Expectancy_Data$Alcohol)
Life_Expectancy_Data$Polio                  <- as.numeric(Life_Expectancy_Data$Polio)
Life_Expectancy_Data$Diphtheria             <- as.numeric(Life_Expectancy_Data$Diphtheria)
Life_Expectancy_Data$GDP                    <- as.numeric(Life_Expectancy_Data$GDP)
```


```r
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
```




![Alcohol & GDP](https://github.com/AyubBen/Portfolio/blob/main/images/Alcohol%20%26%20GDP%20K-NN.png)

![Life Expectency & GDP](https://github.com/AyubBen/Portfolio/blob/main/images/GDP%20%26%20Life%20Exp%20K-nn.png)



### Calculate the accuracy Prediction FOR China & Germany
China   100%
Germany 100%





## Conclusion
Through the use of different business analytical tools and applying statistical methods, forecasting and predictive models, as well as a classification method 
I was able to investigate the GDP and life expectancy data, and other variables that could have been impacted due to GDP.



### - First Objective
The analysis showed China’s GDP rate, from the perspective of developing country, growing 
between 2000 and 2015 with a forecast of the rate to continue to increase for the following three 
years.

On the other hand, the analysis also showed Germany’s GDP rate, as a developed country, 
showed a fluctuation over the years but with an overall increase in the rate. The forecast also showed the country a positive incline on the long term.


### - Second & Third Objective
The results of the analysis in China on life expectancy showed an increase by 4 years between 
2000-2015 and is forecasting to continue growing for the next three years. 
Polio and Diphtheria rate both showed a rise in the years between 2000-2005 but has been the same rate until 2015. 
Lastly, the alcohol consumption rate has been increasing from around 3.1 litres to 5.8 litres.

Moreover, the analysis in Germany for life expectancy showed an overall increase of around 5 
years during the same tested period and is expected to continue to rise slowly over the following three years. 
Polio and Diphtheria rate both showed the same results as China, where the two variables’ rates 
increased in the first 5 years of the analysis, then maintained the same rate until 2015. 
Finally, the alcohol consumption rate over the 15 years and is expected to decrease from 
around 12.8 litres to 11.2 litres.



Overall, referring to the statistical methods applied showed a significant relationship between GDP 
#and the variables tested but the rate of infection for the illnesses did not change overtime as seen in the forecasting analysis

## Limitation:
-  The possibility of external factors affecting the life expectancy of the population.
- The variables investigated in this project were limited, and more important alternative variables could have changed the direction of the project and its findings.
