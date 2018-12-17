#library(plyr)
library(dplyr)
#columns_data_types <-c('Date', 'string', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric')
gold_historical_prices <- read.csv("Gold Historical Prices.csv", header=TRUE)
gold_historical_prices$Day = weekdays(as.Date(gold_historical_prices$Date, '%d-%b-%y'), abbreviate = TRUE)

#Check the Frequency of the Days
print(count(gold_historical_prices, Day))

#Since Sunday has only 25 instances we're going to drop it
gold_historical_prices <- subset(gold_historical_prices, gold_historical_prices$Day!="Sun")
print(count(gold_historical_prices, Day))

#aggregate(gold_historical_prices[, 3:4], list(gold_historical_prices$Day), mean)

#ddply(gold_historical_prices, .(gold_historical_prices$Day), summarize, Rate1=mean(gold_historical_prices$Price))

gold_historical_prices$Price <- as.numeric(gold_historical_prices$Price)

df2 <- gold_historical_prices %>% group_by(Day) %>% summarise_at(vars(Price), mean)
print(df2)
df2$Day <- factor(df2$Day,levels= c("Mon","Tue", "Wed", "Thu", "Fri"))


df2[order(df2$Day), ]
plot(x = df2$Day,y = df2$Price)
