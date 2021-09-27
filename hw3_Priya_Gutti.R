devtools::install_github('xdaiISU/classdata')
library(classdata)
library(ggplot2)
data(ames)
View(ames)

## 1. Explore and explain what is the relationship between the sale price (y) and living area size (x).
p <- ggplot(ames, aes(x = GrLivArea, y = log10(SalePrice)))+ geom_point()
p + geom_abline(intercept = 20000, slope = 100)

## 2. Describe at least two types of anomalies in the previous plot. What do they mean?
## There are two outliers on the far right of the graph at the Living Area of 4600 and 5600. 
##Those points are under the straight line and are noticeable outliers. The straight line with the intercept of 20000 and slope of 100 is a best fit line that shows the relationship between the sale price and living area. 

## 3. Visualize the number of sales by the overall condition. Make sure the conditions are ordered from the best to the worst. What do you find?
ggplot(ames, aes(x = OverallCond)) + geom_bar()

##4. Introduce a variable houseAge into the data set which stands for the age of the house at the time when it was sold. How does the age of the house affect the sale price?
ames$houseAge  <- ames$YrSold - ames$YearBuilt
ggplot(ames, aes(x = houseAge, y = SalePrice))+ geom_point()
## As the house age increases, the sale price decreases. However, when the house age is closer to 0, the sale price varies depending on other variables. 

## 5. Were there more sales of nice houses or poor houses? Make sure to state your criterion for a house to be "nice" or otherwise "poor". Choose an appropriate graph type.
ggplot(ames, aes(x = OverallCond, y = SalePrice)) + geom_point()
ggplot(ames, aes(x = OverallCond, y = log10(SalePrice), group = OverallCond)) +
  geom_boxplot() + 
  coord_flip()
## To show the range of sale prices for the 'nice' and 'poor' houses, the criterion used the Overall Condition of the house when it was sold. 
## Boxplot shows the max and min with the mean of the sale prices and as shown, the Overall condition of the houses don't affect the sale prices since 5.0 has a large range. 
## There might be other factors that go into Sale price such as the community the house is in, if the schools are top ranked, and if it is a demanding area. 

## How do the neighborhood and the slope of property affect the relationship between sale price and year built? Focus on the neighborhoods of Brookside, Clear Creek, College Creek, and Somerset only. Find a visualization that incorporates all four variables. Interpret the result.
Hood <- ames[ames$Neighborhood %in% c('BrkSide', 'ClearCr','CollgCr','Somerst'),]
View(Hood)
ggplot(Hood, aes(x = YearBuilt, y = log10(SalePrice), shape = Neighborhood)) + geom_point() + 
         facet_grid(LandSlope ~ Neighborhood)

##7.Create a side-by-side histogram showing the sales price for the different types of buildings. Comment on the result.
ggplot(ames, aes(x =log10(SalePrice),fill = BldgType)) + geom_histogram(position = 'dodge', bins = 30) + facet_wrap(~BldgType, scales = "free_y")
##Each facet grid shows the histogram of each building type and the relationship between the Sale Price and the Count. 
##1 Family Building type has the most count of sales with the most normal graph and the highest profit. 


